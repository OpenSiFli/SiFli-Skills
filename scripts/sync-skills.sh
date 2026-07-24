#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

rm -rf "$root/skills"
mkdir -p "$root/skills"

while read -r name repo branch src; do
  repo_dir="$tmp/$name"
  git clone --quiet --depth 1 --filter=blob:none --sparse --branch "$branch" \
    "https://github.com/$repo.git" "$repo_dir"
  git -C "$repo_dir" sparse-checkout set "$src"
  cp -R "$repo_dir/$src" "$root/skills/$name"
done <<'EOF'
sifli-build-win OpenSiFli/SiFli-SDK main skills/sifli-build-win
sftool OpenSiFli/sftool master skills/sftool
sifli-sdk-codekit OpenSiFli/SiFli-SDK-CodeKit main skills/sifli-sdk-codekit
EOF
