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

1. Record copy source and copy destination pointers for the filename.
2. Record the first miss and the first insert for a file name.
3. Record a later lookup that returns a previously recorded pointer.
4. Record deletion lines for l_e.txt and t_e.txt.
5. Record eviction lines for those names after drop_caches.
6. Record a rebuild pointer for t_e.txt and compare it to the pre-eviction pointer.
7. Record basename offsets and compare them to the prefix length.
8. Record the long filename miss and later hit.

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

    // Long filename; you will verify the allocation path with probes.
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

Probe code locations (driver file + GitHub links):
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:73` do_filp_open entry handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L73
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:115` d_lookup return handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L115
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:131` d_lookup entry handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L131
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:94` __d_alloc entry handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L94
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:104` __d_alloc return handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L104
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:195` __d_add entry handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L195
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:225` d_delete entry handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L225
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:258` __dentry_kill entry handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L258
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:141` __d_lookup entry handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L141
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:151` __d_lookup_rcu entry handler
  https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c#L151

================================================================================
BUILD AND RUN (ORDER MATTERS)
================================================================================

1) Build the driver
```
cd kernel/drivers/trace_do_filp_open && make clean && make
```
Source: https://github.com/raikrahul/what-happens-when-open-is-called/tree/main/kernel/drivers/trace_do_filp_open

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

2b) Prepare loopback ext2 (for the a.txt case)
```
sudo mkdir -p /mnt/loopfs
sudo dd if=/dev/zero of=/tmp/loopfs.img bs=1M count=64
sudo losetup -fP /tmp/loopfs.img
sudo mkfs.ext2 -F /tmp/loopfs.img
sudo mount /tmp/loopfs.img /mnt/loopfs
sudo sh -c 'echo x > /mnt/loopfs/a.txt'
sync
sudo umount /mnt/loopfs
sudo mount /tmp/loopfs.img /mnt/loopfs
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

Why these commands exist (do not skip):
- `sudo dmesg -C` clears the kernel ring buffer so the next lines are only from this run.
- `sudo insmod ... target_comm=matrix_open` restricts probe output to the process named `matrix_open`.
- `sudo ./matrix_open` is required because the program writes to `/proc/sys/vm/drop_caches`.
- `sleep 3` allows delayed probe lines (lookups, eviction) to finish.
- `sudo dmesg | rg -n "..."` filters the kernel log to just the filename strings and probe labels we need.
  `rg -n` adds line numbers so you can cite the exact evidence line-by-line.

Driver map (what the code is doing and why it exists):
- File: `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c`
- `target_comm` gate: filters output to one user-space program so unrelated kernel noise is ignored.
- `do_filp_open` entry/return: captures the kernel filename pointer at entry and the returned file’s dentry name pointer at return.
- `__d_alloc` entry/return: captures copy source pointer and copy destination pointer for the dentry name.
- `d_lookup` entry/return: captures the hash, length, and name key; return shows hit vs miss.
- `__d_lookup` / `__d_lookup_rcu`: shows lookup on internal and RCU paths for the same key.
- `__d_add`: shows the exact dentry name pointer inserted into the dcache.
- `d_delete`: shows the exact dentry name pointer removed on unlink.
- `__dentry_kill`: shows which dentry was reclaimed by drop_caches (eviction).
- `full_name_hash` (kretprobe): attempts to log the hash computation itself; if it prints nothing, you still have the hash values at `d_lookup` entry.

================================================================================

================================================================================
AXIOMATIC EXPLANATION (READ BEFORE FILLING THE RECORDS)
================================================================================

Proof anchors (kernel source on this machine, read these first):
- Open syscall path to do_filp_open:
  File: `/usr/src/linux-source-6.8.0/fs/open.c`
  Lines: 1388–1414 show `do_sys_openat2` calling `do_filp_open`.
  Lines: 1423–1436 show `SYSCALL_DEFINE3(open)` and `SYSCALL_DEFINE4(openat)` calling `do_sys_open`.
  Command:
  ```
  nl -ba /usr/src/linux-source-6.8.0/fs/open.c | sed -n '1388,1436p'
  ```
- dentry lookup, alloc, insert, delete:
  File: `/usr/src/linux-source-6.8.0/fs/dcache.c`
  Commands:
  ```
  rg -n "d_lookup\\(|__d_alloc\\(|__d_add\\(|d_delete\\(|__dentry_kill" /usr/src/linux-source-6.8.0/fs/dcache.c
  ```

Axioms (base facts used for every step, each tied to the proof anchors above): Open/openat reach
`do_filp_open` via `do_sys_openat2` (fs/open.c:1388–1436). `d_lookup` uses the lookup key `(name,
length, hash)` (fs/dcache.c:2253), and a NULL return is a miss (driver return probe at
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:115–121`). On a miss, `__d_alloc` allocates
the dentry and copies the name (fs/dcache.c:1622), and `__d_add` inserts it into the dcache
(fs/dcache.c:2605). `do_filp_open` returns a `struct file` whose name pointer is read from
`f->f_path.dentry->d_name.name` (driver return probe at
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:82–88`). `d_delete` removes a dentry on
unlink (fs/dcache.c:2384). `__dentry_kill` reclaims a dentry on drop_caches (fs/dcache.c:583).
Pointer equality/inequality uses address identity. Prefix lengths are `/tmp/` = 5 and `/mnt/loopfs/`
= 12 from local evaluation.

Why each worksheet section exists and what you should see: Open `/tmp/t_e.txt` immediately after
drop_caches and record the miss, alloc, add, return, and the basename offset (compare entry pointer
and basename pointer to check for +5). Open `/tmp/t_m.txt` and record miss, alloc, add. Open
`l_m.txt` and record whether alloc entry equals the full string pointer (no prefix). Open
`/mnt/loopfs/a.txt` and record miss, alloc, add, return, and basename offset (compare for +12).
Reopen `l_e.txt` and `/tmp/t_e.txt` and compare d_lookup return pointers to earlier do_filp_open
return pointers. Unlink `l_e.txt` and `/tmp/t_e.txt` and record d_delete lines. Write to drop_caches
and record __dentry_kill lines. Reopen `/tmp/t_e.txt` after eviction and compare rebuilt pointer to
the pre-eviction pointer. Reopen `l_e.txt` after eviction and compare post-eviction pointer to the
pre-eviction pointer. Finally, locate `memcpy(dname, name->name, name->len)` in fs/dcache.c and
record the exact line number.

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
<table>
  <tr>
    <td>
      <pre><code>1) memcpy chain (t_e.txt, copy source -> destination)
"/tmp/t_e.txt" @ 0xffff8bd54c33e020 -> __d_alloc entry 0xffff8bd54c33e025 -> __d_alloc return 0xffff8bd54eaa09f8
2) cache build-up chain (t_e.txt, miss -> insert)
d_lookup return NULL -> __d_add 0xffff8bd54eaa09f8 -> do_filp_open return 0xffff8bd54eaa09f8
3) cache hit chain (t_e.txt, later lookup)
d_lookup return 0xffff8bd54eaa09f8 -> do_filp_open return 0xffff8bd54eaa09f8
4) cache miss chain (t_m.txt, missing)
"/tmp/t_m.txt" -> d_lookup return NULL -> __d_add 0xffff8bd54eaa0e78
5) cache delete chain (unlink)
d_delete 0xffff8bd5628ba9f8 (l_e.txt) + d_delete 0xffff8bd54eaa09f8 (t_e.txt)
Later phases start after this: eviction (__dentry_kill) and rebuild after eviction.</code></pre>
    </td>
    <td>
      <pre><code>t_e.txt miss → alloc → insert → return
open("/tmp/t_e.txt")
  -> do_filp_open entry 0xffff8bd54c33e020
  -> d_lookup hash 1830572521 len 7 "t_e.txt" -> NULL
  -> __d_alloc entry 0xffff8bd54c33e025
  -> __d_alloc return 0xffff8bd54eaa09f8
  -> __d_add entry 0xffff8bd54eaa09f8
  -> do_filp_open return 0xffff8bd54eaa09f8

a.txt miss on loopback ext2
open("/mnt/loopfs/a.txt")
  -> do_filp_open entry 0xffff8bd54c33e020
  -> d_lookup hash 3711754354 len 5 "a.txt" -> NULL
  -> __d_alloc entry 0xffff8bd54c33e02c
  -> __d_alloc return 0xffff8bd54eaa04b8
  -> __d_add entry 0xffff8bd54eaa04b8
  -> do_filp_open return 0xffff8bd54eaa04b8

cache hit for l_e.txt before deletion
open("l_e.txt")
  -> d_lookup hash 440978933 len 7 "l_e.txt" -> 0xffff8bd5628ba9f8
  -> do_filp_open return 0xffff8bd5628ba9f8

unlink deletion + eviction
unlink("l_e.txt") -> d_delete 0xffff8bd5628ba9f8
unlink("/tmp/t_e.txt") -> d_delete 0xffff8bd54eaa09f8
drop_caches -> __dentry_kill 0xffff8bd5628ba9f8 (l_e.txt)
drop_caches -> __dentry_kill 0xffff8bd54eaa09f8 (t_e.txt)
drop_caches -> __dentry_kill 0xffff8bd54eaa0e78 (t_m.txt)
drop_caches -> __dentry_kill 0xffff8bd54eaa0278 (l_m.txt)
drop_caches -> __dentry_kill 0xffff8bd54eaa04b8 (a.txt)

rebuild after eviction (t_e.txt)
open("/tmp/t_e.txt") after drop_caches
  -> d_lookup hash 1830572521 len 7 "t_e.txt" -> NULL
  -> __d_alloc return 0xffff8bd54eaa0338
  -> __d_add entry 0xffff8bd54eaa0338
  -> do_filp_open return 0xffff8bd54eaa0338

post-eviction lookup for l_e.txt
open("l_e.txt") after drop_caches
  -> __d_lookup_rcu hash 440978933 len 7 "l_e.txt"
  -> do_filp_open return 0xffff8bd5450e8278</code></pre>
    </td>
  </tr>
</table>


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

grep -n "memcpy.*name->name" /usr/src/linux-headers-$(uname -r)/fs/dcache.c Line: _____

Code: memcpy(dname, name->name, name->len);

CHAIN SUMMARY (FROM RUN A)
================================================================================

1) memcpy chain (t_e.txt, copy source -> destination)
"/tmp/t_e.txt" @ 0xffff8bd54c33e020 -> __d_alloc entry 0xffff8bd54c33e025 -> __d_alloc return 0xffff8bd54eaa09f8
2) cache build-up chain (t_e.txt, miss -> insert)
d_lookup return NULL -> __d_add 0xffff8bd54eaa09f8 -> do_filp_open return 0xffff8bd54eaa09f8
3) cache hit chain (t_e.txt, later lookup)
d_lookup return 0xffff8bd54eaa09f8 -> do_filp_open return 0xffff8bd54eaa09f8
4) cache miss chain (t_m.txt, missing)
"/tmp/t_m.txt" -> d_lookup return NULL -> __d_add 0xffff8bd54eaa0e78
5) cache delete chain (unlink)
d_delete 0xffff8bd5628ba9f8 (l_e.txt) + d_delete 0xffff8bd54eaa09f8 (t_e.txt)
Later phases start after this: eviction (__dentry_kill) and rebuild after eviction.
