**Stage 3: Filename Walk (Components)**

Flow recap: Stage 1 traced user space → syscall entry. Stage 2 traced `getname()` and the kernel filename buffer. Stage 2b traced dcache insert and return pointer reuse. This stage fills the missing middle: the kernel walks the pathname, advances the pointer, and builds per‑component `qstr` values before lookup.

Trace point inside this `do_sys_openat2` block:

```c
static long do_sys_openat2(int dfd, const char __user *filename,
                           struct open_how *how)
{
    struct open_flags op;
    struct filename *tmp;
    int err, fd;

    err = build_open_flags(how, &op);
    if (unlikely(err))
        return err;

    tmp = getname(filename);
    if (IS_ERR(tmp))
        return PTR_ERR(tmp);

    fd = get_unused_fd_flags(how->flags);
    if (likely(fd >= 0)) {
        struct file *f = do_filp_open(dfd, tmp, &op);
        ...
    }
    putname(tmp);
    return fd;
}
```

We trace the walk that happens after `do_filp_open` receives the kernel string and before `d_lookup` is called for each component. The target functions are in `fs/namei.c`: `link_path_walk`, `walk_component`, and `lookup_fast`. These are where the pathname pointer advances and the `qstr` (name/len/hash) is formed per component.

**User program (multi‑component path)**

```c
const char *path = "/tmp/alpha/beta/gamma/delta.txt";
mkdir("/tmp/alpha", 0755);
mkdir("/tmp/alpha/beta", 0755);
mkdir("/tmp/alpha/beta/gamma", 0755);
int fd = open(path, O_RDWR | O_CREAT, 0644);
```

**What to record (per component)**

Record each component as it is walked. Each record must include the component pointer, length, and hash printed by your probes.

Component order for this path:

`tmp` → `alpha` → `beta` → `gamma` → `delta.txt`

**Record template**

```
component = ________
component ptr = 0x________
component len = ________
component hash = ________
```

**Expected pointer progression**

The component pointer should move forward through the original pathname buffer. You verify this by subtraction of adjacent component pointers (no other inference).

**Build and run**

```
cd kernel/drivers/trace_do_filp_open && make
sudo insmod trace_do_filp_open.ko target_comm=multi_path_open
cd kernel/user/stage3 && gcc -o multi_path_open multi_path_open.c && ./multi_path_open
sudo dmesg | rg -n "link_path_walk|walk_component|lookup_fast|qstr|alpha|beta|gamma|delta"
sudo rmmod trace_do_filp_open
```

This stage ends when you can show the pointer moves from the start of the path to each component boundary and the hash/len belong to that component only.
