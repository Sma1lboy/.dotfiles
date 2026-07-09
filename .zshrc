# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# Completion
autoload -Uz compinit && compinit

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Bind key for zsh-autosuggestions confirm by using keymap ctrl-space
bindkey '^ ' autosuggest-execute

# Prefix history search with Up/Down arrows
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# Starship prompt
eval "$(starship init zsh)"

# Starship preset switcher: `sp` to list, `sp <name>` to apply
sp() {
  local dir="$HOME/.config/starship-presets"
  if [[ -z "$1" ]]; then
    echo "presets in $dir:"
    for f in "$dir"/*.toml; do echo "  ${${f:t}:r}"; done
    return
  fi
  local target="$dir/$1.toml"
  if [[ ! -f "$target" ]]; then
    echo "no preset '$1' — run 'sp' to list"; return 1
  fi
  cp "$target" "$HOME/.config/starship.toml" && echo "applied '$1' — open a new shell or run 'exec zsh'"
}

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
export PATH="$HOME/.ragdoll/bin:$PATH"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

 export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# zsh-syntax-highlighting (must be sourced last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
