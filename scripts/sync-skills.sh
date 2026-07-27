#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

rm -rf "$root/skills"
mkdir -p "$root/skills"

while read -r repo branch src; do
  repo_name="${repo##*/}"
  repo_dir="$tmp/$repo_name"
  git clone --quiet --depth 1 --filter=blob:none --sparse --branch "$branch" \
    "https://github.com/$repo.git" "$repo_dir"
  git -C "$repo_dir" sparse-checkout set "$src"

  for skill_file in "$repo_dir/$src"/*/SKILL.md; do
    [ -e "$skill_file" ] || continue
    skill_dir="$(dirname "$skill_file")"
    skill_name="$(basename "$skill_dir")"
    target="$root/skills/$skill_name"
    if [ -e "$target" ]; then
      echo "Duplicate skill name: $skill_name" >&2
      exit 1
    fi
    cp -R "$skill_dir" "$target"
  done
done <<'EOF'
OpenSiFli/SiFli-SDK main skills
OpenSiFli/sftool master skills
OpenSiFli/SiFli-SDK-CodeKit main skills
EOF
