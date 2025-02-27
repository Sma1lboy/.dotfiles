# If p10k-instant-prompt is available, source it
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  sudo
  web-search
  copypath
  copyfile
  copybuffer
  dirhistory
  virtualenv
  history
  rust
)

source $ZSH/oh-my-zsh.sh

source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Bind key for zsh-autosuggestions confirm by using keymap ctrl-space
bindkey '^ ' autosuggest-execute

# Aliases
alias vim=/opt/homebrew/bin/nvim
alias neofetch="neofetch --source ~/.config/neofetch/ascii/long_norm.txt"
alias venv="~/Library/Python/3.11/bin/virtualenv"
alias lg="lazygit"
alias yi="yarn install"
alias a="yazi"
alias sb="sketchybar"
alias ls="lsd"

# Zsh Autosuggestions highlight style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Add local bin to PATH
export PATH="$PATH:$HOME/.local/bin"

# Added by Windsurf
export PATH="/Users/jacksonc/.codeium/windsurf/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
