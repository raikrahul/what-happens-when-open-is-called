# Flow: struct nameidata — from garbage to fully populated

Kernel: 6.17.0-14-generic
Source: /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c

---

## Step 0: open("usr/lib/file.txt", O_RDONLY)

Userspace calls open(). Syscall dispatches to do_sys_openat2(AT_FDCWD, "usr/lib/file.txt", ...).
do_sys_openat2 calls do_filp_open(dfd, filename, op).

---

## Step 1: do_filp_open — nd is garbage (namei.c:4074)

```c
struct file *do_filp_open(int dfd, struct filename *pathname,
                          const struct open_flags *op)
{
    struct nameidata nd;   // ← line 4076: stack allocation. Contents = GARBAGE.
```

`nd` is a local variable on the kernel stack.
No constructor runs. Every field contains whatever was left on the stack.
`&nd` is a valid pointer (stack address). `nd` itself is nonsense.

### Actual struct definition (fs/namei.c:631-655)

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
    } *stack, internal[EMBEDDED_LEVELS]; // ← THE ARRAY (line 647)
```

### Line 647 C syntax — two separate members, one line

Line 647 declares TWO members of type `struct saved` in one statement:

```c
    } *stack, internal[EMBEDDED_LEVELS];

    // Is equivalent to writing:
    struct saved *stack;          // a POINTER (8 bytes). Initially garbage.
    struct saved internal[2];    // an ARRAY  (2 slots). Initially garbage.
```

These are **two separate, unrelated** fields.
`stack` does NOT automatically point at `internal`.
They have NO connection until `__set_nameidata` manually wires them:

```c
    p->stack = p->internal;      // line 664: NOW stack points at internal
```

Before line 664: `stack` → garbage address, `internal` → garbage data, no relationship.
After  line 664: `stack[0]` IS `internal[0]`, same memory, because the pointer was set.

The code always accesses via `stack[i]`, never `internal[i]` directly.
`internal` is just "free storage pre-allocated inside the struct."
`stack` is the "access handle" that may point at `internal` (cheap) or at a heap buffer (if depth > 2).

Remaining fields after the stack/internal:

```c
    struct filename *name;          // original filename struct from userspace
    const char *pathname;           // raw C string pointer
    struct nameidata *saved;        // previous nd (for nested lookups)
    unsigned        root_seq;       // root dentry RCU sequence
    int             dfd;            // directory fd (AT_FDCWD = -100)
    vfsuid_t        dir_vfsuid;
    umode_t         dir_mode;
} __randomize_layout;
```

### Memory layout BEFORE __set_nameidata (all garbage)

```
p = &nd  (stack address, e.g. 0xFFFF_C000)

Offset  Field                 Value
──────  ────────────────────  ─────────────
+0      path.mnt              ???? (garbage)
+8      path.dentry           ???? (garbage)
+16     last.hash             ???? (garbage)
+20     last.len              ???? (garbage)
+24     last.name             ???? (garbage)
+32     root.mnt              ???? (garbage)
+40     root.dentry           ???? (garbage)
+48     inode                 ???? (garbage)
+56     flags                 ???? (garbage)
+60     state                 ???? (garbage)
+64     seq                   ???? (garbage)
+68     next_seq              ???? (garbage)
+72     m_seq                 ???? (garbage)
+76     r_seq                 ???? (garbage)
+80     last_type             ???? (garbage)
+84     depth                 ???? (garbage)
+88     total_link_count      ???? (garbage)
+96     *stack                ???? (garbage)  ← POINTER to saved[] array
+104    internal[0].link.mnt  ???? (garbage)  ┐
+112    internal[0].link.dentry ???? (garbage) │
+120    internal[0].done      ???? (garbage)  │ SLOT 0 (embedded)
+128    internal[0].name      ???? (garbage)  │
+136    internal[0].seq       ???? (garbage)  ┘
+144    internal[1].link.mnt  ???? (garbage)  ┐
+152    internal[1].link.dentry ???? (garbage) │
+160    internal[1].done      ???? (garbage)  │ SLOT 1 (embedded)
+168    internal[1].name      ???? (garbage)  │
+176    internal[1].seq       ???? (garbage)  ┘
+184    *filename             ???? (garbage)
+192    *pathname             ???? (garbage)
+200    *saved                ???? (garbage)
+208    root_seq              ???? (garbage)
+212    dfd                   ???? (garbage)
+216    dir_vfsuid            ???? (garbage)
+220    dir_mode              ???? (garbage)
```

### After `p->stack = p->internal` (line 664)

```
+96     *stack ──────────────────┐
                                │
+104    internal[0] ◄───────────┘  (stack NOW POINTS HERE)
+144    internal[1]                (stack[1] = here)

stack[0] = internal[0] = still garbage, but depth=0 → never read ✓
stack[1] = internal[1] = still garbage, but depth=0 → never read ✓
```

The trick: `internal[0..1]` is INSIDE the struct (free — no kmalloc).
`*stack` is just a pointer that says "where is my array?"
Setting `stack = internal` means "my array is right here inside me."

---

## Step 2: __set_nameidata — garbage becomes zeroed skeleton (namei.c:660)

```c
    set_nameidata(&nd, dfd, pathname, NULL);   // line 4080
```

This calls `__set_nameidata(p=&nd, dfd, name=pathname)`:

```c
static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
{
    struct nameidata *old = current->nameidata;  // save previous nd (for nested lookups)
    p->stack    = p->internal;     // symlink stack → embedded 2-slot array (no heap)
    p->depth    = 0;               // zero symlink nesting depth
    p->dfd      = dfd;             // store directory fd (AT_FDCWD = -100)
    p->name     = name;            // store struct filename pointer
    p->pathname = name->name;      // store raw C string "usr/lib/file.txt"
    p->path.mnt    = NULL;         // ← NOT YET SET. path_init fills this.
    p->path.dentry = NULL;         // ← NOT YET SET. path_init fills this.
    p->total_link_count = old ? old->total_link_count : 0;  // inherit from parent
    p->saved = old;                // link to previous nd
    current->nameidata = p;        // push onto task's nd stack
}
```

Then `set_nameidata` also does:

```c
    p->state = 0;                  // clear all ND_* bits
    // root == NULL (normal open), so the if(unlikely(root)) branch is SKIPPED
```

### Trace proof: current->nameidata is NULL for first-level open()

Proof file: `proof_nameidata_null.txt`
Probe: `do_filp_open` entry in `trace_path_init.ko`

Every `do_filp_open` call from our demo_short process shows:

```
[DO_FILP_OPEN] ENTRY pid=32606 comm=demo_short current->nameidata=0000000000000000
```

**0x0 = NULL** across all 12 open() calls (libc loader + our 3 test files).
This proves: `old = current->nameidata = NULL` → `p->total_link_count = 0` → `p->saved = NULL` → no nesting.

**After step 2:**
- `nd.dfd` = AT_FDCWD (-100)
- `nd.pathname` = "usr/lib/file.txt"
- `nd.struct filename *` = valid kernel object
- `nd.depth` = 0
- `nd.path.mnt` = NULL        ← still empty
- `nd.path.dentry` = NULL     ← still empty
- `nd.root.mnt` = GARBAGE    ← set_nameidata skipped it!
- `nd.root.dentry` = GARBAGE ← set_nameidata skipped it!
- `nd.state` = 0
- `current->nameidata` = &nd  ← task now knows about this nd
- `nd.pathname` = "usr/lib/file.txt"
- `nd.depth` = 0
- `nd.path.mnt` = NULL        ← still empty
- `nd.path.dentry` = NULL     ← still empty
- `nd.state` = 0
- `current->nameidata` = &nd  ← task now knows about this nd

---

## Step 3: path_openat — passes &nd down (namei.c:3874)

```c
    filp = path_openat(&nd, op, flags | LOOKUP_RCU);   // line 4081
```

path_openat receives nd by pointer. First thing it does:

---

## Step 4: path_init — NULL becomes real cwd (namei.c:2367)

```c
    const char *s = path_init(nd, flags);
```

path_init reads the process's current working directory:

```c
    nd->path = current->fs->pwd;   // copies both .mnt and .dentry from cwd
    nd->inode = nd->path.dentry->d_inode;
    nd->flags = flags;
    nd->seq = nd->next_seq = 0;    // RCU sequence counters
```

**After step 4:**
- `nd.path.dentry` = dentry of /home/r (or wherever cwd is)
- `nd.path.mnt` = vfsmount of the cwd filesystem
- `nd.inode` = inode of cwd
- `nd.flags` = LOOKUP_RCU | ...

nd is now fully initialized. Path walking can begin.

---

## Step 5: link_path_walk — nd.path.dentry evolves (namei.c:2429)

```c
    int err = link_path_walk(s, nd);
```

Enters the for(;;) loop:

### Iteration 1: component = "usr"
- hash_name parses "usr" into nd->last
- walk_component(nd) → lookup_fast(nd)
  - nd->path.dentry = cwd dentry (from path_init)
  - __d_lookup_rcu(cwd_dentry, "usr") → finds usr dentry in dcache
  - d_revalidate (inlined) → returns 1 (ext4: no revalidation)
- step_into(nd, ..., usr_dentry)
  - **OVERWRITES** nd->path.dentry = usr_dentry
  - **OVERWRITES** nd->inode = usr_inode

### Iteration 2: component = "lib"
- nd->path.dentry is now usr_dentry (written by step_into in iteration 1)
- walk_component(nd) → lookup_fast(nd)
  - __d_lookup_rcu(usr_dentry, "lib") → finds lib dentry
- step_into: nd->path.dentry = lib_dentry

### Iteration 3: component = "file.txt" (last component)
- nd->path.dentry is now lib_dentry
- link_path_walk returns 0 (last component handled by caller)

---

## Step 6: open_last_lookups + do_open (namei.c:3850)

path_openat handles the final component "file.txt":
- Looks it up in lib_dentry
- Opens the inode
- Allocates struct file (alloc_empty_file)
- init_file fills f_path, f_inode, f_op, f_mode
- Returns struct file * to do_filp_open

---

## Step 7: restore_nameidata (namei.c:687)

```c
    restore_nameidata();   // line 4086 in do_filp_open
```

Pops nd from the task's nameidata stack:

```c
    current->nameidata = old;   // restore previous nd (or NULL)
```

nd is a stack variable. When do_filp_open returns, the stack frame is reclaimed.
nd ceases to exist.

---

## Summary: nd lifecycle

```
do_filp_open
  │
  ├─ struct nameidata nd;          GARBAGE
  │
  ├─ set_nameidata(&nd, ...)       dfd=AT_FDCWD, path=NULL/NULL, depth=0
  │
  ├─ path_openat(&nd, ...)
  │    │
  │    ├─ path_init(nd)            path.dentry=cwd, path.mnt=cwd_mnt
  │    │
  │    ├─ link_path_walk(nd)
  │    │    ├─ walk_component      path.dentry=usr  (via step_into)
  │    │    ├─ walk_component      path.dentry=lib  (via step_into)
  │    │    └─ return 0
  │    │
  │    ├─ open_last_lookups        resolves "file.txt"
  │    └─ do_open                  creates struct file
  │
  ├─ restore_nameidata()           pops nd from task stack
  │
  └─ return filp;                  nd dies (stack frame gone)
```
