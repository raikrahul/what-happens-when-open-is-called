#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
SITE_DIR="$ROOT_DIR/site"
WORKTREE_DIR="$ROOT_DIR/.worktrees/gh-pages"

if [ ! -d "$SITE_DIR" ]; then
  echo "site/ not found"
  exit 1
fi

if ! git -C "$ROOT_DIR" show-ref --verify --quiet refs/heads/gh-pages; then
  echo "gh-pages branch not found. Create it first."
  exit 1
fi

if [ ! -d "$WORKTREE_DIR" ]; then
  mkdir -p "$ROOT_DIR/.worktrees"
  git -C "$ROOT_DIR" worktree add "$WORKTREE_DIR" gh-pages
fi

# Clear worktree (except .git) and copy site content
find "$WORKTREE_DIR" -mindepth 1 -maxdepth 1 -not -name .git -exec rm -rf {} +

if command -v rsync >/dev/null 2>&1; then
  rsync -a "$SITE_DIR"/ "$WORKTREE_DIR"/
else
  cp -a "$SITE_DIR"/. "$WORKTREE_DIR"/
fi

echo "Site copied to gh-pages worktree. Commit and push from: $WORKTREE_DIR"
