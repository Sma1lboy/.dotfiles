# zsh + starship: the prompt in a git repo, autosuggestion, syntax
# highlighting, prefix history search, aliases.
start_take 110 14 ./tmux-bare.conf
wait_for "orbit-sdk"
# History the later beats search and suggest from.
"${REC_TMUX[@]}" send-keys -t orbit " fc -p; print -s 'git log --oneline -3'; print -s 'git status --short'; clear" Enter
sleep 1.5

cue open
# Autosuggestion: a few letters, the rest arrives grey; → accepts it.
type_text "git st"
sleep 1.2
keys Right
sleep 0.8
keys Enter
sleep 1.5

# Syntax highlighting: a typo is red, a real command is not.
type_text "gti"
sleep 1
keys C-u
type_text "ls"
sleep 0.6
keys Enter
sleep 1.8

# Up searches history by the prefix already typed.
type_text "git l"
keys Up
sleep 1
keys Enter
sleep 2
cue end
end_take
