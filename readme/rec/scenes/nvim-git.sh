# Neovim git with gitsigns: the gutter marks lines changed since the last
# commit as you edit, line blame on demand, and a changed hunk previewed.
start_take 120 32 ./tmux-bare.conf
wait_for "orbit-sdk"
"${REC_TMUX[@]}" send-keys -t orbit " fc -p; clear; nvim --cmd 'lua vim.deprecate = function() end' src/client.ts" Enter
wait_for "createClient" 30
sleep 4

cue open
# Edit two places: the gutter marks each change.
keys 3 G
keys o
type_text "export const DEFAULT_ATTEMPTS = 3"
keys Escape
sleep 1
# A deleted line: the blank one between the imports and the types.
keys 2 G
keys d d
sleep 1.5

# Who wrote a committed line, and in which commit. C-e closes the cmdline
# completion menu first, or Enter would only pick an item from it.
keys :
type_text "Gitsigns toggle_current_line_blame"
keys C-e
keys Enter
keys 1 0 G
sleep 3

# The added line's hunk (now line 3), against what was committed.
keys 3 G
keys :
type_text "Gitsigns preview_hunk"
keys C-e
keys Enter
sleep 3
cue end
"${REC_TMUX[@]}" send-keys -t orbit Escape ":qa!" Enter
sleep 1
end_take
