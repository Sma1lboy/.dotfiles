#!/bin/bash
# omp (oh-my-pi): link config + own extensions + custom themes, copy mcp.json, install plugins.

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/.omp"
TARGET_DIR="$HOME/.omp/agent"

mkdir -p "$TARGET_DIR"

# omp writes config.yml through symlinks (resolves realpath first), so linking is safe.
for item in config.yml extensions themes; do
  target="$TARGET_DIR/$item"
  if [ -L "$target" ]; then
    rm "$target"
  elif [ -e "$target" ]; then
    echo "Backing up $target to $target.back"
    mv "$target" "$target.back"
  fi
  ln -s "$SOURCE_DIR/agent/$item" "$target"
  echo "Symbolic link created: $target -> $SOURCE_DIR/agent/$item"
done

# mcp.json is rewritten via tmp file + rename, which would replace a symlink: copy it instead.
if [ ! -e "$TARGET_DIR/mcp.json" ]; then
  cp "$SOURCE_DIR/agent/mcp.json" "$TARGET_DIR/mcp.json"
  echo "Copied mcp.json to $TARGET_DIR"
fi

if ! command -v omp >/dev/null 2>&1; then
  echo "omp not installed, skipping plugin install"
  exit 0
fi

while read -r plugin; do
  case "$plugin" in "" | \#*) continue ;; esac
  # Public registry: mirrors 404 on pi peer deps such as @earendil-works/pi-coding-agent.
  NPM_CONFIG_REGISTRY=https://registry.npmjs.org BUN_CONFIG_REGISTRY=https://registry.npmjs.org omp plugin install "$plugin"
done <"$SOURCE_DIR/plugins.txt"

if ! omp plugin list 2>/dev/null | grep -q 'i-have-adhd@i-have-adhd'; then
  omp plugin marketplace list 2>/dev/null | grep -q 'i-have-adhd' || omp plugin marketplace add ayghri/i-have-adhd
  omp plugin install i-have-adhd@i-have-adhd
fi
