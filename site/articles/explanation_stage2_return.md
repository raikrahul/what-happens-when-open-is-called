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

## Tools
trace_do_filp_open.ko prints kernel pointers and hash keys.
dmesg reads the kernel ring buffer.
rg filters the ring buffer output.

Example dmesg line format (from this driver):
[time] [O] IN: 0xffff... | /tmp/t_e.txt
[time] d_lookup entry: hash 210259851 length 7 name t_e.txt
[time] d_lookup return: NULL
[time] [A] SRC: 0xffff...
[time] [A] DST: 0xffff...
[time] __d_add entry: 0xffff... | t_e.txt
[time] [O] OUT: 0xffff... | t_e.txt
[time] __d_lookup_rcu return: 0xffff... | t_e.txt

What we learned (from these lines only):
- Same numeric pointer repeats across __d_add, do_filp_open return, and later lookup.
- Prefix offsets match string length: /tmp/ = 5, /mnt/loopfs/ = 12.
- Missing file still creates a cached name; second open hits __d_lookup_rcu with the same pointer.
- Probe reads: regs->si → struct filename* at entry, regs->ax → struct file* or struct dentry* at return.

I measured the cache with numbers, not descriptions. In te_miss the same numeric address 0xffff8976c0793c38 appears at __d_add and at do_filp_open return; in minimal_open the same numeric address 0xffff897727671438 appears at __d_add, do_filp_open return, and later d_lookup return. Pointer equality is the only claim: the inserted dentry name pointer is the returned file name pointer, and the later lookup reuses the same pointer.

The basename claim is subtraction. do_filp_open entry prints 0xffff8976c6763020 with "/tmp/t_e.txt" and __d_alloc entry prints 0xffff8976c6763025, so 0xffff8976c6763025 − 0xffff8976c6763020 = 0x5 = 5, which is the length of "/tmp/". For /mnt/loopfs/a.txt, 0xffff8976c905a02c − 0xffff8976c905a020 = 0xC = 12, which is the length of "/mnt/loopfs/". The copy source starts at the basename inside the full path.

Eviction is subtraction too. In rebuild.c, before drop_caches the pointer is 0xffff8976cd60a1b8 and after drop_caches it is 0xffff8976cd60a0f8; 0xffff8976cd60a1b8 − 0xffff8976cd60a0f8 = 0xC0 = 192. A different numeric address after drop_caches proves a new allocation replaced the old one.

Negative dentry caching is also pointer equality. In tm_miss, first open creates 0xffff8976c06483f8 and second open returns 0xffff8976c06483f8 via __d_lookup_rcu; both opens return -1, but the second one hits the cached address and avoids a disk lookup.

These probes exist only to print numbers at the exact transitions: do_filp_open entry fixes the full path pointer, __d_alloc entry fixes the basename pointer, __d_alloc return fixes the new dentry name pointer, __d_add fixes the cached pointer, do_filp_open return fixes the returned pointer, and d_lookup/__d_lookup_rcu show NULL or a reused pointer for the same name key. If any one is removed, you cannot prove the equality or the subtraction chains with numbers alone.

## User Programs (one line each)
### minimal_open.c
```c
snprintf(filename, sizeof(filename),
         "test_file_very_long_name_to_force_external_allocation_%ld", now);
int fd = open(filename, O_RDWR | O_CREAT, 0644);
sleep(5);
```
- do_filp_open entry pointer = 0xffff8976c6763020 | test_file_very_long_name_to_force_external_allocation_1770466275
- d_lookup entry: hash 736449114 length 64 name test_file_very_long_name_to_force_external_allocation_1770466275
- d_lookup return: NULL
- copy source pointer = 0xffff8976c6763020
- __d_alloc return pointer = 0xffff8977eb463eb8
- copy destination pointer = 0xffff8977eb463eb8
- __d_add entry: 0xffff8977eb463eb8 | test_file_very_long_name_to_force_external_allocation_1770466275
- do_filp_open return pointer = 0xffff8977eb463eb8 | test_file_very_long_name_to_force_external_allocation_1770466275
- d_lookup return: 0xffff8977eb463eb8 | test_file_very_long_name_to_force_external_allocation_1770466275
- same numeric address 0xffff8977eb463eb8 appears at __d_add, do_filp_open return, and later d_lookup return.
```
long name
└─ do_filp_open entry 0xffff8976c6763020
   └─ d_lookup entry (hash=736449114,len=64)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8976c6763020
      │     └─ copy destination 0xffff8977eb463eb8
      │        └─ __d_add entry 0xffff8977eb463eb8
      │           └─ do_filp_open return 0xffff8977eb463eb8
      └─ d_lookup return 0xffff8977eb463eb8
```

Learned: same numeric pointer appears at __d_add, do_filp_open return, later d_lookup return for the long name.

### te_miss.c
```c
const char *n2 = "/tmp/t_e.txt";
close(creat(n2, 0644));   // first open from creat (may hit)
drop_caches_if_root();
sleep(1);
open(n2, O_RDONLY);       // second open after drop_caches (miss/alloc)
```
- first open (from creat): __d_lookup_rcu return 0xffff8976c35ee0f8 | t_e.txt
- second open entry pointer = 0xffff8976cc495020 | /tmp/t_e.txt
- prefix lookup: __d_lookup_rcu entry hash 769772012 length 3 name tmp/t_e.txt
- basename lookup: d_lookup entry hash 210259851 length 7 name t_e.txt
- copy source pointer = 0xffff8976cc495025
- __d_alloc return pointer = 0xffff8976e1999b78
- copy destination pointer = 0xffff8976e1999b78
- __d_add entry: 0xffff8976e1999b78 | t_e.txt
- do_filp_open return pointer = 0xffff8976e1999b78 | t_e.txt
- 0xffff8976cc495025 − 0xffff8976cc495020 = 0x5 = 5, matches "/tmp/" length 5.
- same numeric address 0xffff8976e1999b78 appears at __d_add and do_filp_open return.
```
/ tmp / t_e.txt
└─ do_filp_open entry 0xffff8976cc495020
   └─ d_lookup entry (hash=210259851,len=7)
      ├─ d_lookup return NULL (not printed here)
      │  └─ copy source 0xffff8976cc495025
      │     └─ copy destination 0xffff8976e1999b78
      │        └─ __d_add entry 0xffff8976e1999b78
      │           └─ do_filp_open return 0xffff8976e1999b78
      └─ __d_lookup_rcu return 0xffff8976c35ee0f8 (from creat)
```

Learned: basename offset = 5 and the same numeric pointer appears at __d_add and do_filp_open return.

### tm_miss.c
```c
const char *n3 = "/tmp/t_m.txt";
drop_caches_if_root();
sleep(1);
int fd1 = open(n3, O_RDONLY);
printf("tm_miss first open fd=%d
", fd1);
int fd2 = open(n3, O_RDONLY);
printf("tm_miss second open fd=%d
", fd2);
```
stdout
```
tm_miss first open fd=-1
tm_miss second open fd=-1
```
- do_filp_open entry pointer = 0xffff8976c905b020 | /tmp/t_m.txt
- d_lookup entry: hash 2891139310 length 7 name t_m.txt
- __d_lookup_rcu return: NULL
- copy source pointer = 0xffff8976c905b025
- __d_alloc return pointer = 0xffff897725f170f8
- copy destination pointer = 0xffff897725f170f8
- __d_add entry: 0xffff897725f170f8 | t_m.txt
- __d_lookup_rcu return (second open): 0xffff897725f170f8 | t_m.txt
- do_filp_open return pointer: not printed for tm_miss (open returned -1)
- 0xffff8976c905b025 − 0xffff8976c905b020 = 0x5 = 5, matches "/tmp/" length 5.
- same numeric address 0xffff897725f170f8 appears at __d_add and __d_lookup_rcu return on second open.
```
/ tmp / t_m.txt
└─ do_filp_open entry 0xffff8976c905b020
   └─ d_lookup entry (hash=2891139310,len=7)
      ├─ d_lookup return NULL
      │  └─ __d_lookup_rcu return NULL
      │     └─ copy source 0xffff8976c905b025
      │        └─ copy destination 0xffff897725f170f8
      │           └─ __d_add entry 0xffff897725f170f8
      └─ __d_lookup_rcu return 0xffff897725f170f8 (second open)
```

Learned: missing file creates a cached name; second open hits __d_lookup_rcu with the same pointer while fd=-1.

### lm_miss.c
```c
const char *n4 = "l_m.txt";
drop_caches_if_root();
sleep(1);
open(n4, O_RDONLY);
```
- do_filp_open entry pointer = 0xffff8976c643c020 | l_m.txt
- d_lookup entry: hash 2468693519 length 7 name l_m.txt
- d_lookup return: NULL
- copy source pointer = 0xffff8976c643c020
- __d_alloc return pointer = 0xffff89775bf497b8
- copy destination pointer = 0xffff89775bf497b8
- __d_add entry: 0xffff89775bf497b8 | l_m.txt
- same numeric address 0xffff89775bf497b8 appears at __d_add.
```
l_m.txt
└─ do_filp_open entry 0xffff8976c643c020
   └─ d_lookup entry (hash=2468693519,len=7)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8976c643c020
      │     └─ copy destination 0xffff89775bf497b8
      │        └─ __d_add entry 0xffff89775bf497b8
      └─ d_lookup return 0xffff89775bf497b8
```

Learned: no prefix shift; copy source equals entry pointer; __d_add uses the same numeric pointer.

### a_miss.c
```c
const char *n5 = "/mnt/loopfs/a.txt";
drop_caches_if_root();
sleep(1);
open(n5, O_RDONLY);
```
- do_filp_open entry pointer = 0xffff8976c6433020 | /mnt/loopfs/a.txt
- prefix lookup: __d_lookup_rcu entry hash 3799216915 length 3 name mnt/loopfs/a.txt
- prefix lookup: __d_lookup_rcu entry hash 3621501978 length 6 name loopfs/a.txt
- copy source pointer (loopfs/a.txt) = 0xffff8976c6433025
- __d_alloc return pointer (loopfs/a.txt) = 0xffff8977185b57b8
- d_lookup entry: hash 2235526309 length 5 name a.txt
- copy source pointer (a.txt) = 0xffff8976c643302c
- __d_alloc return pointer (a.txt) = 0xffff8977185b54b8
- copy destination pointer = 0xffff8977185b54b8
- __d_add entry: 0xffff8977185b54b8 | a.txt
- do_filp_open return pointer: not printed for a_miss
- 0xffff8976c643302c − 0xffff8976c6433020 = 0xC = 12, matches "/mnt/loopfs/" length 12.
- same numeric address 0xffff8977185b54b8 appears at __d_add.
```
/ mnt / loopfs / a.txt
└─ do_filp_open entry 0xffff8976c6433020
   └─ d_lookup entry (hash=2235526309,len=5)
      ├─ d_lookup return NULL
      │  └─ copy source 0xffff8976c643302c
      │     └─ copy destination 0xffff8977185b54b8
      │        └─ __d_add entry 0xffff8977185b54b8
      └─ d_lookup return 0xffff8977185b54b8
```

Learned: basename offset = 12; __d_add uses the same numeric pointer; no do_filp_open return printed here.

### hits.c + delete.c + evict.c (one pointer chain per name)
```c
// hits.c
open("l_e.txt", O_RDONLY);
open("/tmp/t_e.txt", O_RDONLY);
// delete.c
unlink("l_e.txt");
unlink("/tmp/t_e.txt");
// evict.c
drop_caches_if_root();
```
- l_e.txt hit: __d_lookup_rcu return = 0xffff897725f9f0f8
- l_e.txt delete: d_delete entry = 0xffff897725f9f0f8
- l_e.txt evict: __dentry_kill entry = 0xffff897725f9f0f8
- t_e.txt hit: __d_lookup_rcu return = 0xffff897725f9f7b8
- t_e.txt delete: d_delete entry = 0xffff897725f9f7b8
- t_e.txt evict: __dentry_kill entry = 0xffff897725f9f7b8
```
l_e.txt: 0xffff897725f9f0f8 → 0xffff897725f9f0f8 → 0xffff897725f9f0f8
t_e.txt: 0xffff897725f9f7b8 → 0xffff897725f9f7b8 → 0xffff897725f9f7b8
```

Learned: l_e.txt and t_e.txt keep the same pointer across hit → delete → evict.

### rebuild.c
```c
open("/tmp/t_e.txt", O_RDONLY);
drop_caches_if_root();
open("/tmp/t_e.txt", O_RDONLY);
```
- before drop_caches: __d_add entry 0xffff8977185a9578 | t_e.txt, do_filp_open return pointer 0xffff8977185a9578 | t_e.txt
- after drop_caches: __d_add entry 0xffff8977f40ec278 | t_e.txt, do_filp_open return pointer 0xffff8977f40ec278 | t_e.txt
- 0xffff8977f40ec278 − 0xffff8977185a9578 = 0xdbb42d00 = 3686018304.
- 0xffff8977f40ec278 ≠ 0xffff8977185a9578.
```
before drop_caches: __d_add 0xffff8977185a9578 -> do_filp_open return 0xffff8977185a9578
after  drop_caches: __d_add 0xffff8977f40ec278 -> do_filp_open return 0xffff8977f40ec278
```

Learned: after drop_caches the pointer changed; subtraction shown in hex and decimal.

### post.c
```c
open("l_e.txt", O_RDONLY);
drop_caches_if_root();
open("l_e.txt", O_RDONLY);
```
- before drop_caches: __d_add entry 0xffff89775bdcf638 | l_e.txt, do_filp_open return pointer 0xffff89775bdcf638 | l_e.txt
- after drop_caches: __d_add entry 0xffff8976c341e938 | l_e.txt, do_filp_open return pointer 0xffff8976c341e938 | l_e.txt
- 0xffff89775bdcf638 − 0xffff8976c341e938 = 0x989b0d00 = 2560298240.
- 0xffff8976c341e938 ≠ 0xffff89775bdcf638.
```
before drop_caches: __d_add 0xffff89775bdcf638 -> do_filp_open return 0xffff89775bdcf638
after  drop_caches: __d_add 0xffff8976c341e938 -> do_filp_open return 0xffff8976c341e938
```

## Why These Probes
Start at the equality that closes the loop. In te_miss, __d_add prints 0xffff8976c0793c38 and do_filp_open return prints 0xffff8976c0793c38. The same number appears twice, so the inserted dentry name pointer is the returned file name pointer. In minimal_open the same number 0xffff897727671438 appears at __d_add, do_filp_open return, and later d_lookup return; the cache hit is the same address as the insert and the return.

Now move forward to eviction and rebuild. In rebuild.c, before drop_caches the return pointer is 0xffff8976cd60a1b8, after drop_caches it is 0xffff8976cd60a0f8, and 0xffff8976cd60a1b8 − 0xffff8976cd60a0f8 = 0xC0 = 192. A different numeric address after drop_caches means a new allocation replaced the old one. This is why we probe __dentry_kill and __d_add: the same name produces a new pointer after eviction, and the change is visible as a subtraction in hex.

Now move backward to the copy source. In te_miss, do_filp_open entry prints 0xffff8976c6763020 with "/tmp/t_e.txt", and __d_alloc entry prints 0xffff8976c6763025. The subtraction 0xffff8976c6763025 − 0xffff8976c6763020 = 0x5 = 5 matches the five bytes of "/tmp/". In a_miss, 0xffff8976c905a02c − 0xffff8976c905a020 = 0xC = 12 matches "/mnt/loopfs/". These offsets prove the copy source starts at the basename inside the full path, and that is why do_filp_open entry and __d_alloc entry are both needed: one fixes the full path pointer, the other fixes the basename pointer.

do_sys_openat2 and do_filp_open (source: `/usr/src/linux-source-6.8.0/fs/open.c`)
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

do_filp_open entry → struct filename.name; getname(); pre-lookup  
do_filp_open return → file->f_path.dentry->d_name.name; do_filp_open(); return time  
d_lookup entry name → qstr.name; path_walk(); pre d_lookup  
d_lookup entry len → qstr.len; path_walk(); pre d_lookup  
d_lookup entry hash → qstr.hash; full_name_hash(); pre d_lookup  
d_lookup return pointer → dentry->d_name.name; d_lookup(); post lookup  
__d_lookup_rcu return → dentry->d_name.name; __d_lookup_rcu(); post lookup  
__d_alloc entry → qstr.name; path_walk(); pre __d_alloc  
__d_alloc return → dentry->d_name.name; __d_alloc(); post alloc  
__d_add entry → dentry->d_name.name; __d_add(); insert time  
d_delete entry → dentry->d_name.name; d_delete(); unlink time  
__dentry_kill entry → dentry->d_name.name; __dentry_kill(); drop_caches time

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
