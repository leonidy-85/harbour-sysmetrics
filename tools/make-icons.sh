#!/usr/bin/env bash
# Render icon assets from icons/icon.svg.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
svg="$root/icons/icon.svg"
base="ru.yurasov.sysmetrics"
for s in 86 108 128 172 256; do
    mkdir -p "$root/icons/${s}x${s}"
    out="$root/icons/${s}x${s}/$base.png"
    if command -v rsvg-convert >/dev/null; then
        rsvg-convert -w "$s" -h "$s" "$svg" -o "$out"
    elif command -v inkscape >/dev/null; then
        inkscape "$svg" --export-type=png --export-width="$s" --export-height="$s" -o "$out" >/dev/null 2>&1
    else
        echo "need rsvg-convert or inkscape" >&2; exit 1
    fi
done
echo "done"
