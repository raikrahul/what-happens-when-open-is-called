# Stat Variants and Empty Paths

## 1. stat(path)
- Resolves the pathname string. Empty string `""` fails with `-ENOENT`.
- Inode example: `stat("/etc/passwd") -> inode 789942`.

## 2. fstat(fd)
- Uses the open descriptor directly; no lookup. Works even if the name was renamed after open.
- Example: open `/etc/passwd` then `fstat(fd)` returns inode 789942.

## 3. fstatat(dirfd, path, flags)
- Performs relative lookup inside `dirfd` with optional flags.
- `fstatat(dirfd, "passwd", 0)` resolves the child entry (inode 789942).
- `fstatat(dirfd, "", AT_EMPTY_PATH)` skips lookup and returns metadata of `dirfd` itself (inode 786433).
- `fstatat(dirfd, "", 0)` fails (`ENOENT`) because empty string still forces a lookup unless `AT_EMPTY_PATH` is set.
- `AT_SYMLINK_NOFOLLOW` can be combined to control symlink handling.

## Demo summary
- `03_trinity_stat_demo.c` shows all five behaviors: `stat`, `fstat`, `fstatat(..., AT_EMPTY_PATH)`, failing empty string, and explicit child lookup.
- Running the updated demo prints the success/failure and inodes for each case.
- The empty-path demo (`02_empty_path_demo.c`) shows `open("")` fails while `fstatat(dirfd, "", AT_EMPTY_PATH)` succeeds.

## Why AT_EMPTY_PATH exists
- It prevents redundant lookups when you already hold a directory descriptor (`dirfd`).
- Without it you must supply a name ("." or otherwise), which repeats pathname traversal and can race with renames.
- This makes directory-relative syscalls atomic: you operate on the descriptor you already opened without pulling a string out of thin air.
