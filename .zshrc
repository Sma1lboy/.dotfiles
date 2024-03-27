if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)

plugins=(
  fast-syntax-highlighting
  zsh-autosuggestions
  zsh-syntax-highlighting
  sudo
  web-search
  copypath
  copyfile
  copybuffer
  dirhistory
  virtualenv
#  zsh_reload
  history
 # osx
  )

source $ZSH/oh-my-zsh.sh


source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias python="/usr/local/bin/python3"
alias vim=/opt/homebrew/bin/nvim
#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
export JAVA_HOME=$(/usr/libexec/java_home)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
alias typora="open -a typora"
alias neofetch="neofetch --source /Users/jacksonchen/.config/neofetch/ascii/long_norm.txt"
alias post="hexo new post"
alias venv="/Users/jacksonchen/Library/Python/3.11/bin/virtualenv"
alias lg="lazygit"
alias bc="better-commits"

# bun completions
[ -s "/Users/jacksonchen/.bun/_bun" ] && source "/Users/jacksonchen/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=/Users/jacksonchen/Documents/Github/depot_tools:$PATH

# Created by `pipx` on 2024-03-25 03:20:42
export PATH="$PATH:/Users/jacksonchen/.local/bin"

export PATH="$PATH:/usr/local/texlive/2024/bin/universal-darwin"
