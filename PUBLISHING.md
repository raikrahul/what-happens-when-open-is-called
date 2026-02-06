# Publishing

This repo keeps site source in `site/`. A GitHub Action publishes it to `gh-pages` on every push to `main`.

## One-time setup

1. Set `main` as the default branch.
2. In GitHub Pages settings, set Source = `gh-pages`.

## Publish

Push to `main`. The workflow in `.github/workflows/publish_site.yml` will:

1. Build HTML from Markdown using `tools/build_site.sh`.
2. Deploy `site/` to `gh-pages`.

## One-Command Publish

```bash
make publish MSG="Update stage2 return"
```

This will build, commit, and push. The GitHub Action will handle deployment.

## Git Hook

This repo enables a local pre-commit hook that rebuilds HTML so you never
commit out-of-date HTML.

## Notes

- Published URLs remain stable because the output paths in `site/` match the existing `gh-pages` layout.
- Keep generated binaries and kernel build artifacts out of git; rebuild as needed.
