#!/bin/bash
# readme/rec/record.sh <scene> -- record readme/casts/<scene>.cast from
# readme/rec/scenes/<scene>.sh, against the configs this machine runs.
# The take is the only step that touches the real tools; render.sh turns the
# committed cast into the README gif as often as needed.
set -u
cd "$(dirname "$0")"
scene=${1:?usage: record.sh <scene>}
[ -f "scenes/$scene.sh" ] || { echo "no scene scenes/$scene.sh" >&2; exit 2; }

RAW=$(mktemp -t "rec-$scene").cast
MARKS=$(mktemp -t "rec-$scene").marks
KEYS=${TMPDIR:-/tmp}/rec-$scene-$$.keys
OUT=../casts/$scene.cast
mkdir -p ../casts

source ./lib.sh
./demo-repo.sh
source "scenes/$scene.sh"
