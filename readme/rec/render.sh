#!/bin/bash
# readme/rec/render.sh [scene...] -- readme/casts/<scene>.cast -> readme/<scene>.gif.
# Deterministic: no tool runs, only the committed recording is drawn, so pacing
# and look change here without re-taking. Default: every scene with a cast.
set -eu
cd "$(dirname "$0")/.."

# Ghostty's Catppuccin Mocha: background, foreground, then the 16 ANSI colours.
THEME=1e1e2e,cdd6f4,45475a,f38ba8,a6e3a1,f9e2af,89b4fa,f5c2e7,94e2d5,bac2de,585b70,f38ba8,a6e3a1,f9e2af,89b4fa,f5c2e7,94e2d5,a6adc8

# Playback speed per scene: typing reads at 1x, a long take is skimmed.
speed() {
  case $1 in
    nvim) echo 1.5 ;;
    *) echo 1.2 ;;
  esac
}

scenes=("$@")
if [ ${#scenes[@]} -eq 0 ]; then
  for cast in casts/*.cast; do scenes+=("$(basename "$cast" .cast)"); done
fi
for scene in "${scenes[@]}"; do
  agg --quiet \
    --font-family "JetBrainsMono Nerd Font Mono" --font-size 16 --line-height 1.3 \
    --theme "$THEME" --speed "$(speed "$scene")" --idle-time-limit 2 \
    --last-frame-duration 3 --fps-cap 20 \
    --select marker:open..marker:end \
    "casts/$scene.cast" "$scene.gif"
  echo "readme/$scene.gif $(du -h "$scene.gif" | cut -f1)"
done
