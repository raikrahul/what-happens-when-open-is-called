# Publishing

This repo keeps site source in `site/` and publishes the built output to the `gh-pages` branch.

## One-time setup

1. Ensure `gh-pages` exists on the remote.
2. Set `main` as the default branch.

## Publish

```bash
./tools/publish_site.sh
# then:
# git -C .worktrees/gh-pages add -A
# git -C .worktrees/gh-pages commit -m "Update site"
# git -C .worktrees/gh-pages push
```

## Notes

- Published URLs remain stable because the output paths in `site/` match the existing `gh-pages` layout.
- Keep generated binaries and kernel build artifacts out of git; rebuild as needed.
