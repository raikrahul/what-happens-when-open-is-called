# Corrected Full Trace (Ext4 Missing File Case)

## Verified Environment Facts (from this machine)
- Target path mount: `/` on `/dev/nvme0n1p4`
- Filesystem type: `ext4`
- Evidence:
  - `findmnt -T <case17_path>` -> `FSTYPE=ext4`
  - ext4 inode ops table in `/usr/src/linux-hwe-6.17-6.17.0/fs/ext4/namei.c:4214-4233` has `.lookup = ext4_lookup`, but **no `.atomic_open`**.

## Critical Correction
- In this kernel + ext4 path, `lookup_open()` **does not call `atomic_open()`** because:
  - gate is `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3686`
  - condition `if (dir_inode->i_op->atomic_open)` is false for ext4 here.
- Therefore your missing-file trace follows the **non-atomic lookup path** (`i_op->lookup`), not `atomic_open`.

---

## Full Step Trace (CALL / RESUME / DONE)

#1.CALL user `open()`
- Caller: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger.c:18`
- Values: `filename=/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case17_do_filp_open_deep_trace/missing_case17_filp.txt`, `flags=O_RDONLY(0)`
- Work: userspace syscall request.

#2.CALL kernel `do_sys_openat2`
- Current: `/usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1420`
- Values: `dfd=-100 (AT_FDCWD)`, `how.flags=0`

#3.DONE build flags
- `/usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1427-1429`

#4.DONE getname
- `/usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1431-1433`
- `tmp=struct filename*` created.

#5.DONE reserve fd slot
- `/usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1435`

#6.CALL `do_filp_open`
- Caller: `/usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1437`
- Current: `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4073`

#7.CALL `path_openat`
- Caller: `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4081`
- Current: `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4034`

#8.DONE alloc empty file
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4040`
- `file=alloc_empty_file(...)`

#9.CALL loop (`link_path_walk` + `open_last_lookups`)
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4050-4052`

#10.CALL `open_last_lookups`
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3768`

#11.CALL `lookup_fast_for_open`
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3786`
- Missing random file -> typically no positive hit.

#12.CALL `lookup_open`
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3815`
- Current function starts `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3618`

#13.CALL `d_lookup` (hash/list lookup)
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3635`
- Calls `__d_lookup` in `/usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2339`
- Hash list walk at `/usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2392`
- On first random miss: returns `NULL`.

#14.DONE miss branch `if (!dentry)`
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3637`

#15.CALL `d_alloc_parallel`
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3638`
- Function body: `/usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:2542+`
- Work: allocate in-lookup dentry candidate; race-check in-lookup hash list.

#16.DONE `IS_ERR(dentry)` check after alloc
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3639-3640`
- Normal missing-file path: false (not allocator failure).

#17.RESUME in `lookup_open`: `atomic_open` gate check
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3686`
- Condition: `if (dir_inode->i_op->atomic_open)`
- **Result in this ext4 build: false**.

#18.CALL non-atomic ext4 lookup path
- Enters block `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3693`
- Calls `dir_inode->i_op->lookup(...)` at `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3694`
- For ext4 this is `ext4_lookup` (`/usr/src/linux-hwe-6.17-6.17.0/fs/ext4/namei.c:1762`, wired at `4216`).

#19.DONE ext4 lookup result
- ext4 lookup ends with `return d_splice_alias(inode, dentry);` at `/usr/src/linux-hwe-6.17-6.17.0/fs/ext4/namei.c:1814`
- Missing file -> `inode=NULL` -> returns dentry as negative.

#20.DONE lookup completion sync
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3696` -> `d_lookup_done(dentry)`

#21.RESUME `lookup_open` return
- No `O_CREAT` branch (since `open_flag=O_RDONLY`) so create block skipped (`3707+`).
- Returns dentry at `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3725`.

#22.RESUME `open_last_lookups`
- `IS_ERR(dentry)` false (`3830`), `FMODE_OPENED|FMODE_CREATED` false (`3833`).
- Goes to `finish_lookup` and calls `step_into(...)` (`3842`).

#23.CALL `step_into`
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:1970`
- In RCU branch, if `inode==NULL`, returns `ERR_PTR(-ENOENT)` at line `1988`.

#24.RESUME `open_last_lookups` returns error pointer
- `res` from `step_into` is error ptr, returned upward (`3842-3845`).

#25.RESUME `path_openat`
- loop assigns `error = link_path_walk(s, nd)` with `s=ERR_PTR(-ENOENT)` and propagates to error path.
- cleanup: `fput_close(file)` at `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4063`
- return `ERR_PTR(error)` at `4070`.

#26.RESUME `do_filp_open` returns error pointer
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4087`

#27.RESUME `do_sys_openat2` handles error
- `IS_ERR(f)` true at `/usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1438`
- `put_unused_fd(fd)` line `1439`
- `fd = PTR_ERR(f)` line `1440` -> `fd=-2`
- return `-2` line `1446`.

#28.DONE userspace result
- libc maps kernel `-2` to `fd=-1`, `errno=2 (ENOENT)` at `user_trigger.c:19-21`.

---

## Deep Detail: Why `do_open()` Was Not Called In This Missing-File Run

This is the exact control gate in `path_openat()`:

- File: `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c`
- Lines:
  - `4050-4052` loop:
    - `while (!(error = link_path_walk(s, nd)) && (s = open_last_lookups(nd, file, op)) != NULL) ;`
  - `4054` gate:
    - `if (!error) error = do_open(nd, file, op);`

So `do_open()` is **strictly conditional** on `error == 0` at line `4054`.

In your missing-file run:

1. `open_last_lookups()` eventually returns an error pointer path (`-ENOENT` propagated through the loop mechanics).
2. Next loop evaluation pushes `error` negative.
3. At line `4054`, condition `if (!error)` is false because `error = -2`.
4. Therefore `do_open()` is skipped.
5. `path_openat()` goes directly to cleanup:
   - `fput_close(file)` at line `4063`
   - `return ERR_PTR(error)` at line `4070`

### Numeric branch truth table for your run

- At `namei.c:4054`:
  - `error = 0`  -> would call `do_open()` (not your case)
  - `error = -2` -> skip `do_open()` (**your case**)

### Consequence

- Since `do_open()` is skipped, this path does **not** execute:
  - `vfs_open(&nd->path, file)` at `namei.c:3895`
- Therefore no successful file-open installation into returned `file*` happens in this run.

---

## Deep Detail: Who Installs `dentry` Into `struct file *` On Success

For your ext4 non-atomic path, successful installation happens via `do_open()` -> `vfs_open()`:

1. `do_open()` call site:
   - `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:4054`
2. `do_open()` internals:
   - `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:3895`
   - calls `vfs_open(&nd->path, file)`
3. `vfs_open()` assignment:
   - `/usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1096`
   - `file->f_path = *path;`
   - this copies both:
     - `file->f_path.mnt`
     - `file->f_path.dentry`

So for successful opens, the install point is concrete and direct:

- `open.c:1096` -> `file->f_path = *path`

For your missing-file run:

- this line is never reached (because `do_open()` is never called).

---

## Direct answer to your key question
Q: "Is this where dentry is attached to struct file in my case?"
- In **this ext4 path**, `atomic_open` branch is not taken, so that specific `atomic_open` file->f_path logic is not your active branch.
- Your path is non-atomic `i_op->lookup` (`ext4_lookup`) with negative dentry flow, then ENOENT.
- Temporary `struct file` is still created in `path_openat` and later cleaned by `fput_close` because open fails.
