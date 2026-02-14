# GitHub CLI Commands Playbook

## A) Verify Auth
```bash
gh auth status
```

## B) Create Public Product Repo (if needed)
```bash
gh repo create <your-org-or-user>/<repo-name> --public --source=. --remote=origin --push
```

## C) Create Private Paid Repo
```bash
gh repo create <your-org-or-user>/<repo-name>-pro --private
```

## D) Create labels for issue-based roadmap
```bash
gh label create "pack:free" --color 0E8A16 || true
gh label create "pack:pro" --color 5319E7 || true
gh label create "status:planned" --color FBCA04 || true
gh label create "status:in-progress" --color 1D76DB || true
gh label create "status:released" --color 0E8A16 || true
```

## E) Create launch issues
```bash
gh issue create --title "Release free case pack #1" --body "Publish case pack with worksheet and runbook" --label "pack:free,status:planned"
gh issue create --title "Release pro case pack #1" --body "Add advanced proof workflow and private worksheet" --label "pack:pro,status:planned"
```

## F) Create release tag for a pack
```bash
git tag -a pack-v0.1.0 -m "Case pack v0.1.0"
git push origin pack-v0.1.0
gh release create pack-v0.1.0 --title "Case Pack v0.1.0" --notes "Free pack release"
```

## G) Optional: create GitHub Project (kanban)
```bash
gh project create --owner @me --title "Kernel Case Packs"
```

## H) Optional: add sponsor link file later
Create `.github/FUNDING.yml` manually when handles are ready.
