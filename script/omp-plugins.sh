#!/bin/bash
# Install npm omp plugins listed in .omp/plugins.txt that are missing locally.
# Run by script/omp.sh and by the .githooks post-merge/post-rewrite hooks after every pull.
# Plugins installed but not listed are reported, not removed.

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIST="$DOTFILES/.omp/plugins.txt"
MODULES="$HOME/.omp/plugins/node_modules"

if ! command -v omp >/dev/null 2>&1; then
  echo "omp-plugins: omp not installed, skipping"
  exit 0
fi

status=0
listed=()
while read -r plugin; do
  case "$plugin" in "" | \#*) continue ;; esac
  listed+=("$plugin")
  [ -e "$MODULES/$plugin/package.json" ] && continue
  echo "omp-plugins: installing $plugin"
  # Public registry: mirrors 404 on pi peer deps such as @earendil-works/pi-coding-agent.
  NPM_CONFIG_REGISTRY=https://registry.npmjs.org BUN_CONFIG_REGISTRY=https://registry.npmjs.org \
    omp plugin install "$plugin" || { echo "omp-plugins: failed to install $plugin" >&2; status=1; }
done <"$LIST"

for pkg in "$MODULES"/*/package.json "$MODULES"/@*/*/package.json; do
  [ -e "$pkg" ] || continue
  name="${pkg#"$MODULES"/}"
  name="${name%/package.json}"
  # Only top-level deps of the plugin dir are plugins; skip transitive packages.
  grep -q "\"$name\"" "$HOME/.omp/plugins/package.json" || continue
  printf '%s\n' "${listed[@]}" | grep -qxF "$name" || echo "omp-plugins: $name installed but not in plugins.txt"
done

exit $status
