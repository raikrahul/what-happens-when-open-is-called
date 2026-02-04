# ARG2: FILENAME COPY (AXIOMATIC)

## AXIOM 0: THE CALL
```
User: open("somefile", O_RDWR)
```

AXIOM 0.1: glibc transforms open() to openat()
SOURCE: glibc/sysdeps/unix/sysv/linux/open.c
```c
int open(const char *file, int oflag, ...) {
    return __libc_openat(AT_FDCWD, file, oflag, mode);
}
```

AXIOM 0.2: AT_FDCWD = -100
SOURCE: include/uapi/linux/fcntl.h:96
```c
#define AT_FDCWD -100
```

DERIVATION 0.3:
```
open("somefile", O_RDWR)
    ↓ AXIOM 0.1
openat(AT_FDCWD, "somefile", O_RDWR, 0)
    ↓ AXIOM 0.2
openat(-100, "somefile", 0x2, 0)
         ↓        ↓       ↓   ↓
       ARG1    ARG2    ARG3 ARG4
```

AXIOM 0.4: openat syscall number = 257
SOURCE: arch/x86/entry/syscalls/syscall_64.tbl:268
```
257  common  openat  sys_openat
```

DERIVATION 0.5:
```
RAX = 257
RDI = -100          (dfd)
RSI = 0x7ffe...     (filename pointer)
RDX = 0x2           (flags)
R10 = 0             (mode)
syscall
```

## AXIOM 1: SYSCALL ENTRY POINT
SOURCE: fs/open.c:1416-1420
```c
long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
{
    struct open_how how = build_open_how(flags, mode);
    return do_sys_openat2(dfd, filename, &how);
}
```

DERIVATION 1.1:
```
do_sys_open(dfd=-100, filename=0x7ffe..., flags=0x2, mode=0)
    ↓
do_sys_openat2(dfd=-100, filename=0x7ffe..., &how)
```

## AXIOM 2: FUNCTION ORDER
SOURCE: fs/open.c:1388-1414
```c
static long do_sys_openat2(int dfd, const char __user *filename,
                           struct open_how *how)
{
    struct open_flags op;
    int fd = build_open_flags(how, &op);  // Line 1392
    struct filename *tmp;

    if (fd)
        return fd;

    tmp = getname(filename);              // Line 1398
    if (IS_ERR(tmp))
        return PTR_ERR(tmp);              // Line 1400

    fd = get_unused_fd_flags(how->flags); // Line 1402
    if (fd >= 0) {
        struct file *f = do_filp_open(dfd, tmp, &op);  // Line 1404
        if (IS_ERR(f)) {
            put_unused_fd(fd);
            fd = PTR_ERR(f);
        } else {
            fd_install(fd, f);            // Line 1409
        }
    }
    putname(tmp);                         // Line 1412
    return fd;
}
```

DERIVATION 2.1: Execution Order
```
Line 1392 < Line 1398 < Line 1402 < Line 1404 < Line 1409 < Line 1412
    ↓           ↓           ↓           ↓           ↓           ↓
 build_flags  getname   get_fd     do_filp    fd_install  putname
    ↓           ↓           ↓           ↓           ↓           ↓
  internal    FIRST      SECOND      THIRD      FOURTH      FREE
```

DERIVATION 2.2: getname() is GATE
```
IF IS_ERR(tmp) at Line 1399:
    THEN return PTR_ERR(tmp) at Line 1400
    ELSE continue to Line 1402
∴ Line 1402-1412 NEVER execute if getname() fails
∴ getname() is GATE function
```

## AXIOM 3: VARIABLE tmp
SOURCE: fs/open.c:1393, 1398, 1404, 1412
```
Line 1393: struct filename *tmp;         // Declaration (stack)
Line 1398: tmp = getname(filename);      // Assignment
Line 1404: do_filp_open(dfd, tmp, &op);  // Usage
Line 1412: putname(tmp);                 // Free
```

DERIVATION 3.1: Lifetime
```
Created:   Line 1398
Used:      Line 1404
Destroyed: Line 1412
Scope:     do_sys_openat2() only
∴ tmp = temporary (local to function)
```

DERIVATION 3.2: No Locks Needed
```
tmp is on stack → only visible to current thread
struct filename is newly allocated → not in any table
refcnt = 1 → single owner
∴ no other thread can access → no locks
```

## AXIOM 4: getname() DEFINITION
SOURCE: fs/namei.c:216-220
```c
struct filename *
getname(const char __user * filename)
{
    return getname_flags(filename, 0, NULL);
}
```

DERIVATION 4.1:
```
getname(0x7ffe...)
    ↓
getname_flags(0x7ffe..., 0, NULL)
```

## AXIOM 5: getname_flags() FULL CODE
SOURCE: fs/namei.c:129-206
```c
struct filename *
getname_flags(const char __user *filename, int flags, int *empty)
{
    struct filename *result;
    char *kname;
    int len;

    result = audit_reusename(filename);    // Line 136
    if (result)
        return result;                     // Line 138

    result = __getname();                  // Line 140
    if (unlikely(!result))
        return ERR_PTR(-ENOMEM);           // Line 142

    /*
     * First, try to embed the struct filename inside the names_cache
     * allocation
     */
    kname = (char *)result->iname;         // Line 148
    result->name = kname;                  // Line 149

    len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);  // Line 151
    if (unlikely(len < 0)) {
        __putname(result);
        return ERR_PTR(len);               // Line 154
    }

    /*
     * Uh-oh. We have a name that's approaching PATH_MAX. Allocate a
     * separate struct filename so we can dedicate the entire
     * names_cache allocation for the pathname, and re-do the copy from
     * userland.
     */
    if (unlikely(len == EMBEDDED_NAME_MAX)) {           // Line 163
        const size_t size = offsetof(struct filename, iname[1]);  // Line 164
        kname = (char *)result;                         // Line 165

        result = kzalloc(size, GFP_KERNEL);             // Line 172
        if (unlikely(!result)) {
            __putname(kname);
            return ERR_PTR(-ENOMEM);                    // Line 175
        }
        result->name = kname;                           // Line 177
        len = strncpy_from_user(kname, filename, PATH_MAX);  // Line 178
        if (unlikely(len < 0)) {
            __putname(kname);
            kfree(result);
            return ERR_PTR(len);                        // Line 182
        }
        if (unlikely(len == PATH_MAX)) {
            __putname(kname);
            kfree(result);
            return ERR_PTR(-ENAMETOOLONG);              // Line 187
        }
    }

    atomic_set(&result->refcnt, 1);                     // Line 191
    /* The empty path is special. */
    if (unlikely(!len)) {
        if (empty)
            *empty = 1;
        if (!(flags & LOOKUP_EMPTY)) {
            putname(result);
            return ERR_PTR(-ENOENT);                    // Line 198
        }
    }

    result->uptr = filename;                            // Line 202
    result->aname = NULL;                               // Line 203
    audit_getname(result);                              // Line 204
    return result;                                      // Line 205
}
```

## AXIOM 6: SLAB ALLOCATION
SOURCE: fs/namei.c:140
```c
result = __getname();
```

AXIOM 6.1: __getname() definition
SOURCE: include/linux/fs.h:2574
```c
#define __getname()  kmem_cache_alloc(names_cachep, GFP_KERNEL)
```

AXIOM 6.2: names_cachep definition
SOURCE: fs/dcache.c:114
```c
static struct kmem_cache *names_cachep __read_mostly;
```

AXIOM 6.3: names_cache creation
SOURCE: fs/dcache.c:3372-3373
```c
names_cachep = kmem_cache_create("names_cache", PATH_MAX, 0,
                                 SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
```

AXIOM 6.4: PATH_MAX definition
SOURCE: include/uapi/linux/limits.h:13
```c
#define PATH_MAX 4096
```

DERIVATION 6.5:
```
__getname()
    ↓ AXIOM 6.1
kmem_cache_alloc(names_cachep, GFP_KERNEL)
    ↓ AXIOM 6.2, 6.3
allocate from "names_cache" slab
    ↓ AXIOM 6.3, 6.4
returns 4096 bytes
```

PROOF 6.6: /proc/slabinfo
```
$ sudo cat /proc/slabinfo | grep names
names_cache   160   160   4096   8   8
              ↑     ↑     ↑      ↑   ↑
           active total size  per-slab pages
```
160 active objects
160 total objects
4096 bytes per object ✓
8 objects per slab
8 pages per slab

4096 * 8 = 32768 bytes
8 * 4096 = 32768 bytes ✓

## AXIOM 7: STRUCT FILENAME LAYOUT
SOURCE: include/linux/fs.h:2554-2560
```c
struct filename {
    const char        *name;    // Pointer to pathname
    const char __user *uptr;    // Original user pointer
    atomic_t           refcnt;  // Reference count
    struct audit_names *aname;  // Audit
    const char         iname[]; // Flexible array for embedded pathname
};
```

DERIVATION 7.1: Size Calculation
```
+0x00: name   = 8 bytes (pointer, 64-bit)
+0x08: uptr   = 8 bytes (pointer, 64-bit)
+0x10: refcnt = 4 bytes (atomic_t = int)
+0x14: padding = 4 bytes (alignment to 8)
+0x18: aname  = 8 bytes (pointer, 64-bit)
+0x20: iname[] = flexible (0 base size)

sizeof(struct filename) = 8 + 8 + 4 + 4 + 8 = 32 bytes = 0x20
```

DERIVATION 7.2: iname[] offset
```
offsetof(struct filename, iname) = 0x20 = 32
```

DERIVATION 7.3: Why name points to iname?
```
SOURCE: fs/namei.c:149 (Phase 1)
result->name = (char *)result->iname;

Purpose: Universal access.
Consumer code always reads 'name' pointer.
- If Phase 1: 'name' points to 'iname' (offset 32)
- If Phase 2: 'name' points to separate buffer
- Consumer doesn't need to know which phase was used.
```


## AXIOM 8: EMBEDDED_NAME_MAX
SOURCE: fs/namei.c:127
```c
#define EMBEDDED_NAME_MAX  (PATH_MAX - offsetof(struct filename, iname))
```

DERIVATION 8.1:
```
EMBEDDED_NAME_MAX = PATH_MAX - offsetof(struct filename, iname)
                  = 4096 - 32
                  = 4064 bytes
```

## AXIOM 9: TWO-PHASE ALLOCATION

PHASE 1: Lines 148-155 (TRY EMBEDDED)
```c
kname = (char *)result->iname;     // Line 148: kname → embedded buffer
result->name = kname;              // Line 149: name → same location
len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);  // Line 151
```

DERIVATION 9.1: Phase 1 Memory Layout
```
result = 0xffff888100500000  (from __getname())
    ↓
┌────────────────────────────────────────────────────────┐
│ 0xffff888100500000: struct filename (32 bytes)         │
│   +0x00 name  = 0xffff888100500020 ────────────────────┼──┐
│   +0x08 uptr  = (not set yet)                          │  │
│   +0x10 refcnt= (not set yet)                          │  │
│   +0x18 aname = (not set yet)                          │  │
│   +0x20 iname[] ←──────────────────────────────────────┼──┘
│         (4064 bytes available for string)              │
└────────────────────────────────────────────────────────┘
kname = 0xffff888100500020 = result + 0x20 = result->iname
```

PHASE 2: Lines 163-189 (IF TOO LONG, REALLOCATE)
```c
if (unlikely(len == EMBEDDED_NAME_MAX)) {    // Line 163
    const size_t size = offsetof(struct filename, iname[1]);  // Line 164
    kname = (char *)result;                  // Line 165: REUSE old allocation!
    result = kzalloc(size, GFP_KERNEL);      // Line 172: new small struct
    result->name = kname;                    // Line 177: point to old buffer
    len = strncpy_from_user(kname, filename, PATH_MAX);  // Line 178: recopy
}
```

WHY `==` NOT `>=`? (Line 364)
```
strncpy_from_user() returns:
    0 to (max-1) → actual string length (fit in buffer)
    max → string was TRUNCATED at max bytes

max = EMBEDDED_NAME_MAX = 4064

IF len < 4064 → string fit → done
IF len == 4064 → string TRUNCATED → might be longer → Phase 2
IF len > 4064 → IMPOSSIBLE (can't return more than max)

∴ len == 4064 means "might be longer, recopy with 4096 limit"
∴ == is correct, >= would be logically equivalent but == is precise
```

DID WE LOSE THE STRING AT LINE 368? (result->name = kname)
```
NO. The string is in kname (the old 4096-byte buffer).

Timeline:
Line 151: strncpy_from_user(kname, ...) → string copied to kname (first 4064 bytes)
Line 165: kname = (char *)result → kname now points to OLD buffer (which has string)
Line 172: result = kzalloc(...) → NEW struct filename allocated
Line 177: result->name = kname → NEW struct's name field points to OLD buffer
Line 178: strncpy_from_user(kname, ..., PATH_MAX) → RECOPY full string to OLD buffer

The OLD buffer (kname) always contained the partial string from Line 151.
Line 178 overwrites it with the complete string.
∴ String never lost.
```

ONE-LINE SUMMARY: WHAT DOES getname() DO?
```
getname(user_ptr) → copies string from user space to kernel buffer, returns struct filename *
```


DERIVATION 9.2: Phase 2 size calculation (Line 164)
```
size = offsetof(struct filename, iname[1])
     = offsetof(struct filename, iname) + sizeof(iname[0])
     = 32 + 1
     = 33 bytes
```

DERIVATION 9.3: Phase 2 Memory Layout
```
BEFORE (len == 4064):
┌────────────────────────────────────────────────────────┐
│ result → 0xffff888100500000 (4096 bytes from slab)     │
│   [struct filename 32B][path string 4064B partial]     │
└────────────────────────────────────────────────────────┘

AFTER Line 165:
kname = 0xffff888100500000  (old 4096-byte buffer)
result = (still points to old buffer momentarily)

AFTER Line 172:
result = 0xffff888100600000  (NEW 33-byte allocation from kzalloc)
kname = 0xffff888100500000   (OLD 4096-byte buffer, now for string only)

┌────────────────────────────────────────────────────────┐
│ kname → 0xffff888100500000 (4096 bytes for path)       │
│   "very/long/path/that/exceeds/4064/bytes..."          │
└────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────┐
│ result → 0xffff888100600000 (33 bytes)       │
│   +0x00 name = 0xffff888100500000 ───────────┼──→ kname (path buffer)
│   +0x08 uptr = (will be set at Line 202)     │
│   ...                                        │
└──────────────────────────────────────────────┘
```

DERIVATION 9.4: Why Two Copies?
```
Copy 1 (Line 151): strncpy_from_user(kname, filename, 4064)
    len = actual length copied
    IF len < 4064 → short path → done
    IF len == 4064 → might be truncated → need recopy

Copy 2 (Line 178): strncpy_from_user(kname, filename, 4096)
    Full 4096 byte limit
    IF len == 4096 → ENAMETOOLONG
    ELSE → done
```

DERIVATION 9.5: Why Not Copy 4096 From Start?
```
Most paths are short (e.g., "somefile" = 8 bytes)
Phase 1 (embedded) = 0 extra allocations
Phase 2 (separate) = 1 extra kzalloc(33 bytes)

IF always Phase 2:
    Every open() does kzalloc(33) = slower
    Wastes memory for short paths

Optimization: try fast path first
```

## AXIOM 10: strncpy_from_user()
SOURCE: lib/strncpy_from_user.c

DERIVATION 10.1: Arguments
```
strncpy_from_user(dst, src, max)
                  ↓    ↓    ↓
                kname  filename  EMBEDDED_NAME_MAX
                  ↓    ↓    ↓
           kernel_ptr user_ptr 4064
```

DERIVATION 10.2: Return Value
```
len >= 0 → number of bytes copied (not including '\0')
len < 0  → error code

len == -EFAULT = -14  → invalid user pointer
len == max     → string might be longer (need recopy)
```

DERIVATION 10.3: Behavior
```
Step 1: Validate user pointer is in user range [0, 0x7fffffffffff]
Step 2: Access user memory (may cause page fault → may sleep)
Step 3: Copy byte by byte until '\0' or max reached
Step 4: Return length (0 to max-1) or error
```

## AXIOM 11: REFCNT
SOURCE: fs/namei.c:191
```c
atomic_set(&result->refcnt, 1);
```

DERIVATION 11.1: After getname()
```
refcnt = 1
owner = do_sys_openat2() (via tmp variable)
```

AXIOM 11.2: putname() definition
SOURCE: fs/namei.c:259-275
```c
void putname(struct filename *name)
{
    if (IS_ERR(name))
        return;

    if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
        return;

    if (!atomic_dec_and_test(&name->refcnt))
        return;

    if (name->name != name->iname) {
        __putname(name->name);
        kfree(name);
    } else
        __putname(name);
}
```

DERIVATION 11.3: Lifecycle in do_sys_openat2()
```
Line 1398: tmp = getname()     → refcnt = 1
Line 1404: do_filp_open(tmp)   → refcnt = 1 (not incremented)
Line 1412: putname(tmp)        → refcnt = 0 → FREE
```

DERIVATION 11.4: Free Logic (putname Lines 270-274)
```
IF name->name != name->iname:
    // Phase 2 case: separate allocations
    __putname(name->name);  // Free 4096-byte buffer
    kfree(name);            // Free 33-byte struct
ELSE:
    // Phase 1 case: embedded
    __putname(name);        // Free single 4096-byte block
```

## AXIOM 12: ERROR PATHS

There are exactly 6 error return points in getname_flags():

ERROR 1: Line 142 (Phase 1 - slab allocation failed)
```
SOURCE: fs/namei.c:141-142
if (unlikely(!result))
    return ERR_PTR(-ENOMEM);

CAUSE: __getname() returned NULL
       names_cache slab exhausted (extremely rare)
       -ENOMEM = -12
```

ERROR 2: Line 154 (Phase 1 - user pointer invalid)
```
SOURCE: fs/namei.c:152-154
len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);
if (unlikely(len < 0)) {
    __putname(result);
    return ERR_PTR(len);
}

CAUSE: strncpy_from_user() failed
       User pointer outside valid range [0, 0x7fffffffffff]
       Or page fault error accessing user memory
       len = -EFAULT = -14
```

ERROR 3: Line 175 (Phase 2 - kzalloc failed)
```
SOURCE: fs/namei.c:172-175
result = kzalloc(size, GFP_KERNEL);
if (unlikely(!result)) {
    __putname(kname);
    return ERR_PTR(-ENOMEM);
}

CAUSE: kzalloc(33, GFP_KERNEL) returned NULL
       Kernel memory exhausted (extremely rare)
       -ENOMEM = -12
```

ERROR 4: Line 182 (Phase 2 - user pointer invalid on recopy)
```
SOURCE: fs/namei.c:178-182
len = strncpy_from_user(kname, filename, PATH_MAX);
if (unlikely(len < 0)) {
    __putname(kname);
    kfree(result);
    return ERR_PTR(len);
}

CAUSE: strncpy_from_user() failed on second copy
       User memory changed between first and second copy?
       Or concurrent unmap of user pages
       len = -EFAULT = -14
```

ERROR 5: Line 187 (path too long)
```
SOURCE: fs/namei.c:184-187
if (unlikely(len == PATH_MAX)) {
    __putname(kname);
    kfree(result);
    return ERR_PTR(-ENAMETOOLONG);
}

CAUSE: Path is exactly 4096 bytes (no room for null terminator)
       Path must be < 4096 bytes
       -ENAMETOOLONG = -36
```

ERROR 6: Line 198 (empty path)
```
SOURCE: fs/namei.c:193-198
if (unlikely(!len)) {
    if (empty)
        *empty = 1;
    if (!(flags & LOOKUP_EMPTY)) {
        putname(result);
        return ERR_PTR(-ENOENT);
    }
}

CAUSE: User passed empty string ""
       And LOOKUP_EMPTY flag not set (default)
       -ENOENT = -2
```

DERIVATION 12.1: Error Code Summary
```
ERROR  LINE  CODE   VALUE   CAUSE
  1    142   ENOMEM   -12   slab alloc failed
  2    154   EFAULT   -14   bad user ptr (phase 1)
  3    175   ENOMEM   -12   kzalloc failed
  4    182   EFAULT   -14   bad user ptr (phase 2)
  5    187   ENAMETOOLONG -36   path >= 4096
  6    198   ENOENT   -2    empty path
```

DERIVATION 12.2: Cleanup Actions per Error
```
ERROR 1: nothing allocated yet → just return
ERROR 2: __putname(result) → free 4096-byte slab object
ERROR 3: __putname(kname) → free old 4096-byte buffer
ERROR 4: __putname(kname) + kfree(result) → free both allocations
ERROR 5: __putname(kname) + kfree(result) → free both allocations
ERROR 6: putname(result) → decrements refcnt and frees
```


AXIOM 12.2: IS_ERR() / PTR_ERR() definitions
SOURCE: include/linux/err.h:19-31
```c
#define MAX_ERRNO  4095

#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)

static inline bool IS_ERR(const void *ptr)
{
    return IS_ERR_VALUE((unsigned long)ptr);
}

static inline long PTR_ERR(const void *ptr)
{
    return (long) ptr;
}
```

DERIVATION 12.3: IS_ERR() Math
```
-MAX_ERRNO = -4095 = 0xfffffffffffff001 (as unsigned long)

IS_ERR(x) = true if x >= 0xfffffffffffff001
          = true if x is in last 4KB of address space
          = true if x looks like a negative error code cast to pointer

Example:
ERR_PTR(-12) = (void *)-12 = 0xfffffffffffffff4
IS_ERR(0xfffffffffffffff4) = true (>= 0xfffffffffffff001)
PTR_ERR(0xfffffffffffffff4) = -12
```

## AXIOM 13: REGISTER MAPPING (x86_64 ABI)
SOURCE: arch/x86/entry/entry_64.S, System V AMD64 ABI

DERIVATION 13.1: Entry to getname()
```
RDI = arg1 = const char __user *filename = 0x0000604075144004 (from trace)
```

DERIVATION 13.2: Exit from getname()
```
RAX = return value = struct filename * = 0xffff898345cef000 (from trace)
      OR error pointer if failed
```

## AXIOM 14: CAPTURED TRACE DATA
SOURCE: dmesg output from trace_filename.ko

```
[25759.220072] #2. getname. SUCCESS.
[25759.220077]     user_ptr (RDI saved) = 0x0000604075144004
[25759.220083]     fn (RAX)             = 0xffff898345cef000
[25759.220088]     fn->name (+0x00)     = 0xffff898345cef020
[25759.220092]     fn->uptr (+0x08)     = 0x0000604075144004
[25759.220096]     string               = "somefile"
[25759.220100]     [✓] AXIOM: fn->uptr == saved RDI
```

## AXIOM 15: VERIFICATION MATH

DERIVATION 15.1: fn->name offset check
```
fn = 0xffff898345cef000
fn->name = 0xffff898345cef020

0xffff898345cef020 - 0xffff898345cef000 = 0x20 = 32

offsetof(struct filename, iname) = 32 (from AXIOM 7.2)

∴ fn->name == fn + 0x20 == &fn->iname[0] ✓
∴ This is Phase 1 (embedded) case
```

DERIVATION 15.2: fn->uptr consistency check
```
user_ptr saved at entry (RDI) = 0x0000604075144004
fn->uptr at return            = 0x0000604075144004

0x0000604075144004 == 0x0000604075144004 ✓

∴ getname_flags() correctly saved original user pointer at Line 202
```

DERIVATION 15.3: Address Space Check
```
User pointer: 0x0000604075144004
    Bits 63-48 = 0x0000 (user canonical form)
    < 0x0000800000000000 (user space limit)
    ∴ valid user address ✓

Kernel pointer: 0xffff898345cef000
    Bits 63-48 = 0xffff (kernel canonical form)
    > 0xffff800000000000 (kernel space start)
    ∴ valid kernel address ✓

Delta = 0xffff898345cef000 - 0x0000604075144004
      = 0xffff2942d0baaffc

This delta represents the user → kernel address transition
```

DERIVATION 15.4: String Verification
```
string = "somefile"
strlen("somefile") = 8 bytes

8 < 4064 (EMBEDDED_NAME_MAX)
∴ Phase 1 (embedded) used ✓
∴ No Phase 2 reallocation needed ✓
```

## AXIOM 16: CALL CHAIN WITH LINE NUMBERS

```
User: open("somefile", O_RDWR)
    ↓
glibc: __libc_openat(AT_FDCWD, "somefile", O_RDWR, 0)
    ↓ syscall instruction with RAX=257
Kernel: entry_SYSCALL_64 (arch/x86/entry/entry_64.S:91)
    ↓ dispatch via sys_call_table[257]
Kernel: __x64_sys_openat (generated wrapper)
    ↓
Kernel: do_sys_open (fs/open.c:1416)
    ↓ build_open_how() at Line 1418
    ↓ call do_sys_openat2() at Line 1419
Kernel: do_sys_openat2 (fs/open.c:1388)
    ↓ build_open_flags() at Line 1392
    ↓ call getname() at Line 1398
Kernel: getname (fs/namei.c:217)
    ↓ call getname_flags() at Line 219
Kernel: getname_flags (fs/namei.c:130)
    ↓ __getname() at Line 140
    ↓ strncpy_from_user() at Line 151
    ↓ atomic_set() at Line 191
    ↓ result->uptr = filename at Line 202
    ↓ return result at Line 205
Return: RAX = 0xffff898345cef000
```

## AXIOM 17: CONTEXT REQUIREMENTS

DERIVATION 17.1: Why Process Context?
```
strncpy_from_user() at Line 151:
    Accesses user memory
    May cause page fault
    Page fault handler may sleep (wait for disk I/O)
    ∴ Cannot be in interrupt context

kzalloc(size, GFP_KERNEL) at Line 172:
    GFP_KERNEL allows sleeping
    ∴ Cannot be in interrupt/softirq context

∴ getname() MUST be called in process context
∴ This is satisfied: syscall runs in process context of calling task
```

DERIVATION 17.2: No preempt_disable() / irq_disable()
```
No spinlocks held by getname_flags()
No RCU read-side critical section
∴ Fully preemptible
∴ Can be interrupted by scheduler
```

## AXIOM 18: MEMORY LAYOUT SUMMARY

SHORT PATH (our case: "somefile"):
```
┌─────────────────────────────────────────────────────────┐
│ 0xffff898345cef000: allocation from names_cache (4096B) │
├─────────────────────────────────────────────────────────┤
│ +0x00 name   = 0xffff898345cef020 ──────────────────────┼──┐
│ +0x08 uptr   = 0x0000604075144004                       │  │
│ +0x10 refcnt = 1                                        │  │
│ +0x14 (pad)  = 0                                        │  │
│ +0x18 aname  = NULL                                     │  │
│ +0x20 iname[0..7] = "somefile"  ←───────────────────────┼──┘
│ +0x28 iname[8]    = '\0'                                │
│ +0x29 ... (unused, 4064 - 9 = 4055 bytes)               │
└─────────────────────────────────────────────────────────┘
Total: 4096 bytes from slab
Used: 32 (struct) + 9 (string + null) = 41 bytes
Wasted: 4096 - 41 = 4055 bytes (acceptable for performance)
```

LONG PATH (hypothetical: 4000 byte path):
```
┌─────────────────────────────────────────────────────────┐
│ 0xffff888100500000: allocation from names_cache (4096B) │
│   Contains: 4000 byte path string + '\0'                │
└─────────────────────────────────────────────────────────┘
                ↑
┌───────────────┼─────────────────────────────────────────┐
│ 0xffff888100600000: kzalloc (33 bytes)                  │
│ +0x00 name   = 0xffff888100500000 ──────────────────────┘
│ +0x08 uptr   = (original user pointer)                  │
│ +0x10 refcnt = 1                                        │
│ +0x18 aname  = NULL                                     │
│ +0x20 iname[0] = (unused, just for size calculation)    │
└─────────────────────────────────────────────────────────┘
Total: 4096 + 33 = 4129 bytes
Two separate allocations
```
