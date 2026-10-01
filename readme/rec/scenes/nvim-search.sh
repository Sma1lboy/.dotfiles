# Neovim search: <leader>g live grep across the repo with preview, then
# <leader>t every TODO/FIX the todo-comments plugin highlights, in Telescope.
start_take 120 32 ./tmux-bare.conf
wait_for "orbit-sdk"
"${REC_TMUX[@]}" send-keys -t orbit " fc -p; clear; nvim --cmd 'lua vim.deprecate = function() end' src/index.ts" Enter
wait_for "createClient" 30
sleep 4

cue open
keys Space g
wait_for "Live Grep" 10
# The prompt takes input a beat after the window draws.
sleep 1
type_text "session"
sleep 2
keys Down
sleep 1.2
keys Enter
sleep 1.5

keys Space t
sleep 2.5
keys Down
sleep 1.2
keys Enter
sleep 2.5
cue end
"${REC_TMUX[@]}" send-keys -t orbit Escape ":qa!" Enter
sleep 1
end_take
