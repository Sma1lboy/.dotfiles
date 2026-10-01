# tmux with this machine's ~/.tmux.conf (oh-my-tmux + .tmux.conf.local):
# the status bar, C-a prefix splits, zoom, a second window, Alt-number switch.
start_take 120 30 "$HOME/.tmux.conf"
wait_for "orbit-sdk"
# oh-my-tmux applies its theme asynchronously, seconds after the server
# starts; until then the prefix is still C-b and the status bar is stock.
for _ in $(seq 60); do
  [ "$("${REC_TMUX[@]}" show -gv prefix)" = C-a ] &&
    "${REC_TMUX[@]}" show -gv status-right | grep -q _battery_status && break
  sleep 0.5
done
sleep 2
"${REC_TMUX[@]}" send-keys -t orbit " fc -p; clear" Enter
sleep 1

cue open
type_text "git log --oneline"
keys Enter
sleep 1.2

# C-a | splits side by side, C-a - stacks; both keep the current directory.
# Prefix chords go through the client (`press`), where the bindings live.
press '\001' '|'
type_text "ls src"
keys Enter
sleep 1
press '\001' -
type_text "git status --short"
keys Enter
sleep 1.5

# Zoom one pane to the whole window and back.
press '\001' z
sleep 1.5
press '\001' z
sleep 1

# A second window, then Alt-1 jumps straight back to the first.
press '\001' c
type_text "cat package.json"
keys Enter
sleep 1.5
press '\0331'
sleep 2
cue end
end_take
