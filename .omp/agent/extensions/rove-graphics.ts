// Shows omp's inline images inside a rove pane.
//
// A rove pane is a PTY slave rendered through @xterm/headless, which drops Kitty graphics
// commands, while the Unicode placeholder cells survive to the outer terminal. So omp runs in
// placeholder mode (~/.zshrc sets PI_FORCE_IMAGE_PROTOCOL=kitty PI_KITTY_PLACEHOLDERS=1 when
// ROVE_TAB_ID is set) and this extension lifts every `ESC _G … ESC \` out of omp's output and
// hands it to rove's `graphics.write`, which every attached rove TUI writes to its own terminal.
// The daemon also reports the real cell pixel size, which the pane cannot measure.
//
// Set ROVE_GRAPHICS_LOG=<file> to log each forward.
import * as fs from "node:fs";
import { Composer, type ExtensionAPI } from "@oh-my-pi/pi-coding-agent";
import { ImageProtocol, ProcessTerminal, setCellDimensions, TERMINAL, type TUI } from "@oh-my-pi/pi-tui";

const APC_RE = /\x1b_G[^\x1b]*\x1b\\/g;
/** A delete-all would also clear other panes' pictures in the shared terminal. */
const DELETE_ALL_RE = /^\x1b_G(?:[^;\x1b]*,)?a=d,d=[aA](?:,|;|\x1b)/;
/** rove caps one payload at 4 MiB decoded; stay under it with margin. */
const MAX_BATCH_BYTES = 3 * 1024 * 1024;

type Method = (this: object, ...args: never[]) => unknown;
type Proto = Record<string, Method | undefined>;

interface Bridge {
	socketPath: string;
	taskId: string;
	tabId: string;
	socket?: Bun.Socket<undefined>;
	connecting?: Promise<Bun.Socket<undefined> | undefined>;
	/** rove-allocated id this tab reuses so forwards never leak ids; the bytes carry omp's own ids. */
	imageId?: number;
	/** Forwards waiting for the first allocation. */
	queue: string[];
	/** An APC split across two writes. */
	carry: string;
	/** Bytes the socket did not accept yet; flushed on drain so large frames arrive whole and in order. */
	outbox?: Buffer;
	seq: number;
	ui?: TUI;
	log?: string;
}

interface GraphicsReply {
	ok: boolean;
	imageId?: number;
	cellWidth?: number;
	cellHeight?: number;
	unsupported?: string;
}

const STATE_KEY = Symbol.for("omp.rove-graphics.state");
const globals = globalThis as { [STATE_KEY]?: Bridge };

function log(bridge: Bridge, message: string): void {
	if (bridge.log) fs.appendFileSync(bridge.log, `${new Date().toISOString()} ${message}\n`);
}

function parseReply(line: string): GraphicsReply | undefined {
	try {
		const frame: unknown = JSON.parse(line);
		if (!frame || typeof frame !== "object" || !("payload" in frame)) return undefined;
		const payload = frame.payload;
		if (!payload || typeof payload !== "object" || !("ok" in payload)) return undefined;
		return payload as GraphicsReply;
	} catch {
		return undefined;
	}
}

function connect(bridge: Bridge): Promise<Bun.Socket<undefined> | undefined> {
	if (bridge.socket) return Promise.resolve(bridge.socket);
	bridge.connecting ??= (async () => {
		let pending = "";
		try {
			const socket = await Bun.connect({
				unix: bridge.socketPath,
				socket: {
					data(_socket, chunk) {
						pending += chunk.toString();
						let newline = pending.indexOf("\n");
						while (newline >= 0) {
							onReply(bridge, pending.slice(0, newline));
							pending = pending.slice(newline + 1);
							newline = pending.indexOf("\n");
						}
					},
					drain(socket) {
						flush(bridge, socket);
					},
					close() {
						bridge.socket = undefined;
						bridge.connecting = undefined;
						bridge.outbox = undefined;
					},
					error() {
						bridge.socket = undefined;
						bridge.connecting = undefined;
						bridge.outbox = undefined;
					},
				},
			});
			bridge.socket = socket;
			return socket;
		} catch (error) {
			log(bridge, `connect failed: ${error instanceof Error ? error.message : String(error)}`);
			bridge.connecting = undefined;
			return undefined;
		}
	})();
	return bridge.connecting;
}

function flush(bridge: Bridge, socket: Bun.Socket<undefined>): void {
	const out = bridge.outbox;
	if (!out) return;
	const written = socket.write(out);
	bridge.outbox = written < out.length ? out.subarray(Math.max(0, written)) : undefined;
}

function onReply(bridge: Bridge, line: string): void {
	const reply = parseReply(line);
	if (!reply) {
		log(bridge, `reply: ${line.slice(0, 200)}`);
		return;
	}
	if (!reply.ok) {
		log(bridge, `rove refused: ${reply.unsupported ?? line.slice(0, 200)}`);
		return;
	}
	if (bridge.imageId !== undefined || reply.imageId === undefined) {
		log(bridge, `rove accepted: ${line.slice(0, 160)}`);
		return;
	}
	bridge.imageId = reply.imageId;
	if (reply.cellWidth && reply.cellHeight) {
		setCellDimensions({ widthPx: reply.cellWidth, heightPx: reply.cellHeight });
		bridge.ui?.invalidate();
		bridge.ui?.requestRender(true);
	}
	log(bridge, `allocated id ${reply.imageId}, cell ${reply.cellWidth}x${reply.cellHeight}`);
	const queued = bridge.queue;
	bridge.queue = [];
	for (const data of queued) send(bridge, data);
}

async function request(bridge: Bridge, payload: Record<string, unknown>): Promise<void> {
	const socket = await connect(bridge);
	if (!socket) return;
	const frame = { type: "request", id: `omp-${++bridge.seq}`, name: "graphics.write", payload };
	const line = Buffer.from(`${JSON.stringify(frame)}\n`);
	bridge.outbox = bridge.outbox ? Buffer.concat([bridge.outbox, line]) : line;
	flush(bridge, socket);
}

function send(bridge: Bridge, apcs: string): void {
	if (bridge.imageId === undefined) {
		bridge.queue.push(apcs);
		return;
	}
	const data = Buffer.from(apcs, "latin1").toBase64();
	log(bridge, `forward ${apcs.length} bytes: ${apcs.slice(0, 80).replaceAll("\x1b", "⎋")}`);
	void request(bridge, { taskId: bridge.taskId, tabId: bridge.tabId, imageId: bridge.imageId, data });
}

/** Splits `data` into terminal text and the graphics commands to forward. */
function extract(bridge: Bridge, data: string): string {
	let text = bridge.carry + data;
	bridge.carry = "";
	const open = text.lastIndexOf("\x1b_G");
	if (open >= 0 && text.indexOf("\x1b\\", open) < 0) {
		bridge.carry = text.slice(open);
		text = text.slice(0, open);
	}
	if (!text.includes("\x1b_G")) return text;
	let batch = "";
	const rest = text.replace(APC_RE, apc => {
		if (DELETE_ALL_RE.test(apc)) return "";
		if (batch.length + apc.length > MAX_BATCH_BYTES) {
			send(bridge, batch);
			batch = "";
		}
		batch += apc;
		return "";
	});
	if (batch) send(bridge, batch);
	return rest;
}

function install(bridge: Bridge): void {
	const terminalProto = ProcessTerminal.prototype as unknown as Proto;
	const write = terminalProto.write;
	if (write === undefined) return;
	terminalProto.write = function (this: object, ...args: never[]) {
		const data: unknown = args[0];
		if (typeof data !== "string") return write.apply(this, args);
		return write.call(this, extract(bridge, data) as never);
	};
	// The composer is the only handle to the TUI, needed to repaint once the real cell size arrives.
	const composerProto = Composer.prototype as unknown as Proto;
	const renderFrame = composerProto.renderFrame;
	if (renderFrame !== undefined) {
		composerProto.renderFrame = function (this: Composer, ...args: never[]) {
			bridge.ui = this.ui;
			return renderFrame.apply(this, args);
		};
	}
	// Omitting imageId allocates one and reports the cell size; the reply flushes the queue.
	void request(bridge, { taskId: bridge.taskId, tabId: bridge.tabId });
}

export default function roveGraphics(pi: ExtensionAPI) {
	pi.setLabel("rove-graphics");
	if (globals[STATE_KEY] !== undefined) return;
	const { KOBE_DAEMON_SOCKET_PATH, ROVE_TASK_ID, ROVE_TAB_ID, ROVE_GRAPHICS_LOG } = process.env;
	if (!KOBE_DAEMON_SOCKET_PATH || !ROVE_TASK_ID || !ROVE_TAB_ID) return;
	if (TERMINAL.imageProtocol !== ImageProtocol.Kitty) return;
	const bridge: Bridge = {
		socketPath: KOBE_DAEMON_SOCKET_PATH,
		taskId: ROVE_TASK_ID,
		tabId: ROVE_TAB_ID,
		queue: [],
		carry: "",
		seq: 0,
		log: ROVE_GRAPHICS_LOG,
	};
	globals[STATE_KEY] = bridge;
	install(bridge);
}
