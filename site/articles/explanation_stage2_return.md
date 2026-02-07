---
layout: default
title: "Stage 2 Return"
---

## Introduction
Kernel headers and sources used in this run:
- `/usr/src/linux-source-6.8.0/fs/open.c`
- `/usr/src/linux-source-6.8.0/fs/dcache.c`
- `/usr/src/linux-source-6.8.0/include/linux/fs.h`
- `kernel/drivers/trace_do_filp_open/trace_do_filp_open.c`

This report uses one run of printed pointers and hashes. All addresses are exact for this run. Your run will differ.

Previous work:
[Stage 1](https://raikrahul.github.io/what-happens-when-open-is-called/stage1.html) entry path and first kernel filename pointer.
[Stage 2](https://raikrahul.github.io/what-happens-when-open-is-called/stage2.html) getname/filename buffer.
[Worksheet](https://raikrahul.github.io/what-happens-when-open-is-called/articles/worksheet_stage2_return.html) for this stage.

## Man Pages Used (parts)
open(2): `int open(const char *pathname, int flags, ...);` returns file descriptor or -1.
creat(2): `int creat(const char *pathname, mode_t mode);` = open with create flags.
unlink(2): `int unlink(const char *pathname);` returns 0 or -1.
write(2): `ssize_t write(int fd, const void *buf, size_t count);` returns bytes written or -1.
sync(2): `void sync(void);` flushes filesystem buffers.
mount(8): `mount <device> <dir>` used for loopback ext2.
umount(8): `umount <dir>` used to remount loopback.
losetup(8): `losetup -fP <img>` maps loopback device.
mkfs.ext2(8): `mkfs.ext2 -F <img>` formats loopback image.
dd(1): `dd if=/dev/zero of=/tmp/loopfs.img bs=1M count=64` creates 64M image.
dmesg(1): `dmesg` prints kernel ring buffer.
insmod(8), rmmod(8): `insmod <ko>` / `rmmod <ko>` load/unload driver.

## Tools
trace_do_filp_open.ko prints kernel pointers and hash keys.
dmesg reads the kernel ring buffer.
rg filters the ring buffer output.

## User Programs (one line each)
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

## Loopback ext2
64M image at /tmp/loopfs.img, mounted at /mnt/loopfs, a.txt created, sync, unmount, remount.

## What We Learned
- Same numeric pointer shows copy destination, dcache insert, and do_filp_open return for the same name.
- Prefix offsets are measurable: /tmp/ = 5, /mnt/loopfs/ = 12; copy source pointer shifts by those exact bytes.
- Cache hit returns the exact pointer printed earlier; unlink and drop_caches act on the same numeric pointers.

## Program Reports

minimal_open.c
```c
snprintf(filename, sizeof(filename),
         "test_file_very_long_name_to_force_external_allocation_%ld", now);
int fd = open(filename, O_RDWR | O_CREAT, 0644);
sleep(5);
```
- do_filp_open entry pointer = 0xffff8b1480ef7020 | test_file_very_long_name_to_force_external_allocation_1770451257
- d_lookup entry: hash 1258787558 length 64 name test_file_very_long_name_to_force_external_allocation_1770451257
- d_lookup return: NULL
- copy source pointer = 0xffff8b1480ef7020
- copy destination pointer = 0xffff8b14d0cc1a98
- __d_add entry: 0xffff8b14d0cc1a98 | test_file_very_long_name_to_force_external_allocation_1770451257
- do_filp_open return pointer = 0xffff8b14d0cc1a98 | test_file_very_long_name_to_force_external_allocation_1770451257
- d_lookup return: 0xffff8b14d0cc1a98 | test_file_very_long_name_to_force_external_allocation_1770451257
- do_filp_open entry printed 0xffff8b1480ef7020 with the long name string.
- __d_alloc copy source pointer 0xffff8b1480ef7020 equals entry pointer.
- __d_add and do_filp_open return printed 0xffff8b14d0cc1a98.
- same numeric address 0xffff8b14d0cc1a98 appears at __d_add, do_filp_open return, and later d_lookup return.
```
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
- do_filp_open entry pointer = 0xffff8b1480ef7020 | /tmp/t_e.txt
- d_lookup entry: hash 3583106372 length 7 name t_e.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b1480ef7025
- copy destination pointer = 0xffff8b1530b66338
- __d_add entry: 0xffff8b1530b66338 | t_e.txt
- do_filp_open return pointer = 0xffff8b1530b66338 | t_e.txt
- do_filp_open entry printed 0xffff8b1480ef7020 for /tmp/t_e.txt.
- __d_alloc copy source pointer 0xffff8b1480ef7025.
- __d_add and do_filp_open return printed 0xffff8b1530b66338.
- 0xffff8b1480ef7025 − 0xffff8b1480ef7020 = 0x5 = 5, matches "/tmp/" length 5.
- same numeric address 0xffff8b1530b66338 appears at __d_add and do_filp_open return.
```
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
- do_filp_open entry pointer = 0xffff8b148f406020 | /tmp/t_m.txt
- d_lookup entry: hash 502501587 length 7 name t_m.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b148f406025
- copy destination pointer = 0xffff8b1484f2ddb8
- __d_add entry: 0xffff8b1484f2ddb8 | t_m.txt
- do_filp_open entry printed 0xffff8b148f406020 for /tmp/t_m.txt.
- __d_alloc copy source pointer 0xffff8b148f406025.
- __d_add printed 0xffff8b1484f2ddb8.
- 0xffff8b148f406025 − 0xffff8b148f406020 = 0x5 = 5, matches "/tmp/" length 5.
- same numeric address 0xffff8b1484f2ddb8 appears at __d_add.
```
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
- do_filp_open entry pointer = 0xffff8b1480ef2020 | l_m.txt
- d_lookup entry: hash 2257632620 length 7 name l_m.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b1480ef2020
- copy destination pointer = 0xffff8b148d58acf8
- __d_add entry: 0xffff8b148d58acf8 | l_m.txt
- do_filp_open entry printed 0xffff8b1480ef2020 for l_m.txt.
- __d_alloc copy source pointer 0xffff8b1480ef2020 equals entry pointer.
- __d_add printed 0xffff8b148d58acf8.
- copy source equals entry pointer because there is no prefix.
- same numeric address 0xffff8b148d58acf8 appears at __d_add.
```
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
- do_filp_open entry pointer = 0xffff8b1481353020 | /mnt/loopfs/a.txt
- d_lookup entry: hash 2498248789 length 5 name a.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8b148135302c
- copy destination pointer = 0xffff8b148d558cf8
- __d_add entry: 0xffff8b148d558cf8 | a.txt
- do_filp_open return pointer = 0xffff8b148d558cf8 | a.txt
- do_filp_open entry printed 0xffff8b1481353020 for /mnt/loopfs/a.txt.
- __d_alloc copy source pointer 0xffff8b148135302c.
- __d_add and do_filp_open return printed 0xffff8b148d558cf8.
- 0xffff8b148135302c − 0xffff8b1481353020 = 0xC = 12, matches "/mnt/loopfs/" length 12.
- same numeric address 0xffff8b148d558cf8 appears at __d_add and do_filp_open return.
```
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
- d_lookup return: 0xffff8b14a710b338 | l_e.txt
- d_lookup return: 0xffff8b14a710be78 | t_e.txt
- d_lookup return printed 0xffff8b14a710b338 and 0xffff8b14a710be78.
- both hit pointers are captured before delete/evict.
```
l_e.txt -> d_lookup return 0xffff8b14a710b338
t_e.txt -> d_lookup return 0xffff8b14a710be78
```

delete.c
- d_lookup return: 0xffff8b14a710b338 | l_e.txt
- d_delete entry: 0xffff8b14a710b338 | l_e.txt
- d_lookup return: 0xffff8b14a710be78 | t_e.txt
- d_delete entry: 0xffff8b14a710be78 | t_e.txt
- d_delete printed the same numeric addresses as d_lookup return.
- delete uses the same numeric pointers printed at d_lookup return.
```
l_e.txt -> d_lookup return 0xffff8b14a710b338 -> d_delete 0xffff8b14a710b338
t_e.txt -> d_lookup return 0xffff8b14a710be78 -> d_delete 0xffff8b14a710be78
```

evict.c
- d_lookup return: 0xffff8b14a710b338 | l_e.txt
- d_lookup return: 0xffff8b14a710be78 | t_e.txt
- __dentry_kill entry: 0xffff8b14a710b338 | l_e.txt
- __dentry_kill entry: 0xffff8b14a710be78 | t_e.txt
- __dentry_kill printed the same numeric addresses as d_lookup return.
- eviction uses the same numeric pointers printed at d_lookup return.
```
l_e.txt -> d_lookup return 0xffff8b14a710b338 -> __dentry_kill 0xffff8b14a710b338
t_e.txt -> d_lookup return 0xffff8b14a710be78 -> __dentry_kill 0xffff8b14a710be78
```

rebuild.c
- before drop_caches: __d_add entry 0xffff8b1484f55278 | t_e.txt, do_filp_open return pointer 0xffff8b1484f55278 | t_e.txt
- after drop_caches: copy destination pointer = 0xffff8b1484f55338, __d_add entry 0xffff8b1484f55338 | t_e.txt, do_filp_open return pointer 0xffff8b1484f55338 | t_e.txt
- __d_add and do_filp_open return printed 0xffff8b1484f55278 before drop_caches.
- __d_add and do_filp_open return printed 0xffff8b1484f55338 after drop_caches.
- 0xffff8b1484f55338 ≠ 0xffff8b1484f55278.
```
before drop_caches: __d_add 0xffff8b1484f55278 -> do_filp_open return 0xffff8b1484f55278
after  drop_caches: __d_add 0xffff8b1484f55338 -> do_filp_open return 0xffff8b1484f55338
```

post.c
- before drop_caches: copy destination pointer = 0xffff8b14804223f8, __d_add entry 0xffff8b14804223f8 | l_e.txt, do_filp_open return pointer 0xffff8b14804223f8 | l_e.txt
- after drop_caches: copy destination pointer = 0xffff8b1480422638, __d_add entry 0xffff8b1480422638 | l_e.txt, do_filp_open return pointer 0xffff8b1480422638 | l_e.txt
- __d_add and do_filp_open return printed 0xffff8b14804223f8 before drop_caches.
- __d_add and do_filp_open return printed 0xffff8b1480422638 after drop_caches.
- 0xffff8b1480422638 ≠ 0xffff8b14804223f8.
```
before drop_caches: __d_add 0xffff8b14804223f8 -> do_filp_open return 0xffff8b14804223f8
after  drop_caches: __d_add 0xffff8b1480422638 -> do_filp_open return 0xffff8b1480422638
```

## Why These Probes
do_filp_open entry: prints the kernel pathname pointer from `struct filename->name`, the first stable kernel copy of the user string for this call.  
do_filp_open return: prints `file->f_path.dentry->d_name.name`, the name pointer carried by the returned file.  
d_lookup entry: prints `qstr->name`, `qstr->len`, `qstr->hash`, the exact lookup key the cache search uses.  
d_lookup return: prints NULL or a dentry name pointer, so hit vs miss is a numeric fact.  
__d_lookup / __d_lookup_rcu: print the same key on internal/RCU paths so the key is visible on those paths too.  
__d_alloc entry: prints `qstr->name` as the copy source pointer used by `memcpy(dname, name->name, name->len)`.  
__d_alloc return: prints `dentry->d_name.name` as the copy destination pointer created by the allocation.  
__d_add entry: prints the dentry name pointer inserted into the dcache hash.  
d_delete entry: prints the dentry name pointer removed by unlink.  
__dentry_kill entry: prints the dentry name pointer reclaimed by drop_caches.  

do_sys_openat2 and do_filp_open (source: `/usr/src/linux-source-6.8.0/fs/open.c`, lines 1388–1414)
```
open/openat
└─ do_sys_openat2
   ├─ filename = getname(filename)
   └─ do_filp_open(dfd, filename, op)
      ├─ struct filename { name=const char*, uptr=const __user char* }  (fs.h:2554–2560)
      ├─ driver open_entry (trace_do_filp_open.c:73–78) → print filename->name
      └─ driver open_ret (trace_do_filp_open.c:82–88) → print file->f_path.dentry->d_name.name
          └─ struct file { struct path f_path; } (fs.h:1000–1019)
```

d_lookup (source: `/usr/src/linux-source-6.8.0/fs/dcache.c`)
```
d_lookup(parent, qstr*)
└─ qstr { name->name, name->len, name->hash }
   ├─ driver lookup_entry → print name, len, hash
   └─ driver lookup_ret → print return pointer or NULL
```

__d_lookup / __d_lookup_rcu (source: `/usr/src/linux-source-6.8.0/fs/dcache.c`)
```
__d_lookup(qstr*) / __d_lookup_rcu(qstr*)
└─ qstr { name->name, name->len, name->hash }
   └─ driver __d_lookup / __d_lookup_rcu → print name, len, hash
```

__d_alloc (source: `/usr/src/linux-source-6.8.0/fs/dcache.c`)
```
__d_alloc(sb, qstr*)
└─ qstr { name->name, name->len }
   ├─ driver alloc_entry → print name->name
   ├─ memcpy(dname, name->name, name->len)
   └─ driver alloc_ret → print dentry->d_name.name
```

__d_add (source: `/usr/src/linux-source-6.8.0/fs/dcache.c`)
```
__d_add(dentry, inode)
└─ driver d_add_entry → print dentry->d_name.name
```

d_delete (source: `/usr/src/linux-source-6.8.0/fs/dcache.c`)
```
d_delete(dentry)
└─ driver d_delete_entry → print dentry->d_name.name
```

__dentry_kill (source: `/usr/src/linux-source-6.8.0/fs/dcache.c`)
```
__dentry_kill(dentry)
└─ driver dentry_kill_entry → print dentry->d_name.name
```
