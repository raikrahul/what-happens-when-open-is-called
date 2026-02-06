---
layout: default
title: "Stage 2 Return"
---

Abstract

We measure the filename string as it passes through do_filp_open and the dentry cache. We record input pointers, copy source and destination, return pointers, cache hits, hash values, explicit cache insert events via __d_add, and cache removal events via d_delete and __dentry_kill. We also add a loopback filesystem case with a short name to show a distinct filesystem path and use drop_caches to force eviction. The results show that do_filp_open returns a pointer to the dentry name. On cache miss, __d_alloc copies the name and the return pointer equals the copy destination, and __d_add shows the insert into the dcache. On cache hit, d_lookup returns the same pointer as the prior return. d_delete and __dentry_kill show deletion and eviction. Hash values and lengths printed at d_lookup entry prove the lookup keys used for each name.

Prior Work

Stage 1: https://raikrahul.github.io/what-happens-when-open-is-called/stage1.html
Stage 2 Entry: https://raikrahul.github.io/what-happens-when-open-is-called/stage2.html
Worksheet: https://raikrahul.github.io/what-happens-when-open-is-called/articles/worksheet_stage2_return.html

Introduction

The goal of this stage is concrete: identify where the filename string ends up at return time and prove it with data. The measurement must include both allocation and cache paths and must show the hash values used for lookup. The test programs are designed to produce both paths in one run, and a loopback filesystem test adds a distinct filesystem path and a short name.

Methods

User-space programs:

minimal_open.c
```c
snprintf(filename, sizeof(filename),
         "test_file_very_long_name_to_force_external_allocation_%ld", now);
int fd = open(filename, O_RDWR | O_CREAT, 0644);
sleep(5);
```

matrix_open.c
```c
close(creat("l_e.txt", 0644));
close(creat("/tmp/t_e.txt", 0644));
drop_caches_if_root();
sleep(1);
open("l_e.txt", O_RDONLY);
open("/tmp/t_e.txt", O_RDONLY);
open("/tmp/t_m.txt", O_RDONLY);
open("l_e.txt", O_RDONLY);
open("l_m.txt", O_RDONLY);
open("/mnt/loopfs/a.txt", O_RDONLY);
open("l_e.txt", O_RDONLY);
sleep(2);
close_all();
unlink("l_e.txt");
unlink("/tmp/t_e.txt");
close(creat("l_e.txt", 0644));
close(creat("/tmp/t_e.txt", 0644));
open("l_e.txt", O_RDONLY);
open("/tmp/t_e.txt", O_RDONLY);
drop_caches_if_root();
sleep(1);
open("l_e.txt", O_RDONLY);
open("/tmp/t_e.txt", O_RDONLY);
``` 

Per-line purpose

close(creat("l_e.txt", 0644)); creates a local file so the first open can hit a real inode in the current directory.
close(creat("/tmp/t_e.txt", 0644)); creates a file under /tmp so the path has a prefix and produces a basename shift in the copy source pointer.
drop_caches_if_root(); evicts dentry cache entries so the next opens show cache misses and inserts.
sleep(1); allows eviction to complete before the first opens.
open("l_e.txt", O_RDONLY); first open of an existing local file, intended to show allocation or cache miss behavior.
open("/tmp/t_e.txt", O_RDONLY); first open of an existing /tmp file, intended to show basename copy and allocation.
open("/tmp/t_m.txt", O_RDONLY); open of a missing /tmp file, intended to show an error path with no returned file pointer.
open("l_e.txt", O_RDONLY); second open of the same local file, intended to show a cache hit and pointer reuse.
open("l_m.txt", O_RDONLY); open of a missing local file, intended to show a second error path.
open("/mnt/loopfs/a.txt", O_RDONLY); open of a file on a loopback ext2 filesystem, intended to show the same flow on a different filesystem and a short name.
open("l_e.txt", O_RDONLY); third open of the local file, intended to show repeated cache hit stability.
sleep(2); allows cache hit probes to run before deletion.
close_all(); releases file descriptors so dentries can be deleted or evicted.
unlink("l_e.txt"); deletes the local file name, intended to show d_delete for that dentry.
unlink("/tmp/t_e.txt"); deletes the /tmp file name, intended to show d_delete for that dentry.
close(creat("l_e.txt", 0644)); recreates the local file name for rebuild tests.
close(creat("/tmp/t_e.txt", 0644)); recreates the /tmp file name for rebuild tests.
open("l_e.txt", O_RDONLY); reopen after deletion to observe reuse or rebuild.
open("/tmp/t_e.txt", O_RDONLY); reopen after deletion to observe reuse or rebuild.
drop_caches_if_root(); forces eviction to prove rebuild after eviction.
sleep(1); allows eviction to complete.
open("l_e.txt", O_RDONLY); reopen after eviction to observe rebuild.
open("/tmp/t_e.txt", O_RDONLY); reopen after eviction to observe rebuild.

Loopback filesystem test:

- 64M loopback file formatted as ext2
- mounted at /mnt/loopfs
- a.txt created, sync, unmount, remount

Symbol availability proof (from this machine)

Kernel headers and sources:

uname -r: 6.14.0-37-generic
/usr/src contains linux-headers-6.14.0-37-generic
/usr/src contains linux-source-6.8.0

kptr_restrict: 1
perf_event_paranoid: 4

Symbols in /proc/kallsyms:

__d_add: ffffffff89beaaa0 (local symbol, type t)
d_add: ffffffff89beaca0 (global symbol, type T)
d_rehash: ffffffff89bea3e0 (global symbol, type T)
d_add_ci: ffffffff89becf20 (global symbol, type T)
full_name_hash: ffffffff89bd5010 (global symbol, type T)

Why __d_add is not in available_filter_functions:
available_filter_functions is the ftrace function list, not a full symbol list. It only includes functions that ftrace exposes (non-inlined, traceable, and globally visible). __d_add is present as a local symbol in kallsyms, so kprobe can attach to it, but ftrace does not list it.

Probe map and observed fields:

- do_filp_open entry: input filename pointer
- __d_alloc entry: copy source pointer
- __d_alloc return: copy destination pointer
- do_filp_open return: returned struct file name pointer
- d_lookup entry: hash value, length, and name string
- d_lookup return: cache hit name pointer
- __d_add entry: dentry name pointer at insert into dcache
- d_delete entry: dentry name pointer at unlink removal
- __dentry_kill entry: dentry name pointer at eviction via drop_caches

Memcpy proof (kernel source)

File: /usr/src/linux-source-6.8.0/fs/dcache.c:1660
memcpy(dname, name->name, name->len);

Per-probe purpose

do_filp_open entry: capture the input name pointer before any lookup or allocation. This is the kernel-side name pointer used for the open.
__d_alloc entry: capture the source pointer used for name copying into a new dentry. This is the copy source.
__d_alloc return: capture the destination pointer for the copied name in the new dentry. This is the copy destination.
do_filp_open return: capture the name pointer referenced by the returned struct file. This is the return pointer we compare against copies and cache hits.
d_lookup entry: capture the hash value, length, and name used as the lookup key. This shows which exact string is hashed for lookup.
d_lookup return: capture the name pointer of a cached dentry on hit. This is the pointer reused on cache hits.
__d_add entry: capture the moment the new dentry name is inserted into the dcache. This is the cache build-up proof.
d_delete entry: capture the moment the name is removed from the dcache hash at unlink time. This is the cache deletion proof.
__dentry_kill entry: capture the moment the dentry is reclaimed by drop_caches. This is the eviction proof.

ASCII diagram: allocation path
```text
user string
    |
    v
do_filp_open entry
    |
    v
__d_alloc entry (copy source)
    |
    v
__d_alloc return (copy destination)
    |
    v
do_filp_open return
```

ASCII diagram: cache hit path
```text
user string
    |
    v
do_filp_open entry
    |
    v
d_lookup return
    |
    v
do_filp_open return
```

ASCII diagram: hash lookup
```text
name string + length
        |
        v
     full_name_hash
        |
        v
   hash value (H)
        |
        v
  d_lookup bucket
```

Results

Run A: matrix_open (root, drop_caches enabled)

Phase 0 (post-creat eviction):

__dentry_kill entry: 0xffff8bd54073ddb8 | l_e.txt
__dentry_kill entry: 0xffff8bd562809878 | t_e.txt

Phase 1 (first opens after eviction):

l_e.txt:
do_filp_open entry pointer = 0xffff8bd543616020
do_filp_open return pointer = 0xffff8bd55866ce78

t_e.txt:
do_filp_open entry pointer = 0xffff8bd543616020
d_lookup entry: hash 1830572521 length 7 name t_e.txt
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd543616025
__d_alloc return pointer = 0xffff8bd540620f38
__d_add entry pointer = 0xffff8bd540620f38
do_filp_open return pointer = 0xffff8bd540620f38

t_m.txt (missing):
d_lookup entry: hash 2543581516 length 7 name t_m.txt
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd543616025
__d_alloc return pointer = 0xffff8bd5406200f8
__d_add entry pointer = 0xffff8bd5406200f8

l_m.txt (missing):
d_lookup entry: hash 1675155717 length 7 name l_m.txt
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd543616020
__d_alloc return pointer = 0xffff8bd5406204b8
__d_add entry pointer = 0xffff8bd5406204b8

a.txt (loopback ext2):
d_lookup entry: hash 3711754354 length 5 name a.txt
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd54361602c
__d_alloc return pointer = 0xffff8bd5406203f8
__d_add entry pointer = 0xffff8bd5406203f8
do_filp_open return pointer = 0xffff8bd5406203f8

Phase 2 (cache hit before deletion):

l_e.txt:
d_lookup entry: hash 399720033 length 7 name l_e.txt
d_lookup return pointer = 0xffff8bd55866ce78

t_e.txt:
d_lookup entry: hash 1830572521 length 7 name t_e.txt
d_lookup return pointer = 0xffff8bd540620f38

Phase 3 (deletion via unlink):

d_delete entry: 0xffff8bd55866ce78 | l_e.txt
d_delete entry: 0xffff8bd540620f38 | t_e.txt
no d_drop entry lines observed in this run

Phase 4 (eviction via drop_caches):

__dentry_kill entry: 0xffff8bd55866ce78 | l_e.txt
__dentry_kill entry: 0xffff8bd540620f38 | t_e.txt
__dentry_kill entry: 0xffff8bd5406203f8 | a.txt
__dentry_kill entry: 0xffff8bd5406204b8 | l_m.txt
__dentry_kill entry: 0xffff8bd5406200f8 | t_m.txt

Phase 5 (rebuild after eviction):

t_e.txt:
d_lookup entry: hash 1830572521 length 7 name t_e.txt
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd543616025
__d_alloc return pointer = 0xffff8bd5406206f8
__d_add entry pointer = 0xffff8bd5406206f8
do_filp_open return pointer = 0xffff8bd5406206f8

l_e.txt:
do_filp_open return pointer = 0xffff8bd572dd8878
no d_lookup entry line observed for l_e.txt in this phase

Numeric checks:

0xffff8bd543616025 - 0xffff8bd543616020 = 0x5 = 5
"/tmp/" length = 5
0xffff8bd54361602c - 0xffff8bd543616020 = 0xC = 12
"/mnt/loopfs/" length = 12

Hash keys (Run A):

l_e.txt with length 7 -> 399720033
t_e.txt with length 7 -> 1830572521
l_m.txt with length 7 -> 1675155717
t_m.txt with length 7 -> 2543581516
a.txt with length 5 -> 3711754354

Run B: minimal_open (target_comm=minimal_open)

test_file_very_long_name_to_force_external_allocation_1770404658:
do_filp_open entry pointer = 0xffff8bd54d663020
d_lookup entry: hash 3918709873 length 64 name test_file_very_long_name_to_force_external_allocation_1770404658
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd54d663020
__d_alloc return pointer = 0xffff8bd69f6fb618
__d_add entry pointer = 0xffff8bd69f6fb618
do_filp_open return pointer = 0xffff8bd69f6fb618

cache hit after 5 seconds:
d_lookup entry: hash 3918709873 length 64 name test_file_very_long_name_to_force_external_allocation_1770404658
d_lookup return pointer = 0xffff8bd69f6fb618

Discussion

The allocation path is shown by a copy source pointer and copy destination pointer appearing and the return pointer equaling the copy destination. The cache build-up is shown by __d_add inserting the same dentry name pointer that __d_alloc produced. The cache hit path is shown by d_lookup returning a pointer equal to the earlier return pointer for the same name. The deletion path is shown by d_delete entries for l_e.txt and t_e.txt after unlink. The eviction path is shown by __dentry_kill entries for the same names after drop_caches. The /tmp case shows a 5 byte offset between the input pointer and the copy source pointer, matching the /tmp/ prefix and isolating the basename. The /mnt/loopfs case shows a 12 byte offset matching the /mnt/loopfs/ prefix. The loopback ext2 case shows the same flow on a different filesystem with a short name. The missing name cases show a lookup miss and a negative dentry insertion via __d_add.

Conclusion

The returned struct file pointer equals the dentry name pointer. On allocation, __d_alloc copies the name and the return pointer equals the copy destination, and __d_add shows the insert into dcache. On cache hit, d_lookup returns the same pointer observed earlier. On deletion, d_delete shows removal of the dentry for l_e.txt and t_e.txt. On eviction, __dentry_kill shows those dentries reclaimed after drop_caches. Hash values and lengths printed at d_lookup entry prove that each lookup hashes the exact key string used for that path.
