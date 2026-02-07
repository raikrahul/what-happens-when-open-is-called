---
layout: default
title: "Stage 2 Return - Kernel Filename Tracing (Copy vs Cache)"
---

[HOME] ../index.html
Print ../articles/worksheet_stage2_return.html
Stage 1 https://raikrahul.github.io/what-happens-when-open-is-called/stage1.html
Stage 2 Entry https://raikrahul.github.io/what-happens-when-open-is-called/stage2.html
Stage 2 Return (Explanation) https://raikrahul.github.io/what-happens-when-open-is-
called/articles/explanation_stage2_return.html
What we trace and where it lives:
trace_do_filp_open driver: kernel/drivers/trace_do_filp_open/trace_do_filp_open.c
do_filp_open: /usr/src/linux-source-6.8.0/fs/open.c
d_lookup, __d_lookup, __d_lookup_rcu, __d_alloc, __d_add, d_delete, __dentry_kill: /usr/src/linux-source-6.8.0/fs/dcache.c
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

User tests repo: https://github.com/raikrahul/what-happens-when-open-is-called/tree/main/kernel/user/stage2
Build and run:

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

Start at the equality checks in the middle because that is where the proof closes, then drive
forward to the diagram end by chaining the same address from __d_alloc return to __d_add to
do_filp_open return and then to the later d_lookup hit, and then walk backward from that chain to
the start by matching each address in the Record list to the struct filename at entry and the
dentry->d_name at return so every step has a numeric anchor before the next step is drawn.

Record:
- do_filp_open entry pointer = 0x________ |
test_file_very_long_name_to_force_external_allocation_XXXX
- d_lookup entry: hash ________ length 64 name
test_file_very_long_name_to_force_external_allocation_XXXX
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | test_file_very_long_name_to_force_external_allocation_XXXX
- do_filp_open return pointer = 0x________ |
test_file_very_long_name_to_force_external_allocation_XXXX
- cache hit later: d_lookup return pointer = 0x________ |
test_file_very_long_name_to_force_external_allocation_XXXX
Draw the struct filename { name = 0x________, len = 64, uptr = user string } and the dentry {
d_name.name = 0x________, d_name.len = 64, d_name.hash = ________ } with the exact values you just
recorded, then chain the calls in order by reusing the same addresses as they move from do_filp_open
entry to d_lookup miss to __d_alloc entry/return to __d_add to do_filp_open return to the later
d_lookup hit, so every pointer equality in your record is shown as the same numeric address in your
drawn structs and every miss/hit is shown as NULL vs the recorded dentry->d_name.name value.

Checks:
- __d_alloc return == __d_add entry == do_filp_open return
- cache hit pointer equals earlier return pointer

Make a diagram (required):
- Draw the full pointer flow for this long filename as a single chain:
  do_filp_open entry -> d_lookup miss -> __d_alloc entry -> __d_alloc return -> __d_add ->
do_filp_open return -> d_lookup hit.
- Use your recorded addresses in the diagram, not placeholders.
- Base the copy step on kernel source: /usr/src/linux-headers-$(uname -r)/fs/dcache.c
  Search for: memcpy(dname, name->name, name->len);
  This is the line that explains why the __d_alloc destination pointer equals the dentry name
pointer.

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

Record: te_miss
- do_filp_open entry pointer = 0x________ | /tmp/t_e.txt
- d_lookup entry: hash ________ length 7 name t_e.txt
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_e.txt
- do_filp_open return pointer = 0x________ | t_e.txt
- offset check: (entry pointer + 5) == __d_alloc entry pointer
Diagram (pstree):
```
/tmp/t_e.txt
└─ do_filp_open entry 0x________
   └─ d_lookup entry (hash=____, len=7, name=t_e.txt)
      ├─ d_lookup return NULL
      │  └─ __d_alloc entry 0x________
      │     └─ __d_alloc return 0x________
      │        └─ __d_add entry 0x________ | t_e.txt
      │           └─ do_filp_open return 0x________ | t_e.txt
      └─ d_lookup return 0x________ | t_e.txt
```

Record: tm_miss
- do_filp_open entry pointer = 0x________ | /tmp/t_m.txt
- d_lookup entry: hash ________ length 7 name t_m.txt
- d_lookup return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_m.txt
Diagram (pstree):
```
/tmp/t_m.txt
└─ do_filp_open entry 0x________
   └─ d_lookup entry (hash=____, len=7, name=t_m.txt)
      ├─ d_lookup return NULL
      │  └─ __d_alloc entry 0x________
      │     └─ __d_alloc return 0x________
      │        └─ __d_add entry 0x________ | t_m.txt
      └─ d_lookup return 0x________ | t_m.txt
```

Record: lm_miss
- do_filp_open entry pointer = 0x________ | l_m.txt
- d_lookup entry: hash ________ length 7 name l_m.txt
- d_lookup return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | l_m.txt
Diagram (pstree):
```
l_m.txt
└─ do_filp_open entry 0x________
   └─ d_lookup entry (hash=____, len=7, name=l_m.txt)
      ├─ d_lookup return NULL
      │  └─ __d_alloc entry 0x________
      │     └─ __d_alloc return 0x________
      │        └─ __d_add entry 0x________ | l_m.txt
      └─ d_lookup return 0x________ | l_m.txt
```

Record: a_miss
- do_filp_open entry pointer = 0x________ | /mnt/loopfs/a.txt
- d_lookup entry: hash ________ length 5 name a.txt
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | a.txt
- do_filp_open return pointer = 0x________ | a.txt
- offset check: (entry pointer + 12) == __d_alloc entry pointer
Diagram (pstree):
```
/mnt/loopfs/a.txt
└─ do_filp_open entry 0x________
   └─ d_lookup entry (hash=____, len=5, name=a.txt)
      ├─ d_lookup return NULL
      │  └─ __d_alloc entry 0x________
      │     └─ __d_alloc return 0x________
      │        └─ __d_add entry 0x________ | a.txt
      │           └─ do_filp_open return 0x________ | a.txt
      └─ d_lookup return 0x________ | a.txt
```

Record: evict
- d_lookup return pointer = 0x________ | l_e.txt
- d_lookup return pointer = 0x________ | t_e.txt
- __dentry_kill entry = 0x________ | l_e.txt
- __dentry_kill entry = 0x________ | t_e.txt
Diagram (pstree):
```
l_e.txt
└─ d_lookup return 0x________ | l_e.txt
   └─ __dentry_kill entry 0x________ | l_e.txt
t_e.txt
└─ d_lookup return 0x________ | t_e.txt
   └─ __dentry_kill entry 0x________ | t_e.txt
```

Record: delete
- d_delete entry = 0x________ | l_e.txt
- d_delete entry = 0x________ | t_e.txt
Diagram (pstree):
```
l_e.txt
└─ d_delete entry 0x________ | l_e.txt
t_e.txt
└─ d_delete entry 0x________ | t_e.txt
```

Record: rebuild
- d_lookup return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_e.txt
- do_filp_open return pointer = 0x________ | t_e.txt
- inequality check: rebuild pointer != pre-eviction pointer
Diagram (pstree):
```
/tmp/t_e.txt
└─ d_lookup return NULL
   └─ __d_alloc return 0x________
      └─ __d_add entry 0x________ | t_e.txt
         └─ do_filp_open return 0x________ | t_e.txt
0x________ ≠ 0x________
```

Record: post
- __d_lookup_rcu entry: hash ________ length 7 name l_e.txt
- do_filp_open return pointer = 0x________ | l_e.txt
- inequality check: post-eviction pointer != pre-eviction pointer
Diagram (pstree):
```
l_e.txt
└─ __d_lookup_rcu entry (hash=____, len=7, name=l_e.txt)
   └─ do_filp_open return 0x________ | l_e.txt
0x________ ≠ 0x________
```

Diagram (ASCII tree, fill with your numbers):
```
struct filename { name=0x________, str="..." }
└─ do_filp_open entry
   └─ qstr { name=0x________, len=__, hash=__, str="..." }
      └─ d_lookup entry
         ├─ d_lookup return NULL
         │  └─ __d_alloc entry
         │     └─ dentry { d_name.name=0x________, d_name.len=__, d_name.hash=__, d_name.str="..." }
         │        └─ __d_alloc return
         │           └─ __d_add entry
         │              └─ do_filp_open return pointer 0x________ | ...
         └─ d_lookup return 0x________ | ...
```
} -> __d_alloc return -> __d_add entry -> do_filp_open return pointer 0xffff8b14d0cc60f8 | t_e.txt
-> d_lookup return pointer 0xffff8b149e488cf8 | t_e.txt on cache hit -> d_delete entry
0xffff8b149e488cf8 | t_e.txt on unlink -> __dentry_kill entry 0xffff8b149e488cf8 | t_e.txt on
drop_caches, and for the short-name case struct filename { name=0xffff8b148256b020,
str="/mnt/loopfs/a.txt" } -> qstr { name=0xffff8b148256b02c, len=5, hash=2244109168, str="a.txt" }
-> __d_alloc return dentry { d_name.name=0xffff8b14d0cc8e78, d_name.len=5, d_name.hash=2244109168,
d_name.str="a.txt" } -> do_filp_open return pointer 0xffff8b14d0cc8e78 | a.txt, with the offsets
0xffff8b148256c025−0xffff8b148256c020=5 and 0xffff8b148256b02c−0xffff8b148256b020=12.



================================================================================

1. /usr/src/linux-source-6.8.0/fs/open.c + /usr/src/linux-source-6.8.0/fs/dcache.c → `nl -ba /usr/src/linux-source-6.8.0/fs/open.c | sed -n '1388,1436p'` → open/openat→do_filp_open ✓ → `nl -ba /usr/src/linux-source-6.8.0/fs/dcache.c | sed -n '2245,2265p'` → d_lookup(name,len,hash), NULL=miss ✓ → `rg -n "memcpy(dname, name->name, name->len)" /usr/src/linux-source-6.8.0/fs/dcache.c` → __d_alloc copy ✓ → `rg -n "__d_add\(|d_delete\(|__dentry_kill" /usr/src/linux-source-6.8.0/fs/dcache.c` → __d_add/d_delete/__dentry_kill ✓ → `nl -ba kernel/drivers/trace_do_filp_open/trace_do_filp_open.c | sed -n '82,90p'` → do_filp_open return pointer ✓
2. 0xffff8b148256c025−0xffff8b148256c020=0x5=5, /tmp/=5 ✓, compute?
3. 0xffff8b148256b02c−0xffff8b148256b020=0xC=12, /mnt/loopfs/=12 ✓, compute?
4. /tmp/t_e.txt: 0xffff8b148256c020→0xffff8b148256c025→0xffff8b14d0cc60f8→0xffff8b14d0cc60f8→0xffff8b14d0cc60f8 ✓, compute?
5. /tmp/t_m.txt: 0xffff8b1480ef5020→0xffff8b148d58d3f8→0xffff8b148d58d3f8 ✓, compute?
6. l_m.txt: 0xffff8b1482462020→0xffff8b14a70b6278→0xffff8b14a70b6278 ✓, compute?
7. /mnt/loopfs/a.txt: 0xffff8b148256b020→0xffff8b148256b02c→0xffff8b14d0cc8e78→0xffff8b14d0cc8e78 ✓, compute?
8. hit: 0xffff8b149e4886f8 + 0xffff8b149e488cf8 reused ✓, verify?
9. delete: d_delete 0xffff8b149e4886f8 + 0xffff8b149e488cf8 ✓, verify?
10. evict: __dentry_kill 0xffff8b149e4886f8 + 0xffff8b149e488cf8 ✓, verify?
11. rebuild: 0xffff8b14a712db78≠0xffff8b149e488cf8 ✗, verify?
12. post: 0xffff8b148a31f878≠0xffff8b149e4886f8 ✗, verify?
QUIZ (ANSWER YES/NO)
1. 0xffff8b14d0cc60f8=0xffff8b14d0cc60f8=0xffff8b14d0cc60f8 ✓? 2. 0xffff8b149e4886f8 unchanged
before delete ✓? 3. 0xffff8b148a31f878≠0xffff8b149e4886f8 ✓?
