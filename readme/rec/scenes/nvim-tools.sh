# Neovim tools: <leader>O symbols outline beside the code, and <C-j> the
# toggleterm terminal under it.
start_take 120 32 ./tmux-bare.conf
wait_for "orbit-sdk"
"${REC_TMUX[@]}" send-keys -t orbit " fc -p; clear; nvim --cmd 'lua vim.deprecate = function() end' src/client.ts" Enter
wait_for "createClient" 30
sleep 6

cue open
keys Space O
sleep 2.5
keys C-w l
sleep 0.5
keys j
keys j
keys j
sleep 1.5
keys C-w h
sleep 0.5

# A terminal pane that comes and goes on <C-j>.
keys C-j
sleep 1.5
type_text "git log --oneline"
keys Enter
sleep 2.5
keys C-j
sleep 2
cue end
"${REC_TMUX[@]}" send-keys -t orbit Escape ":qa!" Enter
sleep 1
end_take
