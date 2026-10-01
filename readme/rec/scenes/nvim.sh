# Neovim with this machine's config (~/.config/nvim -> .config/nvim): the
# Dracula theme and lualine, nvim-tree on C-e, Telescope on <space>f, LSP
# completion while typing.
start_take 120 32 ./tmux-bare.conf
wait_for "orbit-sdk"
# Plugins still calling APIs Neovim 0.11 deprecated pop warnings that are not
# part of the config being shown; this take alone silences them.
"${REC_TMUX[@]}" send-keys -t orbit " fc -p; clear; nvim --cmd 'lua vim.deprecate = function() end' src/client.ts" Enter
wait_for "createClient" 30
# Plugins, treesitter and the TypeScript server settle before the camera rolls.
sleep 5

cue open
# The file tree, opened and walked.
keys C-e
sleep 1.5
keys j
keys j
sleep 1
keys C-e
sleep 0.8

# Fuzzy-find a file and open it.
keys Space
keys f
wait_for "Find Files" 10
sleep 0.5
type_text "sess"
sleep 1
keys Enter
sleep 1.5

# Back to the client: completion from the language server as you type.
keys Space
keys f
sleep 0.6
type_text "client.ts"
sleep 0.8
keys Enter
sleep 1
# A new line after the last one: completion from the language server.
keys G
keys o
keys Enter
type_text "export const orbit = createCl"
sleep 1.5
# Enter confirms the completion (p-cmp.lua).
keys Enter
sleep 0.8
keys Escape
sleep 2.5
cue end
"${REC_TMUX[@]}" send-keys -t orbit Escape ":qa!" Enter
sleep 1
end_take
