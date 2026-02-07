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

kernel/drivers/trace_do_filp_open/trace_do_filp_open.c — https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c; kernel/user/stage2/minimal_open.c — https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage2/minimal_open.c; kernel/user/stage2/matrix_open.c — https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage2/matrix_open.c

What we trace (string → pointer flow, in order). Location: kernel/drivers/trace_do_filp_open/trace_do_filp_open.c
```text
[do_filp_open entry]   struct filename->name
└─[d_lookup entry]     qstr->{name,len,hash}
  ├─[__d_lookup entry] qstr->{name,len,hash}
  ├─[__d_lookup_rcu]   qstr->{name,len,hash}
  └─[d_lookup return]  NULL | dentry->d_name.name
     └─[miss path]
       ├─[__d_alloc entry]  qstr->name
       ├─[__d_alloc return] dentry->d_name.name
       └─[__d_add entry]    dentry->d_name.name
[do_filp_open return]  f->f_path.dentry->d_name.name
[d_delete entry]       dentry->d_name.name
[__dentry_kill entry]  dentry->d_name.name
```

================================================================================
User Tests
================================================================================

Location (repo): https://github.com/raikrahul/what-happens-when-open-is-called/tree/main/kernel/user/stage2

================================================================================
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

Start at the equality checks in the middle because that is where the proof closes, then drive forward to the diagram end by chaining the same address from __d_alloc return to __d_add to do_filp_open return and then to the later d_lookup hit, and then walk backward from that chain to the start by matching each address in the Record list to the struct filename at entry and the dentry->d_name at return so every step has a numeric anchor before the next step is drawn.

Record:
- do_filp_open entry pointer = 0x________ | test_file_very_long_name_to_force_external_allocation_XXXX
- d_lookup entry: hash ________ length 64 name test_file_very_long_name_to_force_external_allocation_XXXX
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | test_file_very_long_name_to_force_external_allocation_XXXX
- do_filp_open return pointer = 0x________ | test_file_very_long_name_to_force_external_allocation_XXXX
- cache hit later: d_lookup return pointer = 0x________ | test_file_very_long_name_to_force_external_allocation_XXXX
Draw the struct filename { name = 0x________, len = 64, uptr = user string } and the dentry { d_name.name = 0x________, d_name.len = 64, d_name.hash = ________ } with the exact values you just recorded, then chain the calls in order by reusing the same addresses as they move from do_filp_open entry to d_lookup miss to __d_alloc entry/return to __d_add to do_filp_open return to the later d_lookup hit, so every pointer equality in your record is shown as the same numeric address in your drawn structs and every miss/hit is shown as NULL vs the recorded dentry->d_name.name value.

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

3) Run split programs (one at a time)
```
cd kernel/user/stage2
sudo dmesg -C
sudo rmmod trace_do_filp_open
sudo insmod ../../drivers/trace_do_filp_open/trace_do_filp_open.ko target_comm=<program>
sudo ./<program>
sleep 2
sudo dmesg | rg -n "t_e.txt|t_m.txt|l_m.txt|l_e.txt|a.txt|d_lookup entry|d_lookup return|__d_alloc|__d_add|do_filp_open|d_delete|__dentry_kill"
```

TEST 2: MATRIX (split programs, no labels)

Problem statement and numbers: the kernel pointer for /tmp/t_e.txt is 0xffff8b148256c020 and the copy-source pointer is 0xffff8b148256c025, so 0xffff8b148256c025 − 0xffff8b148256c020 = 0x5 = 5, and “/tmp/” is 5 bytes. The kernel pointer for /mnt/loopfs/a.txt is 0xffff8b148256b020 and the copy-source pointer is 0xffff8b148256b02c, so 0xffff8b148256b02c − 0xffff8b148256b020 = 0xC = 12, and “/mnt/loopfs/” is 12 bytes. The copied name pointer 0xffff8b14d0cc60f8 appears in both __d_add and do_filp_open return for t_e.txt, so the file’s name pointer equals the copied name storage. The cache-hit pointers are 0xffff8b149e4886f8 for l_e.txt and 0xffff8b149e488cf8 for t_e.txt, and those exact pointers appear again in d_delete and __dentry_kill.

te_miss (t_e.txt miss + copy + insert + return; /tmp/ offset +5):
- do_filp_open entry pointer = 0xffff8b148256c020 | /tmp/t_e.txt
- d_lookup entry hash 3583106372 len 7 name t_e.txt
- d_lookup return: NULL
- __d_alloc entry pointer = 0xffff8b148256c025
- __d_alloc return pointer = 0xffff8b14d0cc60f8
- __d_add entry pointer = 0xffff8b14d0cc60f8 | t_e.txt
- do_filp_open return pointer = 0xffff8b14d0cc60f8 | t_e.txt

tm_miss (t_m.txt miss + copy + insert; /tmp/ offset +5):
- do_filp_open entry pointer = 0xffff8b1480ef5020 | /tmp/t_m.txt
- d_lookup entry hash 502501587 len 7 name t_m.txt
- d_lookup return: NULL
- __d_alloc return pointer = 0xffff8b148d58d3f8
- __d_add entry pointer = 0xffff8b148d58d3f8 | t_m.txt

lm_miss (l_m.txt miss + copy + insert; no prefix):
- do_filp_open entry pointer = 0xffff8b1482462020 | l_m.txt
- d_lookup entry hash 2257632620 len 7 name l_m.txt
- d_lookup return: NULL
- __d_alloc return pointer = 0xffff8b14a70b6278
- __d_add entry pointer = 0xffff8b14a70b6278 | l_m.txt

a_miss (a.txt miss + copy + insert; /mnt/loopfs/ offset +12):
- do_filp_open entry pointer = 0xffff8b148256b020 | /mnt/loopfs/a.txt
- d_lookup entry hash 2244109168 len 5 name a.txt
- d_lookup return: NULL
- __d_alloc entry pointer = 0xffff8b148256b02c
- __d_alloc return pointer = 0xffff8b14d0cc8e78
- __d_add entry pointer = 0xffff8b14d0cc8e78 | a.txt
- do_filp_open return pointer = 0xffff8b14d0cc8e78 | a.txt

evict (pre-eviction lookup + eviction):
- d_lookup return pointer = 0xffff8b149e4886f8 | l_e.txt
- d_lookup return pointer = 0xffff8b149e488cf8 | t_e.txt
- __dentry_kill entry = 0xffff8b149e4886f8 | l_e.txt
- __dentry_kill entry = 0xffff8b149e488cf8 | t_e.txt

delete (unlink):
- d_delete entry = 0xffff8b149e4886f8 | l_e.txt
- d_delete entry = 0xffff8b149e488cf8 | t_e.txt

rebuild (post-eviction t_e.txt):
- __d_alloc return pointer = 0xffff8b14a712db78
- __d_add entry pointer = 0xffff8b14a712db78 | t_e.txt
- do_filp_open return pointer = 0xffff8b14a712db78 | t_e.txt
- inequality check: 0xffff8b14a712db78 != 0xffff8b149e488cf8

post (post-eviction l_e.txt):
- __d_lookup_rcu entry: hash 1845489866 length 7 name l_e.txt
- do_filp_open return pointer = 0xffff8b148a31f878 | l_e.txt
- inequality check: 0xffff8b148a31f878 != 0xffff8b149e4886f8

Single-chain diagram with concrete data: struct filename { name=0xffff8b148256c020, str="/tmp/t_e.txt" } -> do_filp_open entry -> qstr { name=0xffff8b148256c025, len=7, hash=3583106372, str="t_e.txt" } -> d_lookup entry -> d_lookup return NULL -> __d_alloc entry -> dentry { d_name.name=0xffff8b14d0cc60f8, d_name.len=7, d_name.hash=3583106372, d_name.str="t_e.txt" } -> __d_alloc return -> __d_add entry -> do_filp_open return pointer 0xffff8b14d0cc60f8 | t_e.txt -> d_lookup return pointer 0xffff8b149e488cf8 | t_e.txt on cache hit -> d_delete entry 0xffff8b149e488cf8 | t_e.txt on unlink -> __dentry_kill entry 0xffff8b149e488cf8 | t_e.txt on drop_caches, and for the short-name case struct filename { name=0xffff8b148256b020, str="/mnt/loopfs/a.txt" } -> qstr { name=0xffff8b148256b02c, len=5, hash=2244109168, str="a.txt" } -> __d_alloc return dentry { d_name.name=0xffff8b14d0cc8e78, d_name.len=5, d_name.hash=2244109168, d_name.str="a.txt" } -> do_filp_open return pointer 0xffff8b14d0cc8e78 | a.txt, with the offsets 0xffff8b148256c025−0xffff8b148256c020=5 and 0xffff8b148256b02c−0xffff8b148256b020=12.



================================================================================

`/usr/src/linux-source-6.8.0/fs/open.c` and `/usr/src/linux-source-6.8.0/fs/dcache.c`
→ `nl -ba /usr/src/linux-source-6.8.0/fs/open.c | sed -n '1388,1436p'`
→ open/openat → do_filp_open
→ d_lookup uses (name,len,hash) and NULL return = miss
→ __d_alloc allocates and copies name, __d_add inserts into dcache
→ do_filp_open return pointer = f->f_path.dentry->d_name.name
→ d_delete = unlink removal, __dentry_kill = drop_caches eviction
→ /tmp/ length 5, /mnt/loopfs/ length 12 via `python3 - <<'PY'\nprint(len('/tmp/'))\nprint(len('/mnt/loopfs/'))\nPY`
→ `nl -ba /usr/src/linux-source-6.8.0/fs/dcache.c | sed -n '2245,2265p'`
→ `rg -n "memcpy\\(dname, name->name, name->len\\)" /usr/src/linux-source-6.8.0/fs/dcache.c`
→ `rg -n "__d_add\\(|d_delete\\(|__dentry_kill" /usr/src/linux-source-6.8.0/fs/dcache.c`
→ `nl -ba kernel/drivers/trace_do_filp_open/trace_do_filp_open.c | sed -n '82,90p'`
→ /tmp/t_e.txt miss + alloc + add + return; offset +5
→ /tmp/t_m.txt miss + alloc + add
→ l_m.txt alloc entry equals full string pointer
→ /mnt/loopfs/a.txt miss + alloc + add + return; offset +12
→ l_e.txt and /tmp/t_e.txt hits vs earlier return pointers
→ unlink l_e.txt and /tmp/t_e.txt: d_delete
→ drop_caches: __dentry_kill
→ reopen /tmp/t_e.txt: rebuild pointer vs pre-eviction
→ reopen l_e.txt: post-eviction pointer vs pre-eviction


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
