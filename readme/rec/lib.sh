# Helpers for README takes, sourced by record.sh. A take drives a real,
# private tmux server (socket `dotrec`, never your own) while asciinema
# records it; the storyboard only says what to press and what to wait for.
# bash 3.2 compatible (macOS /bin/bash).

REC_TMUX=(tmux -L dotrec)
# Fixture repo the scenes work in; its path is on camera, so it is neutral.
REC_DEMO=/tmp/dotfiles-demo/orbit-sdk

now() { perl -MTime::HiRes=time -e 'printf "%.3f", time'; }

# start_take COLS ROWS TMUX_CONF -- start the private server and the recorder.
start_take() {
  local cols=$1 rows=$2 conf=$3
  "${REC_TMUX[@]}" kill-server 2>/dev/null
  rm -f "$RAW" "$MARKS" "$KEYS"
  mkfifo "$KEYS"
  # The pane runs a login zsh in the demo repo, with this machine's real configs.
  "${REC_TMUX[@]}" -f "$conf" new-session -d -s orbit -x "$cols" -y "$rows" -c "$REC_DEMO" "zsh -l"
  TERM=xterm-256color COLORTERM=truecolor asciinema rec --headless -q --overwrite \
    -f asciicast-v2 --window-size "${cols}x${rows}" \
    -c "python3 relay.py $KEYS ${REC_TMUX[*]} attach -t orbit" "$RAW" &
  REC_PID=$!
  T0=$(now)
  sleep 1.5
}

# cue LABEL -- a marker the render selects ranges by (agg --select marker:a..marker:b).
cue() { echo "$(perl -e "printf '%.3f', $(now) - $T0") $1" >>"$MARKS"; }

# keys KEY... -- tmux key names (C-a, Enter, Up, ...), then a beat.
keys() { "${REC_TMUX[@]}" send-keys -t orbit "$@"; sleep "${BEAT:-0.5}"; }

# press BYTES... -- raw bytes typed into the tmux CLIENT, the way a keyboard
# would, so prefix bindings fire (`keys` goes straight to the pane and skips
# them). printf escapes: press '\001' '|' is C-a then |; '\0331' is Alt-1.
press() {
  local b
  for b in "$@"; do
    printf "$b" >"$KEYS"
    sleep 0.35
  done
  sleep "${BEAT:-0.5}"
}

# type TEXT -- literal text at a readable typing speed.
type_text() {
  local text=$1 i
  for ((i = 0; i < ${#text}; i++)); do
    "${REC_TMUX[@]}" send-keys -t orbit -l "${text:i:1}"
    sleep 0.06
  done
  sleep 0.3
}

# wait_for TEXT [SECONDS] -- until TEXT is on screen; fails the take otherwise.
wait_for() {
  local text=$1 limit=${2:-15} start
  start=$(date +%s)
  until "${REC_TMUX[@]}" capture-pane -p -t orbit | grep -qF -- "$text"; do
    if (($(date +%s) - start > limit)); then
      echo "take failed: never saw \"$text\"" >&2
      "${REC_TMUX[@]}" capture-pane -p -t orbit >&2
      end_take fail
      exit 1
    fi
    sleep 0.2
  done
}

# end_take [fail] -- stop recording, merge cues, refuse leaks, publish the cast.
end_take() {
  "${REC_TMUX[@]}" kill-server 2>/dev/null
  wait "$REC_PID" 2>/dev/null
  [ "${1:-}" = fail ] && return
  python3 - "$RAW" "$MARKS" "$OUT" <<'PY'
import json, os, re, socket, sys, getpass
raw, marks, out = sys.argv[1:]
lines = open(raw).read().splitlines()
header, events = lines[0], [json.loads(l) for l in lines[1:]]
# The prompt and the tmux status bar print the account and machine names
# from the system, not from $USER. Each is swapped for a neutral name of the
# SAME length, in place, so every column after it stays where it was drawn.
# A redraw can split a name across output chunks and wrap escape sequences
# around its letters, so matching runs on the joined stream with escapes
# removed, and each matched letter is replaced at its own offset.
user, host = getpass.getuser(), socket.gethostname().split(".")[0]
swaps = [(user, "orbitdev"), (host, "orbit-dev-macbookpro")]
outputs = [e for e in events if e[1] == "o"]
stream = "".join(e[2] for e in outputs)
ESCAPE = re.compile(r"\x1b(?:\[[0-?]*[ -/]*[@-~]|[\]P_^][^\x07\x1b]*(?:\x07|\x1b\\)?|[()*+#%][\s\S]|[\s\S])")
offsets, start = [], 0
for m in ESCAPE.finditer(stream):
    offsets.extend(range(start, m.start()))
    start = m.end()
offsets.extend(range(start, len(stream)))
visible = "".join(stream[i] for i in offsets)
chars = list(stream)
for real, neutral in swaps:
    neutral = (neutral * 3)[: len(real)]
    for m in re.finditer(re.escape(real), visible):
        for k in range(len(real)):
            chars[offsets[m.start() + k]] = neutral[k]
# Escape strings carry names too (tmux sets the window title from #H): a
# plain swap on the joined stream, still the same length.
joined = "".join(chars)
for real, neutral in swaps:
    joined = joined.replace(real, (neutral * 3)[: len(real)])
chars = list(joined)
at = 0
for e in outputs:
    e[2], at = "".join(chars[at : at + len(e[2])]), at + len(e[2])
if os.path.exists(marks):
    for line in open(marks):
        t, label = line.split(" ", 1)
        events.append([float(t), "m", label.strip()])
events.sort(key=lambda e: e[0])
text = "\n".join([header] + [json.dumps(e, ensure_ascii=False) for e in events]) + "\n"
visible = "".join(chars[i] for i in offsets)
# Whatever is left that names this machine or its owner, in the bytes or on
# screen, is refused.
for needle in {os.path.expanduser("~"), user, host}:
    if len(needle) >= 4 and (needle in text or needle in visible):
        sys.exit(f"take refused: the recording contains {needle!r}; re-route that beat")
if re.search(r"[\w.+-]+@[\w-]+\.[a-z]{2,}", text + visible):
    sys.exit("take refused: the recording contains an e-mail address")
open(out, "w").write(text)
print(out)
PY
}
