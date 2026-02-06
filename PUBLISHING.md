# Publishing

This repo keeps site source in `site/`. A GitHub Action publishes it to `gh-pages` on every push to `main`.

## One-time setup

1. Set `main` as the default branch.
2. In GitHub Pages settings, set Source = `gh-pages`.

## Publish

Push to `main`. The workflow in `.github/workflows/publish_site.yml` will deploy `site/` to `gh-pages`.

## Notes

- Published URLs remain stable because the output paths in `site/` match the existing `gh-pages` layout.
- Keep generated binaries and kernel build artifacts out of git; rebuild as needed.
