---
layout: default
title: "Stage 2 Return"
---

addresses and hash values are from one run; your run will differ.
This stage traces one thing and nothing else: the user‑space filename string as it turns into a
kernel pointer, gets copied, hashed, cached, deleted, and reused on return. No VMs, no heavy
tracers, no filters—only dmesg plus kprobes/kretprobes. If it is not tied to a printed pointer,
hash, or a kernel source line, it is not stated.
https://github.com/raikrahul/what-happens-when-open-is-called/tree/main/kernel/drivers/trace_do_filp_open
Save your work before loading the module. This is not hand‑holding; if you want a different kernel,
use an AI tool to port the driver.

https://raikrahul.github.io/what-happens-when-open-is-called/stage1.html
https://raikrahul.github.io/what-happens-when-open-is-called/stage2.html
https://raikrahul.github.io/what-happens-when-open-is-called/articles/worksheet_stage2_return.html

prove, using only printed pointers and hashes, that the user‑space filename string becomes a kernel pointer, that the basename pointer is a fixed offset inside that kernel buffer, that the name bytes are copied into dentry name storage, and that the cache hit reuses the same pointer. The run numbers are: do_filp_open entry pointer for /tmp/t_e.txt is 0xffff8b148256c020, and __d_alloc entry pointer is 0xffff8b148256c025, so 0xffff8b148256c025 − 0xffff8b148256c020 = 0x5 = 5, and the prefix length of “/tmp/” is 5, so the copy source starts exactly at the basename. For /mnt/loopfs/a.txt, do_filp_open entry pointer is 0xffff8b148256b020 and __d_alloc entry pointer is 0xffff8b148256b02c, so 0xffff8b148256b02c − 0xffff8b148256b020 = 0xC = 12, and the prefix length of “/mnt/loopfs/” is 12. For t_e.txt, __d_alloc return pointer is 0xffff8b14d0cc60f8, __d_add entry pointer is 0xffff8b14d0cc60f8, and do_filp_open return pointer is 0xffff8b14d0cc60f8, so the copied name pointer is reused as the file’s name pointer. For the cache hit before eviction, d_lookup return pointer for l_e.txt is 0xffff8b149e4886f8 and for t_e.txt is 0xffff8b149e488cf8, and those same pointers appear in d_delete and __dentry_kill, so the cache hit, delete, and eviction refer to the same dentry name addresses.

minimal_open.c
```c
snprintf(filename, sizeof(filename),
         "test_file_very_long_name_to_force_external_allocation_%ld", now);
int fd = open(filename, O_RDWR | O_CREAT, 0644);
sleep(5);
```

te_miss.c (t_e.txt miss + alloc + add + return)
tm_miss.c (t_m.txt miss + alloc + add)
lm_miss.c (l_m.txt miss + alloc + add)
a_miss.c (a.txt miss + alloc + add)
hits.c (cache hits for l_e.txt and t_e.txt)
delete.c (unlink l_e.txt and t_e.txt)
evict.c (drop_caches eviction)
rebuild.c (post-eviction rebuild for t_e.txt)
post.c (post-eviction lookup for l_e.txt)

```text
do_filp_open entry -> struct filename->name
d_lookup entry -> qstr->{name,len,hash}
__d_lookup entry -> qstr->{name,len,hash}
__d_lookup_rcu -> qstr->{name,len,hash}
d_lookup return -> NULL | dentry->d_name.name
__d_alloc entry -> qstr->name
__d_alloc return -> dentry->d_name.name
__d_add entry -> dentry->d_name.name
do_filp_open return -> f->f_path.dentry->d_name.name
d_delete entry -> dentry->d_name.name
__dentry_kill entry -> dentry->d_name.name
```

Per-line purpose is in the inline `//` comments in each `kernel/user/stage2/*.c` program. Each open, unlink, and drop_caches call is annotated next to its line.

64M loopback file formatted as ext2, mounted at /mnt/loopfs, a.txt created, sync, unmount, remount.

```text
do_filp_open entry -> input filename pointer + string -> establishes kernel-side name before lookup -> driver open entry probe
__d_alloc entry -> copy source pointer (qstr->name) -> driver alloc entry probe
__d_alloc return -> copy destination pointer (dentry->d_name.name) -> driver alloc return probe
do_filp_open return -> returned file name pointer -> ties file to dentry name storage -> driver open return probe
d_lookup entry -> hash, length, name -> defines lookup key used for cache search -> driver lookup entry probe
d_lookup return -> dentry name pointer + string or NULL -> driver lookup return probe
__d_lookup entry -> hash, length, name -> internal lookup path key -> driver __d_lookup probe
__d_lookup_rcu entry -> hash, length, name -> RCU fast-path lookup key -> driver __d_lookup_rcu probe
full_name_hash return -> hash, length, salt, name -> records hash computation (if observed) -> driver hash ret probe
__d_add entry -> dentry name pointer + string -> driver __d_add probe
d_delete entry -> dentry name pointer + string -> driver d_delete probe
__dentry_kill entry -> dentry name pointer + string -> driver __dentry_kill probe
```

`/usr/src/linux-source-6.8.0/fs/dcache.c:1660` memcpy(dname, name->name, name->len);

te_miss: do_filp_open entry pointer = 0xffff8b148256c020 | /tmp/t_e.txt; d_lookup entry hash 3583106372 len 7 name t_e.txt; d_lookup return NULL; __d_alloc entry pointer = 0xffff8b148256c025; __d_alloc return pointer = 0xffff8b14d0cc60f8; __d_add entry pointer = 0xffff8b14d0cc60f8 | t_e.txt; do_filp_open return pointer = 0xffff8b14d0cc60f8 | t_e.txt.
tm_miss: do_filp_open entry pointer = 0xffff8b1480ef5020 | /tmp/t_m.txt; d_lookup entry hash 502501587 len 7 name t_m.txt; d_lookup return NULL; __d_alloc entry pointer = 0xffff8b1480ef5025; __d_alloc return pointer = 0xffff8b148d58d3f8; __d_add entry pointer = 0xffff8b148d58d3f8 | t_m.txt.
lm_miss: do_filp_open entry pointer = 0xffff8b1482462020 | l_m.txt; d_lookup entry hash 2257632620 len 7 name l_m.txt; d_lookup return NULL; __d_alloc entry pointer = 0xffff8b1482462020; __d_alloc return pointer = 0xffff8b14a70b6278; __d_add entry pointer = 0xffff8b14a70b6278 | l_m.txt.
a_miss: do_filp_open entry pointer = 0xffff8b148256b020 | /mnt/loopfs/a.txt; d_lookup entry hash 2244109168 len 5 name a.txt; d_lookup return NULL; __d_alloc entry pointer = 0xffff8b148256b02c; __d_alloc return pointer = 0xffff8b14d0cc8e78; __d_add entry pointer = 0xffff8b14d0cc8e78 | a.txt; do_filp_open return pointer = 0xffff8b14d0cc8e78 | a.txt.
pre-eviction hit: d_lookup return pointer = 0xffff8b149e4886f8 | l_e.txt; d_lookup return pointer = 0xffff8b149e488cf8 | t_e.txt.
d_delete entry = 0xffff8b149e4886f8 | l_e.txt; d_delete entry = 0xffff8b149e488cf8 | t_e.txt.
__dentry_kill entry = 0xffff8b149e4886f8 | l_e.txt; __dentry_kill entry = 0xffff8b149e488cf8 | t_e.txt.
__d_alloc return pointer = 0xffff8b14a712db78; __d_add entry pointer = 0xffff8b14a712db78 | t_e.txt; do_filp_open return pointer = 0xffff8b14a712db78 | t_e.txt.
do_filp_open return pointer = 0xffff8b148a31f878 | l_e.txt.

```c
char n4[] = "l_m.txt";

f[4] = open(n4, O_RDONLY);
```

do_filp_open entry pointer = 0xffff8bd546392020 | l_m.txt
d_lookup entry: hash 2166850383 length 7 name l_m.txt
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd546392020
__d_alloc return pointer = 0xffff8bd728c76938
__d_add entry: 0xffff8bd728c76938 | l_m.txt

The entry pointer 0xffff8bd546392020 is f->name from do_filp_open entry (trace_do_filp_open.c: open_entry). Its type is const char * inside struct filename (include/linux/fs.h). The printed string is l_m.txt, so the kernel pathname buffer begins at that address and the filename part begins at the same address because there is no prefix. The lookup key is l_m.txt with length 7 and hash 2166850383, and d_lookup reads qstr->len and qstr->name (include/linux/dcache.h, fs/dcache.c), so the lookup uses 7 bytes. The lookup returns NULL, so there is no cached entry for that key. The allocation source pointer is 0xffff8bd546392020, which equals the pathname buffer start, so qstr->name points to the filename part in that buffer. The allocation return pointer is 0xffff8bd728c76938, which is dentry->d_name.name (struct dentry in include/linux/dcache.h) returned by __d_alloc. The insert line uses 0xffff8bd728c76938, so that same dentry name pointer is inserted into the dcache hash for l_m.txt.

```c
char n2[] = "/tmp/t_e.txt";
close(creat(n2, 0644));
drop_caches_if_root();
sleep(1);

f[1] = open(n2, O_RDONLY);
```

`|` separates pointer value (left) and the string read from that pointer (right).
do_filp_open entry pointer = 0xffff8bd546392020 | /tmp/t_e.txt
d_lookup entry: hash 1830572521 length 7 name t_e.txt
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd546392025
__d_alloc return pointer = 0xffff8bd728c76338
__d_add entry: 0xffff8bd728c76338 | t_e.txt
do_filp_open return pointer = 0xffff8bd728c76338 | t_e.txt
"/tmp/t_e.txt" @ 0xffff8bd546392020 -> d_lookup (t_e.txt, 7, 1830572521) -> NULL -> __d_alloc entry 0xffff8bd546392025 -> __d_alloc return 0xffff8bd728c76338 -> __d_add 0xffff8bd728c76338 -> do_filp_open return 0xffff8bd728c76338.

0xffff8bd546392025 - 0xffff8bd546392020 = 0x5 = 5
"/tmp/" length = 5
0xffff8bd728c76338 = __d_alloc return pointer = __d_add entry pointer = do_filp_open return pointer

In the probe output lines, the part after `|` is the string read from that pointer and printed by the driver.

Path reasoning (t_e.txt).
The entry line prints f->name from the do_filp_open argument (trace_do_filp_open.c: open_entry), so 0xffff8bd546392020 is the kernel-resident pathname buffer for this call.
d_lookup uses qstr->name and qstr->len (`/usr/src/linux-source-6.8.0/fs/dcache.c`, d_lookup/__d_lookup). The entry prints length 7 name t_e.txt; /tmp/t_e.txt is 12 bytes, so the lookup key is the 7‑byte basename, not the full path.
d_lookup return: NULL, so allocation follows.
__d_alloc entry pointer = 0xffff8bd546392025. This equals 0xffff8bd546392020 + 5; 5 is the length of "/tmp/". So qstr->name for __d_alloc points at the filename part after the "/tmp/" prefix in the same kernel buffer.
__d_alloc return pointer = 0xffff8bd728c76338, a different address than 0xffff8bd546392020.
__d_add entry shows 0xffff8bd728c76338 | t_e.txt, the same address as the __d_alloc return pointer.
do_filp_open return pointer = 0xffff8bd728c76338 | t_e.txt.

t_m.txt miss, insert.
```c
char n3[] = "/tmp/t_m.txt";

f[2] = open(n3, O_RDONLY);
```

do_filp_open entry pointer = 0xffff8bd546392020 | /tmp/t_m.txt
d_lookup entry: hash 2543581516 length 7 name t_m.txt
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd546392025
__d_alloc return pointer = 0xffff8bd728c763f8
__d_add entry: 0xffff8bd728c763f8 | t_m.txt
"/tmp/t_m.txt" @ 0xffff8bd546392020 -> d_lookup (t_m.txt, 7, 2543581516) -> NULL -> __d_alloc entry 0xffff8bd546392025 -> __d_alloc return 0xffff8bd728c763f8 -> __d_add 0xffff8bd728c763f8.

0xffff8bd546392025 - 0xffff8bd546392020 = 0x5 = 5
"/tmp/" length = 5

The entry pointer is 0xffff8bd546392020 and the string is /tmp/t_m.txt, so the kernel copy for this call is fixed to that address. The lookup key is t_m.txt with length 7 and hash 2543581516, so the lookup uses 7 bytes and not 12. The lookup returns NULL, so the cache has no entry for that key at this time. The allocation source pointer is 0xffff8bd546392025, which is 0xffff8bd546392020 + 5; that 5 matches the length of "/tmp/", so the copy source begins at the filename part after the "/tmp/" prefix in the same string. The allocation return pointer is 0xffff8bd728c763f8, which is distinct from 0xffff8bd546392020. The insert line uses 0xffff8bd728c763f8, so the same new address is placed into the dcache.

a.txt miss, memcpy, insert (loopback ext2).
```c
char n5[] = "/mnt/loopfs/a.txt";

f[5] = open(n5, O_RDONLY);
```

do_filp_open entry pointer = 0xffff8bd546392020 | /mnt/loopfs/a.txt
d_lookup entry: hash 3711754354 length 5 name a.txt
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd54639202c
__d_alloc return pointer = 0xffff8bd728c76cf8
__d_add entry: 0xffff8bd728c76cf8 | a.txt
do_filp_open return pointer = 0xffff8bd728c76cf8 | a.txt

0xffff8bd54639202c - 0xffff8bd546392020 = 0xC = 12
"/mnt/loopfs/" length = 12
0xffff8bd728c76cf8 = __d_alloc return pointer = __d_add entry pointer = do_filp_open return pointer

The entry pointer is 0xffff8bd546392020 and the string is /mnt/loopfs/a.txt. The lookup key is a.txt with length 5 and hash 3711754354, so the lookup uses 5 bytes. The lookup returns NULL, so the cache has no entry for that key. The allocation source pointer is 0xffff8bd54639202c, which is 0xffff8bd546392020 + 12, so the filename part starts after the 12‑byte prefix /mnt/loopfs/. The allocation return pointer is 0xffff8bd728c76cf8. The insert line uses 0xffff8bd728c76cf8, and the return line matches it.

Cache hit: l_e.txt and t_e.txt before deletion.
```c
char n1[] = "l_e.txt";
char n2[] = "/tmp/t_e.txt";

// first opens happen earlier
f[3] = open(n1, O_RDONLY);

// later opens hit cache
f[0] = open(n1, O_RDONLY);
f[1] = open(n2, O_RDONLY);
```

d_lookup entry: hash 440978933 length 7 name l_e.txt
d_lookup return: 0xffff8bd7e94c8578 | l_e.txt
d_lookup entry: hash 1830572521 length 7 name t_e.txt
d_lookup return: 0xffff8bd728c76338 | t_e.txt

0xffff8bd7e94c8578 = earlier l_e.txt return pointer
0xffff8bd728c76338 = earlier t_e.txt return pointer

The lookup for l_e.txt returns 0xffff8bd7e94c8578, which equals the earlier return pointer for l_e.txt. The lookup for t_e.txt returns 0xffff8bd728c76338, which equals the earlier return pointer for t_e.txt.

Cache deletion via unlink.
```c
unlink("l_e.txt");
unlink("/tmp/t_e.txt");
```

d_delete entry from d_delete_entry: 0xffff8bd7e94c8578 | l_e.txt
d_delete entry from d_delete_entry: 0xffff8bd728c76338 | t_e.txt
no d_drop entry lines observed in this run

0xffff8bd7e94c8578 = cached l_e.txt pointer from hit
0xffff8bd728c76338 = cached t_e.txt pointer from hit

The delete line for l_e.txt uses 0xffff8bd7e94c8578. The delete line for t_e.txt uses 0xffff8bd728c76338. No d_drop line appears in this run.

Cache eviction via drop_caches.
```c
drop_caches_if_root();
// writes "2\n" to /proc/sys/vm/drop_caches
```

do_filp_open entry pointer = 0xffff8bd546392020 | /proc/sys/vm/drop_caches
do_filp_open return pointer = 0xffff8bd6fce05db8 | drop_caches
__dentry_kill entry from dentry_kill_entry: 0xffff8bd728c763f8 | t_m.txt
__dentry_kill entry from dentry_kill_entry: 0xffff8bd728c76938 | l_m.txt
__dentry_kill entry from dentry_kill_entry: 0xffff8bd7e94c8578 | l_e.txt
__dentry_kill entry from dentry_kill_entry: 0xffff8bd728c76338 | t_e.txt
__dentry_kill entry from dentry_kill_entry: 0xffff8bd728c76cf8 | a.txt
matrix_open (129968): drop_caches: 2
With split programs, this line will show the comm of the program that writes drop_caches (evict.c).

0xffff8bd728c763f8 = t_m.txt pointer
0xffff8bd728c76938 = l_m.txt pointer
0xffff8bd7e94c8578 = l_e.txt pointer
0xffff8bd728c76338 = t_e.txt pointer
0xffff8bd728c76cf8 = a.txt pointer

The control file open is 0xffff8bd546392020 | /proc/sys/vm/drop_caches and returns 0xffff8bd6fce05db8 | drop_caches. The eviction lines show __dentry_kill for the five pointers above.

Cache rebuild after eviction: t_e.txt.
```c
drop_caches_if_root();
sleep(1);

// reopen after eviction
f[0] = open("l_e.txt", O_RDONLY);
f[1] = open("/tmp/t_e.txt", O_RDONLY);
```

d_lookup entry: hash 1830572521 length 7 name t_e.txt
__d_alloc entry pointer = 0xffff8bd546392025
__d_alloc return pointer = 0xffff8bd728c76338
__d_add entry: 0xffff8bd728c76338 | t_e.txt
do_filp_open return pointer = 0xffff8bd728c76338 | t_e.txt

Restated pre-eviction t_e.txt pointer used for inequality: do_filp_open return pointer =
0xffff8bd728c76338 | t_e.txt

0xffff8bd728c76338 = 0xffff8bd728c76338

The post-eviction lookup for t_e.txt returns 0xffff8bd728c76338, which equals the pre-eviction pointer 0xffff8bd728c76338 in this run.

Post-eviction lookup for l_e.txt
```c
drop_caches_if_root();
sleep(1);

// reopen after eviction
f[0] = open("l_e.txt", O_RDONLY);
```

do_filp_open entry pointer = 0xffff8bd546392020 | l_e.txt
__d_lookup_rcu entry from lookup_rcu_entry: hash 440978933 length 7 name l_e.txt
do_filp_open return pointer = 0xffff8bd7e94c8db8 | l_e.txt

Restated pre-eviction l_e.txt pointer used for inequality: do_filp_open return pointer =
0xffff8bd7e94c8578 | l_e.txt

0xffff8bd7e94c8db8 != 0xffff8bd7e94c8578

The post-eviction lookup uses __d_lookup_rcu with hash 440978933 length 7 name l_e.txt, then returns 0xffff8bd7e94c8db8.

Hash keys used in Run A.
```c
// these names are opened in this run:
open("l_e.txt", O_RDONLY);
open("/tmp/t_e.txt", O_RDONLY);
open("l_m.txt", O_RDONLY);
open("/tmp/t_m.txt", O_RDONLY);
open("/mnt/loopfs/a.txt", O_RDONLY);
```

d_lookup entry: hash 440978933 length 7 name l_e.txt
d_lookup entry: hash 1830572521 length 7 name t_e.txt
d_lookup entry: hash 2166850383 length 7 name l_m.txt
d_lookup entry: hash 2543581516 length 7 name t_m.txt
d_lookup entry: hash 3711754354 length 5 name a.txt

Each hash line is printed at lookup entry with name and length, so each hash is tied to the exact key shown: l_e.txt (7, 440978933), t_e.txt (7, 1830572521), l_m.txt (7, 2166850383), t_m.txt (7, 2543581516), a.txt (5, 3711754354).

Run B: minimal_open (target_comm=minimal_open)

Long filename: allocation, copy, cache hit.
```c
snprintf(filename, sizeof(filename),
         "test_file_very_long_name_to_force_external_allocation_%ld", now);
int fd = open(filename, O_RDWR | O_CREAT, 0644);
sleep(5);
```

do_filp_open entry pointer = 0xffff8bd55197c020 | test_file_very_long_name_to_force_external_allocation_1770418995
d_lookup entry: hash 3008531989 length 64 name test_file_very_long_name_to_force_external_allocation_1770418995
d_lookup return: NULL
__d_alloc entry pointer = 0xffff8bd55197c020
__d_alloc return pointer = 0xffff8bd556040f18
__d_add entry: 0xffff8bd556040f18 | test_file_very_long_name_to_force_external_allocation_1770418995
do_filp_open return pointer = 0xffff8bd556040f18 | test_file_very_long_name_to_force_external_allocation_1770418995
d_lookup return: 0xffff8bd556040f18 | test_file_very_long_name_to_force_external_allocation_1770418995

0xffff8bd556040f18 = __d_alloc return pointer = __d_add entry pointer = do_filp_open return pointer = d_lookup return pointer

The entry pointer is 0xffff8bd55197c020 and the string is the full long filename, so the kernel copy is fixed to that address. The lookup key is the long filename with length 64 and hash 3008531989, so the key and length are explicit. The lookup returns NULL, so the cache has no entry for that key on first use. The allocation source pointer is 0xffff8bd55197c020, which equals the string pointer, so the copy source is the start of the long name. The allocation return pointer is 0xffff8bd556040f18, which is new storage. The insert line uses 0xffff8bd556040f18, and the return line matches it. The later d_lookup return line also returns 0xffff8bd556040f18, so the cache hit reuses the same pointer. The equality chain is 0xffff8bd556040f18 = __d_alloc return = __d_add entry = do_filp_open return = d_lookup return.

__d_alloc entry pointer = 0xffff8bd546392025 __d_alloc return pointer =
0xffff8bd728c76338 __d_add entry: 0xffff8bd728c76338 | t_e.txt do_filp_open return pointer =
0xffff8bd728c76338 | t_e.txt

0xffff8bd728c76338 = __d_alloc return pointer 0xffff8bd728c76338 = __d_add entry pointer
0xffff8bd728c76338 = do_filp_open return pointer

__d_alloc entry pointer = 0xffff8bd54639202c __d_alloc return pointer =
0xffff8bd728c76cf8 __d_add entry: 0xffff8bd728c76cf8 | a.txt do_filp_open return pointer =
0xffff8bd728c76cf8 | a.txt

0xffff8bd728c76cf8 = __d_alloc return pointer 0xffff8bd728c76cf8 = __d_add entry pointer
0xffff8bd728c76cf8 = do_filp_open return pointer

__d_alloc entry pointer = 0xffff8bd55197c020 __d_alloc return pointer =
0xffff8bd556040f18 __d_add entry: 0xffff8bd556040f18 |
test_file_very_long_name_to_force_external_allocation_1770418995 do_filp_open return pointer =
0xffff8bd556040f18 | test_file_very_long_name_to_force_external_allocation_1770418995

0xffff8bd556040f18 = __d_alloc return pointer 0xffff8bd556040f18 = __d_add entry pointer
0xffff8bd556040f18 = do_filp_open return pointer

d_lookup return: NULL __d_add entry: 0xffff8bd728c76338 | t_e.txt

d_lookup return: NULL __d_add entry: 0xffff8bd728c763f8 | t_m.txt

d_lookup return: NULL __d_add entry: 0xffff8bd728c76938 | l_m.txt

d_lookup return: NULL __d_add entry: 0xffff8bd728c76cf8 | a.txt

d_lookup return: NULL __d_add entry: 0xffff8bd556040f18 |
test_file_very_long_name_to_force_external_allocation_1770418995

d_lookup return: NULL (t_e.txt) d_lookup return: NULL (t_m.txt) d_lookup return: NULL
(l_m.txt) d_lookup return: NULL (a.txt) d_lookup return: NULL (long filename)

d_lookup entry: hash 440978933 length 7 name l_e.txt d_lookup return: 0xffff8bd7e94c8578 |
l_e.txt

d_lookup entry: hash 1830572521 length 7 name t_e.txt
d_lookup return: 0xffff8bd728c76338 | t_e.txt

d_lookup entry: hash 3008531989 length 64 name
test_file_very_long_name_to_force_external_allocation_1770418995 d_lookup return pointer =
0xffff8bd556040f18

d_delete entry: 0xffff8bd7e94c8578 | l_e.txt d_delete entry: 0xffff8bd728c76338 | t_e.txt

do_filp_open entry pointer = 0xffff8bd546392020 | /proc/sys/vm/drop_caches do_filp_open
return pointer = 0xffff8bd6fce05db8 | drop_caches __dentry_kill entry: 0xffff8bd7e94c8578 | l_e.txt
__dentry_kill entry: 0xffff8bd728c76338 | t_e.txt __dentry_kill entry: 0xffff8bd728c763f8 | t_m.txt
__dentry_kill entry: 0xffff8bd728c76938 | l_m.txt __dentry_kill entry: 0xffff8bd728c76cf8 | a.txt

d_lookup entry: hash 1830572521 length 7 name t_e.txt d_lookup return: NULL __d_alloc
entry pointer = 0xffff8bd546392025 __d_alloc return pointer = 0xffff8bd728c76338 __d_add entry:
0xffff8bd728c76338 | t_e.txt do_filp_open return pointer = 0xffff8bd728c76338 | t_e.txt

d_lookup entry: hash 3008531989 length 64 name
test_file_very_long_name_to_force_external_allocation_1770418995 d_lookup return: NULL __d_alloc
entry pointer = 0xffff8bd55197c020 __d_alloc return pointer = 0xffff8bd556040f18 __d_add entry:
0xffff8bd556040f18 | test_file_very_long_name_to_force_external_allocation_1770418995 do_filp_open
return pointer = 0xffff8bd556040f18 |
test_file_very_long_name_to_force_external_allocation_1770418995

d_lookup entry: hash 3711754354 length 5 name a.txt d_lookup return: NULL __d_alloc entry
pointer = 0xffff8bd54639202c __d_alloc return pointer = 0xffff8bd728c76cf8 __d_add entry:
0xffff8bd728c76cf8 | a.txt do_filp_open return pointer = 0xffff8bd728c76cf8 | a.txt

0xffff8bd54639202c - 0xffff8bd546392020 = 0xC = 12 "/mnt/loopfs/" length = 12

Post-eviction l_e.txt lookup/return without __d_add shown below
```text
sudo dmesg | rg -n "__d_lookup_rcu entry:.*l_e.txt|\[O\] OUT: .*l_e.txt"
15:[33032.402797] __d_lookup_rcu entry: hash 440978933 length 7 name l_e.txt
17:[33032.402853] do_filp_open return pointer = 0xffff8bd54e0c74b8 | l_e.txt
35:[33033.423905] __d_lookup_rcu entry: hash 440978933 length 7 name l_e.txt
37:[33033.423931] do_filp_open return pointer = 0xffff8bd7e94c8578 | l_e.txt
149:[33036.444278] __d_lookup_rcu entry: hash 440978933 length 7 name l_e.txt
151:[33036.444304] do_filp_open return pointer = 0xffff8bd7e94c8db8 | l_e.txt
```

Repeated __d_lookup_rcu entries show the lookup key for l_e.txt after eviction, and the do_filp_open return pointer lines show the return pointer seen by do_filp_open. The change from 0xffff8bd7e94c8578 to 0xffff8bd7e94c8db8 records a new return pointer after eviction without an __d_add line in this run.
