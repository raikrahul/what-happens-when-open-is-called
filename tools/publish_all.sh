#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT_DIR"

./tools/build_site.sh

git add -A

if git diff --cached --quiet; then
  echo "No changes to commit"
  exit 0
fi

MSG=${MSG:-"Update content"}

git commit -m "$MSG"

git push
