# FILP AND INODE: THE RAW DATA - FROM FIRST PRINCIPLES

## AXIOM 0: WHAT IS A FILE DESCRIPTOR?

**FUNDAMENTAL TRUTH**: In Unix/Linux, "everything is a file"

When you call `open("/dev/aesdchar", O_RDWR)`, you get back an integer called a **file descriptor** (fd).

**What is this integer?**
- It's an **index** into a per-process array called the **file descriptor table**
- Example: `fd = 3` means `current->files->fdt->fd[3]` points to a `struct file`

**The Three Layers:**
```
USER SPACE:     fd = 3 (just an integer)
                 |
                 v
KERNEL SPACE:   current->files->fdt->fd[3] = 0xffff888100234000
                                              |
                                              v
                                            struct file {
                                                .f_op = &aesd_fops
                                                .f_inode = 0xffff888100567000
                                                .f_pos = 0
                                                ...
                                            }
```

---

## AXIOM 1: THE COMPLETE CALL CHAIN (VERIFIED FROM KERNEL 6.8.0)

**Source**: `/usr/src/linux-source-6.8.0/fs/`

```
USER SPACE                          KERNEL SPACE
----------                          ------------
fd = open("/dev/aesdchar", O_RDWR)
    |
    | [System call transition: user mode → kernel mode]
    v
syscall table entry: sys_openat    [arch/x86/entry/syscalls/syscall_64.tbl]
    |
    v
SYSCALL_DEFINE4(openat, ...)       [fs/open.c:1430]
    |
    v
do_sys_open(dfd, filename, flags, mode)  [fs/open.c:1416]
    |
    | // Convert flags to kernel structure
    v
struct open_how how = build_open_how(flags, mode)  [fs/open.c:1418]
    |
    v
do_sys_openat2(dfd, filename, &how)  [fs/open.c:1388]
    |
    | // STEP 1: Parse and validate flags
    v
build_open_flags(&how, &op)        [fs/open.c:1392]
    |                               // Converts O_RDWR (0x0002) to:
    |                               //   op.acc_mode = MAY_READ | MAY_WRITE
    |                               //   op.open_flag = 0x0002
    |                               //   op.intent = LOOKUP_OPEN
    |
    | // STEP 2: Allocate file descriptor number
    v
fd = get_unused_fd_flags(flags)    [fs/open.c:1402]
    |                               // Returns: fd = 3 (example)
    |                               // Reserves slot in fd table
    |
    | // STEP 3: Open the file (main work)
    v
file = do_filp_open(dfd, tmp, &op)  [fs/open.c:1404]
    |
    v
path_openat(&nd, op, flags)        [fs/namei.c:3780]
    |
    | // *** ALLOCATION HAPPENS HERE ***
    v
file = alloc_empty_file(op->open_flag, current_cred())  [fs/namei.c:3786]
    |                                                    [SLAB: filp cache]
    | // Allocates 192 bytes from SLAB cache
    | // Returns: file = 0xffff888100234000 (example)
    | // At this point: file->f_op = NULL
    |
    | // STEP 4: Path lookup - find the inode
    v
path_init(nd, flags)               [fs/namei.c:3795]
    |                               // Initialize nameidata structure
    v
link_path_walk("/dev/aesdchar", nd)  [fs/namei.c:3796]
    |                                 // Walk path components:
    |                                 //   "/" → root dentry
    |                                 //   "dev" → /dev dentry
    |                                 //   "aesdchar" → /dev/aesdchar dentry
    v
open_last_lookups(nd, file, op)    [fs/namei.c:3797]
    |                               // Finds final dentry
    |                               // nd->path.dentry = dentry for "aesdchar"
    |
    | // STEP 5: Open the file
    v
do_open(nd, file, op)              [fs/namei.c:3800]
    |
    v
vfs_open(&nd->path, file)          [fs/namei.c:3xxx]
    |
    v
do_dentry_open(file, inode, NULL)  [fs/open.c:902]
    |
    | // STEP 6: Link file to inode
    v
file->f_inode = inode              [fs/open.c:910]
    |                               // inode = nd->path.dentry->d_inode
file->f_mapping = inode->i_mapping [fs/open.c:911]
    |
    | // STEP 7: FIRST f_op assignment
    v
file->f_op = fops_get(inode->i_fop)  [fs/open.c:934]
    |                                 // For character devices:
    |                                 //   inode->i_fop = &def_chr_fops
    |                                 // So: file->f_op = &def_chr_fops
    |
    | // STEP 8: Call the open function
    v
open = file->f_op->open            [fs/open.c:951]
    |                               // open = chrdev_open
    v
error = open(inode, file)          [fs/open.c:953]
    |
    v
chrdev_open(inode, file)           [fs/char_dev.c:373]
    |
    | // STEP 9: Lookup driver's cdev structure
    v
kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx)  [fs/char_dev.c:386]
    |                                               // i_rdev = MKDEV(240, 0)
    |                                               // Looks up in global cdev_map
    v
p = container_of(kobj, struct cdev, kobj)  [fs/char_dev.c:389]
    |                                       // p = &aesd_device.cdev
    |                                       // (registered by driver's cdev_add)
    |
    | // STEP 10: Get driver's file_operations
    v
fops = fops_get(p->ops)            [fs/char_dev.c:408]
    |                               // p->ops = &aesd_fops
    |                               // (set by driver's cdev_init)
    |
    | // STEP 11: SECOND f_op assignment (FINAL)
    v
replace_fops(file, fops)           [fs/char_dev.c:412]
    |                               // Macro expands to:
    |                               //   fops_put(file->f_op);  // Release def_chr_fops
    |                               //   file->f_op = fops;     // Assign aesd_fops
    |
    | // STEP 12: Call driver's open callback
    v
ret = file->f_op->open(inode, file)  [fs/char_dev.c:414]
    |
    v
aesd_open(inode, file)             [YOUR DRIVER: drivers/misc/aesd/main.c]
    |                               // Driver initializes:
    |                               //   file->private_data = &aesd_device
    |                               //   etc.
    v
return 0 to chrdev_open
    |
    v
return 0 to do_dentry_open
    |
    v
file->f_mode |= FMODE_OPENED       [fs/open.c:957]
    |                               // Mark file as successfully opened
    v
return file to path_openat
    |
    v
return file to do_filp_open
    |
    v
return file to do_sys_openat2
    |
    | // STEP 13: Install file in fd table
    v
fd_install(fd, file)               [fs/open.c:1409]
    |                               // current->files->fdt->fd[3] = file
    |                               // Now fd 3 points to our file structure
    v
return fd to user space            [fd = 3]
```

## AXIOM 1: struct file LAYOUT (filp)

```
ADDRESS         FIELD                           SIZE    VALUE EXAMPLE
-------         -----                           ----    -------------
0x00            struct file.f_u.fu_list         16      list_head
0x10            struct file.f_path              32      path{mnt,dentry}
0x30            struct file.f_inode             8       0xffff888100234000
0x38            struct file.f_op                8       0xffffffffc0012000 (aesd_fops)
0x40            struct file.f_lock              4       spinlock
0x44            struct file.f_count             4       atomic_t = 1
0x48            struct file.f_flags             4       O_RDWR = 0x0002
0x4c            struct file.f_mode              4       FMODE_READ | FMODE_WRITE
0x50            struct file.f_pos               8       0 (current file offset)
0x58            struct file.f_owner             32      pid, uid, euid
0x78            struct file.f_ra                24      readahead state
0x90            struct file.f_version           8       0
0x98            struct file.f_security          8       NULL
0xa0            struct file.private_data        8       NULL (driver can use this)
0xa8            struct file.f_ep                8       NULL (epoll)
0xb0            struct file.f_mapping           8       0xffff8881002340a8
TOTAL: 184 bytes (0xb8)
```

## AXIOM 2: struct inode LAYOUT

```
ADDRESS         FIELD                           SIZE    VALUE EXAMPLE
-------         -----                           ----    -------------
0x00            struct inode.i_mode             2       S_IFCHR | 0666 = 0x21b6
0x02            struct inode.i_opflags          2       0
0x04            struct inode.i_uid              4       0 (root)
0x08            struct inode.i_gid              4       0 (root)
0x0c            struct inode.i_flags            4       0
0x10            struct inode.i_acl              8       NULL
0x18            struct inode.i_default_acl      8       NULL
0x20            struct inode.i_op               8       0xffffffff82456000
0x28            struct inode.i_sb               8       0xffff888100200000
0x30            struct inode.i_mapping          8       0xffff8881002340a8
0x38            struct inode.i_ino              8       12345 (device number)
0x40            union {i_nlink, __i_nlink}      4       1
0x44            struct inode.i_rdev             4       MKDEV(240, 0) = 0xf000
0x48            struct inode.i_size             8       0 (char device has no size)
0x50            struct inode.i_atime            16      access time
0x60            struct inode.i_mtime            16      modify time
0x70            struct inode.i_ctime            16      change time
0x80            struct inode.i_lock             4       spinlock
0x84            struct inode.i_bytes            4       0
0x88            struct inode.i_blkbits          2       0
0x8a            struct inode.i_write_hint       1       0
0x8c            struct inode.i_blocks           8       0
0x94            struct inode.i_state            4       I_DIRTY = 0x01
0x98            struct inode.i_hash             16      list_head
0xa8            struct inode.i_io_list          16      list_head
0xb8            struct inode.i_wb_list          16      list_head
0xc8            struct inode.i_lru              16      list_head
0xd8            struct inode.i_sb_list          16      list_head
0xe8            struct inode.i_dentry           16      list_head
0xf8            struct inode.i_rcu              16      rcu_head
0x108           struct inode.i_dio_count        4       atomic_t
0x10c           struct inode.i_writecount       4       atomic_t = 1
0x110           struct inode.i_readcount        8       atomic64_t
0x118           struct inode.i_cdev             8       0xffff888100234100
0x120           struct inode.i_cdev_index       4       0
TOTAL: ~296 bytes
```

## AXIOM 3: FILP IS NOT NULL WHEN

```
CALL PATH:
---------
1. sys_read(fd=3, buf=0x7fff1234, count=100)
        |
        v
2. SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
        |
        v
3. fdget(fd) -> struct fd{f.file, f.flags}
        f.file = current->files->fdt->fd[3]  // LOOKUP in fd table
        f.file = 0xffff888100234000          // THIS IS filp
        f.flags = 0
        |
        v
4. vfs_read(f.file, buf, count, &f.file->f_pos)
        filp = 0xffff888100234000            // PASSED to vfs_read
        |
        v
5. filp->f_op->read(filp, buf, count, pos)  // CALLS aesd_read
        filp = 0xffff888100234000            // RECEIVED by driver
```

## AXIOM 4: FILP CAN BE NULL WHEN

```
SCENARIO: Direct kernel call without fd
---------
kernel_read(file=NULL, buf, count, pos)  // BUG: NULL pointer
    |
    v
vfs_read(filp=NULL, ...)
    |
    v
filp->f_op->read  // CRASH: NULL pointer dereference

SCENARIO: Race condition on close
---------
Thread A: read(fd) started
Thread B: close(fd) executes
    fd_table[fd] = NULL  // CLEARED
Thread A: filp = fd_table[fd]  // NOW NULL

SCENARIO: Error in fdget
---------
fd = -1 (invalid)
fdget(-1) returns {NULL, 0}
vfs_read(NULL, ...) called
```

## AXIOM 5: WHY "filp" NOT "file"

```
HISTORY:
-------
Original Unix: "fp" = file pointer
Linux 0.01:    "file" = struct file *
Linux 0.96:    "filp" introduced to avoid shadowing
               "file" was commonly used as local variable

EXAMPLE CONFLICT:
----------------
// BAD: variable shadows type
struct file *file;  // "file" is both type and variable

// GOOD: distinct names
struct file *filp;  // "filp" = file pointer
struct inode *inode;

CONVENTION:
----------
filp = pointer to struct file
inode = pointer to struct inode
buf = pointer to buffer
pos = pointer to position
```

## AXIOM 6: INODE VS FILP RELATIONSHIP

```
ONE INODE, MANY FILPS:
---------------------
Process A: open("/dev/aesdchar") -> fd=3, filp_A=0x1000
Process B: open("/dev/aesdchar") -> fd=4, filp_B=0x2000
Process C: open("/dev/aesdchar") -> fd=3, filp_C=0x3000

All three filps point to SAME inode:
    filp_A->f_inode = 0xffff888100234000
    filp_B->f_inode = 0xffff888100234000
    filp_C->f_inode = 0xffff888100234000

inode->i_cdev = 0xffff888100234100 (our aesd_device.cdev)

MEMORY LAYOUT:
-------------
0xffff888100234000: inode for /dev/aesdchar
    i_rdev = MKDEV(240, 0)
    i_cdev = 0xffff888100234100
    i_count = 3 (3 opens)

0xffff888100234100: cdev structure
    ops = &aesd_fops
    list = [inode0, inode1, ...]
    dev = 0xf00000 (240 << 20 | 0)

0x1000: filp_A (Process A)
    f_inode = 0xffff888100234000
    f_pos = 0
    f_count = 1

0x2000: filp_B (Process B)
    f_inode = 0xffff888100234000
    f_pos = 0
    f_count = 1

0x3000: filp_C (Process C)
    f_inode = 0xffff888100234000
    f_pos = 0
    f_count = 1
```

## AXIOM 7: GETTING FROM filp TO YOUR DEVICE

```
CODE:
----
struct aesd_dev *dev;
struct inode *inode;

inode = filp->f_inode;                          // 0xffff888100234000
    // inode at 0x30: i_cdev = 0xffff888100234100

dev = container_of(inode->i_cdev, struct aesd_dev, cdev);
    // container_of(ptr, type, member)
    // ptr = 0xffff888100234100 (cdev address)
    // type = struct aesd_dev
    // member = cdev
    // 
    // calculation: 
    //   offset = &((struct aesd_dev *)0)->cdev = 0
    //   result = 0xffff888100234100 - 0 = 0xffff888100234100
    // 
    // dev = 0xffff888100234100

ALTERNATIVE:
-----------
// Store dev pointer in filp->private_data during open
static int aesd_open(struct inode *inode, struct file *filp)
{
    struct aesd_dev *dev;
    dev = container_of(inode->i_cdev, struct aesd_dev, cdev);
    filp->private_data = dev;  // STORE for later
    return 0;
}

static ssize_t aesd_read(struct file *filp, char __user *buf, ...)
{
    struct aesd_dev *dev = filp->private_data;  // RETRIEVE
    // dev = 0xffff888100234100
}
```

## AXIOM 8: THE OPEN SEQUENCE WITH REAL ADDRESSES

```
USER: fd = open("/dev/aesdchar", O_RDWR)

KERNEL:
------
1. path_lookup("/dev/aesdchar") 
   dentry = 0xffff888100233800
   dentry->d_inode = 0xffff888100234000

2. inode = 0xffff888100234000
   inode->i_rdev = 0xf00000 (240, 0)
   inode->i_cdev = 0xffff888100234100

3. filp = get_empty_filp()
   filp = 0xffff888100234200
   filp->f_op = 0xffffffffc0012000 (aesd_fops)
   filp->f_inode = 0xffff888100234000
   filp->f_flags = O_RDWR = 0x0002
   filp->f_mode = FMODE_READ | FMODE_WRITE = 0x3
   filp->f_pos = 0

4. filp->f_op->open(inode, filp)
   aesd_open(0xffff888100234000, 0xffff888100234200)

5. fd = get_unused_fd()
   fd = 3
   fd_install(3, filp)
   current->files->fdt->fd[3] = 0xffff888100234200

6. return 3 to user
```

## AXIOM 9: EXPLANATION OF build_open_flags()

### 1. Purpose and Functionality
`build_open_flags()` is a kernel function that translates user-space file open flags into kernel-internal flags. Specifically, in this context:

- **Input**: User-space flag `O_RDWR` (value `0x0002`)
- **Output**: Kernel-internal flags structure that the VFS (Virtual File System) can understand
- **Purpose**: Validates and converts the flags passed to `open()` system call into a format the kernel can use for file operations

### 2. Key Components and Their Interactions
**Starting from First Principles:**

**AXIOM: What is O_RDWR?**
- `O_RDWR = 0x0002` is a bitfield constant defined in `<fcntl.h>`
- It means: "Open for ReaD and WRite access"
- Binary representation: `0000 0010`

**The Flow:**
```
User calls: open("/dev/aesdchar", O_RDWR)
           ↓
System call: sys_openat
           ↓
do_sys_open()
           ↓
build_open_flags() ← YOU ARE HERE
```

**What build_open_flags() does:**
1. Parses the flag value `0x0002` (`O_RDWR`)
2. Extracts access mode bits:
   - Read permission: YES
   - Write permission: YES
3. Converts to kernel's internal representation:
   - Sets `FMODE_READ` bit
   - Sets `FMODE_WRITE` bit
4. Validates flags (checks for invalid combinations)
5. Returns a `struct open_flags` containing:
   - `open_flag`: Original user flags
   - `mode`: File creation mode (if creating)
   - `acc_mode`: Access mode (`MAY_READ | MAY_WRITE`)
   - `intent`: What the kernel intends to do

### 3. Important Patterns and Techniques

**Pattern 1: Flag Translation Layer**
This is a security boundary between user space and kernel space:
- User provides untrusted input (`O_RDWR`)
- Kernel validates and sanitizes it
- Kernel uses its own internal representation

**Pattern 2: Bitfield Manipulation**
```c
// Conceptual implementation
if (flags & O_RDWR) {
    acc_mode = MAY_READ | MAY_WRITE;
}
```

**Pattern 3: Early Validation**
The function validates flags before allocating resources (like the `struct file`), preventing wasted work on invalid requests.

**Context in the Call Chain:**
- **Before**: `do_sys_open()` receives raw user flags
- **During**: `build_open_flags()` validates and converts them
- **After**: `get_empty_filp()` allocates the file structure using validated flags

This function is critical because it ensures that only valid, kernel-understood flags proceed to the file allocation and inode linking stages.