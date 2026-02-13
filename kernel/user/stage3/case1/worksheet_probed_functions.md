# Stage 3 / Case 1 — Probed Functions Worksheet

Kernel: `6.17.0-14-generic`  
Source: `/usr/src/linux-hwe-6.17-6.17.0/fs/`  
Driver directory: `kernel/drivers/stage3/case1/trace_path_init/`  
Proof directory:  `kernel/user/stage3/case1/`  

---

## Complete list of probed kernel functions

### Driver 1: `trace_path_init.ko`

Traces the upper half of `open()` — from `do_filp_open` down to `path_init`.

| # | Function            | File           | Line | Type     | Probe Method    | Arguments (x86-64 ABI)                     |
|---|---------------------|----------------|------|----------|-----------------|---------------------------------------------|
| 1 | `do_filp_open`      | `fs/namei.c`   | 3917 | kprobe   | symbol entry    | `%rdi`=dfd, `%rsi`=filename, `%rdx`=op      |
|   |                     |                |      | kretprobe| symbol return   | `%rax`=struct file *                         |
| 2 | `path_openat`       | `fs/namei.c`   | 3874 | kprobe   | symbol entry    | `%rdi`=nd, `%rsi`=op, `%rdx`=flags          |
|   |                     |                |      | kretprobe| symbol return   | `%rax`=struct file *                         |
| 3 | `alloc_empty_file`  | `fs/file_table.c`| —  | kprobe   | symbol entry    | `%rdi`=flags, `%rsi`=cred                   |
|   |                     |                |      | kretprobe| symbol return   | `%rax`=struct file *                         |
| 4 | `init_file`         | `fs/file_table.c`| —  | kprobe   | symbol entry    | `%rdi`=file, `%rsi`=flags, `%rdx`=cred      |
|   |                     |                |      | kretprobe| symbol return   | `%rax`=int (0 or error)                      |
| 5 | `fdget_raw`         | kernel         | —    | kprobe   | symbol entry    | `%rdi`=fd                                    |
| 6 | `path_lookupat`     | `fs/namei.c`   | 2640 | kprobe   | symbol entry    | `%rdi`=nd, `%rsi`=flags, `%rdx`=path         |
|   |                     |                |      | kretprobe| symbol return   | `%rax`=int (0 or -errno)                     |
| 7 | `path_init`         | `fs/namei.c`   | 2367 | kprobe   | symbol entry    | `%rdi`=nd, `%rsi`=flags                      |
|   |                     |                | +offsets| kprobe| offset probes   | Offsets: `OFF_FD`, `OFF_CWD`, `OFF_CMP`      |
|   |                     |                |      | kretprobe| symbol return   | `%rax`=const char * (adjusted name)          |
| 8 | `link_path_walk`    | `fs/namei.c`   | 2429 | kprobe   | symbol entry    | `%rdi`=name, `%rsi`=nd                       |
|   |                     |                |      | kretprobe| symbol return   | `%rax`=int (0 or -errno)                     |

**Proof files:**
- `proof.txt` — full `do_filp_open` → `path_openat` → `alloc_empty_file` chain
- `proof_path_init_normal.txt` — `path_init` for relative paths (AT_FDCWD)
- `proof_path_init_fd_offset.txt` — `path_init` for fd-relative paths
- `proof_path_init_opath.txt` — `path_init` with O_PATH
- `proof_path_init_offsets.txt` — `path_init` internal offset probes
- `proof_path_lookupat.txt` — `path_lookupat` entry/return
- `proof_normal_open.txt` — full normal open trace

---

### Driver 2: `trace_lpw_v2.ko`

Traces `link_path_walk` internals using instruction-offset probes within the same function.

| # | Probe Point              | Method                     | Offset      | What it captures                                      |
|---|--------------------------|----------------------------|-------------|-------------------------------------------------------|
| 1 | `link_path_walk` entry   | kprobe symbol              | 0x0         | `%rdi`=name, `%rsi`=nd → path string, flags, depth    |
| 2 | `may_lookup` call site   | kprobe symbol+offset       | `OFF_MAY_LOOKUP` (0x7d) | `%rdi`=idmap, `%rsi`=nd → permission check   |
| 3 | `hash_name` call site    | kprobe symbol+offset       | `OFF_HASH_NAME` (0x9a) | `%rdi`=nd, `%rsi`=name → tokenize component  |
| 4 | `walk_component` site 1  | kprobe symbol+offset       | `OFF_WALK_COMPONENT_1` (0x100) | `%rdi`=nd, `%rsi`=flags → component lookup |
| 5 | `walk_component` site 2  | kprobe symbol+offset       | `OFF_WALK_COMPONENT_2` (0x142) | second call site for walk_component        |
| 6 | `link_path_walk` return  | kretprobe symbol           | —           | `%rax`=int (0 or -errno)                              |

All offsets are relative to `link_path_walk` symbol address.
Computed from: `objdump -d vmlinux | grep -A300 link_path_walk`

**Proof files:**
- `proof_lpw_safe_demo_short.txt` — full walk of `/mnt/loop_test/some/deep/path/file.txt`
- `proof_lpw_trace.txt` — raw offset-based trace

---

### Driver 3: `trace_lpw_safe.ko` (current version)

Traces `link_path_walk` and its callees as distinct function symbols.  
**No instruction offsets** — pure symbol-based kprobes.

| # | Function            | File            | Line  | Probe     | Args (entry) / Return (ret)                            |
|---|---------------------|-----------------|-------|-----------|--------------------------------------------------------|
| 1 | `link_path_walk`    | `fs/namei.c`    | 2429  | kprobe    | `%rdi`=name (char *), `%rsi`=nd (nameidata *)          |
|   |                     |                 |       | kretprobe | `%rax`=int (0=OK, negative=errno)                      |
| 2 | `walk_component`    | `fs/namei.c`    | 2133  | kprobe    | `%rdi`=nd (nameidata *), `%rsi`=flags (int)            |
|   |                     |                 |       | kretprobe | `%rax`=NULL (not symlink) / ERR_PTR (error) / ptr (symlink) |
| 3 | `lookup_fast`       | `fs/namei.c`    | 1739  | kprobe    | `%rdi`=nd (nameidata *)                                 |
|   |                     |                 |       | kretprobe | `%rax`=dentry * (hit) / NULL (miss) / ERR_PTR (error)  |
| 4 | `__d_lookup_rcu`    | `fs/dcache.c`   | 2253  | kprobe    | `%rdi`=parent (dentry *), `%rsi`=name (qstr *), `%rdx`=seqp |
|   |                     |                 |       | kretprobe | `%rax`=dentry * (found) / NULL (not in cache)          |

**Proof files:**
- `proof_lpw_loop.txt` — symlink loop (`someothersymlink → someothersymlink`)
- `proof_lpw_loop_v2.txt` — refined loop trace with walk_component return values
- `proof_puzzle_trace.txt` — mutual symlink loop (`loop_a ↔ loop_b`) + trailing-slash test (`file_link/`)

---

### Driver 4: `trace_lpw.ko`

Early prototype. Traces `link_path_walk` entry + offset probes for the for(;;) loop, hash_name, and walk_component call sites. Superseded by `trace_lpw_v2.ko` and `trace_lpw_safe.ko`.

---

## Call graph (top to bottom)

```
do_sys_openat2()                          [syscall entry]
  └─ do_filp_open()                       [trace_path_init.ko probe #1]
       │  struct nameidata nd;            ← nd DECLARED here (stack local)
       │  set_nameidata(&nd, dfd, pathname, NULL)
       │                                  ← fills nd.dfd, nd.pathname, links to task
       └─ path_openat(&nd, op, flags)     [trace_path_init.ko probe #2]
            ├─ alloc_empty_file()          [trace_path_init.ko probe #3]
            ├─ path_init(nd, flags)        [trace_path_init.ko probe #7]
            │                              ← fills nd->path.dentry from cwd or root
            ├─ link_path_walk(name, nd)    [trace_lpw_safe.ko probe #1]
            │    └─ for (;;) {
            │         ├─ may_lookup()      [trace_lpw_v2.ko offset probe]
            │         ├─ hash_name()       [trace_lpw_v2.ko offset probe]
            │         └─ walk_component()  [trace_lpw_safe.ko probe #2]
            │              ├─ lookup_fast()        [trace_lpw_safe.ko probe #3]
            │              │    ├─ __d_lookup_rcu() [trace_lpw_safe.ko probe #4]
            │              │    └─ d_revalidate()   [INLINED — not probeable]
            │              ├─ __lookup_slow()       [NOT probed]
            │              ├─ handle_mounts()       [NOT probed]
            │              └─ step_into()           [NOT probed]
            │       }
            ├─ open_last_lookups()         [NOT probed]
            └─ do_open()                   [NOT probed]
                 └─ init_file()            [trace_path_init.ko probe #4]
```

---

## Function-by-function source reference

### 1. `link_path_walk` — fs/namei.c:2429

```c
static int link_path_walk(const char *name, struct nameidata *nd)
```

**Purpose:** Walk the path string component-by-component.  
**Loop structure:** `for (;;)` at line 2448.  
Each iteration: `may_lookup()` → `hash_name()` → `walk_component()`.  
Returns 0 on success, negative errno on failure.

### 2. `walk_component` — fs/namei.c:2133

```c
static const char *walk_component(struct nameidata *nd, int flags)
```

**Purpose:** Resolve one path component (the string in `nd->last`).  
**Steps:**
1. Call `lookup_fast(nd)` — check the dentry cache
2. If miss → call `lookup_slow(nd, &dentry, ...)` — filesystem-level lookup
3. Call `handle_mounts(nd, dentry, &path)` — cross mount boundaries
4. Call `step_into(nd, flags, dentry, ...)` — update nd, handle symlinks

**Return:**
- `NULL` → component resolved, not a symlink, continue loop
- Valid pointer → symlink detected, caller must follow it
- `ERR_PTR(errno)` → error

### 3. `lookup_fast` — fs/namei.c:1739

```c
static struct dentry *lookup_fast(struct nameidata *nd)
```

**Purpose:** Check if the component (`nd->last`) exists in the dentry cache.  
**Two code paths (line 1749):**

```
if (nd->flags & LOOKUP_RCU) {
    dentry = __d_lookup_rcu(parent, &nd->last, &nd->next_seq);  // line 1750
    ...
    status = d_revalidate(..., dentry, ...);                     // line 1764
} else {
    dentry = __d_lookup(parent, &nd->last);                      // line 1774
    status = d_revalidate(..., dentry, ...);                     // line 1777
}
```

**Return:**
- Valid `dentry *` → cache hit, revalidation passed
- `NULL` → cache miss
- `ERR_PTR(-ECHILD)` → RCU sequence mismatch or revalidation failure

### 4. `__d_lookup_rcu` — fs/dcache.c:2253

```c
struct dentry *__d_lookup_rcu(const struct dentry *parent,
                              const struct qstr *name,
                              unsigned *seqp)
```

**Purpose:** Search the dcache hash table for a dentry matching `name` under `parent`, under RCU protection (no locks, no reference counts).  
**Mechanism:** Compute hash from `name`, walk the hash bucket chain, compare `d_name` fields.  
**Return:**
- `dentry *` → found in cache
- `NULL` → not found

### 5. `d_revalidate` — fs/namei.c:925 (INLINED)

```c
static inline int d_revalidate(struct inode *dir, const struct qstr *name,
                               struct dentry *dentry, unsigned int flags)
{
    if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
        return dentry->d_op->d_revalidate(dir, name, dentry, flags);
    else
        return 1;  // valid by default
}
```

**Why it cannot be probed:**
- Declared `static inline` → compiler inlines it into `lookup_fast`
- No symbol in `/proc/kallsyms`
- Cannot attach kprobe to non-existent symbol

**Observability through `lookup_fast` return:**
- If `d_revalidate` returns > 0 → `lookup_fast` returns the dentry (cache hit)
- If `d_revalidate` returns 0 → dentry invalidated, `lookup_fast` returns `ERR_PTR(0)`
- If `d_revalidate` returns -ECHILD → RCU retry needed, `lookup_fast` returns `ERR_PTR(-ECHILD)`

**Filesystem dependency:**
- ext4 on loopback: ext4 does NOT set `DCACHE_OP_REVALIDATE` (unless `encrypt` or `casefold` is enabled)
- Therefore `d_revalidate` returns 1 immediately for all ext4 dentries in our test
- The probe for `lookup_fast` return value confirms this: every return is a valid dentry pointer (not NULL, not ERR_PTR)

---

## Proof file index

| Proof File                       | Driver Used         | What It Proves                                                |
|----------------------------------|---------------------|---------------------------------------------------------------|
| `proof.txt`                      | trace_path_init.ko  | do_filp_open → path_openat → alloc_empty_file chain           |
| `proof_path_init_normal.txt`     | trace_path_init.ko  | path_init for relative path with AT_FDCWD                     |
| `proof_path_init_fd_offset.txt`  | trace_path_init.ko  | path_init for fd-relative paths                                |
| `proof_path_init_opath.txt`      | trace_path_init.ko  | path_init with O_PATH flag                                     |
| `proof_path_init_offsets.txt`    | trace_path_init.ko  | path_init internal offset probes (fd, cwd, component)          |
| `proof_path_lookupat.txt`        | trace_path_init.ko  | path_lookupat entry/return                                     |
| `proof_normal_open.txt`          | trace_path_init.ko  | full normal open trace end-to-end                              |
| `proof_lpw_trace.txt`            | trace_lpw.ko        | raw offset-based link_path_walk trace                          |
| `proof_lpw_safe_demo_short.txt`  | trace_lpw_v2.ko     | full walk of multi-component path                              |
| `proof_lpw_loop.txt`             | trace_lpw_safe.ko   | symlink loop detection (self-referencing symlink)              |
| `proof_lpw_loop_v2.txt`          | trace_lpw_safe.ko   | walk_component return value for symlinks vs directories        |
| `proof_puzzle_trace.txt`         | trace_lpw_safe.ko   | mutual symlink loop (loop_a ↔ loop_b) + trailing-slash ENOTDIR |
| `proof_check_opath.txt`          | trace_path_init.ko  | O_PATH behavior verification                                   |
| `proof_demo_o_path.txt`          | trace_path_init.ko  | O_PATH opens without file read/write                           |
| `proof_demo_o_path_dir.txt`      | trace_path_init.ko  | O_PATH on directory                                             |
| `proof_demo_o_tmpfile.txt`       | trace_path_init.ko  | O_TMPFILE anonymous file creation                              |
| `proof_demo_at_fdcwd.txt`        | trace_path_init.ko  | AT_FDCWD relative path resolution                              |
| `proof_demo_thread_safety.txt`   | trace_path_init.ko  | thread safety of path resolution                                |
| `proof_demo_toctou.txt`          | trace_path_init.ko  | TOCTOU race condition demonstration                             |
| `proof_case1_relative.txt`       | trace_path_init.ko  | relative path resolution detailed trace                         |
| `proof_nameidata_null.txt`       | trace_path_init.ko  | PROOF: current->nameidata is NULL (no nesting)                  |

---

## Key findings from traces

### 1. Dcache hit path (normal case)

```
link_path_walk("usr/lib/file.txt")
  for each component:
    walk_component(nd, flags)
      lookup_fast(nd)                     ← checks dcache
        __d_lookup_rcu(parent, "usr")     ← hash-bucket search
        return dentry("usr")              ← HIT
      d_revalidate(dentry)                ← inlined, returns 1 (ext4)
      return dentry("usr")                ← to walk_component
    handle_mounts(...)
    step_into(...)
    return NULL                           ← not a symlink, continue loop
```

Trace evidence: `proof_lpw_safe_demo_short.txt`
- Every `walk_component` returns `NULL` (0x0) for directory components
- Every `lookup_fast` returns a valid dentry pointer

### 2. Symlink detection

```
walk_component(nd, flags)
  lookup_fast(nd)              ← finds "someothersymlink" in dcache
  step_into(nd, ...)           ← sees S_ISLNK, returns link string
  return ffff8b43d14bb078      ← non-NULL, non-ERR = symlink pointer
```

Trace evidence: `proof_lpw_loop_v2.txt` line 703:
```
#703.Return [walk_component SYMBOL]. Values [ret=ffff8b43d14bb078]. Data [Symlink Found].
```

### 3. Symlink loop detection (ELOOP)

For mutual symlinks `loop_a → loop_b → loop_a`:
- `link_path_walk` is called repeatedly by `path_lookupat` (tail-symlink restart)
- `nd->depth` stays 0 in each call (tail optimization — stack does not grow)
- A global counter (`nd->total_link_count` or similar) enforces `MAXSYMLINKS` (40)
- After 40 iterations: `ELOOP` (-40) returned

Trace evidence: `proof_puzzle_trace.txt`
- Lines 840-895: repeated `link_path_walk ENTRY` with `depth=0`, all for `loop_a`

### 4. Trailing-slash forces directory semantic (ENOTDIR)

Path: `/mnt/loop_test/file_link/`  
`file_link` is a symlink → `target_file` (a regular file).

```
link_path_walk("file_link/")     ← returns 0 (OK — walked file_link)
link_path_walk("target_file")    ← returns 0 (OK — walked target_file)
  ↓ back in path_openat / open_last_lookups
  nd->flags has LOOKUP_DIRECTORY set (because trailing slash)
  target_file is NOT a directory
  → ENOTDIR returned to userspace
```

Trace evidence: `proof_puzzle_trace.txt` lines 914-920:
- `link_path_walk` returns 0 for both `file_link/` and `target_file`
- The error is generated by the caller, not by `link_path_walk`
- This proves `link_path_walk` is purely a traversal engine; type validation is done by the caller

---

## Struct nameidata — actual kernel definition (fs/namei.c:631-655)

```c
#define EMBEDDED_LEVELS 2
struct nameidata {
    struct path     path;           // .mnt + .dentry → current lookup position
    struct qstr     last;           // .name + .len + .hash → last parsed component
    struct path     root;           // .mnt + .dentry → filesystem root
    struct inode    *inode;         // path.dentry->d_inode (cached)
    unsigned int    flags, state;   // LOOKUP_* flags, ND_* state bits
    unsigned        seq, next_seq, m_seq, r_seq;  // RCU sequence counters
    int             last_type;      // LAST_NORM / LAST_DOT / LAST_DOTDOT / LAST_ROOT
    unsigned        depth;          // current symlink nesting depth
    int             total_link_count;              // total symlinks followed
    struct saved {
        struct path link;           // symlink's own dentry+mount
        struct delayed_call done;   // cleanup callback
        const char *name;           // remaining path to resume after symlink
        unsigned seq;               // RCU seq at time of save
    } *stack, internal[EMBEDDED_LEVELS]; // ← stack POINTS AT internal (no heap)
    struct filename *name;          // original filename struct from userspace
    const char *pathname;           // raw C string pointer
    struct nameidata *saved;        // previous nd (for nested lookups)
    unsigned        root_seq;       // root dentry RCU sequence
    int             dfd;            // directory fd (AT_FDCWD = -100)
    vfsuid_t        dir_vfsuid;
    umode_t         dir_mode;
} __randomize_layout;
```

### The stack / internal relationship

```
__set_nameidata does:  p->stack = p->internal;   (line 664)
                       p->depth = 0;              (line 665)

+96     *stack ──────────────────┐
                                │
+104    internal[0] ◄───────────┘  stack[0] = internal[0]
+144    internal[1]                stack[1] = internal[1]

depth = 0  →  slots in use = 0  →  garbage in internal[] never read
```

- `internal[0..1]` lives INSIDE the struct on the stack (zero allocation cost)
- `*stack` is a pointer: "where is my saved-symlink array?"
- `stack = internal` means "the array is right here inside me"
- If depth exceeds 2: `nd_alloc_stack()` → `kmalloc` → `stack` points to heap

#2. Call. do_sys_openat2(AT_FDCWD, "usr/lib/file.txt", &op). Values: dfd=-100, filename="...", op={flags=0...}. Data: args struct. Work: Build open flags, call do_filp_open. Errors: None. Real value: N/A. Real data: struct open_how pop. Caller Line Number: fs/open.c:1205. Current Line Number: fs/open.c:1230.

#2b. Call. get_unused_fd_flags(how->flags). Values: flags. Data: Reserve FD in table. Work: Find first available slot in fdt. Errors: None. Real value: 3. Real data: fd=3 (reserved, points to NULL file). Caller Line Number: fs/open.c:1435. Current Line Number: fs/file.c.

#3. Call. do_filp_open(dfd, pathname, &op). Values: dfd=-100, pathname=struct filename*(0xffff8ea...), op=0xffff... Data: op->open_flag=0. Work: Main open logic entry. Errors: None. Real value: N/A. Real data: current->nameidata=NULL. Caller Line Number: fs/open.c:1255. Current Line Number: fs/namei.c:4073.

### The `saved` field / recursive lookups / `current->nameidata`

- **`saved`**: Used to chain `nameidata` structs when the kernel performs a **nested lookup** (e.g., an `exec` or specialized driver call triggers an open while another open is in progress).
- **`current->nameidata`**: Points to the *active* nameidata. `__set_nameidata` (flow step 2) reads this into `old` and saves it in `saved`.
- **Proof of NULL**: For standard userspace operations (like `demo_short`), `current->nameidata` is **NULL** at entry.
  - See `proof_nameidata_null.txt` (captured via trace_path_init.ko)
  - Result: `0000000000000000` for all opens.
  - Meaning: Standard `open()` does not nest. `old` is NULL.

### `name` vs `pathname` and Thread Safety
- **`p->name`** (`struct filename *`): The full kernel object (refcounted).
- **`p->pathname`** (`const char *`): The actual string pointer inside that object.
- **Thread Safety**: `nd` is a **stack-local variable**. Each thread has its own stack. `current->nameidata` is per-task. There is **zero race condition** risk for `nd` itself.

### `alloc_empty_file` (fs/file_table.c)

- **Purpose**: Allocates a raw `struct file` object from `filp_cachep`.
- **Called by**: `path_openat` (early, before path walk).
- **Key Logic**:
  1. Checks global file limit (`max_files`).
  2. Allocates memory via `kmem_cache_alloc`.
  3. Calls `init_file` to set credentials and flags.
- **The "Mount Warning" Explained**:
  - The returned file is **floating** (not attached to a mount yet).
  - If the file is for **writing**, the kernel must eventually increment `mnt->mnt_writers` on the target mount.
  - Since `alloc_empty_file` doesn't know the target mount yet, the **caller** is responsible for this increment later (in `do_dentry_open`).
  - Failure to do so leads to "imbalanced writer count" warnings at close (`fput`).

### File Descriptor vs struct file Timing

- **FD Reservation**: The integer `fd` (e.g. 3) is reserved **before** `struct file` is created.
  - Location: `do_sys_openat2` calls `get_unused_fd_flags`.
  - State: The slot in the FD table is marked "busy" but points to `NULL`.
- **struct file Creation**: Happened in `path_openat` -> `alloc_empty_file`.
- **Linkage**: The connection `frame->fd[3] = file` happens **after** `path_openat` returns successfully.
  - Location: `fd_install(fd, f)`.

### `path_init` (fs/namei.c)

- **Purpose**: Determines the **Starting Point** (`nd->path`) for the path walk.
- **Inputs**: `nd` (garbage except `dfd`), path string `s`.
- **Logic**:
  1.  **Absolute Path** (`/`): Ignores `dfd`. Starts at `current->fs->root`.
  2.  **Relative Path** (`usr/lib/...`):
      -   **If `AT_FDCWD`**: Starts at `current->fs->pwd` (Process Working Directory).
      -   **If FD > 0**: Starts at the path pointed to by that file descriptor (`fd_file(dfd)->f_path`).
- **Return Value**:
  - **Relative Path**: Returns the original string `s` exactly (e.g., `"usr/lib/file.txt"`).
  - **Absolute Path**: Returns the string *after* any leading slashes (e.g., `"usr/lib/file.txt"` for path `"/usr/lib/file.txt"`).
- **Outcome**: Populates `nd->path` with a valid, pinned `{mnt, dentry}` pair (e.g., pointing to your CWD directory record).
- **Nuance**: Note that `set_nameidata` initializes `nd->path` (Current Position), but `path_init` explicitly clears `nd->root` (Search Boundary) at Line 2565 to remove stack garbage for normal lookups where the root wasn't preset.

### `link_path_walk` (fs/namei.c)

- **Purpose**: Iterates over path components (e.g., "usr", "lib") and resolves each one.
- **Inputs**: `name` (the remaining string from `path_init`), `nd` (search context).
- **Core Loop**:
  1.  **Component Extraction**: Uses `hash_name` to find the next component.
  2.  **Resolution**: Calls `walk_component` to find the dentry for that component.
  3.  **Iteration**: Continues until no more slashes remain.
- **Tracing Tasks**:
  - Prove the string components ("usr", "lib") are parsed correctly.
  - Show the transition from one dentry to the next.
-   **Proof of Distinct Identity**:
    -   We demonstrated with `demo_dup_names` that two directories with identical names ("common") have **different dentry pointers** in kernel memory.
    -   The kernel distinguishes them solely by address/mount, not by string.
    -   See `proof_dup_names.txt` for logs showing pointer differences.

---


---

## Notes on d_revalidate traceability

### Why kprobe cannot attach

1. `d_revalidate` at `fs/namei.c:925` is `static inline`
2. The compiler embeds its body into `lookup_fast` during compilation
3. `/proc/kallsyms` has no entry for `d_revalidate` (only filesystem-specific implementations like `fscrypt_d_revalidate`, `nfs_d_revalidate`, etc.)

### Alternative approaches (not used)

1. **Probe filesystem-specific implementations**: e.g., `nfs_d_revalidate` — but ext4 does not implement one (it relies on the default `return 1` path)
2. **ftrace with function graph**: would capture inlined calls if built with `-pg` and CONFIG_FUNCTION_GRAPH_TRACER
3. **eBPF fentry**: can attach to inlined functions if BTF type info is available

### Current solution

The `lookup_fast` return value is sufficient:
- **Valid dentry** → `d_revalidate` passed (for ext4: `DCACHE_OP_REVALIDATE` not set → returns 1)
- **NULL** → `__d_lookup_rcu` returned NULL (dcache miss) → `d_revalidate` never called
- **ERR_PTR** → either RCU sequence fail or `d_revalidate` returned ≤ 0
