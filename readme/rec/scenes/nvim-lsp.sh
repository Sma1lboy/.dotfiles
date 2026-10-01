# Neovim LSP (typescript-tools + ts_ls via mason): K hover, gD to the
# definition in another file and back, <space>r rename across files,
# <leader>xx diagnostics in Trouble.
start_take 120 32 ./tmux-bare.conf
wait_for "orbit-sdk"
# Plugins still calling APIs Neovim 0.11 deprecated pop warnings that are not
# part of the config being shown; this take alone silences them.
"${REC_TMUX[@]}" send-keys -t orbit " fc -p; clear; nvim --cmd 'lua vim.deprecate = function() end' src/client.ts" Enter
wait_for "createClient" 30
# The TypeScript servers index the project before the camera rolls.
sleep 8
# Cursor onto the session helper the client imports.
keys /
type_text "getSession(Date"
keys Enter
sleep 0.5

cue open
# Its signature, from the language server.
keys K
sleep 3
keys Escape
sleep 0.5

# Jump to where it is defined, in session.ts, and back.
keys g D
wait_for "export async function getSession" 10
sleep 2.5

# Rename it at its definition: the import and the call in client.ts follow.
keys Space r
sleep 1.2
keys C-u
type_text "loadSession"
keys Enter
sleep 2
keys C-o
sleep 2.5

# A type error, then the project's diagnostics in Trouble.
keys G o
keys Enter
type_text 'export const retries: number = "three"'
keys Escape
sleep 2.5
keys Space x x
sleep 3.5
cue end
"${REC_TMUX[@]}" send-keys -t orbit Escape ":qa!" Enter
sleep 1
end_take
