# Vim with this repo's .vimrc: everforest, airline, relative numbers,
# auto-pairs. The plugins are not committed (.vim/plugged holds empty
# gitlinks), so the take installs them once into a cache outside the repo
# and outside ~/.vim, and runs the repo's .vimrc against that.
VIMDEMO=/tmp/dotfiles-demo/vim
if [ ! -d "$VIMDEMO/plugged/vim-airline" ]; then
  mkdir -p "$VIMDEMO/autoload"
  cp ../../.vim/autoload/plug.vim "$VIMDEMO/autoload/"
  # Ex mode: vim-plug runs without a terminal to draw its progress window on.
  /usr/bin/vim -es -Nu ../../.vimrc -i NONE --cmd "set rtp^=$VIMDEMO" \
    --cmd "let g:plug_home='$VIMDEMO/plugged'" -c PlugInstall -c qa >/dev/null 2>&1
  [ -d "$VIMDEMO/plugged/vim-airline" ] || { echo "PlugInstall failed" >&2; exit 1; }
fi
# /usr/bin/vim by path: in zsh `vim` is aliased to nvim.
VIM="/usr/bin/vim -Nu $(cd ../.. && pwd)/.vimrc --cmd 'set rtp^=$VIMDEMO' --cmd \"let g:plug_home='$VIMDEMO/plugged'\""

start_take 110 26 ./tmux-bare.conf
wait_for "orbit-sdk"
"${REC_TMUX[@]}" send-keys -t orbit " fc -p; clear; $VIM src/client.ts" Enter
wait_for "createClient" 20
sleep 2

cue open
# Relative numbers follow the cursor.
for _ in 1 2 3 4 5 6 7 8; do keys j; done
sleep 0.6
# auto-pairs closes brackets and quotes as they are typed, on a new line at
# the end of the file.
keys G
keys o
keys Enter
type_text "export const retry = { attempts: [1, 2, 3], label: 'orbit' }"
sleep 1
keys Escape
sleep 2
cue end
"${REC_TMUX[@]}" send-keys -t orbit Escape ":qa!" Enter
sleep 1
end_take
