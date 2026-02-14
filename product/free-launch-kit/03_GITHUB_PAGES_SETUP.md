# GitHub Pages Setup (Free)

## Option 1: Use existing `site/` folder in this repo
1. Build site (if your project already supports it):
```bash
make build-site
```
2. Publish to `gh-pages` branch:
```bash
make publish MSG="publish case pack page"
```
3. In GitHub repo settings:
- Pages -> Source -> Deploy from branch
- Branch: `gh-pages`
- Folder: `/ (root)`

## Option 2: Native Pages from `/docs`
1. Create `docs/index.md` and docs pages.
2. Repo settings -> Pages -> Source:
- Branch: `main`
- Folder: `/docs`

## Minimal Public Page Structure
1. Home page: what this project does.
2. Free Pack page: what is included, download/use steps.
3. Pro Pack page: what paid includes, where to buy.
4. Proof Gallery page: screenshots/log snippets.
5. Contact page: GitHub Discussions + email.

## Publish Rule
- Keep one URL stable.
- Do not rename main pages every week.
- Add new packs as new subpages.
