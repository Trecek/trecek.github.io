#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"

errors=0

declare -A sticker_map

for post in "${root}"/_posts/*.md; do
  [[ -f "$post" ]] || continue

  sticker=$(grep -oP '!\[.*?\]\(\K[^)]+(?=\)\{: \.post-cat-sticker \})' "$post" || true)

  if [[ -z "$sticker" ]]; then
    echo "ERROR: $(basename "$post") is missing a cat sticker"
    errors=$((errors + 1))
    continue
  fi

  # Normalize: strip leading / for filesystem check
  local_path="${root}/${sticker#/}"

  if [[ -n "${sticker_map[$sticker]:-}" ]]; then
    echo "ERROR: $(basename "$post") reuses sticker '${sticker}' (already used in ${sticker_map[$sticker]})"
    errors=$((errors + 1))
  else
    sticker_map[$sticker]="$(basename "$post")"
  fi

  if [[ ! -f "$local_path" ]]; then
    echo "ERROR: $(basename "$post") references '${sticker}' but file does not exist"
    errors=$((errors + 1))
  fi
done

count=${#sticker_map[@]}

if [[ $errors -gt 0 ]]; then
  echo "Cat sticker check FAILED with ${errors} error(s)"
  exit 1
fi

echo "Cat sticker check passed: ${count} posts verified, all stickers unique"
