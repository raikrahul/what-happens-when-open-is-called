---
layout: default
title: "Stage 2 Return"
---

QUESTION

Where does the filename string live when do_filp_open returns?

ANSWER

The filename lives in dentry->d_name.name. The returned struct file points to this address.

PROOF METHOD

Print kernel pointers at 5 locations using kprobes. Compare addresses. If address A equals address B, they point to the same memory. If A - B = 5, the offset is 5 bytes. This is the only method: pointer equality and pointer arithmetic.

USER SPACE CODE

```c
#include <fcntl.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main(void) {
    char filename[128];
    time_t now = time(NULL);
    snprintf(filename, sizeof(filename),
             "test_file_very_long_name_to_force_external_allocation_%ld", now);
    int fd = open(filename, O_RDWR | O_CREAT, 0644);
    printf("fd=%d\n", fd);
    sleep(5);
    close(fd);
    return 0;
}
```

WHY THIS CODE

The filename is 64 bytes long. This forces __d_alloc to use external allocation for dentry->d_name.name. Short names (< 36 bytes) use inline storage inside struct dentry. Long names allocate separate memory. We need external allocation to see the memcpy destination address differ from the dentry struct address.

SOURCE: /usr/src/linux-source-6.8.0/fs/dcache.c:1651
```c
if (name->len > DNAME_INLINE_LEN-1) {
    dname = kmalloc(name->len + 1, GFP_KERNEL);
    if (!dname) {
        kmem_cache_free(dentry_cache, dentry);
        return NULL;
    }
} else {
    dname = dentry->d_iname;
}
memcpy(dname, name->name, name->len);
```

DNAME_INLINE_LEN = 36 (include/linux/dcache.h:98)
Our filename length = 64 bytes > 36 bytes, so kmalloc runs, dname points to external buffer, memcpy copies to external buffer.

PROBES

do_sys_openat2 (fs/open.c:1388) calls getname which copies user string to kernel buffer and returns struct filename * at 0xffff8f294c36e020.

Line 1404 calls do_filp_open(dfd, filename, op). Probe at do_filp_open entry prints filename->name which is 0xffff8f294c36e020 pointing to "test_file_very_long_name_to_force_external_allocation_1770484700". This is the input: the full path string that do_filp_open receives from getname.

do_filp_open calls path_openat which calls link_path_walk which walks the path component by component. For each component, link_path_walk calls walk_component which calls lookup_fast which calls __d_lookup_rcu to search the dcache.

__d_lookup_rcu computes hash of the component name using full_name_hash, searches the dcache hash table for a dentry with matching hash and name. If found, returns existing dentry. If not found, returns NULL.

On NULL, lookup_fast returns -ECHILD, walk_component calls lookup_slow which calls __lookup_slow which calls d_lookup. d_lookup calls __d_lookup which searches again without RCU. On NULL, __lookup_slow calls d_alloc_parallel which calls __d_alloc.

Probe at __d_alloc entry prints qstr->name which is 0xffff8f294c36e020 pointing to "test_file_very_long_name_to_force_external_allocation_1770484700". This is the memcpy source: the basename pointer that __d_alloc will copy from.

__d_alloc allocates struct dentry from dentry_cache slab. If name length > 35 bytes, __d_alloc calls kmalloc to allocate external buffer for the name. Our name is 64 bytes so kmalloc returns buffer at 0xffff8f2bb3de6618. __d_alloc calls memcpy(0xffff8f2bb3de6618, 0xffff8f294c36e020, 64) to copy the name. __d_alloc sets dentry->d_name.name = 0xffff8f2bb3de6618.

Probe at __d_alloc return prints dentry->d_name.name which is 0xffff8f2bb3de6618. This is the memcpy destination: the new buffer where the name now lives.

__d_alloc returns dentry to d_alloc_parallel which returns dentry to __lookup_slow which calls lookup_open which calls atomic_open which fails, then calls lookup_real which calls vfs_create which creates the file and sets dentry->d_inode.

lookup_open calls d_add which calls __d_add. __d_add inserts the dentry into the dcache hash table so future lookups can find it. Probe at __d_add entry prints dentry->d_name.name which is 0xffff8f2bb3de6618. This is the cached pointer: the name address that is now in the dcache.

__d_add returns to d_add which returns to lookup_open which returns to open_last_lookups which returns to path_openat which calls do_open which calls vfs_open which calls do_dentry_open which allocates struct file and sets file->f_path.dentry = dentry.

do_dentry_open returns file to vfs_open which returns file to do_open which returns file to path_openat which returns file to do_filp_open. Probe at do_filp_open return prints file->f_path.dentry->d_name.name which is 0xffff8f2bb3de6618. This is the output: the name address that the returned file points to.

DATA STRUCTURES BEFORE FIRST CALL

User space calls open("test_file_very_long_name_to_force_external_allocation_1770484700", O_RDWR | O_CREAT, 0644). Libc transforms this to openat(AT_FDCWD, "test_file_very_long_name_to_force_external_allocation_1770484700", O_RDWR | O_CREAT, 0644). Syscall enters kernel at do_sys_openat2 (fs/open.c:1388). Line 1398 calls getname(filename) which copies user string to kernel buffer and returns struct filename * at 0xffff8f294c36e020. Line 1404 calls do_filp_open(dfd, filename, op) where filename = 0xffff8f294c36e020.

struct filename at 0xffff8f294c36e020:
```
+0x00: name  = 0xffff8f294c36e020  (points to iname[])
+0x08: uptr  = 0x7ffe...           (user pointer)
+0x10: refcnt = 1
+0x18: aname = NULL
+0x20: iname[] = "test_file_very_long_name_to_force_external_allocation_1770484700"
```

PROBE 1 OUTPUT

```
[O] IN: 0xffff8f294c36e020 | test_file_very_long_name_to_force_external_allocation_1770484700
```

do_filp_open receives struct filename * at 0xffff8f294c36e020. The name field points to 0xffff8f294c36e020 (iname[] at offset +0x20 from struct base). Probe reads regs->si = 0xffff8f294c36e020, dereferences filename->name, prints 0xffff8f294c36e020 and the string. This is the input address.

DATA STRUCTURES BEFORE SECOND CALL

do_filp_open calls path_openat which calls link_path_walk which calls walk_component which calls lookup_fast which calls __d_lookup_rcu (fs/dcache.c:2345). __d_lookup_rcu searches dcache for existing dentry with name "test_file_very_long_name_to_force_external_allocation_1770484700". Hash = 4193849663, length = 64. Search returns NULL (cache miss). lookup_fast returns -ECHILD. walk_component calls lookup_slow which calls __lookup_slow which calls d_lookup (fs/dcache.c:2486). d_lookup calls __d_lookup which searches again, returns NULL. __lookup_slow calls d_alloc_parallel which calls __d_alloc (fs/dcache.c:1651).

struct qstr passed to __d_alloc:
```
+0x00: hash = 4193849663
+0x04: len  = 64
+0x08: name = 0xffff8f294c36e020  (points to basename in filename->iname[])
```

PROBE 2 OUTPUT

```
[A] SRC: 0xffff8f294c36e020
```

__d_alloc receives struct qstr * in regs->si. Probe dereferences qstr->name, prints 0xffff8f294c36e020. This is the memcpy source address. Note: 0xffff8f294c36e020 - 0xffff8f294c36e020 = 0x0 = 0 bytes offset because filename has no directory prefix. If filename was "/tmp/file.txt", the offset would be 5 bytes (strlen("/tmp/")).

DATA STRUCTURES DURING __d_alloc

__d_alloc allocates struct dentry from dentry_cache slab (fs/dcache.c:1651). Line 1651 checks if name->len > DNAME_INLINE_LEN-1 (64 > 35 = true). Line 1652 calls kmalloc(64 + 1, GFP_KERNEL) which returns buffer at 0xffff8f2bb3de6618. Line 1658 sets dname = 0xffff8f2bb3de6618. Line 1660 calls memcpy(0xffff8f2bb3de6618, 0xffff8f294c36e020, 64). Line 1661 sets dname[64] = '\0'. Line 1662 sets dentry->d_name.name = 0xffff8f2bb3de6618.

struct dentry after __d_alloc:
```
+0x00: d_flags = 0
+0x04: d_seq = 0
+0x08: d_hash = { next = NULL, pprev = NULL }
+0x18: d_parent = 0xffff...  (parent dentry)
+0x20: d_name.hash = 4193849663
+0x24: d_name.len = 64
+0x28: d_name.name = 0xffff8f2bb3de6618  (external buffer)
+0x30: d_inode = NULL  (not set yet)
+0x38: d_iname[36] = unused (external allocation used)
```

PROBE 3 OUTPUT

```
[A] DST: 0xffff8f2bb3de6618
```

__d_alloc returns struct dentry * in regs->ax. Probe dereferences dentry->d_name.name, prints 0xffff8f2bb3de6618. This is the memcpy destination address. Pointer equality: 0xffff8f2bb3de6618 (DST) was the target of memcpy from 0xffff8f294c36e020 (SRC).

DATA STRUCTURES BEFORE THIRD CALL

__d_alloc returns dentry to d_alloc_parallel which returns dentry to __lookup_slow which calls lookup_open which calls atomic_open which fails, then calls lookup_real which calls vfs_create which succeeds and sets dentry->d_inode to new inode. lookup_open calls d_add which calls __d_add (fs/dcache.c:2794). __d_add inserts dentry into dcache hash table.

PROBE 4 OUTPUT

```
__d_add entry: 0xffff8f2bb3de6618 | test_file_very_long_name_to_force_external_allocation_1770484700
```

__d_add receives struct dentry * in regs->di. Probe dereferences dentry->d_name.name, prints 0xffff8f2bb3de6618 and the string. This is the cached pointer. Pointer equality: 0xffff8f2bb3de6618 (add) equals 0xffff8f2bb3de6618 (DST). The inserted dentry name pointer is the memcpy destination pointer.

DATA STRUCTURES BEFORE FOURTH CALL

__d_add returns to lookup_open which returns to atomic_open which returns to lookup_open which returns to open_last_lookups which returns to path_openat which calls do_open which calls vfs_open which calls do_dentry_open which allocates struct file from filp_cache slab and sets file->f_path.dentry = dentry. do_dentry_open returns file to vfs_open which returns file to do_open which returns file to path_openat which returns file to do_filp_open.

struct file after do_dentry_open:
```
+0x00: f_u = { ... }
+0x10: f_path.mnt = 0xffff...  (mount point)
+0x18: f_path.dentry = 0xffff8f2bb3de6600  (dentry struct base)
+0x20: f_inode = 0xffff...  (inode)
+0x28: f_op = 0xffff...  (file operations)
```

dentry at 0xffff8f2bb3de6600:
```
+0x28: d_name.name = 0xffff8f2bb3de6618
```

file->f_path.dentry->d_name.name = 0xffff8f2bb3de6618

PROBE 5 OUTPUT

```
[O] OUT: 0xffff8f2bb3de6618 | test_file_very_long_name_to_force_external_allocation_1770484700
```

do_filp_open returns struct file * in regs->ax. Probe dereferences file->f_path.dentry->d_name.name, prints 0xffff8f2bb3de6618 and the string. This is the output address. Pointer equality: 0xffff8f2bb3de6618 (OUT) equals 0xffff8f2bb3de6618 (add) equals 0xffff8f2bb3de6618 (DST). The returned file name pointer is the inserted dentry name pointer is the memcpy destination pointer.

PROOF CHAIN

0xffff8f294c36e020 (IN) -> memcpy source
0xffff8f2bb3de6618 (DST) -> memcpy destination
0xffff8f2bb3de6618 (add) -> inserted into dcache
0xffff8f2bb3de6618 (OUT) -> returned to user

Pointer equality proves: DST = add = OUT. The filename lives in dentry->d_name.name at 0xffff8f2bb3de6618. The returned struct file points to this address via file->f_path.dentry->d_name.name.

CACHE HIT TEST

Run minimal_open again after 5 seconds. dcache still has dentry for "test_file_very_long_name_to_force_external_allocation_1770484700". Second open calls d_lookup which calls __d_lookup which searches dcache and finds existing dentry.

PROBE OUTPUT SECOND OPEN

```
d_lookup entry: hash 4193849663 length 64 name test_file_very_long_name_to_force_external_allocation_1770484700
d_lookup return: 0xffff8f2bb3de6618 | test_file_very_long_name_to_force_external_allocation_1770484700
```

d_lookup returns existing dentry. No [A] SRC or [A] DST lines appear (no __d_alloc called). No __d_add line appears (no insertion). Pointer equality: 0xffff8f2bb3de6618 (lookup return) equals 0xffff8f2bb3de6618 (first open OUT). Cache hit reuses same address. No memcpy on cache hit.

NEGATIVE DENTRY TEST

```c
const char *n3 = "/tmp/t_m.txt";
drop_caches_if_root();
sleep(1);
int fd1 = open(n3, O_RDONLY);
printf("tm_miss first open fd=%d\n", fd1);
int fd2 = open(n3, O_RDONLY);
printf("tm_miss second open fd=%d\n", fd2);
```

File /tmp/t_m.txt does not exist. First open returns fd=-1. Second open returns fd=-1.

PROBE OUTPUT FIRST OPEN

```
[O] IN: 0xffff8f2940f34020 | /tmp/t_m.txt
__d_lookup_rcu entry: hash 3314222277 length 3 name tmp/t_m.txt
__d_lookup_rcu return: 0xffff8f29481d6e78 | tmp
__d_lookup_rcu entry: hash 1429044786 length 7 name t_m.txt
__d_lookup_rcu return: NULL
d_lookup entry: hash 1429044786 length 7 name t_m.txt
d_lookup return: NULL
[A] SRC: 0xffff8f2940f34025
[A] DST: 0xffff8f2bb95c0578
__d_lookup_rcu entry: hash 1429044786 length 7 name t_m.txt
__d_lookup_rcu return: NULL
__d_add entry: 0xffff8f2bb95c0578 | t_m.txt
dput entry: 0xffff8f2bb95c0578 | t_m.txt
```

Basename offset: 0xffff8f2940f34025 - 0xffff8f2940f34020 = 0x5 = 5 bytes = strlen("/tmp/"). The kernel skips the directory prefix "/tmp/" and passes pointer to basename "t_m.txt" at offset +5 to __d_alloc. __d_alloc allocates dentry, memcpy copies "t_m.txt" to 0xffff8f2bb95c0578, __d_add inserts dentry into dcache. File does not exist so vfs_create fails, open returns -1, but dentry exists in dcache with d_inode=NULL. This is a negative dentry.

PROBE OUTPUT SECOND OPEN

```
[O] IN: 0xffff8f2940f34020 | /tmp/t_m.txt
__d_lookup_rcu entry: hash 3314222277 length 3 name tmp/t_m.txt
__d_lookup_rcu return: 0xffff8f29481d6e78 | tmp
__d_lookup_rcu entry: hash 1429044786 length 7 name t_m.txt
__d_lookup_rcu return: 0xffff8f2bb95c0578 | t_m.txt
```

__d_lookup_rcu returns 0xffff8f2bb95c0578. No [A] SRC or [A] DST lines (no __d_alloc). No __d_add line (no insertion). Pointer equality: 0xffff8f2bb95c0578 (second open lookup) equals 0xffff8f2bb95c0578 (first open add). Negative dentry cached. Second open hits cache, avoids disk lookup, returns -1 immediately.

CACHE INVALIDATION TEST

```c
const char *name = "/tmp/evict_test.txt";
close(creat(name, 0644));
sleep(1);
if (geteuid() == 0) {
    sync();
    int fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
    if (fd >= 0) {
        write(fd, "2\n", 2);
        close(fd);
    }
}
sleep(1);
int fd = open(name, O_RDONLY);
```

PROBE OUTPUT FIRST OPEN

```
[O] IN: 0xffff8f294aea3020 | /tmp/evict_test.txt
__d_lookup_rcu entry: hash 3314222277 length 3 name tmp/evict_test.txt
__d_lookup_rcu entry: hash 1728927617 length 14 name evict_test.txt
d_lookup entry: hash 1728927617 length 14 name evict_test.txt
[A] SRC: 0xffff8f294aea3025
[A] DST: 0xffff8f294c931038
__d_lookup_rcu entry: hash 1728927617 length 14 name evict_test.txt
__d_add entry: 0xffff8f294c931038 | evict_test.txt
[O] OUT: 0xffff8f294c931038 | evict_test.txt
```

Basename offset: 0xffff8f294aea3025 - 0xffff8f294aea3020 = 0x5 = 5 bytes = strlen("/tmp/"). dentry->d_name.name = 0xffff8f294c931038.

PROBE OUTPUT SECOND OPEN (AFTER DROP_CACHES)

```
[O] IN: 0xffff8f29465f9020 | /tmp/evict_test.txt
__d_lookup_rcu entry: hash 3314222277 length 3 name tmp/evict_test.txt
__d_lookup_rcu entry: hash 1728927617 length 14 name evict_test.txt
d_lookup entry: hash 1728927617 length 14 name evict_test.txt
[A] SRC: 0xffff8f29465f9025
[A] DST: 0xffff8f2995e79db8
__d_lookup_rcu entry: hash 1728927617 length 14 name evict_test.txt
__d_add entry: 0xffff8f2995e79db8 | evict_test.txt
[O] OUT: 0xffff8f2995e79db8 | evict_test.txt
```

Basename offset: 0xffff8f29465f9025 - 0xffff8f29465f9020 = 0x5 = 5 bytes = strlen("/tmp/"). dentry->d_name.name = 0xffff8f2995e79db8. Address comparison: 0xffff8f2995e79db8 ≠ 0xffff8f294c931038. Subtraction: 0xffff8f2995e79db8 - 0xffff8f294c931038 = 0x4b48d80 = 78999936 bytes. Addresses differ. drop_caches evicted old dentry. Second open allocated new dentry at different address. Both opens show [A] SRC and [A] DST (memcpy happened twice). Basename offset consistent (5 bytes both times).

KERNEL SOURCES

/usr/src/linux-source-6.8.0/fs/open.c:1404 do_filp_open
/usr/src/linux-source-6.8.0/fs/dcache.c:1651 __d_alloc
/usr/src/linux-source-6.8.0/fs/dcache.c:2486 d_lookup
/usr/src/linux-source-6.8.0/fs/dcache.c:2345 __d_lookup_rcu
/usr/src/linux-source-6.8.0/fs/dcache.c:2794 __d_add

struct filename: include/linux/fs.h:2554-2560
struct file: include/linux/fs.h:1000-1019
struct dentry: include/linux/dcache.h:89-150
struct qstr: include/linux/dcache.h:47-51

DRIVER

kernel/drivers/trace_do_filp_open/trace_do_filp_open.c

Kprobes: do_filp_open, __d_alloc, d_lookup, __d_lookup_rcu, __d_add
Kretprobes: do_filp_open, __d_alloc, d_lookup, __d_lookup_rcu

Build: cd kernel/drivers/trace_do_filp_open && make
Load: sudo insmod trace_do_filp_open.ko target_comm=minimal_open
Run: cd kernel/user/stage2 && gcc -o minimal_open minimal_open.c && ./minimal_open
Read: sudo dmesg | grep -E "\[O\]|\[A\]|d_lookup|__d_add"
Unload: sudo rmmod trace_do_filp_open

PREVIOUS WORK

Stage 1: User Space to Syscall Boundary
https://raikrahul.github.io/what-happens-when-open-is-called/stage1.html
Proved: open() -> PLT -> GOT -> libc -> openat() -> syscall

Stage 2 Entry: Kernel Space - Tracing getname()
https://raikrahul.github.io/what-happens-when-open-is-called/stage2.html
Proved: syscall -> do_sys_openat2 -> getname() copies user string to kernel buffer

Stage 2 Return: This Document
Proved: do_filp_open -> __d_alloc -> memcpy -> __d_add -> return file pointing to dentry name

Complete chain: User space open("file") -> libc openat(AT_FDCWD, "file", flags) -> syscall -> kernel do_sys_openat2 -> getname copies to kernel -> do_filp_open -> __d_alloc copies to dentry -> return struct file pointing to dentry name. Every step verified with printed addresses from actual runs on Linux 6.14.0-37-generic, Ubuntu 24.04, 2026-02-07.
