# omp (oh-my-pi) with this machine's ~/.omp/agent (config.yml, the
# titanium-custom theme and the extensions under .omp/agent/extensions):
# one real turn that reads the repo and answers, with the custom status line.
# Costs one small model turn. --no-session keeps it out of your history.
start_take 120 34 ./tmux-bare.conf
wait_for "orbit-sdk"
"${REC_TMUX[@]}" send-keys -t orbit " fc -p; clear; omp --no-session" Enter
wait_for "❯" 60
# MCP servers finish connecting and the banner settles.
sleep 6

cue open
type_text "What does this repo do? Read src/ and answer in two sentences."
sleep 0.6
keys Enter
# The answer names the client's retry loop; the turn is over once it shows
# and the composer is back.
wait_for "retr" 120
sleep 6
cue end
"${REC_TMUX[@]}" send-keys -t orbit C-c
sleep 0.5
"${REC_TMUX[@]}" send-keys -t orbit C-c
sleep 1
end_take
