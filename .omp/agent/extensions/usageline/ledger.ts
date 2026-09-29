// Pure bookkeeping for usageline: no omp API, no file IO.

/**
 * One ledger line: what the main session's usage totals grew by since the
 * previous line. `n` is how many main-agent responses the growth covers; a
 * cache-warm refresh, a compaction or a title request lands with `n: 0`.
 * Subagent (task) spend arrives through the parent's totals.
 */
export type Rec = {
	/** epoch ms */
	t: number;
	/** project root */
	p: string;
	/** model id */
	m: string;
	n: number;
	i: number;
	o: number;
	cr: number;
	cw: number;
	usd: number;
};

export type Totals = { reqs: number; inTok: number; outTok: number; cacheRead: number; cacheWrite: number; usd: number };

/** Prompt-cache tokens of one response, in omp's `Usage` field names. */
export type CacheTokens = { input: number; cacheRead: number; cacheWrite: number };

/** A response counts as a cache miss when it rewrote at least this much and read less than it wrote. */
export const MISS_MIN_WRITE = 10_000;

export const zero = (): Totals => ({ reqs: 0, inTok: 0, outTok: 0, cacheRead: 0, cacheWrite: 0, usd: 0 });

export function addRec(into: Totals, r: Rec): void {
	into.reqs += r.n;
	into.inTok += r.i;
	into.outTok += r.o;
	into.cacheRead += r.cr;
	into.cacheWrite += r.cw;
	into.usd += r.usd;
}

function addTotals(into: Totals, t: Totals): void {
	into.reqs += t.reqs;
	into.inTok += t.inTok;
	into.outTok += t.outTok;
	into.cacheRead += t.cacheRead;
	into.cacheWrite += t.cacheWrite;
	into.usd += t.usd;
}

/** Local calendar day, YYYY-MM-DD: the ledger's file name. */
export function dayOf(ms: number): string {
	const d = new Date(ms);
	const p = (n: number) => String(n).padStart(2, "0");
	return `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}`;
}

/** Records in a chunk of JSONL; a malformed line (a torn write) is skipped. */
export function parseLines(text: string): Rec[] {
	const out: Rec[] = [];
	for (const line of text.split("\n")) {
		if (!line) continue;
		try {
			const r = JSON.parse(line) as Rec;
			if (typeof r.p === "string" && typeof r.usd === "number") out.push(r);
		} catch {
			// skip
		}
	}
	return out;
}

/** Share of the prompt served from the cache, 0..1; null when nothing was sent. */
export function hitRate(t: CacheTokens): number | null {
	const sent = t.input + t.cacheRead + t.cacheWrite;
	return sent === 0 ? null : t.cacheRead / sent;
}

export type MissContext = {
	/** When the cache was last read or written (a response or a warm refresh); null before the first. */
	prevTouchMs: number | null;
	/** When this request started. */
	startMs: number;
	prevModel: string | null;
	model: string;
	compactedSince: boolean;
	/** Cache lifetime of the tier last written; undefined when the model declares none. */
	ttlMs: number | undefined;
};

/** Why a response rewrote its prompt cache, or null when it mostly read it. */
export function missReason(u: CacheTokens, c: MissContext): string | null {
	const w = u.cacheWrite;
	if (w < MISS_MIN_WRITE || w <= u.cacheRead) return null;
	if (c.prevTouchMs === null) return "first request";
	if (c.compactedSince) return "after compact";
	if (c.prevModel !== null && c.prevModel !== c.model) return `model ${shortModel(c.prevModel)}→${shortModel(c.model)}`;
	const idle = c.startMs - c.prevTouchMs;
	if (c.ttlMs !== undefined && idle > c.ttlMs) return `idle ${fmtDuration(idle)} > ${fmtDuration(c.ttlMs)} ttl`;
	return "prefix changed";
}

export function shortModel(id: string): string {
	const m = id.match(/claude-([a-z]+)-(\d+)(?:-(\d{1,2}))?(?:-\d{8})?(?:\[.*\])?$/);
	if (!m) return id;
	return m[3] ? `${m[1]} ${m[2]}.${m[3]}` : `${m[1]} ${m[2]}`;
}

export function fmtTokens(n: number): string {
	if (n < 1000) return String(n);
	if (n < 999_950) return `${(n / 1000).toFixed(n < 10_000 ? 1 : 0)}k`;
	return `${(n / 1_000_000).toFixed(1)}M`;
}

export const fmtUsd = (n: number): string => (n < 10 ? `$${n.toFixed(2)}` : `$${n.toFixed(1)}`);

export const fmtPct = (r: number): string => `${(r * 100).toFixed(1)}%`;

export function fmtDuration(ms: number): string {
	const s = Math.max(0, Math.round(ms / 1000));
	if (s < 60) return `${s}s`;
	const m = Math.floor(s / 60);
	if (m < 10 && s % 60) return `${m}m${String(s % 60).padStart(2, "0")}s`;
	if (m < 60) return `${m}m`;
	return `${Math.floor(m / 60)}h${String(m % 60).padStart(2, "0")}`;
}

/** Time left on the cache: whole minutes from ten up, m:ss below. */
export function fmtCountdown(left: number): string {
	if (left >= 10 * 60_000) return `${Math.floor(left / 60_000)}m`;
	const s = Math.ceil(left / 1000);
	return `${Math.floor(s / 60)}:${String(s % 60).padStart(2, "0")}`;
}

/** The /usageline report: this project's last `days` days, then every project today. */
export function report(recs: readonly Rec[], project: string, today: string, days = 7): string {
	const head = ["day", "reqs", "input", "output", "cache r", "cache w", "hit", "cost"];
	const rowOf = (label: string, t: Totals) => {
		const r = hitRate({ input: t.inTok, cacheRead: t.cacheRead, cacheWrite: t.cacheWrite });
		return [
			label,
			String(t.reqs),
			fmtTokens(t.inTok),
			fmtTokens(t.outTok),
			fmtTokens(t.cacheRead),
			fmtTokens(t.cacheWrite),
			r === null ? "-" : fmtPct(r),
			fmtUsd(t.usd),
		];
	};

	const byDay = new Map<string, Totals>();
	const byProject = new Map<string, Totals>();
	for (const r of recs) {
		const day = dayOf(r.t);
		if (r.p === project && day <= today) {
			let t = byDay.get(day);
			if (!t) byDay.set(day, (t = zero()));
			addRec(t, r);
		}
		if (day === today) {
			let t = byProject.get(r.p);
			if (!t) byProject.set(r.p, (t = zero()));
			addRec(t, r);
		}
	}
	const mine = [...byDay.entries()].sort((a, b) => (a[0] < b[0] ? 1 : -1)).slice(0, days);
	const all = zero();
	for (const [, t] of mine) addTotals(all, t);

	const table = (h: string[], rows: string[][]) => {
		const w = h.map((_, i) => Math.max(h[i]!.length, ...rows.map(r => r[i]!.length)));
		const line = (r: string[]) => r.map((c, i) => (i === 0 ? c.padEnd(w[i]!) : c.padStart(w[i]!))).join("  ");
		return [line(h), ...rows.map(line)].join("\n");
	};

	const out = [project, ""];
	out.push(
		mine.length === 0
			? "no usage recorded here yet"
			: table(head, [...mine.map(([d, t]) => rowOf(d, t)), rowOf(`${mine.length}d total`, all)]),
	);
	if (byProject.size > 0) {
		const rows = [...byProject.entries()].sort((a, b) => b[1].usd - a[1].usd);
		out.push("", "today, every project", "");
		out.push(table(["project", ...head.slice(1)], rows.map(([p, t]) => rowOf(p.split("/").at(-1) ?? p, t))));
	}
	return out.join("\n");
}
