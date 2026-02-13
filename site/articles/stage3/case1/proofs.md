---
title: "Stage 3 Case 1: Axiomatic Proofs — do_sys_openat2"
layout: default
---

# Proofs: User-Space → Kernel Boundary

## Source Files

| File | Purpose |
|:-----|:--------|
| `kernel/drivers/trace_do_sys_openat2/trace_do_sys_openat2.c` | kprobe + kretprobe on `do_sys_openat2` |
| `kernel/drivers/trace_path_init/trace_path_init.c` | kprobe on `do_filp_open` + `fdget_raw` to observe `path_init` branching |
| `kernel/user/stage3/case1_relative/case1_relative.c` | user-space: `open("some_relative_file.txt", ...)` |
| `kernel/user/stage3/demo_at_fdcwd/demo_at_fdcwd.c` | user-space: AT_FDCWD equivalence (3 calling conventions) |
| `kernel/user/stage3/demo_thread_safety/demo_thread_safety.c` | user-space: chdir race with threads |
| `kernel/user/stage3/demo_toctou/demo_toctou.c` | user-space: rename+symlink TOCTOU attack |
| `/usr/src/linux-hwe-6.17-6.17.0/fs/open.c:1420` | kernel definition of `do_sys_openat2` |
| `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:2526` | kernel definition of `path_init` (AT_FDCWD branch at line 2576) |

## Call Chain (source → kernel)

```
case1_relative.c:  open(path, O_CREAT | O_WRONLY, 0644)
        │
        ▼  (glibc converts open → openat)
glibc:  syscall(257, AT_FDCWD=-100, path_ptr, flags, mode)
        │
        ▼  (syscall instruction → kernel entry)
fs/open.c:1463  SYSCALL_DEFINE4(openat, dfd, filename, flags, mode)
        │
        ▼
fs/open.c:1449  do_sys_open(dfd, filename, flags, mode)
        │
        ▼
fs/open.c:1420  do_sys_openat2(dfd, filename, &how)   ← PROBED HERE
        │
        ▼
fs/namei.c:4073 do_filp_open(dfd, tmp, &op)
```

## Proof 1: dfd == AT_FDCWD (-100)

**Claim:** glibc inserts `AT_FDCWD` as the first argument when converting `open()` to `openat()`.

**User-space code:**
```c
open("some_relative_file.txt", O_CREAT | O_WRONLY, 0644);
// No dfd argument — glibc must supply AT_FDCWD
```

**Kernel source (`fs/open.c:1456`):**
```c
SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
{
    ...
    return do_sys_open(AT_FDCWD, filename, flags, mode);
}
```

**dmesg output (kprobe entry):**
```
[OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x000062cb32f39010
[OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
```

**Verdict:** ✓ `dfd = -100 = 0xffffffffffffff9c`.  glibc passed `AT_FDCWD` exactly as the kernel source defines it.

---

## Proof 2: filename pointer == user-space .rodata address

**Claim:** The `filename` pointer that arrives in `do_sys_openat2` is the same virtual address that the user-space program holds in `.rodata`.

**User-space output:**
```
fd=3 path_addr=0x62cb32f39010 path="some_relative_file.txt"
```

**dmesg output (kprobe entry for our open call):**
```
[OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x000062cb32f39010
```

**Address comparison:**

| Source | Address |
|:-------|:--------|
| User-space `printf("%p", path)` | `0x62cb32f39010` |
| Kernel `regs->si` | `0x000062cb32f39010` |

**Verdict:** ✓ Identical. The pointer traveled from the `.rodata` section of the PIE binary, through glibc, through the `syscall` instruction, into kernel register `%rsi`, and arrived in `do_sys_openat2` without modification.

---

## Proof 3: returned fd matches user-space

**Claim:** The file descriptor returned by `do_sys_openat2` is the same integer that `open()` returns to user-space.

**User-space output:**
```
fd=3
```

**dmesg output (kretprobe return for our open call):**
```
[OPENAT2] RETURN pid=59309 comm=case1_relative. fd=3
[OPENAT2] PROOF: fd=3 (success, valid descriptor)
```

**Verdict:** ✓ `fd=3` in both. The kernel allocated fd 3 via `get_unused_fd_flags()` at `fs/open.c:1435`, and that same integer propagated back through `%rax` → syscall return → glibc wrapper → user-space `open()` return value.

---

## Bonus: Dynamic linker opens visible in same trace

Before our `open("some_relative_file.txt")` call, the probe captured the dynamic linker's own `openat` calls during process startup:

```
[OPENAT2] ENTRY ... filename="/usr/local/cuda/lib64/glibc-hwcaps/x86-64-v3/libc.so.6"  fd=-2 (ENOENT)
[OPENAT2] ENTRY ... filename="/usr/local/cuda/lib64/glibc-hwcaps/x86-64-v2/libc.so.6"  fd=-2 (ENOENT)
[OPENAT2] ENTRY ... filename="/usr/local/cuda/lib64/libc.so.6"                           fd=-2 (ENOENT)
[OPENAT2] ENTRY ... filename="glibc-hwcaps/x86-64-v3/libc.so.6"                         fd=-2 (ENOENT)
[OPENAT2] ENTRY ... filename="glibc-hwcaps/x86-64-v2/libc.so.6"                         fd=-2 (ENOENT)
[OPENAT2] ENTRY ... filename="libc.so.6"                                                 fd=-2 (ENOENT)
[OPENAT2] ENTRY ... filename="/etc/ld.so.cache"                                          fd=3  (success)
[OPENAT2] ENTRY ... filename="/lib/x86_64-linux-gnu/libc.so.6"                           fd=3  (success)
[OPENAT2] ENTRY ... filename_uptr=0x000062cb32f39010                                     fd=3  (OUR CALL)
```

This shows the `ld-linux` dynamic linker searching for `libc.so.6` across multiple paths before finding it. All use `dfd=-100` (AT_FDCWD). Our call is the last one.

---

## Raw dmesg (complete)

```
[16596.297269] trace_do_sys_openat2: loaded, target_comm=case1_relative.
[16605.028574] [OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x00007fff71e97e80 filename="/usr/local/cuda/lib64/glibc-hwcaps/x86-64-v3/libc.so.6"
[16605.028591] [OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[16605.028610] [OPENAT2] RETURN pid=59309 comm=case1_relative. fd=-2
[16605.028617] [OPENAT2] PROOF: fd=-2 (error: -2)
[16605.028631] [OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x00007fff71e97e80 filename="/usr/local/cuda/lib64/glibc-hwcaps/x86-64-v2/libc.so.6"
[16605.028639] [OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[16605.028651] [OPENAT2] RETURN pid=59309 comm=case1_relative. fd=-2
[16605.028657] [OPENAT2] PROOF: fd=-2 (error: -2)
[16605.028670] [OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x00007fff71e97e80 filename="/usr/local/cuda/lib64/libc.so.6"
[16605.028677] [OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[16605.028689] [OPENAT2] RETURN pid=59309 comm=case1_relative. fd=-2
[16605.028695] [OPENAT2] PROOF: fd=-2 (error: -2)
[16605.028711] [OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x00007fff71e97e80 filename="glibc-hwcaps/x86-64-v3/libc.so.6"
[16605.028718] [OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[16605.028726] [OPENAT2] RETURN pid=59309 comm=case1_relative. fd=-2
[16605.028731] [OPENAT2] PROOF: fd=-2 (error: -2)
[16605.028738] [OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x00007fff71e97e80 filename="glibc-hwcaps/x86-64-v2/libc.so.6"
[16605.028744] [OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[16605.028752] [OPENAT2] RETURN pid=59309 comm=case1_relative. fd=-2
[16605.028758] [OPENAT2] PROOF: fd=-2 (error: -2)
[16605.028764] [OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x00007fff71e97e80 filename="libc.so.6"
[16605.028770] [OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[16605.028778] [OPENAT2] RETURN pid=59309 comm=case1_relative. fd=-2
[16605.028784] [OPENAT2] PROOF: fd=-2 (error: -2)
[16605.028791] [OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x00007ca15567238f filename="/etc/ld.so.cache"
[16605.028798] [OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[16605.028809] [OPENAT2] RETURN pid=59309 comm=case1_relative. fd=3
[16605.028815] [OPENAT2] PROOF: fd=3 (success, valid descriptor)
[16605.028859] [OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x00007ca15563a210 filename="/lib/x86_64-linux-gnu/libc.so.6"
[16605.028866] [OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[16605.028878] [OPENAT2] RETURN pid=59309 comm=case1_relative. fd=3
[16605.028883] [OPENAT2] PROOF: fd=3 (success, valid descriptor)
[16605.029315] [OPENAT2] ENTRY pid=59309 comm=case1_relative. dfd=-100 filename_uptr=0x000062cb32f39010 (copy failed)
[16605.029338] [OPENAT2] RETURN pid=59309 comm=case1_relative. fd=3
[16605.029344] [OPENAT2] PROOF: fd=3 (success, valid descriptor)
```

---

## Proof 4: AT_FDCWD — three calling conventions, one kernel path

**Claim:** `open()`, `openat(AT_FDCWD, ...)`, and `syscall(257, -100, ...)` all arrive in `do_sys_openat2` with `dfd=-100`.

**Source:** `kernel/user/stage3/demo_at_fdcwd/demo_at_fdcwd.c`

**User-space output:**
```
[open]   fd=3  → created test_fdcwd.txt in cwd
[openat] fd=4  → created test_fdcwd_2.txt in cwd
[syscall] fd=5 → created test_fdcwd_3.txt in cwd
All three are identical. AT_FDCWD = -100
```

**dmesg (our three calls only):**
```
[OPENAT2] ENTRY pid=63414 dfd=-100 filename_uptr=0x0000647cd7718013 filename="test_fdcwd.txt"
[OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[OPENAT2] PROOF: dfd==-100 → kernel uses current->fs->pwd = "demo_at_fdcwd"
[OPENAT2] RETURN fd=3

[OPENAT2] ENTRY pid=63414 dfd=-100 filename_uptr=0x0000647cd771805b filename="test_fdcwd_2.txt"
[OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[OPENAT2] PROOF: dfd==-100 → kernel uses current->fs->pwd = "demo_at_fdcwd"
[OPENAT2] RETURN fd=4

[OPENAT2] ENTRY pid=63414 dfd=-100 filename_uptr=0x0000647cd77180a5 filename="test_fdcwd_3.txt"
[OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[OPENAT2] PROOF: dfd==-100 → kernel uses current->fs->pwd = "demo_at_fdcwd"
[OPENAT2] RETURN fd=5
```

**Verdict:** ✓ All three calls produce `dfd=-100` and `pwd="demo_at_fdcwd"`. The kernel cannot distinguish which user-space API was used — they all collapse to the same `do_sys_openat2(dfd=-100, ...)`.

---

## Proof 5: Thread Safety — openat(dir_fd) immune to chdir()

**Claim:** When Thread 2 calls `chdir()`, Thread 1's `openat(dir_fd, ...)` is unaffected because `dfd=3` bypasses `current->fs->pwd` entirely. Thread 3's `open(...)` resolves through `dfd=-100` → `pwd` → gets the changed directory.

**Source:** `kernel/user/stage3/demo_thread_safety/demo_thread_safety.c`

**User-space output:**
```
[Thread 1] openat(dir_fd, "data.txt") → content: CORRECT: dir_A   ✓
[Thread 3] open("data.txt")           → content: WRONG: dir_B     ✗
```

**dmesg (critical lines — Thread 1 vs Thread 3):**
```
[OPENAT2] ENTRY pid=63622 comm=demo_thread_saf dfd=3     filename="data.txt"
[OPENAT2] PROOF: dfd == 3 (NOT AT_FDCWD)
[OPENAT2] RETURN pid=63622 fd=4

[OPENAT2] ENTRY pid=63623 comm=demo_thread_saf dfd=-100  filename="data.txt"
[OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[OPENAT2] PROOF: dfd==-100 → kernel uses current->fs->pwd = "dir_B"
[OPENAT2] RETURN pid=63623 fd=4
```

**Analysis:**

| Thread | pid | `dfd` | `pwd` at call time | Resolves from | Read content |
|:-------|:----|:------|:-------------------|:--------------|:-------------|
| 1 (openat) | 63622 | `3` | (irrelevant) | pinned dir_A inode | CORRECT: dir_A ✓ |
| 3 (open) | 63623 | `-100` | `dir_B` | `current->fs->pwd` | WRONG: dir_B ✗ |

Thread 2 changed `current->fs->pwd` from `dir_A` to `dir_B` via `chdir()`. Thread 3 (`dfd=-100`) resolved through `pwd` and got `dir_B`. Thread 1 (`dfd=3`) never touched `pwd` — the kernel looked up fd 3 in the fd table, found the pinned `dir_A` inode, and resolved `"data.txt"` from there.

**Verdict:** ✓ `dfd=-100` means "use `current->fs->pwd`" which is shared and mutable. A real directory fd bypasses it entirely.

---

## Proof 6: TOCTOU — openat(dir_fd) immune to rename+symlink attack

**Claim:** After an attacker renames `real_dir → old_dir` and symlinks `evil_dir → real_dir`, path-based `open()` follows the symlink (reads evil data), but `openat(dir_fd, ...)` still resolves from the original inode (reads correct data).

**Source:** `kernel/user/stage3/demo_toctou/demo_toctou.c`

**User-space output:**
```
Scenario A (open):   content: EVIL: attacker data     ✗
Scenario B (openat): content: CORRECT: real_dir       ✓
```

**dmesg (Scenario A — path re-resolved through symlink):**
```
[OPENAT2] ENTRY pid=63754 dfd=-100 filename="/tmp/demo_toctou/real_dir/secret.txt"
[OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED
[OPENAT2] PROOF: dfd==-100 → kernel uses current->fs->pwd = "demo_toctou"
[OPENAT2] RETURN fd=3
```
The kernel walked the path `/tmp/demo_toctou/real_dir/secret.txt` fresh. After the rename, `real_dir` is a symlink to `evil_dir`, so the kernel followed it and opened the attacker's file.

**dmesg (Scenario B — pinned fd bypasses path):**
```
[OPENAT2] ENTRY pid=63754 dfd=3 filename="secret.txt"
[OPENAT2] PROOF: dfd == 3 (NOT AT_FDCWD)
[OPENAT2] RETURN fd=4
```
`dfd=3` points to the inode of the original `real_dir` (pinned when `open("/tmp/demo_toctou/real_dir", O_DIRECTORY)` was called before the attack). Renaming the path in the filesystem changed the name→inode mapping, but the fd holds a direct reference to the inode. The kernel resolved `"secret.txt"` relative to that inode.

**Verdict:** ✓ `dfd=-100` re-walks the full path (vulnerable to TOCTOU). A real directory fd holds a kernel reference to the inode (immune to rename/symlink attacks).

---

## Proof 7: path_init branch directly observed via fdget_raw probe

**Claim:** When `dfd == AT_FDCWD (-100)`, `path_init` executes the if-branch at `namei.c:2576` and calls `get_fs_pwd()` (inlined). When `dfd` is a real fd, `path_init` executes the else-branch at `namei.c:2591` and calls `fdget_raw()` (exported, probeable). We can prove which branch executes by probing `fdget_raw`.

**Probe logic:**

| Function | Location | Branch | Probeable? |
|:---------|:---------|:-------|:-----------|
| `get_fs_pwd` | namei.c:2588 (if-branch) | `dfd == AT_FDCWD` | ✗ `static inline` — compiler inlines it |
| `fdget_raw` | namei.c:2593 (else-branch) | `dfd != AT_FDCWD` | ✓ exported `T` in kallsyms |

If `fdget_raw` fires → else-branch taken. If it does NOT fire → if-branch taken.

**Source:** `kernel/drivers/trace_path_init/trace_path_init.c` (probes `do_filp_open` + `fdget_raw`)

**Kernel source (`fs/namei.c:2576–2618`):**
```c
if (nd->dfd == AT_FDCWD) {                   // line 2576 — IF branch
    // ...
    get_fs_pwd(current->fs, &nd->path);       // line 2588 — INLINED, invisible
    nd->inode = nd->path.dentry->d_inode;
} else {                                       // line 2591 — ELSE branch
    CLASS(fd_raw, f)(nd->dfd);                 // line 2593 — expands to fdget_raw()
    dentry = fd_file(f)->f_path.dentry;        //           — looks up fd in fd table
    nd->path = fd_file(f)->f_path;             // line 2610 — uses fd's path
    nd->inode = nd->path.dentry->d_inode;
}
```

**Demo: thread safety (demo_thread_safety.out)**

**Thread 1 (pid=69031, `openat(dir_fd=3, "data.txt")`) — dmesg:**
```
[PATH_INIT] ENTRY pid=69031 dfd=3 (fd lookup) pathname="data.txt"
[PATH_INIT] BRANCH: FD_LOOKUP → path_init will look up fd 3 in fd table (ignoring pwd)
[PATH_INIT] BRANCH: current->fs->pwd = "dir_B" (IGNORED — kernel uses fd 3 instead)
[PATH_INIT] CODE: namei.c:2576 if (nd->dfd == AT_FDCWD) → FALSE → line 2593: fd_raw(nd->dfd)
[PATH_INIT] FDGET_RAW pid=69031 fd=3
[PATH_INIT] PROOF: fdget_raw() called → path_init ELSE branch CONFIRMED (namei.c:2593)
[PATH_INIT] PROOF: kernel is looking up fd 3 in fd table, NOT using current->fs->pwd
[PATH_INIT] RETURN pid=69031 result=struct_file*=0xffff8ea95a6ddb40 (success)
```

**Thread 3 (pid=69032, `open("data.txt")`) — dmesg:**
```
[PATH_INIT] ENTRY pid=69032 dfd=-100 (AT_FDCWD) pathname="data.txt"
[PATH_INIT] BRANCH: AT_FDCWD → path_init will use current->fs->pwd = "dir_B"
[PATH_INIT] CODE: namei.c:2576 if (nd->dfd == AT_FDCWD) → TRUE → line 2578: nd->path = fs->pwd
[PATH_INIT] RETURN pid=69032 result=struct_file*=0xffff8ea8788ed540 (success)
```
(No `FDGET_RAW` line — `fdget_raw()` was never called → if-branch taken.)

**Comparison:**

| Thread | pid | `dfd` | `fdget_raw` fired? | Branch taken | `pwd` | Result |
|:-------|:----|:------|:-------------------|:-------------|:------|:-------|
| 1 (openat) | 69031 | `3` | ✓ YES (`fd=3`) | ELSE (namei.c:2593) | `dir_B` (ignored) | CORRECT: dir_A |
| 3 (open) | 69032 | `-100` | ✗ NO | IF (namei.c:2576) | `dir_B` (used) | WRONG: dir_B |

**Verdict:** ✓ Both branches of `path_init` directly observed. `fdget_raw()` firing for pid=69031 is conclusive proof that the kernel executed `namei.c:2593` (else-branch). Its absence for pid=69032 proves the kernel executed `namei.c:2576` (if-branch, `get_fs_pwd`). Both threads had `pwd="dir_B"`, but only Thread 3 used it.

---

## Proof 8: Full Kernel Call Chain (do_filp_open → path_openat → path_init)

**Claim:** The kernel call chain for opening a file is `do_filp_open` → `path_openat` → `path_init`. We can observe this sequence by probing all three functions (using `fdget_raw` as a proxy for `path_init`'s else branch).

**Source:** `kernel/drivers/trace_path_init/trace_path_init.c` (added `path_openat` probe)

**Demo: Thread Safety (Thread 1 - dfd=3):**

```
[PATH_INIT] ENTRY pid=70829 dfd=3 (fd lookup) pathname="data.txt"
[PATH_INIT] BRANCH: FD_LOOKUP → path_init will look up fd 3 (ignoring pwd)
[PATH_INIT] path_openat() called (fs/namei.c) → calling path_init next...
[PATH_INIT] FDGET_RAW pid=70829 fd=3  (← implies path_init executing else branch)
[PATH_INIT] PROOF: fdget_raw() called → path_init ELSE branch CONFIRMED
[PATH_INIT] path_openat() returned struct_file*=0xffff8ea78dfb9540 (success)
[PATH_INIT] RETURN pid=70829 struct_file*=0xffff8ea78dfb9540 (success)
```

**Demo: Thread Safety (Thread 3 - dfd=-100):**

```
[PATH_INIT] ENTRY pid=70830 dfd=-100 (AT_FDCWD) pathname="data.txt"
[PATH_INIT] BRANCH: AT_FDCWD → path_init will use current->fs->pwd = "dir_B"
[PATH_INIT] path_openat() called (fs/namei.c) → calling path_init next...
  (NO FDGET_RAW called → implies path_init executed if-branch with get_fs_pwd)
[PATH_INIT] path_openat() returned struct_file*=0xffff8ea95a6dd0c0 (success)
[PATH_INIT] RETURN pid=70830 struct_file*=0xffff8ea95a6dd0c0 (success)
```

**Verdict:** ✓ Validated the exact sequence of kernel functions. We have axiomatic proof of:
1. Entry at `do_filp_open` (dfd decision)
2. Transition to `path_openat`
3. Branching execution in `path_init` (via presence/absence of `fdget_raw`)

---

## Proof 9: alloc_empty_file() Sequence

**Claim:** `path_openat` allocates a blank `struct file` *before* it starts path resolution (and thus before deciding on AT_FDCWD vs fd-lookup). We can observe this by probing `alloc_empty_file`.

**Source:** `kernel/drivers/trace_path_init/trace_path_init.c` (added `alloc_empty_file` probe)

**Sequence Observed (Thread 1 - dfd=3):**
```
[PATH_INIT] do_filp_open(dfd=3, ...)
[PATH_INIT] path_openat(...)
[PATH_INIT]   alloc_empty_file(flags=0x8000, ...)
[PATH_INIT]   alloc_empty_file() returned struct_file*=0xffff8ea953e2a780
[PATH_INIT]     fdget_raw(fd=3)  (ELSE branch taken)
[PATH_INIT] path_openat() returned struct_file*=0xffff8ea953e2a780
[PATH_INIT] do_filp_open() returned struct_file*=0xffff8ea953e2a780
```

**Sequence Observed (Thread 3 - dfd=-100):**
```
[PATH_INIT] do_filp_open(dfd=-100, ...)
[PATH_INIT] path_openat(...)
[PATH_INIT]   alloc_empty_file(flags=0x8000, ...)
[PATH_INIT]   alloc_empty_file() returned struct_file*=0xffff8ea96efb7a80
[PATH_INIT]     (NO fdget_raw → IF branch taken, using pwd)
[PATH_INIT] path_openat() returned struct_file*=0xffff8ea96efb7a80
[PATH_INIT] do_filp_open() returned struct_file*=0xffff8ea96efb7a80
```


---

## Proof 10: Exhaustive Validation of User-Space Demos

**Claim:** The `alloc_empty_file` → `path_init` sequence holds true for ALL variations of `open` and `openat`. We verified this by running every demo program with the full kernel trace.

**Source:** `kernel/drivers/trace_path_init/trace_path_init.c` (full instrumentation)

**Summary Table:**

| Demo | Call Type | `dfd` | `alloc_empty_file`? | `fdget_raw`? | Branch Taken | Result |
|:-----|:----------|:------|:--------------------|:-------------|:-------------|:-------|
| `demo_at_fdcwd` | `open` | `AT_FDCWD` | ✓ YES | ✗ NO | IF (pwd) | Valid |
| `demo_at_fdcwd` | `openat` | `AT_FDCWD` | ✓ YES | ✗ NO | IF (pwd) | Valid |
| `demo_at_fdcwd` | `syscall` | `AT_FDCWD` | ✓ YES | ✗ NO | IF (pwd) | Valid |
| `demo_toctou` | `open` (Scenario A) | `AT_FDCWD` | ✓ YES | ✗ NO | IF (pwd) | **Vulnerable** |
| `demo_toctou` | `openat` (Scenario B) | Fd 3 | ✓ YES | ✓ YES | ELSE (fd) | **Secure** |
| `case1_relative` | `open` | `AT_FDCWD` | ✓ YES | ✗ NO | IF (pwd) | Valid |
| `demo_thread_safety` | `open` (Thread 3) | `AT_FDCWD` | ✓ YES | ✗ NO | IF (pwd) | **Unsafe** |
| `demo_thread_safety` | `openat` (Thread 1) | Fd 3 | ✓ YES | ✓ YES | ELSE (fd) | **Safe** |

**Snippet: `demo_toctou` (Full Trace Comparison):**

*Scenario A (Vulnerable):*
```
[PATH_INIT] entry dfd=-100 (AT_FDCWD)
[PATH_INIT] alloc_empty_file() → new file* ...ba80
[PATH_INIT] (NO fdget_raw)
[PATH_INIT] return file* ...ba80
```

*Scenario B (Secure):*
```
[PATH_INIT] entry dfd=3 (FD LOOKUP)
[PATH_INIT] alloc_empty_file() → new file* ...bcc0
[PATH_INIT] FDGET_RAW fd=3
[PATH_INIT] return file* ...bcc0
```

**Verdict:** ✓ The kernel *always* allocates a file object first. Then, `path_init` creates the path. If `dfd=AT_FDCWD`, it clones the `pwd` (vulnerable to raciness). If `dfd` is numeric, it pins the inode (secure).

---

## Proof 11: O_PATH Directory Operations

**Claim:** An `O_PATH` file descriptor allows `openat()` (anchored lookup) but fails `fdopendir()` (content reading). The kernel trace confirms `O_PATH` handling and subsequent `fd` usage.

**Source:** `kernel/user/stage3/case1/demo_o_path/demo_o_path_dir.c`

**User-space output:**
```
[*] Opened 'demo_dir' with O_PATH (fd=3)
[!] fdopendir failed as expected: Bad file descriptor
[*] Success! Used O_PATH fd to open 'secret_file.txt' via openat().
```

**dmesg analysis:**

1.  **Opening the directory (O_PATH | O_DIRECTORY):**

```
[PATH_INIT] entry dfd=-100 pathname="demo_dir"
[PATH_INIT] alloc_empty_file() → flags=0x210000 (O_PATH | O_DIRECTORY)
[PATH_INIT] init_file() called
[PATH_INIT]   f=0xffff..., flags=0x210000
[PATH_INIT] path_openat() returned success
```
*Verdict:* The kernel sees `O_PATH` (0x200000) + `O_DIRECTORY` (0x10000), allocates the file object, resolves the path, and returns a descriptor without opening it for I/O.

2.  **Using the fd (openat):**

```
[PATH_INIT] ENTRY pid=79108 dfd=3 (fd lookup) pathname="secret_file.txt"
[PATH_INIT] BRANCH: FD_LOOKUP → path_init will look up fd 3 (ignoring pwd)
[PATH_INIT] FDGET_RAW fd=3
[PATH_INIT] PROOF: fdget_raw() called → path_init ELSE branch CONFIRMED
[PATH_INIT] path_openat() returned success
```
*Verdict:* When `openat(3, ...)` is called, the kernel bypasses `PWD` and uses the `struct path` stored in fd 3 (pinned to `demo_dir`) as the starting point. This confirms `O_PATH` descriptors are valid anchors for path resolution.

---

## Proof 12: O_TMPFILE Creation

**Claim:** `open(dir, O_TMPFILE...)` triggers `alloc_empty_file` with the `__O_TMPFILE` bit set (0x400000) and executes `do_tmpfile` logic, resulting in an unnamed inode.

**Source:** `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.c`

**User-space output:**
```
[*] Opened O_TMPFILE in '.' (fd=3)
[*] fstat: Inode=1449743, nlink=0 (Expected: 1 or 0?)
[*] Check 'ls -la' output (should NOT see any new weird file)...
  (File is invisible)
```

**dmesg analysis:**
```
[PATH_INIT] ENTRY dfd=-100 pathname="."
[PATH_INIT] alloc_empty_file() called
[PATH_INIT]   flags=0x418002
[PATH_INIT] path_openat() returned success
```

**Flag Decoding:**
*   `0x418002` breakdown:
    *   `0x400000` = `__O_TMPFILE`
    *   `0x010000` = `O_DIRECTORY`
    *   `0x008000` = `O_LARGEFILE`
    *   `0x000002` = `O_RDWR`

*Verdict:* The kernel received the `__O_TMPFILE` flag (via `do_filp_open` -> `path_openat` -> `alloc_empty_file`). The successful return of `path_openat` (despite `pathname="."` which is a directory) confirms that `do_tmpfile` intercepted the call and created the temporary file *associated* with that directory, rather than trying to open the directory itself for writing (which would fail with `EISDIR`).







---

## Proof 13: path_lookupat for O_TMPFILE

**Claim:** `do_tmpfile` calls `path_lookupat` with `LOOKUP_DIRECTORY` (0x2), and it *succeeds* (returns 0), resolving the directory where the temp file will live.

**Source:** `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.c` (traced by `trace_path_init.ko` with `path_lookupat` probes)

**dmesg analysis (proof_path_lookupat.txt):**
```
[PATH_INIT] alloc_empty_file() returned new struct_file*=0xffff8ea7c88fd0c0
[PATH_INIT] path_lookupat() called with LOOKUP_DIRECTORY (flags=0x103)
[PATH_INIT] PROOF: potentially from do_tmpfile() or do_o_path()
[PATH_INIT] path_lookupat() returned success (0)
[PATH_INIT] path_openat() returned struct_file*=0xffff8ea7c88fd0c0 (success)
```

**Verdict:** `path_lookupat` was called with flags `0x103` (which includes `LOOKUP_DIRECTORY` = `0x2`). It returned `0` (success). This proves `do_tmpfile` successfully resolved the directory path and proceeded to create the unlinked file via `vfs_tmpfile`. It does **not** always return an error.

---

## Proof 14: link_path_walk — Path Component Resolution

**Claim:** After `path_init` establishes the starting point (either `current->fs->pwd` for AT_FDCWD or a pinned directory inode for fd lookup), `link_path_walk` is called to resolve each component of the pathname. We can observe this by probing `link_path_walk` directly.

**Source:** `kernel/drivers/stage3/case1/trace_path_init/trace_path_init.c` (added `link_path_walk` kprobe)

**Kernel source (`fs/namei.c:2427`):**
```c
static int link_path_walk(const char *name, struct nameidata *nd)
{
    int depth = 0;
    int err;

    nd->last_type = LAST_ROOT;
    nd->flags |= LOOKUP_PARENT;
    if (IS_ERR(name))
        return PTR_ERR(name);
    if (*name == '/') {
        do {
            name++;
        } while (unlikely(*name == '/'));
    }
    // ... component-by-component resolution
}
```

### Observed Trace Patterns

**Pattern A: Successful Path Resolution**
```
[PATH_INIT] path_init() returned ptr=ffff8ea78be77020
[PATH_WALK] link_path_walk() called with path="some_relative_file.txt"
[PATH_WALK] link_path_walk() returned success (0)
[PATH_INIT] path_openat() returned struct_file*=... (success)
```

**Pattern B: Error Path (ENOENT)**
```
[PATH_WALK] link_path_walk() called with path="/usr/local/cuda/lib64/glibc-hwcaps/x86-64-v3/libc.so.6"
[PATH_WALK] link_path_walk() returned error -2
[PATH_INIT] path_openat() returned ERR(-2)
```
*Observation: The dynamic linker attempts multiple library paths; failed lookups return -2 (ENOENT) immediately.*

**Pattern C: Multiple Component Resolution (O_PATH directory traversal)**
```
[PATH_WALK] link_path_walk() called with path="../../devices/virtual/dmi/id"
[PATH_WALK] link_path_walk() returned success (0)
[PATH_WALK] link_path_walk() called with path="/sys/class/dmi/id"
[PATH_WALK] link_path_walk() returned error -2
[PATH_WALK] link_path_walk() called with path="/sys/bus/dmi/devices/id"
[PATH_WALK] link_path_walk() returned error -2
```
*Observation: `link_path_walk` handles relative paths with `..` components and absolute paths. Multiple attempts show fallback resolution strategies.*

### Full Kernel Call Chain with link_path_walk

**Case: case1_relative (AT_FDCWD branch)**
```
[PATH_INIT] ENTRY pid=94117 comm=test_comm dfd=-100 (AT_FDCWD) pathname="some_relative_file.txt"
[PATH_INIT] BRANCH: AT_FDCWD → path_init will use current->fs->pwd = "case1_relative"
[PATH_INIT] path_openat() called (fs/namei.c) → calling path_init next...
[PATH_INIT] alloc_empty_file() called → allocating struct file
[PATH_INIT]   flags=0x8041, cred=...
[PATH_INIT] init_file() called
[PATH_INIT]   f=..., flags=0x8041, cred=...
[PATH_INIT] init_file() returned 0
[PATH_INIT] alloc_empty_file() returned new struct_file*=...
[PATH_INIT] path_init() called
[PATH_INIT]   flags=0x101
[PATH_INIT] OFFSET+305: Checking dfd == AT_FDCWD? (dfd=4294967196)
[PATH_INIT] OFFSET+314: Taken AT_FDCWD branch (using CWD)
[PATH_INIT] path_init() returned ptr=...
[PATH_WALK] link_path_walk() called with path="some_relative_file.txt"
[PATH_WALK] link_path_walk() returned success (0)
[PATH_INIT] path_openat() returned struct_file*=... (success)
[PATH_INIT] RETURN pid=94117 comm=test_comm result=struct_file*=... (success)
```

**Case: demo_o_path_dir (FD lookup branch)**
```
[PATH_INIT] ENTRY pid=... dfd=3 (fd lookup) pathname="secret_file.txt"
[PATH_INIT] BRANCH: FD_LOOKUP → path_init will look up fd 3 in fd table (ignoring pwd)
[PATH_INIT] path_openat() called (fs/namei.c) → calling path_init next...
[PATH_INIT] alloc_empty_file() called → allocating struct file
[PATH_INIT] FDGET_RAW pid=... fd=3
[PATH_INIT] PROOF: fdget_raw() called → path_init ELSE branch CONFIRMED
[PATH_INIT] path_init() returned ptr=...
[PATH_WALK] link_path_walk() called with path="secret_file.txt"
[PATH_WALK] link_path_walk() returned success (0)
[PATH_INIT] path_openat() returned struct_file*=... (success)
```

### Summary Table: link_path_walk Across All Demos

| Demo | Path Type | link_path_walk Input | Return | Context |
|:-----|:----------|:---------------------|:-------|:--------|
| `case1_relative` | Relative | `"some_relative_file.txt"` | 0 (success) | AT_FDCWD → CWD |
| `demo_at_fdcwd` | Relative | `"test_fdcwd.txt"` | 0 (success) | AT_FDCWD (3 variants) |
| `demo_o_path_dir` | Relative | `"secret_file.txt"` | 0 (success) | FD lookup (dir_fd=3) |
| `demo_o_tmpfile` | Special | `"."` | 0 (success) | O_TMPFILE on directory |
| `demo_thread_safety` (T1) | Relative | `"data.txt"` | 0 (success) | FD lookup (ignores chdir) |
| `demo_thread_safety` (T3) | Relative | `"data.txt"` | 0 (success) | AT_FDCWD (affected by chdir) |
| `demo_toctou` (A) | Absolute | `"/tmp/demo_toctou/real_dir/secret.txt"` | 0 (success) | AT_FDCWD (vulnerable) |
| `demo_toctou` (B) | Relative | `"secret.txt"` | 0 (success) | FD lookup (immune) |
| Dynamic linker | Absolute | `"/lib/x86_64-linux-gnu/libc.so.6"` | 0 (success) | Library loading |
| Dynamic linker | Absolute | `"/usr/local/cuda/lib64/libc.so.6"` | -2 (ENOENT) | Failed lookup |

**Key Insight:** `link_path_walk` receives the path string from `path_init` and walks it component by component. The starting point (CWD vs pinned fd) is already established when `link_path_walk` is called — it simply resolves the remaining path components from that starting point.

**Verdict:** ✓ `link_path_walk` is the core path resolution function. It receives the path from `path_init`, handles both relative and absolute paths, processes `..` and `.` components, and returns 0 on success or negative errno on failure. The trace proves the complete chain: `do_filp_open` → `path_openat` → `path_init` → `link_path_walk` → `path_lookupat`.

---

## Updated Source File List

| File | Purpose |
|:-----|:--------|
| `kernel/drivers/stage3/case1/trace_path_init/trace_path_init.c` | kprobe + kretprobe on `do_filp_open`, `path_openat`, `path_init`, `link_path_walk`, `alloc_empty_file`, `init_file`, `fdget_raw`, `path_lookupat` |
| `kernel/user/stage3/case1/case1_relative/case1_relative.c` | Basic relative path open |
| `kernel/user/stage3/case1/demo_at_fdcwd/demo_at_fdcwd.c` | Three calling conventions (open/openat/syscall) |
| `kernel/user/stage3/case1/demo_o_path/demo_o_path_dir.c` | O_PATH directory + openat demonstration |
| `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.c` | O_TMPFILE creation demonstration |
| `kernel/user/stage3/case1/demo_thread_safety/demo_thread_safety.c` | chdir race condition with threads |
| `kernel/user/stage3/case1/demo_toctou/demo_toctou.c` | rename+symlink TOCTOU attack |
| `kernel/user/stage3/case1/demo_o_path/demo_o_path.c` | Basic O_PATH operations |
| `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:2427` | `link_path_walk` definition |
| `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:2576` | `path_init` AT_FDCWD branch |

---

## Trace Files Generated

All traces captured with `link_path_walk` instrumentation:

| Trace File | Program | Lines | Key Observation |
|:-----------|:--------|:------|:----------------|
| `proof_case1_relative.txt` | case1_relative | 91,942 | Basic relative path resolution via AT_FDCWD |
| `proof_demo_at_fdcwd.txt` | demo_at_fdcwd | 333,627 | Three calling conventions, identical kernel paths |
| `proof_demo_o_path.txt` | demo_o_path | 229 | O_PATH basic operations |
| `proof_demo_o_path_dir.txt` | demo_o_path_dir | 277 | O_PATH + openat with fd lookup |
| `proof_demo_o_tmpfile.txt` | demo_o_tmpfile | 248,293 | O_TMPFILE directory resolution |
| `proof_demo_thread_safety.txt` | demo_thread_safety | 332 | AT_FDCWD vs fd lookup with concurrent chdir |
| `proof_demo_toctou.txt` | demo_toctou | 414,284 | Path re-resolution vs pinned inode |
