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

Example dmesg line format (from this driver):
```
[time] [O] IN: 0xffff... | /tmp/t_e.txt
[time] d_lookup entry: hash 210259851 length 7 name t_e.txt
[time] d_lookup return: NULL
[time] [A] SRC: 0xffff...
[time] [A] DST: 0xffff...
[time] __d_add entry: 0xffff... | t_e.txt
[time] [O] OUT: 0xffff... | t_e.txt
[time] __d_lookup_rcu return: 0xffff... | t_e.txt
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

Start at the equal-pointer checks, then link the same address across __d_alloc return → __d_add →
do_filp_open return → later d_lookup hit. Then walk backward and match each address to do_filp_open
entry (struct filename->name) and the dentry name on return. Every step must reuse a number already
written.

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
Diagram (pstree):
```
test_file_very_long_name_to_force_external_allocation_XXXX
└─ do_filp_open entry 0x________
   └─ d_lookup entry (hash=____, len=64, name=...)
      ├─ d_lookup return NULL
      │  └─ __d_alloc entry 0x________
      │     └─ __d_alloc return 0x________
      │        └─ __d_add entry 0x________ | test_file_...
      │           └─ do_filp_open return 0x________ | test_file_...
      └─ d_lookup return 0x________ | test_file_...
```
Checks:
- __d_alloc return == __d_add entry == do_filp_open return
- cache hit pointer equals earlier return pointer

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
Code:
```c
const char *n2 = "/tmp/t_e.txt";
close(creat(n2, 0644));
drop_caches_if_root();
sleep(1);
open(n2, O_RDONLY);
```
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
Code:
```c
const char *n3 = "/tmp/t_m.txt";
drop_caches_if_root();
sleep(1);
int fd1 = open(n3, O_RDONLY);
printf("tm_miss first open fd=%d\n", fd1);
int fd2 = open(n3, O_RDONLY);
printf("tm_miss second open fd=%d\n", fd2);
```
- do_filp_open entry pointer = 0x________ | /tmp/t_m.txt
- d_lookup entry: hash ________ length 7 name t_m.txt
- d_lookup return: NULL
- __d_lookup_rcu return: NULL
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | t_m.txt
- __d_lookup_rcu return (second open): 0x________ | t_m.txt
- do_filp_open return pointer: not printed for tm_miss (open returned -1)
Diagram (pstree):
```
/tmp/t_m.txt
└─ do_filp_open entry 0x________
   └─ d_lookup entry (hash=____, len=7, name=t_m.txt)
      ├─ d_lookup return NULL
      │  └─ __d_lookup_rcu return NULL
      │     └─ __d_alloc entry 0x________
      │        └─ __d_alloc return 0x________
      │           └─ __d_add entry 0x________ | t_m.txt
      └─ __d_lookup_rcu return 0x________ | t_m.txt (second open)
```

Record: lm_miss
Code:
```c
const char *n4 = "l_m.txt";
drop_caches_if_root();
sleep(1);
open(n4, O_RDONLY);
```
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
Code:
```c
const char *n5 = "/mnt/loopfs/a.txt";
drop_caches_if_root();
sleep(1);
open(n5, O_RDONLY);
```
- do_filp_open entry pointer = 0x________ | /mnt/loopfs/a.txt
- d_lookup entry: hash ________ length 5 name a.txt
- d_lookup return: NULL
- __d_alloc entry pointer = 0x________
- __d_alloc return pointer = 0x________
- __d_add entry pointer = 0x________ | a.txt
- do_filp_open return pointer: not printed for a_miss (if open failed)
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
Code:
```c
const char *n1 = "l_e.txt";
const char *n2 = "/tmp/t_e.txt";
close(creat(n1, 0644));
close(creat(n2, 0644));
open(n1, O_RDONLY);
open(n2, O_RDONLY);
drop_caches_if_root();
```
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
Code:
```c
const char *n1 = "l_e.txt";
const char *n2 = "/tmp/t_e.txt";
close(creat(n1, 0644));
close(creat(n2, 0644));
open(n1, O_RDONLY);
open(n2, O_RDONLY);
unlink(n1);
unlink(n2);
```
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
Code:
```c
const char *n1 = "l_e.txt";
const char *n2 = "/tmp/t_e.txt";
close(creat(n1, 0644));
close(creat(n2, 0644));
open(n1, O_RDONLY);
open(n2, O_RDONLY);
drop_caches_if_root();
sleep(1);
open(n2, O_RDONLY);
```
- before drop_caches: __d_add entry pointer = 0x________ | t_e.txt
- before drop_caches: do_filp_open return pointer = 0x________ | t_e.txt
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
Code:
```c
const char *n1 = "l_e.txt";
const char *n2 = "/tmp/t_e.txt";
close(creat(n1, 0644));
close(creat(n2, 0644));
open(n1, O_RDONLY);
open(n2, O_RDONLY);
drop_caches_if_root();
sleep(1);
open(n1, O_RDONLY);
```
- before drop_caches: __d_add entry pointer = 0x________ | l_e.txt
- before drop_caches: do_filp_open return pointer = 0x________ | l_e.txt
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
