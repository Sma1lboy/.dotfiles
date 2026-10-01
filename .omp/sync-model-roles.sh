#!/usr/bin/env bash
# Pulls the modelRoles block maintained by the cloud "omp model-watch" routine (pushed to
# origin/main) into the local omp config. Only applies when the remote block changed since the
# last sync, so uncommitted local edits survive until the routine bumps something.
set -u
repo="$HOME/.dotfiles"
cfg="$repo/.omp/agent/config.yml"
state="$HOME/.omp/agent/.model-roles-sync"
fetch_head="$repo/.git/FETCH_HEAD"

if [ ! -f "$fetch_head" ] || [ -n "$(find "$fetch_head" -mmin +360 2>/dev/null)" ]; then
  git -C "$repo" fetch -q origin main 2>/dev/null || exit 0
fi

roles() { awk '/^modelRoles:/{f=1;next} f&&/^[^ ]/{exit} f'; }
remote=$(git -C "$repo" show origin/main:.omp/agent/config.yml 2>/dev/null | roles)
[ -n "$remote" ] || exit 0
hash=$(printf '%s' "$remote" | shasum | cut -c1-40)
[ "$hash" = "$(cat "$state" 2>/dev/null)" ] && exit 0

local_roles=$(roles <"$cfg")
if [ "$remote" != "$local_roles" ]; then
  tmp=$(mktemp)
  BLOCK="$remote" awk '/^modelRoles:/{print; print ENVIRON["BLOCK"]; skip=1; next} skip&&/^[^ ]/{skip=0} !skip' "$cfg" >"$tmp" &&
    cat "$tmp" >"$cfg" # write through the symlink target
  rm -f "$tmp"
  echo "omp modelRoles synced from dotfiles:"
  diff <(echo "$local_roles") <(echo "$remote") | grep '^[<>]'
  echo "updating omp so the new model ids are in its catalog..."
  command omp update >/dev/null 2>&1 || echo "omp update failed; run it manually"
fi
echo "$hash" >"$state"
