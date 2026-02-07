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
Proof Goals
================================================================================

You will capture pointer copies, first misses and inserts, later hits, and the delete/evict/rebuild
sequence. You will also measure prefix offsets (/tmp/ and /mnt/loopfs/) and confirm the long‑name
miss followed by a later hit.

================================================================================
Files Used
================================================================================

kernel/drivers/trace_do_filp_open/trace_do_filp_open.c
https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c

kernel/user/stage2/minimal_open.c
https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage2/minimal_open.c

kernel/user/stage2/matrix_open.c
https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage2/matrix_open.c

What we trace (string → pointer flow, in order):
do_filp_open(entry): reads struct filename->name (kernel string pointer).
d_lookup(entry): reads qstr->name/qstr->len/qstr->hash (lookup key).
d_lookup(return): NULL on miss, dentry->d_name.name on hit.
__d_alloc(entry): reads qstr->name (copy source pointer).
__d_alloc(return): returns dentry->d_name.name (copy destination pointer).
__d_add(entry): inserts dentry->d_name.name into the dcache.
do_filp_open(return): returns file whose f_path.dentry->d_name.name is printed.
d_delete(entry): removes dentry name on unlink.
__dentry_kill(entry): reclaims dentry on drop_caches.
__d_lookup / __d_lookup_rcu: internal/RCU lookup paths for the same key.

================================================================================
User Tests
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
Kernel Probes
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

Probe code locations (driver file, local):
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:73` open entry
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:82` open return
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:94` __d_alloc entry
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:104` __d_alloc return
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:115` d_lookup return
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:131` d_lookup entry
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:141` __d_lookup entry
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:151` __d_lookup_rcu entry
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:195` __d_add entry
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:225` d_delete entry
`kernel/drivers/trace_do_filp_open/trace_do_filp_open.c:258` __dentry_kill entry

================================================================================
BUILD AND RUN (ORDER MATTERS)
================================================================================

1) Build the driver (repo root)
```
cd kernel/drivers/trace_do_filp_open && make clean && make
```

2) Run minimal_open (long filename)
```
cd kernel/user/stage2
sudo dmesg -C
sudo rmmod trace_do_filp_open
sudo insmod ../../drivers/trace_do_filp_open/trace_do_filp_open.ko target_comm=minimal_open
./minimal_open
sleep 5
sudo dmesg | rg -n "test_file_very_long_name_to_force_external_allocation"
```

WHAT TO RECORD (FILL THIS IN)
================================================================================

TEST 1: LONG FILENAME (minimal_open)

Why: isolate long-name allocation and later hit using a single name string.

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

2b) Prepare loopback ext2 (a.txt)
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
cd kernel/user/stage2
sudo dmesg -C
sudo rmmod trace_do_filp_open
sudo insmod ../../drivers/trace_do_filp_open/trace_do_filp_open.ko target_comm=matrix_open
sudo ./matrix_open
sleep 3
sudo dmesg | rg -n "l_e.txt|t_e.txt|t_m.txt|l_m.txt|a.txt|drop_caches|d_lookup entry|d_lookup return|__d_add entry|d_delete entry|__dentry_kill entry|__d_lookup entry|__d_lookup_rcu entry|__d_alloc"
```

TEST 2: MATRIX (matrix_open)

FILE A (t_e.txt, first open after drop_caches):
Why: clean miss path with a /tmp prefix and offset +5.
- do_filp_open entry pointer = 0x________ | /tmp/t_e.txt
- d_lookup entry hash ________ len 7 name t_e.txt
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_e.txt
- do_filp_open return pointer = 0x________ | t_e.txt
- offset check: (entry pointer + 5) == __d_alloc entry pointer

FILE B (t_m.txt, missing):
Why: miss+insert for a missing /tmp name.
- do_filp_open entry pointer = 0x________ | /tmp/t_m.txt
- d_lookup return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_m.txt

FILE C (l_m.txt, missing):
Why: miss+insert with no prefix (alloc entry equals string pointer).
- do_filp_open entry pointer = 0x________ | l_m.txt
- d_lookup return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | l_m.txt

FILE D (a.txt, loopback ext2):
Why: same flow on ext2 with short name and /mnt/loopfs/ offset +12.
- do_filp_open entry pointer = 0x________ | /mnt/loopfs/a.txt
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | a.txt
- do_filp_open return pointer = 0x________ | a.txt
- offset check: (entry pointer + 12) == __d_alloc entry pointer

CACHE HIT (before deletion):
Why: show pointer reuse on hit.
- d_lookup return pointer = 0x________ | l_e.txt
- d_lookup return pointer = 0x________ | t_e.txt

DELETION (unlink):
Why: show d_delete removal for the same pointers.
- d_delete entry = 0x________ | l_e.txt
- d_delete entry = 0x________ | t_e.txt

EVICTION (drop_caches):
Why: show __dentry_kill for cached names.
- do_filp_open entry/return for /proc/sys/vm/drop_caches
- __dentry_kill entry = 0x________ | l_e.txt
- __dentry_kill entry = 0x________ | t_e.txt

REBUILD (after eviction, t_e.txt):
Why: show new or reused pointer after eviction.
- d_lookup return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_e.txt
- do_filp_open return pointer = 0x________ | t_e.txt
- inequality check: rebuild pointer != pre-eviction pointer

POST-EVICTION LOOKUP (l_e.txt):
Why: compare post-eviction pointer to pre-eviction pointer.
- __d_lookup_rcu entry: hash ________ length 7 name l_e.txt
- do_filp_open return pointer = 0x________ | l_e.txt
- inequality check: post-eviction pointer != pre-eviction pointer

Why these commands exist (do not skip):
- `sudo dmesg -C` clears the kernel ring buffer so the next lines are only from this run.
- `sudo insmod ... target_comm=matrix_open` restricts probe output to the process named `matrix_open`.
- `sudo ./matrix_open` is required because the program writes to `/proc/sys/vm/drop_caches`.
- `sleep 3` allows delayed probe lines (lookups, eviction) to finish.
- `sudo dmesg | rg -n "..."` filters the kernel log to just the filename strings and probe labels we need.
  `rg -n` adds line numbers so you can cite the exact evidence line-by-line.

The probe driver in `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c` is a controlled capture
layer that isolates one user-space process (`target_comm`) and records the exact pointer flow and
lookup keys along the open path. Entry/return probes on `do_filp_open` report the kernel filename
pointer on entry and the dentry name pointer carried by the returned file on exit. Entry/return
probes on `__d_alloc` expose the copy source pointer (`qstr->name`) and the copy destination pointer
(`dentry->d_name.name`), which anchor memcpy and insertion proofs. `d_lookup` entry/return emit the
hash, length, and name key plus hit/miss, while `__d_lookup` and `__d_lookup_rcu` expose internal
and RCU lookup paths for the same key. `__d_add`, `d_delete`, and `__dentry_kill` mark insertion,
unlink removal, and eviction via `drop_caches`. The `full_name_hash` kretprobe attempts to log the
hash computation itself; if it is silent, the hash values still appear at `d_lookup` entry.



================================================================================

`/usr/src/linux-source-6.8.0/fs/open.c` and `/usr/src/linux-source-6.8.0/fs/dcache.c`.
`nl -ba /usr/src/linux-source-6.8.0/fs/open.c | sed -n '1388,1436p'` and `rg -n "d_lookup\\(|__d_alloc\\(|__d_add\\(|d_delete\\(|__dentry_kill" /usr/src/linux-source-6.8.0/fs/dcache.c`.

Axioms
- open/openat → do_filp_open.
- d_lookup uses (name, len, hash). NULL return = miss.
- __d_alloc allocates and copies name. __d_add inserts into dcache.
- do_filp_open return pointer = f->f_path.dentry->d_name.name (probe reads it).
- d_delete = unlink removal. __dentry_kill = drop_caches eviction.
- /tmp/ length 5. /mnt/loopfs/ length 12.

Verification (run these; paste output beside each line)
`nl -ba /usr/src/linux-source-6.8.0/fs/open.c | sed -n '1388,1436p'`
`nl -ba /usr/src/linux-source-6.8.0/fs/dcache.c | sed -n '2245,2265p'`
`rg -n "memcpy\\(dname, name->name, name->len\\)" /usr/src/linux-source-6.8.0/fs/dcache.c`
`rg -n "__d_add\\(|d_delete\\(|__dentry_kill" /usr/src/linux-source-6.8.0/fs/dcache.c`
`nl -ba kernel/drivers/trace_do_filp_open/trace_do_filp_open.c | sed -n '82,90p'`
`python3 - <<'PY'\nprint(len('/tmp/'))\nprint(len('/mnt/loopfs/'))\nPY`

Record plan
- /tmp/t_e.txt: miss + alloc + add + return; offset +5.
- /tmp/t_m.txt: miss + alloc + add.
- l_m.txt: alloc entry equals full string pointer.
- /mnt/loopfs/a.txt: miss + alloc + add + return; offset +12.
- l_e.txt and /tmp/t_e.txt: hits vs earlier return pointers.
- unlink l_e.txt and /tmp/t_e.txt: d_delete.
- drop_caches: __dentry_kill.
- reopen /tmp/t_e.txt: rebuild pointer vs pre-eviction.
- reopen l_e.txt: post-eviction pointer vs pre-eviction.
- memcpy line: find `memcpy(dname, name->name, name->len)` in fs/dcache.c.


================================================================================

CHAIN AND TRACE SUMMARY (END)
================================================================================

1) memcpy chain (t_e.txt, copy source -> destination)
"/tmp/t_e.txt" @ 0xffff8bd546392020 -> __d_alloc entry 0xffff8bd546392025 -> __d_alloc return 0xffff8bd728c76338
qstr->name starts 5 bytes after /tmp/ and __d_alloc copies that name into dentry storage.
2) cache build-up chain (t_e.txt, miss -> insert)
d_lookup return NULL -> __d_add 0xffff8bd728c76338 -> do_filp_open return 0xffff8bd728c76338
Miss creates a new dentry name pointer and inserts it; the same pointer is returned by open.
3) cache hit chain (t_e.txt, later lookup)
d_lookup return 0xffff8bd728c76338 -> do_filp_open return 0xffff8bd728c76338
Hit returns the cached pointer without new allocation.
4) cache miss chain (t_m.txt, missing)
"/tmp/t_m.txt" -> d_lookup return NULL -> __d_add 0xffff8bd728c763f8
Missing name still gets a dentry entry (negative dentry) with its own pointer.
5) cache delete chain (unlink)
d_delete 0xffff8bd7e94c8578 (l_e.txt) + d_delete 0xffff8bd728c76338 (t_e.txt)
Unlink removes the cached dentries for these pointers.
Later phases start after this: eviction (__dentry_kill) and rebuild after eviction.

t_e.txt miss -> alloc -> insert -> return
open("/tmp/t_e.txt")
  -> do_filp_open entry 0xffff8bd546392020
  -> d_lookup hash 1830572521 len 7 "t_e.txt" -> NULL
  -> __d_alloc entry 0xffff8bd546392025
  -> __d_alloc return 0xffff8bd728c76338
  -> __d_add entry 0xffff8bd728c76338
  -> do_filp_open return 0xffff8bd728c76338
Miss path with /tmp prefix; name pointer shifts by +5, then alloc+insert returns same pointer.

a.txt miss on loopback ext2
open("/mnt/loopfs/a.txt")
  -> do_filp_open entry 0xffff8bd546392020
  -> d_lookup hash 3711754354 len 5 "a.txt" -> NULL
  -> __d_alloc entry 0xffff8bd54639202c
  -> __d_alloc return 0xffff8bd728c76cf8
  -> __d_add entry 0xffff8bd728c76cf8
  -> do_filp_open return 0xffff8bd728c76cf8
Same miss path on ext2 with /mnt/loopfs/ prefix; name pointer shifts by +12.

cache hit for l_e.txt before deletion
open("l_e.txt")
  -> d_lookup hash 440978933 len 7 "l_e.txt" -> 0xffff8bd7e94c8578
  -> do_filp_open return 0xffff8bd7e94c8578
Hit returns the cached pointer without allocation.

unlink deletion + eviction
unlink("l_e.txt") -> d_delete 0xffff8bd7e94c8578
unlink("/tmp/t_e.txt") -> d_delete 0xffff8bd728c76338
drop_caches -> __dentry_kill 0xffff8bd7e94c8578 (l_e.txt)
drop_caches -> __dentry_kill 0xffff8bd728c76338 (t_e.txt)
drop_caches -> __dentry_kill 0xffff8bd728c763f8 (t_m.txt)
drop_caches -> __dentry_kill 0xffff8bd728c76938 (l_m.txt)
drop_caches -> __dentry_kill 0xffff8bd728c76cf8 (a.txt)
Unlink removes entries; drop_caches reclaims remaining dentries.

rebuild after eviction (t_e.txt)
open("/tmp/t_e.txt") after drop_caches
  -> d_lookup hash 1830572521 len 7 "t_e.txt" -> NULL
  -> __d_alloc return 0xffff8bd728c76338
  -> __d_add entry 0xffff8bd728c76338
  -> do_filp_open return 0xffff8bd728c76338
In this run the rebuild reuses the same pointer value.

post-eviction lookup for l_e.txt
open("l_e.txt") after drop_caches
  -> __d_lookup_rcu hash 440978933 len 7 "l_e.txt"
  -> do_filp_open return 0xffff8bd7e94c8db8
Post-eviction return pointer differs from pre-eviction pointer.

QUIZ (ANSWER YES/NO)
- Did your memcpy chain show __d_alloc entry and __d_alloc return with the same return pointer as __d_add?
- Did your cache hit for l_e.txt return the same pointer you saw before deletion?
- Did your post-eviction l_e.txt return pointer differ from the pre-eviction pointer?
