#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
ARTICLES_DIR="$ROOT_DIR/site/articles"

if [ ! -d "$ARTICLES_DIR" ]; then
  echo "site/articles not found"
  exit 1
fi

cd "$ARTICLES_DIR"

# Build list of markdown files excluding backups
mapfile -t md_files < <(find . -maxdepth 1 -type f -name "*.md" ! -name "*.bak*" ! -name "*.backup*" -print)

if [ ${#md_files[@]} -eq 0 ]; then
  echo "No markdown files found"
  exit 0
fi

python3 convert_md.py "${md_files[@]}"
