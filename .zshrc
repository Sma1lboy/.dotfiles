# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/Users/bytedance/.oh-my-zsh/custom/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

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
unalias sp 2>/dev/null
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
#alias ls="lsd"

# Zsh Autosuggestions highlight style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export ANDROID_HOME=${HOME}/Library/Android/sdk
export ANDROID_AVD_HOME=${HOME}/.android/avd
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
alias mirror="scrcpy --show-touches"
alias claude="CLAUDE_CODE_NO_FLICKER=1 claude --allow-dangerously-skip-permissions"
alias codex="codex --sandbox danger-full-access"



export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --- BEGIN FEDERATED REPO GIT TELEMETRY CODE BLOCK ---
# https://bytedance.sg.larkoffice.com/docx/SurId67UBoZxHwxe07Clr5Ufgog

export FEDERATED_REPO_GIT_TELEMETRY_VERSION=1.3.0
export GIT_TRACE2_EVENT="$HOME/.trace2/event"
export GIT_TRACE2_EVENT_BRIEF=true
export GIT_TRACE2_MAX_FILES=100000

# --- END FEDERATED REPO GIT TELEMETRY CODE BLOCK ---


# bun completions
[ -s "/Users/bytedance/.bun/_bun" ] && source "/Users/bytedance/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# --- Terminal mode auto-reset (fix garbled chars after SSH disconnects) ---
# Some remote programs (tmux, vim, TUIs) enable focus reporting / mouse
# reporting / bracketed paste. If the SSH session dies before they can send
# the disable sequences, the local terminal keeps interpreting cursor moves
# and clicks as escape sequences -- showing as `^[[I`, `65;69;32M...` etc.
# Re-disable these modes before every prompt so a dropped ssh can't poison
# the local TTY for long.
_reset_term_modes() {
  # ?1004 = focus reporting
  # ?1000 ?1002 ?1003 = mouse reporting (normal / btn-event / any-event)
  # ?1006 ?1015 = mouse encoding (SGR / urxvt)
  # NOTE: do NOT touch ?2004 (bracketed paste) -- zsh manages it itself.
  printf '\033[?1004l\033[?1000l\033[?1002l\033[?1003l\033[?1006l\033[?1015l'
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _reset_term_modes

# Manual recovery when the terminal is already wedged: type `fix-term`<Enter>
# (blind-type it -- works even when input looks broken).
fix-term() {
  stty sane
  _reset_term_modes
  printf '\033c'   # full terminal reset; clears screen
}

# zsh-syntax-highlighting (must be sourced last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias ls="lsd"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<

# kobe completions
command -v kobe >/dev/null && source <(kobe completions zsh)

# CLIProxyAPI (local daemon on :8317, key in ~/.cli-proxy-api/keys.txt)
alias claudecpa='ANTHROPIC_BASE_URL=http://127.0.0.1:8317 ANTHROPIC_AUTH_TOKEN=$CLIPROXY_API_KEY CLAUDE_CODE_NO_FLICKER=1 command claude --dangerously-skip-permissions'
alias codexcpa='command codex -c model_provider=cliproxy --dangerously-bypass-approvals-and-sandbox'
alias cpa-claude-login='~/i/CLIProxyAPI/cli-proxy-api --config ~/.cli-proxy-api/config.yaml --claude-login'
alias cpa-codex-login='~/i/CLIProxyAPI/cli-proxy-api --config ~/.cli-proxy-api/config.yaml --codex-login'

# kimi-code
export PATH="/Users/bytedance/.kimi-code/bin:$PATH"

# pin bytedcli — 0.60.0+ breaks BITS/ByteCloud auth, keep auto-upgrade off
export BYTEDCLI_NO_AUTO_UPGRADE=1

# machine-local secrets & overrides (not tracked in dotfiles)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
