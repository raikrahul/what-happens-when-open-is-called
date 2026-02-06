---
layout: default
title: "Stage 2 Return - Kernel Filename Tracing (Copy vs Cache)"
---

[HOME] ../index.html
Print ../articles/worksheet_stage2_return.html
Stage 1 https://raikrahul.github.io/what-happens-when-open-is-called/stage1.html
Stage 2 Entry https://raikrahul.github.io/what-happens-when-open-is-called/stage2.html
Stage 2 Return (Explanation) https://raikrahul.github.io/what-happens-when-open-is-called/articles/explanation_stage2_return.html

================================================================================
WHAT YOU ARE TRYING TO PROVE (IN ORDER)
================================================================================

1. The filename string used by open is copied into dentry name storage.
2. On cache miss, a new dentry is allocated and inserted.
3. On cache hit, the same dentry name pointer is reused.
4. On unlink, the dentry is deleted (d_delete).
5. On drop_caches, the dentry is evicted (__dentry_kill).
6. After eviction, t_e.txt rebuilds with a new dentry name pointer.
7. Basename offsets are exactly the prefix length (/tmp/ = 5, /mnt/loopfs/ = 12).
8. Long filenames go through the same path with length 64 and a later cache hit.

================================================================================
FILES YOU WILL TOUCH (AND WHY)
================================================================================

1. kernel/drivers/trace_do_filp_open/trace_do_filp_open.c
   Reason: probes to print real pointer values and hash keys.

2. kernel/user/stage2/minimal_open.c
   Reason: long filename path (length 64).

3. kernel/user/stage2/matrix_open.c
   Reason: cache miss, hit, delete, eviction, rebuild, basename offsets.

================================================================================
USER SPACE TEST PROGRAMS (AND WHY THEY EXIST)
================================================================================

Location (repo): https://github.com/raikrahul/what-happens-when-open-is-called/tree/main/kernel/user/stage2

PROGRAM 1: minimal_open.c
```c
#include <fcntl.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main() {
    char filename[128];
    time_t now = time(NULL);

    // Forces external allocation (name > inline dentry buffer)
    snprintf(filename, sizeof(filename),
             "test_file_very_long_name_to_force_external_allocation_%ld", now);

    int fd = open(filename, O_RDWR | O_CREAT, 0644);
    printf("fd=%d
", fd);
    sleep(5);  // Delay lets us observe a later cache hit.
    close(fd);
    unlink(filename);
    return 0;
}
```

PROGRAM 2: matrix_open.c
```c
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

static void close_if_open(int *fd) {
    if (*fd >= 0) {
        close(*fd);
        *fd = -1;
    }
}

static void drop_caches_if_root(void) {
    int fd;
    if (geteuid() != 0)
        return;
    sync();
    fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
    if (fd >= 0) {
        ssize_t w = write(fd, "2
", 2);
        (void)w;
        close(fd);
    }
}

int main() {
    int f[6];
    char n1[] = "l_e.txt";
    char n2[] = "/tmp/t_e.txt";
    char n3[] = "/tmp/t_m.txt";
    char n4[] = "l_m.txt";
    char n5[] = "/mnt/loopfs/a.txt";

    for (int i = 0; i < 6; i++)
        f[i] = -1;

    close(creat(n1, 0644));
    close(creat(n2, 0644));
    drop_caches_if_root();
    sleep(1);

    f[0] = open(n1, O_RDONLY);
    f[1] = open(n2, O_RDONLY);
    f[2] = open(n3, O_RDONLY);
    f[3] = open(n1, O_RDONLY);
    f[4] = open(n4, O_RDONLY);
    f[5] = open(n5, O_RDONLY);

    close_if_open(&f[0]);
    f[0] = open(n1, O_RDONLY);

    sleep(2);
    close_if_open(&f[0]);
    close_if_open(&f[1]);
    close_if_open(&f[2]);
    close_if_open(&f[3]);
    close_if_open(&f[4]);
    close_if_open(&f[5]);

    unlink(n1);
    unlink(n2);
    close(creat(n1, 0644));
    close(creat(n2, 0644));
    f[0] = open(n1, O_RDONLY);
    f[1] = open(n2, O_RDONLY);

    close_if_open(&f[0]);
    close_if_open(&f[1]);

    drop_caches_if_root();
    sleep(1);
    f[0] = open(n1, O_RDONLY);
    f[1] = open(n2, O_RDONLY);
    close_if_open(&f[0]);
    close_if_open(&f[1]);

    return 0;
}
```

================================================================================
KERNEL PROBES YOU MUST HAVE (WHY EACH EXISTS)
================================================================================

Location: kernel/drivers/trace_do_filp_open/trace_do_filp_open.c

Required probes:
- do_filp_open entry: prints filename pointer and string
- d_lookup entry: prints hash, length, name (lookup key)
- d_lookup return: prints NULL (miss) or dentry name pointer (hit)
- __d_alloc entry: prints copy source pointer
- __d_alloc return: prints copy destination pointer
- __d_add entry: prints inserted dentry name pointer
- d_delete entry: prints deleted dentry name pointer
- __dentry_kill entry: prints evicted dentry name pointer
- __d_lookup and __d_lookup_rcu: internal lookup path keys

================================================================================
BUILD AND RUN (ORDER MATTERS)
================================================================================

1) Build the driver
```
cd kernel/drivers/trace_do_filp_open && make clean && make
```

2) Run minimal_open (long filename)
```
sudo dmesg -C
sudo rmmod trace_do_filp_open
sudo insmod trace_do_filp_open.ko target_comm=minimal_open
cd ../../user/stage2
./minimal_open
sleep 5
sudo dmesg | rg -n "test_file_very_long_name_to_force_external_allocation"
```

3) Run matrix_open (all paths)
```
sudo dmesg -C
sudo rmmod trace_do_filp_open
sudo insmod trace_do_filp_open.ko target_comm=matrix_open
cd ../../user/stage2
sudo ./matrix_open
sleep 3
sudo dmesg | rg -n "l_e.txt|t_e.txt|t_m.txt|l_m.txt|a.txt|drop_caches|d_lookup entry|d_lookup return|__d_add entry|d_delete entry|__dentry_kill entry|__d_lookup entry|__d_lookup_rcu entry|__d_alloc"
```

================================================================================

================================================================================
AXIOMATIC EXPLANATION (READ BEFORE FILLING THE RECORDS)
================================================================================

Axioms (base facts used for every step):
- A1. open(path) causes the kernel to run do_filp_open with a kernel-resident filename string.
- A2. d_lookup searches the dcache using the lookup key (name, length, hash).
- A3. If d_lookup returns NULL, the lookup missed the cache.
- A4. On a miss, __d_alloc allocates a dentry and copies the name into dentry->d_name.name.
- A5. __d_add inserts the dentry into the dcache.
- A6. do_filp_open returns a struct file that points to f->f_path.dentry->d_name.name.
- A7. d_delete removes a dentry on unlink.
- A8. __dentry_kill reclaims a dentry on drop_caches.
- A9. Pointer equality means same address. Pointer inequality means different address.
- A10. /tmp/ length is 5. /mnt/loopfs/ length is 12.

Why each worksheet section exists and what you should see:

FILE A (t_e.txt, first open after drop_caches)
- You open /tmp/t_e.txt immediately after drop_caches to force a cache miss.
- Expected: do_filp_open entry for /tmp/t_e.txt, d_lookup miss, __d_alloc entry/return, __d_add, do_filp_open return.
- Offset check proves basename pointer = entry pointer + 5 (A10).

FILE B (t_m.txt, missing)
- You open /tmp/t_m.txt to force a miss on a name that does not exist.
- Expected: d_lookup return NULL, __d_alloc return, __d_add for t_m.txt (negative dentry).

FILE C (l_m.txt, missing)
- You open l_m.txt without a prefix to show no basename shift.
- Expected: __d_alloc entry pointer equals the full string pointer (no /tmp/ offset).

FILE D (a.txt, loopback ext2)
- You open /mnt/loopfs/a.txt to prove the same mechanism on a different filesystem and short name.
- Expected: d_lookup miss, __d_alloc entry pointer = entry pointer + 12 (A10), __d_add, do_filp_open return.

CACHE HIT (before deletion)
- You open l_e.txt and t_e.txt again after they were inserted.
- Expected: d_lookup returns pointers equal to earlier do_filp_open return pointers (A9).

DELETION (unlink)
- You call unlink for l_e.txt and /tmp/t_e.txt.
- Expected: d_delete entry lines for those names (A7).

EVICTION (drop_caches)
- You write to /proc/sys/vm/drop_caches.
- Expected: __dentry_kill lines for those names (A8).

REBUILD (after eviction, t_e.txt)
- You open /tmp/t_e.txt after eviction.
- Expected: d_lookup return NULL, new __d_alloc return pointer, __d_add, do_filp_open return.
- Inequality check: rebuilt pointer != pre-eviction pointer (A9).

POST-EVICTION LOOKUP (l_e.txt)
- You open l_e.txt after eviction.
- Expected: __d_lookup_rcu entry for l_e.txt and a new do_filp_open return pointer (A9).

FIND THE COPY (kernel source)
- You locate memcpy(dname, name->name, name->len) in fs/dcache.c.
- This is the exact copy step that makes __d_alloc return pointer equal to the dentry name pointer (A4).

WHAT TO RECORD (FILL THIS IN)
================================================================================

TEST 1: LONG FILENAME (minimal_open)

Record:
- do_filp_open entry pointer = 0x________ | test_file_very_long_name_to_force_external_allocation_XXXX
- d_lookup entry: hash ________ length 64 name test_file_very_long_name_to_force_external_allocation_XXXX
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | test_file_very_long_name_to_force_external_allocation_XXXX
- do_filp_open return pointer = 0x________ | test_file_very_long_name_to_force_external_allocation_XXXX
- cache hit later: d_lookup return pointer = 0x________ | test_file_very_long_name_to_force_external_allocation_XXXX

Checks:
- __d_alloc return == __d_add entry == do_filp_open return
- cache hit pointer equals earlier return pointer

Make a diagram (required):
- Draw the full pointer flow for this long filename as a single chain:
  do_filp_open entry -> d_lookup miss -> __d_alloc entry -> __d_alloc return -> __d_add -> do_filp_open return -> d_lookup hit.
- Use your recorded addresses in the diagram, not placeholders.
- Base the copy step on kernel source: /usr/src/linux-headers-$(uname -r)/fs/dcache.c
  Search for: memcpy(dname, name->name, name->len);
  This is the line that explains why the __d_alloc destination pointer equals the dentry name pointer.

TEST 2: MATRIX (matrix_open)

FILE A (t_e.txt, first open after drop_caches):
- do_filp_open entry pointer = 0x________ | /tmp/t_e.txt
- d_lookup entry hash ________ len 7 name t_e.txt
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_e.txt
- do_filp_open return pointer = 0x________ | t_e.txt
- offset check: (entry pointer + 5) == __d_alloc entry pointer

FILE B (t_m.txt, missing):
- do_filp_open entry pointer = 0x________ | /tmp/t_m.txt
- d_lookup return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_m.txt

FILE C (l_m.txt, missing):
- do_filp_open entry pointer = 0x________ | l_m.txt
- d_lookup return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | l_m.txt

FILE D (a.txt, loopback ext2):
- do_filp_open entry pointer = 0x________ | /mnt/loopfs/a.txt
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | a.txt
- do_filp_open return pointer = 0x________ | a.txt
- offset check: (entry pointer + 12) == __d_alloc entry pointer

CACHE HIT (before deletion):
- d_lookup return pointer = 0x________ | l_e.txt
- d_lookup return pointer = 0x________ | t_e.txt

DELETION (unlink):
- d_delete entry = 0x________ | l_e.txt
- d_delete entry = 0x________ | t_e.txt

EVICTION (drop_caches):
- do_filp_open entry/return for /proc/sys/vm/drop_caches
- __dentry_kill entry = 0x________ | l_e.txt
- __dentry_kill entry = 0x________ | t_e.txt

REBUILD (after eviction, t_e.txt):
- d_lookup return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_e.txt
- do_filp_open return pointer = 0x________ | t_e.txt
- inequality check: rebuild pointer != pre-eviction pointer

POST-EVICTION LOOKUP (l_e.txt):
- __d_lookup_rcu entry: hash ________ length 7 name l_e.txt
- do_filp_open return pointer = 0x________ | l_e.txt
- inequality check: post-eviction pointer != pre-eviction pointer

================================================================================
FIND THE COPY
================================================================================

grep -n "memcpy.*name->name" /usr/src/linux-headers-$(uname -r)/fs/dcache.c
Line: _____

Code:
memcpy(dname, name->name, name->len);

================================================================================
FAILURE MODES
================================================================================

1. No output
   Process name filter mismatch.
   Check target_comm parameter.

2. No d_lookup lines
   Probes not registered.
   Ensure kp_lookup, kp_d_lookup, kp_d_lookup_rcu are registered.

3. Crash on error path
   Dereferencing error pointer.
   Check IS_ERR(f) before deref.

4. Kernel panic
   NULL pointer dereference.
   Check pointers before deref.

5. Module load fails
   Kernel version mismatch.
   make clean && make

6. Missing kernel headers
   Install linux-headers-$(uname -r)

================================================================================
UNDERSTANDING CHECKLIST
================================================================================

[ ] Driver compiles and loads
[ ] minimal_open shows long filename miss + add + return
[ ] long filename later shows cache hit
[ ] matrix_open shows t_e.txt miss + add + return
[ ] /tmp offset check is 5
[ ] loopfs offset check is 12
[ ] matrix_open shows cache hit before deletion
[ ] matrix_open shows deletion via d_delete
[ ] matrix_open shows eviction via __dentry_kill
[ ] matrix_open shows rebuild for t_e.txt after eviction
[ ] matrix_open shows post-eviction lookup for l_e.txt
[ ] memcpy located in kernel source
