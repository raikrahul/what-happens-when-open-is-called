---
layout: default
title: "Stage 2 Return"
---

**Introduction**
This report uses one run of printed pointers and hashes. All addresses are exact for this run. Your run will differ.

**Previous Work**
<a href="https://raikrahul.github.io/what-happens-when-open-is-called/stage1.html">Stage 1</a> entry path and first kernel filename pointer.
<a href="https://raikrahul.github.io/what-happens-when-open-is-called/stage2.html">Stage 2</a> getname/filename buffer.
<a href="https://raikrahul.github.io/what-happens-when-open-is-called/articles/worksheet_stage2_return.html">Worksheet</a> for this stage.

**Man Pages Used (parts)**
open(2): SYNOPSIS, RETURN VALUE, ERRORS.
creat(2): SYNOPSIS, RETURN VALUE.
unlink(2): SYNOPSIS, RETURN VALUE.
write(2): SYNOPSIS, RETURN VALUE (drop_caches write).
sync(2): DESCRIPTION.
mount(8): SYNOPSIS, EXAMPLES.
umount(8): SYNOPSIS.
losetup(8): SYNOPSIS, EXAMPLES.
mkfs.ext2(8): SYNOPSIS.
dd(1): SYNOPSIS.
dmesg(1): SYNOPSIS.
insmod(8), rmmod(8): SYNOPSIS.

**Tools**
trace_do_filp_open.ko prints kernel pointers and hash keys.
dmesg reads the kernel ring buffer.
rg filters the ring buffer output.

**User Programs (one line each)**
minimal_open.c: one long name to show copy source, copy destination, insert, and later lookup of the same pointer.
te_miss.c: /tmp/t_e.txt after drop_caches to show +5 offset and insert pointer.
tm_miss.c: /tmp/t_m.txt missing to show miss and insert pointer with +5 offset.
lm_miss.c: l_m.txt missing to show copy source equals entry pointer (no prefix).
a_miss.c: /mnt/loopfs/a.txt on ext2 to show +12 offset and insert pointer.
hits.c: pre‑eviction hits for l_e.txt and t_e.txt.
delete.c: unlink l_e.txt and t_e.txt and capture d_delete pointers.
evict.c: drop_caches and capture __dentry_kill pointers.
rebuild.c: t_e.txt before and after drop_caches to show pointer change.
post.c: l_e.txt before and after drop_caches to show pointer change.

**Loopback ext2**
64M image at /tmp/loopfs.img, mounted at /mnt/loopfs, a.txt created, sync, unmount, remount.

**Program Reports**

minimal_open.c
```c
snprintf(filename, sizeof(filename),
         "test_file_very_long_name_to_force_external_allocation_%ld", now);
int fd = open(filename, O_RDWR | O_CREAT, 0644);
sleep(5);
```
Probe data
- do_filp_open entry pointer = 0xffff8b1480ef7020 | test_file_very_long_name_to_force_external_allocation_1770451257
- d_lookup entry: hash 1258787558 length 64 name test_file_very_long_name_to_force_external_allocation_1770451257
- d_lookup return: NULL
- copy source pointer = 0xffff8b1480ef7020
- copy destination pointer = 0xffff8b14d0cc1a98
- __d_add entry: 0xffff8b14d0cc1a98 | test_file_very_long_name_to_force_external_allocation_1770451257
- do_filp_open return pointer = 0xffff8b14d0cc1a98 | test_file_very_long_name_to_force_external_allocation_1770451257
- d_lookup return: 0xffff8b14d0cc1a98 | test_file_very_long_name_to_force_external_allocation_1770451257
Kernel functions and pointers
- do_filp_open entry printed 0xffff8b1480ef7020 with the long name string.
- __d_alloc copy source pointer 0xffff8b1480ef7020 equals entry pointer.
- __d_add and do_filp_open return printed 0xffff8b14d0cc1a98.
What this shows
- same numeric address 0xffff8b14d0cc1a98 appears at __d_add, do_filp_open return, and later d_lookup return.
Diagram
```text
long name
└─ do_filp_open entry 0xffff8b1480ef7020
   └─ d_lookup entry (hash=1258787558,len=64)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8b1480ef7020
      │     └─ copy destination 0xffff8b14d0cc1a98
      │        └─ __d_add entry 0xffff8b14d0cc1a98
      │           └─ do_filp_open return 0xffff8b14d0cc1a98
      └─ d_lookup return 0xffff8b14d0cc1a98
```

te_miss.c
```c
const char *n2 = "/tmp/t_e.txt";
close(creat(n2, 0644));
drop_caches_if_root();
sleep(1);
open(n2, O_RDONLY);
```
Probe data
- do_filp_open entry pointer = 0xffff8b1480ef7020 | /tmp/t_e.txt
- d_lookup entry: hash 3583106372 length 7 name t_e.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b1480ef7025
- copy destination pointer = 0xffff8b1530b66338
- __d_add entry: 0xffff8b1530b66338 | t_e.txt
- do_filp_open return pointer = 0xffff8b1530b66338 | t_e.txt
Kernel functions and pointers
- do_filp_open entry printed 0xffff8b1480ef7020 for /tmp/t_e.txt.
- __d_alloc copy source pointer 0xffff8b1480ef7025.
- __d_add and do_filp_open return printed 0xffff8b1530b66338.
What this shows
- 0xffff8b1480ef7025 − 0xffff8b1480ef7020 = 0x5 = 5, matches "/tmp/" length 5.
- same numeric address 0xffff8b1530b66338 appears at __d_add and do_filp_open return.
Diagram
```text
/ tmp / t_e.txt
└─ do_filp_open entry 0xffff8b1480ef7020
   └─ d_lookup entry (hash=3583106372,len=7)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8b1480ef7025
      │     └─ copy destination 0xffff8b1530b66338
      │        └─ __d_add entry 0xffff8b1530b66338
      │           └─ do_filp_open return 0xffff8b1530b66338
      └─ d_lookup return 0xffff8b1530b66338
```

tm_miss.c
```c
const char *n3 = "/tmp/t_m.txt";
drop_caches_if_root();
sleep(1);
open(n3, O_RDONLY);
```
Probe data
- do_filp_open entry pointer = 0xffff8b148f406020 | /tmp/t_m.txt
- d_lookup entry: hash 502501587 length 7 name t_m.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b148f406025
- copy destination pointer = 0xffff8b1484f2ddb8
- __d_add entry: 0xffff8b1484f2ddb8 | t_m.txt
Kernel functions and pointers
- do_filp_open entry printed 0xffff8b148f406020 for /tmp/t_m.txt.
- __d_alloc copy source pointer 0xffff8b148f406025.
- __d_add printed 0xffff8b1484f2ddb8.
What this shows
- 0xffff8b148f406025 − 0xffff8b148f406020 = 0x5 = 5, matches "/tmp/" length 5.
- same numeric address 0xffff8b1484f2ddb8 appears at __d_add.
Diagram
```text
/ tmp / t_m.txt
└─ do_filp_open entry 0xffff8b148f406020
   └─ d_lookup entry (hash=502501587,len=7)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8b148f406025
      │     └─ copy destination 0xffff8b1484f2ddb8
      │        └─ __d_add entry 0xffff8b1484f2ddb8
      └─ d_lookup return 0xffff8b1484f2ddb8
```

lm_miss.c
```c
const char *n4 = "l_m.txt";
drop_caches_if_root();
sleep(1);
open(n4, O_RDONLY);
```
Probe data
- do_filp_open entry pointer = 0xffff8b1480ef2020 | l_m.txt
- d_lookup entry: hash 2257632620 length 7 name l_m.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b1480ef2020
- copy destination pointer = 0xffff8b148d58acf8
- __d_add entry: 0xffff8b148d58acf8 | l_m.txt
Kernel functions and pointers
- do_filp_open entry printed 0xffff8b1480ef2020 for l_m.txt.
- __d_alloc copy source pointer 0xffff8b1480ef2020 equals entry pointer.
- __d_add printed 0xffff8b148d58acf8.
What this shows
- copy source equals entry pointer because there is no prefix.
- same numeric address 0xffff8b148d58acf8 appears at __d_add.
Diagram
```text
l_m.txt
└─ do_filp_open entry 0xffff8b1480ef2020
   └─ d_lookup entry (hash=2257632620,len=7)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8b1480ef2020
      │     └─ copy destination 0xffff8b148d58acf8
      │        └─ __d_add entry 0xffff8b148d58acf8
      └─ d_lookup return 0xffff8b148d58acf8
```

a_miss.c
```c
const char *n5 = "/mnt/loopfs/a.txt";
drop_caches_if_root();
sleep(1);
open(n5, O_RDONLY);
```
Probe data
- do_filp_open entry pointer = 0xffff8b1481353020 | /mnt/loopfs/a.txt
- d_lookup entry: hash 2498248789 length 5 name a.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b148135302c
- copy destination pointer = 0xffff8b148d558cf8
- __d_add entry: 0xffff8b148d558cf8 | a.txt
- do_filp_open return pointer = 0xffff8b148d558cf8 | a.txt
Kernel functions and pointers
- do_filp_open entry printed 0xffff8b1481353020 for /mnt/loopfs/a.txt.
- __d_alloc copy source pointer 0xffff8b148135302c.
- __d_add and do_filp_open return printed 0xffff8b148d558cf8.
What this shows
- 0xffff8b148135302c − 0xffff8b1481353020 = 0xC = 12, matches "/mnt/loopfs/" length 12.
- same numeric address 0xffff8b148d558cf8 appears at __d_add and do_filp_open return.
Diagram
```text
/ mnt / loopfs / a.txt
└─ do_filp_open entry 0xffff8b1481353020
   └─ d_lookup entry (hash=2498248789,len=5)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8b148135302c
      │     └─ copy destination 0xffff8b148d558cf8
      │        └─ __d_add entry 0xffff8b148d558cf8
      │           └─ do_filp_open return 0xffff8b148d558cf8
      └─ d_lookup return 0xffff8b148d558cf8
```

hits.c
Probe data
- d_lookup return: 0xffff8b14a710b338 | l_e.txt
- d_lookup return: 0xffff8b14a710be78 | t_e.txt
Kernel functions and pointers
- d_lookup return printed 0xffff8b14a710b338 and 0xffff8b14a710be78.
What this shows
- both hit pointers are captured before delete/evict.
Diagram
```text
l_e.txt -> d_lookup return 0xffff8b14a710b338
t_e.txt -> d_lookup return 0xffff8b14a710be78
```

delete.c
Probe data
- d_lookup return: 0xffff8b14a710b338 | l_e.txt
- d_delete entry: 0xffff8b14a710b338 | l_e.txt
- d_lookup return: 0xffff8b14a710be78 | t_e.txt
- d_delete entry: 0xffff8b14a710be78 | t_e.txt
Kernel functions and pointers
- d_delete printed the same numeric addresses as d_lookup return.
What this shows
- delete uses the same numeric pointers printed at d_lookup return.
Diagram
```text
l_e.txt -> d_lookup return 0xffff8b14a710b338 -> d_delete 0xffff8b14a710b338
t_e.txt -> d_lookup return 0xffff8b14a710be78 -> d_delete 0xffff8b14a710be78
```

evict.c
Probe data
- d_lookup return: 0xffff8b14a710b338 | l_e.txt
- d_lookup return: 0xffff8b14a710be78 | t_e.txt
- __dentry_kill entry: 0xffff8b14a710b338 | l_e.txt
- __dentry_kill entry: 0xffff8b14a710be78 | t_e.txt
Kernel functions and pointers
- __dentry_kill printed the same numeric addresses as d_lookup return.
What this shows
- eviction uses the same numeric pointers printed at d_lookup return.
Diagram
```text
l_e.txt -> d_lookup return 0xffff8b14a710b338 -> __dentry_kill 0xffff8b14a710b338
t_e.txt -> d_lookup return 0xffff8b14a710be78 -> __dentry_kill 0xffff8b14a710be78
```

rebuild.c
Probe data
- before drop_caches: __d_add entry 0xffff8b1484f55278 | t_e.txt, do_filp_open return pointer 0xffff8b1484f55278 | t_e.txt
- after drop_caches: copy destination pointer = 0xffff8b1484f55338, __d_add entry 0xffff8b1484f55338 | t_e.txt, do_filp_open return pointer 0xffff8b1484f55338 | t_e.txt
Kernel functions and pointers
- __d_add and do_filp_open return printed 0xffff8b1484f55278 before drop_caches.
- __d_add and do_filp_open return printed 0xffff8b1484f55338 after drop_caches.
What this shows
- 0xffff8b1484f55338 ≠ 0xffff8b1484f55278.
Diagram
```text
before drop_caches: __d_add 0xffff8b1484f55278 -> do_filp_open return 0xffff8b1484f55278
after  drop_caches: __d_add 0xffff8b1484f55338 -> do_filp_open return 0xffff8b1484f55338
```

post.c
Probe data
- before drop_caches: copy destination pointer = 0xffff8b14804223f8, __d_add entry 0xffff8b14804223f8 | l_e.txt, do_filp_open return pointer 0xffff8b14804223f8 | l_e.txt
- after drop_caches: copy destination pointer = 0xffff8b1480422638, __d_add entry 0xffff8b1480422638 | l_e.txt, do_filp_open return pointer 0xffff8b1480422638 | l_e.txt
Kernel functions and pointers
- __d_add and do_filp_open return printed 0xffff8b14804223f8 before drop_caches.
- __d_add and do_filp_open return printed 0xffff8b1480422638 after drop_caches.
What this shows
- 0xffff8b1480422638 ≠ 0xffff8b14804223f8.
Diagram
```text
before drop_caches: __d_add 0xffff8b14804223f8 -> do_filp_open return 0xffff8b14804223f8
after  drop_caches: __d_add 0xffff8b1480422638 -> do_filp_open return 0xffff8b1480422638
```
