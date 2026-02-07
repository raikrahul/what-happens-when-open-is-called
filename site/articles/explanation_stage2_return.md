---
layout: default
title: "Stage 2 Return"
---

**Goal**

addresses and hash values are from one run; your run will differ. prove only with printed pointers and hashes. /tmp/t_e.txt: do_filp_open entry pointer 0xffff8b1480ef7020, copy source pointer 0xffff8b1480ef7025, so 0xffff8b1480ef7025 − 0xffff8b1480ef7020 = 0x5 = 5, and "/tmp/" length = 5. /mnt/loopfs/a.txt: do_filp_open entry pointer 0xffff8b1481353020, copy source pointer 0xffff8b148135302c, so 0xffff8b148135302c − 0xffff8b1481353020 = 0xC = 12, and "/mnt/loopfs/" length = 12. t_e.txt after drop_caches in te_miss: copy destination pointer 0xffff8b1530b66338 = __d_add entry pointer 0xffff8b1530b66338 = do_filp_open return pointer 0xffff8b1530b66338. a.txt: copy destination pointer 0xffff8b148d558cf8 = __d_add entry pointer 0xffff8b148d558cf8 = do_filp_open return pointer 0xffff8b148d558cf8. rebuild: t_e.txt copy destination 0xffff8b1484f55338 and earlier 0xffff8b1484f55278 are not equal.
Stage 1 traced the entry path into open and printed the first kernel-visible filename pointer. Stage 2 (entry) traced the getname/filename path and established the kernel string buffer.

**Programs**

minimal_open.c
```c
snprintf(filename, sizeof(filename),
         "test_file_very_long_name_to_force_external_allocation_%ld", now);
int fd = open(filename, O_RDWR | O_CREAT, 0644);
sleep(5);
```

te_miss.c, tm_miss.c, lm_miss.c, a_miss.c, hits.c, delete.c, evict.c, rebuild.c, post.c in `kernel/user/stage2`. loopback ext2: 64M image, mount at /mnt/loopfs, create a.txt, sync, unmount, remount.

**Data**

minimal_open.c
- do_filp_open entry pointer = 0xffff8b1480ef7020 | test_file_very_long_name_to_force_external_allocation_1770451257
- d_lookup entry: hash 1258787558 length 64 name test_file_very_long_name_to_force_external_allocation_1770451257
- d_lookup return: NULL
- copy source pointer = 0xffff8b1480ef7020
- copy destination pointer = 0xffff8b14d0cc1a98
- __d_add entry: 0xffff8b14d0cc1a98 | test_file_very_long_name_to_force_external_allocation_1770451257
- do_filp_open return pointer = 0xffff8b14d0cc1a98 | test_file_very_long_name_to_force_external_allocation_1770451257
- d_lookup return: 0xffff8b14d0cc1a98 | test_file_very_long_name_to_force_external_allocation_1770451257

te_miss.c (after drop_caches block)
- do_filp_open entry pointer = 0xffff8b1480ef7020 | /tmp/t_e.txt
- d_lookup entry: hash 3583106372 length 7 name t_e.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b1480ef7025
- copy destination pointer = 0xffff8b1530b66338
- __d_add entry: 0xffff8b1530b66338 | t_e.txt
- do_filp_open return pointer = 0xffff8b1530b66338 | t_e.txt

tm_miss.c
- do_filp_open entry pointer = 0xffff8b148f406020 | /tmp/t_m.txt
- d_lookup entry: hash 502501587 length 7 name t_m.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b148f406025
- copy destination pointer = 0xffff8b1484f2ddb8
- __d_add entry: 0xffff8b1484f2ddb8 | t_m.txt

lm_miss.c
- do_filp_open entry pointer = 0xffff8b1480ef2020 | l_m.txt
- d_lookup entry: hash 2257632620 length 7 name l_m.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b1480ef2020
- copy destination pointer = 0xffff8b148d58acf8
- __d_add entry: 0xffff8b148d58acf8 | l_m.txt

a_miss.c
- do_filp_open entry pointer = 0xffff8b1481353020 | /mnt/loopfs/a.txt
- d_lookup entry: hash 2498248789 length 5 name a.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b148135302c
- copy destination pointer = 0xffff8b148d558cf8
- __d_add entry: 0xffff8b148d558cf8 | a.txt
- do_filp_open return pointer = 0xffff8b148d558cf8 | a.txt

delete.c
- d_lookup return: 0xffff8b14a710b338 | l_e.txt
- d_delete entry: 0xffff8b14a710b338 | l_e.txt
- d_lookup return: 0xffff8b14a710be78 | t_e.txt
- d_delete entry: 0xffff8b14a710be78 | t_e.txt

evict.c
- d_lookup return: 0xffff8b14a710b338 | l_e.txt
- d_lookup return: 0xffff8b14a710be78 | t_e.txt
- __dentry_kill entry: 0xffff8b14a710b338 | l_e.txt
- __dentry_kill entry: 0xffff8b14a710be78 | t_e.txt

rebuild.c
- before drop_caches: __d_add entry 0xffff8b1484f55278 | t_e.txt, do_filp_open return pointer 0xffff8b1484f55278 | t_e.txt
- after drop_caches: copy destination pointer = 0xffff8b1484f55338, __d_add entry 0xffff8b1484f55338 | t_e.txt, do_filp_open return pointer 0xffff8b1484f55338 | t_e.txt

post.c
- before drop_caches: copy destination pointer = 0xffff8b14804223f8, __d_add entry 0xffff8b14804223f8 | l_e.txt, do_filp_open return pointer 0xffff8b14804223f8 | l_e.txt
- after drop_caches: copy destination pointer = 0xffff8b1480422638, __d_add entry 0xffff8b1480422638 | l_e.txt, do_filp_open return pointer 0xffff8b1480422638 | l_e.txt

**Checks**

0xffff8b1480ef7025 − 0xffff8b1480ef7020 = 0x5 = 5
"/tmp/" length = 5
0xffff8b148135302c − 0xffff8b1481353020 = 0xC = 12
"/mnt/loopfs/" length = 12
0xffff8b14d0cc1a98 = __d_add entry pointer = do_filp_open return pointer (minimal_open)
0xffff8b1530b66338 = __d_add entry pointer = do_filp_open return pointer (te_miss after drop_caches)
0xffff8b148d558cf8 = __d_add entry pointer = do_filp_open return pointer (a_miss)
0xffff8b1484f55338 ≠ 0xffff8b1484f55278 (t_e.txt rebuild)
0xffff8b1480422638 ≠ 0xffff8b14804223f8 (l_e.txt post-eviction)

**Diagrams**

minimal_open.c
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

te_miss.c (after drop_caches block)
```text
/tmp/t_e.txt
└─ do_filp_open entry 0xffff8b1480ef7020
   └─ d_lookup entry (hash=3583106372,len=7)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8b1480ef7025
      │     └─ copy destination 0xffff8b1530b66338
      │        └─ __d_add entry 0xffff8b1530b66338
      │           └─ do_filp_open return 0xffff8b1530b66338
      └─ d_lookup return 0xffff8b1530b66338
```

a_miss.c
```text
/mnt/loopfs/a.txt
└─ do_filp_open entry 0xffff8b1481353020
   └─ d_lookup entry (hash=2498248789,len=5)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8b148135302c
      │     └─ copy destination 0xffff8b148d558cf8
      │        └─ __d_add entry 0xffff8b148d558cf8
      │           └─ do_filp_open return 0xffff8b148d558cf8
      └─ d_lookup return 0xffff8b148d558cf8
```

rebuild.c (t_e.txt)
```text
before drop_caches: __d_add 0xffff8b1484f55278 -> do_filp_open return 0xffff8b1484f55278
after  drop_caches: __d_add 0xffff8b1484f55338 -> do_filp_open return 0xffff8b1484f55338
```

post.c (l_e.txt)
```text
before drop_caches: __d_add 0xffff8b14804223f8 -> do_filp_open return 0xffff8b14804223f8
after  drop_caches: __d_add 0xffff8b1480422638 -> do_filp_open return 0xffff8b1480422638
```
