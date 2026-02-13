# Conversation Log (partial)
*Purpose:* Capture key requests/results for later reading; not committed.

## Kernel tracing
- Stages 1-2-2b walked user->syscall, `getname`, dcache insert.
- Stage 3 scaffolding added: component walk program + explanation/worksheet/textbook.
- Stage 3 site pages and index updated; site rebuilt.

## Kernel workspace & tooling
- Installed ubuntu-mainline-kernel.sh script, updated to 6.18.7 images via `-i --yes`.
- Documented lack of dbgsym packages; Linux debug build estimate 1-3h.
- Installed multi-component program to drive new tracing.

## Next tracing direction
- Probing targeted functions: `link_path_walk`, `walk_component`, `lookup_fast`, `path_openat` callers.
- Plan to record `qstr` pointer/len/hash per component for `/tmp/alpha/.../delta.txt`.

## Devops additions
- Added Sublime project request pending, created new stage folder structure and markdown scaffolding.
- Stage 3 structured with recap intros referencing earlier stages.

(TODO: keep this file untracked per request.)
