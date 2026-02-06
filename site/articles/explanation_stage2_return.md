---
layout: default
title: "Stage 2 Return"
---

Abstract

We measure the filename string as it passes through do_filp_open and the dentry cache. We record
input pointers, copy source and destination, return pointers, cache hits, hash values, explicit
cache insert events via __d_add, and cache removal events via d_delete and __dentry_kill. We also
add a loopback filesystem case with a short name to show a distinct filesystem path and use
drop_caches to trigger eviction. All conclusions in this document are derived from the recorded
probe lines shown below.

Prior Work

Stage 1: https://raikrahul.github.io/what-happens-when-open-is-called/stage1.html
Stage 2 Entry: https://raikrahul.github.io/what-happens-when-open-is-called/stage2.html
Worksheet: https://raikrahul.github.io/what-happens-when-open-is-called/articles/worksheet_stage2_return.html

Introduction

The goal of this stage is concrete: identify where the filename string ends up at return time using
recorded probe data. The measurement includes both allocation and cache paths and the hash values
used for lookup. The test programs are designed to produce both paths in one run, and a loopback
filesystem test adds a distinct filesystem path and a short name.

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
See inline `//` comments in `kernel/user/stage2/matrix_open.c` for the per-line purpose. Each open,
unlink, and drop_caches call is annotated directly next to the code line so this block is not
needed here.

Loopback filesystem test:

- 64M loopback file formatted as ext2
- mounted at /mnt/loopfs
- a.txt created, sync, unmount, remount

Probe map (clearer, with reason and proof anchor)

| Probe | Observed field | Why it matters | Proof anchor |
| --- | --- | --- | --- |
| do_filp_open entry | input filename pointer + string | establishes kernel-side name before lookup | driver open entry probe |
| __d_alloc entry | copy source pointer | shows which basename string is copied | driver alloc entry probe |
| __d_alloc return | copy destination pointer | identifies new dentry name storage | driver alloc return probe |
| do_filp_open return | returned file name pointer | ties file to dentry name storage | driver open return probe |
| d_lookup entry | hash, length, name | defines lookup key used for cache search | driver lookup entry probe |
| d_lookup return | dentry name pointer or NULL | proves hit or miss | driver lookup return probe |
| __d_lookup entry | hash, length, name | internal lookup path key | driver __d_lookup probe |
| __d_lookup_rcu entry | hash, length, name | RCU fast-path lookup key | driver __d_lookup_rcu probe |
| full_name_hash return | hash, length, salt, name | records hash computation (if observed) | driver hash ret probe |
| __d_add entry | dentry name pointer | proves cache insert | driver __d_add probe |
| d_delete entry | dentry name pointer | proves unlink removal | driver d_delete probe |
| __dentry_kill entry | dentry name pointer | proves eviction via drop_caches | driver __dentry_kill probe |

Memcpy proof (kernel source)

File: /usr/src/linux-source-6.8.0/fs/dcache.c:1660 memcpy(dname, name->name, name->len);

Chains (real data, in order)

1) memcpy chain (t_e.txt, copy source -> destination)
```text
"/tmp/t_e.txt" @ 0xffff8bd55debc020 -> __d_alloc entry 0xffff8bd55debc025 -> __d_alloc return 0xffff8bd572708638
```

2) cache build-up chain (t_e.txt, miss -> insert)
```text
d_lookup return NULL -> __d_add 0xffff8bd572708638 -> do_filp_open return 0xffff8bd572708638
```

3) cache hit chain (t_e.txt, later lookup)
```text
d_lookup return 0xffff8bd572708638 -> do_filp_open return 0xffff8bd572708638
```

4) cache miss chain (t_m.txt, missing)
```text
"/tmp/t_m.txt" -> d_lookup return NULL -> __d_add 0xffff8bd5727080f8
```

5) cache delete chain (unlink)
```text
d_delete 0xffff8bd55868a0f8 (l_e.txt) + d_delete 0xffff8bd572708638 (t_e.txt)
```

Later phases start after this: eviction (__dentry_kill) and rebuild after eviction.

Table of Contents

1. Results: Run A (matrix_open) proofs A1–A10
2. Results: Run B (minimal_open) proof B1
3. Proof map (claims to evidence)
4. Discussion
5. Conclusion
6. Full Proofs (No Data Removed)
7. What We Failed To Observe And Why

Results

Run A: matrix_open (root, drop_caches enabled)

Research Narrative (Run A)

This section preserves every pointer, address, and line from the trace while adding the logical
structure expected of a research textbook. Each claim is followed by direct evidence and a
derivation that uses only the data printed above.

Claim A1. Cache miss, memcpy, and insert for t_e.txt.

User-space code that triggers this evidence (matrix_open.c):
```c
char n2[] = "/tmp/t_e.txt";
close(creat(n2, 0644));
drop_caches_if_root();
sleep(1);

f[1] = open(n2, O_RDONLY);
```

Kernel evidence: do_filp_open entry pointer = 0xffff8bd55debc020 | /tmp/t_e.txt d_lookup entry: hash
1830572521 length 7 name t_e.txt d_lookup return: NULL __d_alloc entry pointer = 0xffff8bd55debc025
__d_alloc return pointer = 0xffff8bd572708638 __d_add entry: 0xffff8bd572708638 | t_e.txt
do_filp_open return pointer = 0xffff8bd572708638 | t_e.txt

Pointer meanings (t_e.txt):
- do_filp_open entry pointer 0xffff8bd55debc020 points to the kernel-side string "/tmp/t_e.txt" used for this open call.
- d_lookup entry uses the basename "t_e.txt" (length 7) and hash 1830572521 as the lookup key for this path.
- d_lookup return: NULL means no cached dentry matched that key.
- __d_alloc entry pointer 0xffff8bd55debc025 points to the basename start inside the same string (after "/tmp/").
- __d_alloc return pointer 0xffff8bd572708638 points to newly allocated dentry name storage.
- __d_add entry pointer 0xffff8bd572708638 shows that same storage inserted into the dcache hash.
- do_filp_open return pointer 0xffff8bd572708638 shows the returned file points at that dentry name storage.

Function-by-function explanation (t_e.txt path):
- do_filp_open entry: entry point for VFS open; receives the kernel-side filename string. The pointer 0xffff8bd55debc020 is set by getname() before lookup and points to "/tmp/t_e.txt".
- d_lookup entry: dcache lookup using key (name, length, hash). The key is derived from basename "t_e.txt" with length 7 and hash 1830572521.
- d_lookup return: NULL indicates a cache miss for that key in the parent directory.
- __d_alloc entry: allocates a new dentry and copies the basename. The pointer 0xffff8bd55debc025 is the basename start inside "/tmp/t_e.txt" (prefix length 5).
- __d_alloc return: returns the new dentry; 0xffff8bd572708638 is the allocated dentry name storage.
- __d_add entry: inserts the new dentry into the dcache; the same pointer 0xffff8bd572708638 is what gets hashed into the cache.
- do_filp_open return: returns a struct file whose f_path.dentry->d_name.name equals 0xffff8bd572708638, tying the file to the copied name.

Compat explanation (t_e.txt, compact):
"/tmp/t_e.txt" @ 0xffff8bd55debc020 -> do_filp_open entry -> d_lookup (t_e.txt, 7, 1830572521) miss
-> __d_alloc entry 0xffff8bd55debc025 (basename) -> __d_alloc return 0xffff8bd572708638
-> __d_add 0xffff8bd572708638 -> do_filp_open return 0xffff8bd572708638.

Derivation (user-space trigger and why): User-space code:
```c
char n2[] = "/tmp/t_e.txt";
close(creat(n2, 0644));
drop_caches_if_root();
sleep(1);

f[1] = open(n2, O_RDONLY);
```
Why this creates the pointer subtraction:
- The open string is "/tmp/t_e.txt".
- The basename starts after the 5-byte prefix "/tmp/".
- The basename pointer equals the original pointer plus 5.

Derivation (data): 0xffff8bd55debc025 - 0xffff8bd55debc020 = 0x5 = 5 "/tmp/" length = 5
0xffff8bd572708638 = __d_alloc return pointer 0xffff8bd572708638 = __d_add entry pointer
0xffff8bd572708638 = do_filp_open return pointer

Claim A2. Cache miss and insert for missing t_m.txt.

This claim isolates a missing /tmp file to record a miss and insert with a basename offset.

User-space code that triggers this evidence (matrix_open.c):
```c
char n3[] = "/tmp/t_m.txt";

f[2] = open(n3, O_RDONLY);
```

Kernel evidence: do_filp_open entry pointer = 0xffff8bd55debc020 | /tmp/t_m.txt d_lookup entry: hash
2543581516 length 7 name t_m.txt d_lookup return: NULL __d_alloc entry pointer = 0xffff8bd55debc025
__d_alloc return pointer = 0xffff8bd5727080f8 __d_add entry: 0xffff8bd5727080f8 | t_m.txt

Pointer meanings (t_m.txt):
- do_filp_open entry pointer 0xffff8bd55debc020 points to "/tmp/t_m.txt" in kernel memory for this open.
- d_lookup entry hash 2543581516 and length 7 use basename "t_m.txt" as the key.
- d_lookup return: NULL shows no cached dentry matched.
- __d_alloc entry pointer 0xffff8bd55debc025 points to basename start after "/tmp/".
- __d_alloc return pointer 0xffff8bd5727080f8 is the newly allocated dentry name storage.
- __d_add entry pointer 0xffff8bd5727080f8 inserts that name storage into the dcache as a negative entry.

Basename explanation (t_m.txt):
- A pathname is split into parent directory + basename. For "/tmp/t_m.txt", the parent is "/tmp/" and the basename is "t_m.txt".
- The dcache lookup and name copy operate on the basename, not the full path. That is why the copy source pointer is not the full string pointer.
- __d_alloc entry pointer is the basename start inside the same string, so it equals the full string pointer + 5 ("/tmp/" length).
- __d_alloc return pointer is new dentry name storage allocated by __d_alloc; __d_add inserts that same storage into the cache.

Compat explanation (t_m.txt, compact):
"/tmp/t_m.txt" @ 0xffff8bd55debc020 -> d_lookup (t_m.txt, 7, 2543581516) miss -> __d_alloc entry
0xffff8bd55debc025 (basename) -> __d_alloc return 0xffff8bd5727080f8 -> __d_add 0xffff8bd5727080f8.

Claim A3. Cache miss and insert for missing l_m.txt.

This claim repeats the missing-file case without a prefix to show the entry pointer equals the full
string start.

User-space code that triggers this evidence (matrix_open.c):
```c
char n4[] = "l_m.txt";

f[4] = open(n4, O_RDONLY);
```

Kernel evidence: do_filp_open entry pointer = 0xffff8bd55debc020 | l_m.txt d_lookup entry: hash
2166850383 length 7 name l_m.txt d_lookup return: NULL __d_alloc entry pointer = 0xffff8bd55debc020
__d_alloc return pointer = 0xffff8bd572708878 __d_add entry: 0xffff8bd572708878 | l_m.txt

Pointer meanings (l_m.txt):
- do_filp_open entry pointer 0xffff8bd55debc020 points to "l_m.txt" for this open.
- d_lookup entry hash 2166850383 and length 7 use basename "l_m.txt" as the key.
- d_lookup return: NULL shows no cached dentry matched.
- __d_alloc entry pointer 0xffff8bd55debc020 equals the string start (no prefix).
- __d_alloc return pointer 0xffff8bd572708878 is the newly allocated dentry name storage.
- __d_add entry pointer 0xffff8bd572708878 inserts that name storage into the dcache as a negative entry.

Claim A4. Cache miss, memcpy, and insert for a.txt on loopback ext2.

This claim moves the same mechanism onto a different filesystem and a shorter basename.

User-space code that triggers this evidence (matrix_open.c):
```c
char n5[] = "/mnt/loopfs/a.txt";

f[5] = open(n5, O_RDONLY);
```

Kernel evidence: do_filp_open entry pointer = 0xffff8bd55debc020 | /mnt/loopfs/a.txt d_lookup entry:
hash 3711754354 length 5 name a.txt d_lookup return: NULL __d_alloc entry pointer =
0xffff8bd55debc02c __d_alloc return pointer = 0xffff8bd572708b78 __d_add entry: 0xffff8bd572708b78 |
a.txt do_filp_open return pointer = 0xffff8bd572708b78 | a.txt

Pointer meanings (a.txt):
- do_filp_open entry pointer 0xffff8bd55debc020 points to "/mnt/loopfs/a.txt" in kernel memory for this open.
- d_lookup entry hash 3711754354 and length 5 use basename "a.txt" as the key.
- d_lookup return: NULL shows no cached dentry matched.
- __d_alloc entry pointer 0xffff8bd55debc02c points to basename start after "/mnt/loopfs/".
- __d_alloc return pointer 0xffff8bd572708b78 is the newly allocated dentry name storage.
- __d_add entry pointer 0xffff8bd572708b78 inserts that name storage into the dcache.
- do_filp_open return pointer 0xffff8bd572708b78 shows the returned file points at that dentry name storage.

Derivation: 0xffff8bd55debc02c - 0xffff8bd55debc020 = 0xC = 12 "/mnt/loopfs/" length = 12
0xffff8bd572708b78 = __d_alloc return pointer 0xffff8bd572708b78 = __d_add entry pointer
0xffff8bd572708b78 = do_filp_open return pointer

Claim A5. Cache hit for l_e.txt and t_e.txt before deletion.

This claim shows reuse: the lookup returns the same pointer observed on the earlier return.

User-space code that triggers this evidence (matrix_open.c):
```c
char n1[] = "l_e.txt";
char n2[] = "/tmp/t_e.txt";

// first opens happen earlier
f[3] = open(n1, O_RDONLY);

// later opens hit cache
f[0] = open(n1, O_RDONLY);
f[1] = open(n2, O_RDONLY);
```

Kernel evidence: d_lookup entry: hash 440978933 length 7 name l_e.txt d_lookup return:
0xffff8bd55868a0f8 | l_e.txt

Pointer meanings (cache hits):
- d_lookup return pointer 0xffff8bd55868a0f8 for l_e.txt matches the earlier return pointer for l_e.txt, so the cached dentry is reused.
- d_lookup return pointer 0xffff8bd572708638 for t_e.txt matches the earlier return pointer for t_e.txt, so the cached dentry is reused.

d_lookup entry: hash 1830572521 length 7 name t_e.txt d_lookup return: 0xffff8bd572708638 | t_e.txt

Claim A6. Cache deletion via unlink.

This claim pins deletion to the explicit unlink calls in user space.

User-space code that triggers this evidence (matrix_open.c):
```c
unlink("l_e.txt");
unlink("/tmp/t_e.txt");
```

Kernel evidence: d_delete entry: 0xffff8bd55868a0f8 | l_e.txt d_delete entry: 0xffff8bd572708638 |
t_e.txt no d_drop entry lines observed in this run

Pointer meanings (deletion):
- d_delete entry pointer 0xffff8bd55868a0f8 names the cached l_e.txt dentry that was removed by unlink.
- d_delete entry pointer 0xffff8bd572708638 names the cached t_e.txt dentry that was removed by unlink.
- no d_drop line means d_delete is the observed removal path for this run.

Claim A7. Cache eviction via drop_caches.

This claim shows eviction driven by a write to /proc/sys/vm/drop_caches.

User-space code that triggers this evidence (matrix_open.c):
```c
drop_caches_if_root();
// writes "2\n" to /proc/sys/vm/drop_caches
```

Kernel evidence: do_filp_open entry pointer = 0xffff8bd543611020 | /proc/sys/vm/drop_caches
do_filp_open return pointer = 0xffff8bd6fce05db8 | drop_caches __dentry_kill entry:
0xffff8bd5727080f8 | t_m.txt __dentry_kill entry: 0xffff8bd572708878 | l_m.txt __dentry_kill entry:
0xffff8bd55868a0f8 | l_e.txt __dentry_kill entry: 0xffff8bd572708638 | t_e.txt __dentry_kill entry:
0xffff8bd572708b78 | a.txt matrix_open (106880): drop_caches: 2

Pointer meanings (eviction):
- do_filp_open entry/return for /proc/sys/vm/drop_caches shows the control write that triggers eviction.
- __dentry_kill entry pointers show eviction of l_e.txt, t_e.txt, t_m.txt, l_m.txt, and a.txt dentries reclaimed by drop_caches.

Claim A8. Cache rebuild after eviction for t_e.txt.

This claim records the pointer observed after eviction and compares it to the pre-eviction pointer.

User-space code that triggers this evidence (matrix_open.c):
```c
drop_caches_if_root();
sleep(1);

// reopen after eviction
f[0] = open("l_e.txt", O_RDONLY);
f[1] = open("/tmp/t_e.txt", O_RDONLY);
```

Kernel evidence: d_lookup entry: hash 1830572521 length 7 name t_e.txt __d_alloc entry pointer =
0xffff8bd543611025 __d_alloc return pointer = 0xffff8bd54429b9f8 __d_add entry: 0xffff8bd54429b9f8 |
t_e.txt do_filp_open return pointer = 0xffff8bd54429b9f8 | t_e.txt

Restated pre-eviction t_e.txt pointer used for inequality: do_filp_open return pointer =
0xffff8bd572708638 | t_e.txt

Pointer meanings (rebuild t_e.txt):
- __d_alloc entry pointer 0xffff8bd55debc025 points to basename "t_e.txt" in the reopened path.
- __d_alloc return pointer 0xffff8bd54429b9f8 is the new dentry name storage after eviction.
- __d_add entry pointer 0xffff8bd54429b9f8 inserts the rebuilt name into the cache.
- do_filp_open return pointer 0xffff8bd54429b9f8 confirms the returned file points at the rebuilt name storage.

Derivation: 0xffff8bd54429b9f8 != 0xffff8bd572708638

Claim A9. Post-eviction lookup observed for l_e.txt.

This claim records the RCU lookup path and the new return pointer after eviction.

User-space code that triggers this evidence (matrix_open.c):
```c
drop_caches_if_root();
sleep(1);

// reopen after eviction
f[0] = open("l_e.txt", O_RDONLY);
```

Kernel evidence: do_filp_open entry pointer = 0xffff8bd543611020 | l_e.txt __d_lookup_rcu entry:
hash 440978933 length 7 name l_e.txt do_filp_open return pointer = 0xffff8bd549b4e1b8 | l_e.txt

Restated pre-eviction l_e.txt pointer used for inequality: do_filp_open return pointer =
0xffff8bd55868a0f8 | l_e.txt

Pointer meanings (post-eviction l_e.txt):
- __d_lookup_rcu entry shows the lookup key for l_e.txt after eviction.
- do_filp_open return pointer 0xffff8bd549b4e1b8 is a new name pointer (not equal to pre-eviction pointer 0xffff8bd55868a0f8).

Derivation: 0xffff8bd549b4e1b8 != 0xffff8bd55868a0f8

Claim A10. Hash keys used in Run A.

This claim summarizes the exact keys hashed for each name observed in this run.

User-space code that triggers this evidence (matrix_open.c):
```c
// these names are opened in this run:
open("l_e.txt", O_RDONLY);
open("/tmp/t_e.txt", O_RDONLY);
open("l_m.txt", O_RDONLY);
open("/tmp/t_m.txt", O_RDONLY);
open("/mnt/loopfs/a.txt", O_RDONLY);
```

Kernel evidence: l_e.txt length 7 hash 440978933 t_e.txt length 7 hash 1830572521 l_m.txt length 7
hash 2166850383 t_m.txt length 7 hash 2543581516 a.txt length 5 hash 3711754354

Pointer meanings (hash keys):
- each d_lookup entry line is printed at lookup entry and therefore corresponds to the exact key string and length hashed for that name in this run.

Run B: minimal_open (target_comm=minimal_open)

This run isolates a single long filename to show the long-name allocation and lookup path in full.

Claim B1. Long filename allocation, copy, and cache hit.

User-space code that triggers this evidence (minimal_open.c):
```c
snprintf(filename, sizeof(filename),
         "test_file_very_long_name_to_force_external_allocation_%ld", now);
int fd = open(filename, O_RDWR | O_CREAT, 0644);
sleep(5);
```

Kernel evidence: do_filp_open entry pointer = 0xffff8bd55337c020 |
test_file_very_long_name_to_force_external_allocation_1770408898 d_lookup entry: hash 3778081590
length 64 name test_file_very_long_name_to_force_external_allocation_1770408898 d_lookup return:
NULL __d_alloc entry pointer = 0xffff8bd55337c020 __d_alloc return pointer = 0xffff8bd7b1f07cd8
__d_add entry: 0xffff8bd7b1f07cd8 | test_file_very_long_name_to_force_external_allocation_1770408898
do_filp_open return pointer = 0xffff8bd7b1f07cd8 |
test_file_very_long_name_to_force_external_allocation_1770408898 d_lookup return: 0xffff8bd7b1f07cd8
| test_file_very_long_name_to_force_external_allocation_1770408898

Pointer meanings (long filename):
- do_filp_open entry pointer 0xffff8bd55337c020 points to the kernel-resident long filename string.
- d_lookup entry hash 3778081590 length 64 shows the lookup key used for the long name.
- d_lookup return: NULL shows the cache miss on first lookup.
- __d_alloc entry pointer 0xffff8bd55337c020 shows the copy source equals the long name pointer.
- __d_alloc return pointer 0xffff8bd7b1f07cd8 is the dentry name storage allocated for the long name.
- __d_add entry pointer 0xffff8bd7b1f07cd8 shows the insert of that long name into the dcache.
- do_filp_open return pointer 0xffff8bd7b1f07cd8 shows the returned file points to that same name storage.
- later d_lookup return pointer 0xffff8bd7b1f07cd8 shows a cache hit on the same name pointer.

Compat explanation (long filename, compact):
do_filp_open entry 0xffff8bd55337c020 -> struct filename.name (kernel string); d_lookup key
("test_file_very_long_name_to_force_external_allocation_1770408898", 64, 3778081590) -> miss;
__d_alloc entry 0xffff8bd55337c020 (copy source) -> __d_alloc return 0xffff8bd7b1f07cd8
(`dentry->d_name.name`, copy destination) -> __d_add inserts 0xffff8bd7b1f07cd8 -> do_filp_open
return points to 0xffff8bd7b1f07cd8 -> later d_lookup return 0xffff8bd7b1f07cd8 (cache hit).

Derivation: 0xffff8bd7b1f07cd8 = __d_alloc return pointer 0xffff8bd7b1f07cd8 = __d_add entry pointer
0xffff8bd7b1f07cd8 = do_filp_open return pointer 0xffff8bd7b1f07cd8 = d_lookup return pointer (cache
hit)


Proof map (claims to evidence)

Memcpy of name into dentry storage: Claim A1, Claim A4, Claim B1

Cache build-up (insert): Claim A1, Claim A2, Claim A3, Claim A4, Claim A8, Claim B1

Cache hit: Claim A5, Claim B1

Cache miss: Claim A1, Claim A2, Claim A3, Claim A4, Claim B1

Cache deletion: Claim A6

Cache eviction: Claim A7

Cache rebuild: Claim A8

Discussion

Every claim above is tied to an explicit probe line and an explicit pointer equality or inequality.
The RCU lookup path is recorded via __d_lookup_rcu for l_e.txt after eviction. Rebuild with explicit
__d_add is recorded for t_e.txt; l_e.txt is only shown with post-eviction lookup and a new return
pointer. The hash values are shown at d_lookup entry (and also at __d_lookup/__d_lookup_rcu) and
therefore define the lookup key used in each case.

Conclusion

The data lines below are used to derive the copy/insert/lookup/delete/evict/rebuild relationships
stated in the claims. For l_e.txt after eviction, the lookup is observed on the RCU path and returns
a new pointer, but an explicit insert line is not observed in this run.

Full Proofs (No Data Removed)

Proof 1. memcpy of filename into dentry storage.

Evidence (t_e.txt): __d_alloc entry pointer = 0xffff8bd55debc025 __d_alloc return pointer =
0xffff8bd572708638 __d_add entry: 0xffff8bd572708638 | t_e.txt do_filp_open return pointer =
0xffff8bd572708638 | t_e.txt

Derivation: 0xffff8bd572708638 = __d_alloc return pointer 0xffff8bd572708638 = __d_add entry pointer
0xffff8bd572708638 = do_filp_open return pointer

Evidence (a.txt): __d_alloc entry pointer = 0xffff8bd55debc02c __d_alloc return pointer =
0xffff8bd572708b78 __d_add entry: 0xffff8bd572708b78 | a.txt do_filp_open return pointer =
0xffff8bd572708b78 | a.txt

Derivation: 0xffff8bd572708b78 = __d_alloc return pointer 0xffff8bd572708b78 = __d_add entry pointer
0xffff8bd572708b78 = do_filp_open return pointer

Evidence (long filename): __d_alloc entry pointer = 0xffff8bd55337c020 __d_alloc return pointer =
0xffff8bd7b1f07cd8 __d_add entry: 0xffff8bd7b1f07cd8 |
test_file_very_long_name_to_force_external_allocation_1770408898 do_filp_open return pointer =
0xffff8bd7b1f07cd8 | test_file_very_long_name_to_force_external_allocation_1770408898

Derivation: 0xffff8bd7b1f07cd8 = __d_alloc return pointer 0xffff8bd7b1f07cd8 = __d_add entry pointer
0xffff8bd7b1f07cd8 = do_filp_open return pointer

Proof 2. Cache build-up (insert) on miss.

Evidence: d_lookup return: NULL __d_add entry: 0xffff8bd572708638 | t_e.txt

d_lookup return: NULL __d_add entry: 0xffff8bd5727080f8 | t_m.txt

d_lookup return: NULL __d_add entry: 0xffff8bd572708878 | l_m.txt

d_lookup return: NULL __d_add entry: 0xffff8bd572708b78 | a.txt

d_lookup return: NULL __d_add entry: 0xffff8bd7b1f07cd8 |
test_file_very_long_name_to_force_external_allocation_1770408898

Proof 3. Cache miss.

Evidence: d_lookup return: NULL (t_e.txt) d_lookup return: NULL (t_m.txt) d_lookup return: NULL
(l_m.txt) d_lookup return: NULL (a.txt) d_lookup return: NULL (long filename)

Proof 4. Cache hit.

Evidence: d_lookup entry: hash 440978933 length 7 name l_e.txt d_lookup return: 0xffff8bd55868a0f8 |
l_e.txt

d_lookup entry: hash 1830572521 length 7 name t_e.txt d_lookup return: 0xffff8bd572708638 | t_e.txt

d_lookup entry: hash 3778081590 length 64 name
test_file_very_long_name_to_force_external_allocation_1770408898 d_lookup return pointer =
0xffff8bd7b1f07cd8

Proof 5. Cache delete.

Evidence: d_delete entry: 0xffff8bd55868a0f8 | l_e.txt d_delete entry: 0xffff8bd572708638 | t_e.txt

Proof 5b. Cache eviction (drop_caches).

Evidence: do_filp_open entry pointer = 0xffff8bd543611020 | /proc/sys/vm/drop_caches do_filp_open
return pointer = 0xffff8bd6fce05db8 | drop_caches __dentry_kill entry: 0xffff8bd55868a0f8 | l_e.txt
__dentry_kill entry: 0xffff8bd572708638 | t_e.txt __dentry_kill entry: 0xffff8bd5727080f8 | t_m.txt
__dentry_kill entry: 0xffff8bd572708878 | l_m.txt __dentry_kill entry: 0xffff8bd572708b78 | a.txt

Proof 5c. Cache rebuild after eviction (t_e.txt).

Evidence: d_lookup entry: hash 1830572521 length 7 name t_e.txt d_lookup return: NULL __d_alloc
entry pointer = 0xffff8bd55debc025 __d_alloc return pointer = 0xffff8bd54429b9f8 __d_add entry:
0xffff8bd54429b9f8 | t_e.txt do_filp_open return pointer = 0xffff8bd54429b9f8 | t_e.txt

Proof 6. Long filename behavior.

Evidence: d_lookup entry: hash 3778081590 length 64 name
test_file_very_long_name_to_force_external_allocation_1770408898 d_lookup return: NULL __d_alloc
entry pointer = 0xffff8bd55337c020 __d_alloc return pointer = 0xffff8bd7b1f07cd8 __d_add entry:
0xffff8bd7b1f07cd8 | test_file_very_long_name_to_force_external_allocation_1770408898 do_filp_open
return pointer = 0xffff8bd7b1f07cd8 |
test_file_very_long_name_to_force_external_allocation_1770408898

Proof 7. Short filename behavior.

Evidence: d_lookup entry: hash 3711754354 length 5 name a.txt d_lookup return: NULL __d_alloc entry
pointer = 0xffff8bd55debc02c __d_alloc return pointer = 0xffff8bd572708b78 __d_add entry:
0xffff8bd572708b78 | a.txt do_filp_open return pointer = 0xffff8bd572708b78 | a.txt

Derivation: 0xffff8bd55debc02c - 0xffff8bd55debc020 = 0xC = 12 "/mnt/loopfs/" length = 12

Symbol availability proof (from this machine)

Kernel headers and sources:

uname -r: 6.14.0-37-generic /usr/src contains linux-headers-6.14.0-37-generic /usr/src contains
linux-source-6.8.0

kptr_restrict: 1 perf_event_paranoid: 4

Symbols in /proc/kallsyms:

__d_add: ffffffff89beaaa0 (local symbol, type t) d_add: ffffffff89beaca0 (global symbol, type T)
d_rehash: ffffffff89bea3e0 (global symbol, type T) d_add_ci: ffffffff89becf20 (global symbol, type
T) full_name_hash: ffffffff89bd5010 (global symbol, type T)

Why __d_add is not in available_filter_functions: available_filter_functions is the ftrace function
list, not a full symbol list. It only includes functions that ftrace exposes (non-inlined,
traceable, and globally visible). __d_add is present as a local symbol in kallsyms, so kprobe can
attach to it, but ftrace does not list it.

What We Failed To Observe And Why

1. We did not observe a __d_add line for l_e.txt in the post-eviction rebuild phase. The post-eviction lookup is visible on the RCU path and returns a new pointer, but an explicit insert line for l_e.txt was not printed in this run. This is why Claim A9 is phrased as a post-eviction lookup, not an explicit insert for l_e.txt.
2. We did not observe any d_drop entry lines for these names. The d_delete lines are present in the data, but d_drop did not fire for these paths in this run.
3. We did not observe any full_name_hash return lines in this run. The full_name_hash kretprobe is registered, but the function may be inlined or bypassed in this path on this kernel build. Hash values are still recorded via d_lookup entry, __d_lookup entry, and __d_lookup_rcu entry, which report the key hash and length used.

Proofs from the latest run (commands + results):

```text
sudo dmesg | rg -n "__d_add entry: .*l_e.txt"
<no output>

sudo dmesg | rg -n "d_drop entry"
<no output>

sudo dmesg | rg -n "full_name_hash return"
<no output>
```

Post-eviction l_e.txt lookup/return is visible even without __d_add:
```text
sudo dmesg | rg -n "__d_lookup_rcu entry:.*l_e.txt|\[O\] OUT: .*l_e.txt"
35:[32438.302505] __d_lookup_rcu entry: hash 440978933 length 7 name l_e.txt
37:[32438.302532] [O] OUT: 0xffff8bd7e7bd6578 | l_e.txt
149:[32441.321252] __d_lookup_rcu entry: hash 440978933 length 7 name l_e.txt
151:[32441.321294] [O] OUT: 0xffff8bd5441fc3f8 | l_e.txt
```

Wide-Screen Trace Appendix

Full Trace A (matrix_open, latest run)

Scope note: this trace lists the open sequence after the first drop_caches call. The earlier
creat(...) calls also execute do_filp_open and appear in dmesg, but they are not repeated here to
keep the step list aligned to the open sequence used for the claims.

#1. Call. do_filp_open entry. Values: name pointer 0xffff8bd55debc020, name string /tmp/t_e.txt.
Data: user-space open("/tmp/t_e.txt") reached kernel. Work: begin lookup for basename t_e.txt.
Errors: none. Caller line: not recorded. Current line: not recorded. Resume: will return to caller
with file pointer. #2. Call. __d_lookup_rcu entry. Values: hash 2802308728, length 3, name
tmp/t_e.txt. Data: RCU path checks tmp/t_e.txt prefix. Work: prefix lookup. Errors: none. Caller
line: not recorded. Current line: not recorded. Resume: returns to lookup path. #3. Call.
__d_lookup_rcu entry. Values: hash 1830572521, length 7, name t_e.txt. Data: RCU path checks
basename. Work: fast path lookup. Errors: none. Caller line: not recorded. Current line: not
recorded. Resume: returns to lookup path. #4. Call. d_lookup entry. Values: hash 1830572521, length
7, name t_e.txt. Data: exact lookup key. Work: slow path lookup. Errors: none. Caller line: not
recorded. Current line: not recorded. Resume: returns with hit/miss. #5. Return. d_lookup return.
Values: NULL. Data: cache miss. Work: miss triggers allocation. Errors: none. Caller line: not
recorded. Current line: not recorded. Resume: control continues to allocate dentry. #6. Call.
__d_alloc entry. Values: name pointer 0xffff8bd55debc025. Data: points to basename start in
/tmp/t_e.txt. Work: allocate dentry name storage and copy. Errors: none. Caller line: not recorded.
Current line: not recorded. Resume: returns new dentry pointer. #7. Return. __d_alloc return.
Values: name pointer 0xffff8bd572708638. Data: newly allocated dentry name storage for t_e.txt.
Work: allocate completed. Errors: none. Caller line: not recorded. Current line: not recorded.
Resume: control continues to insert into dcache. #8. Call. __d_add entry. Values: name pointer
0xffff8bd572708638, name t_e.txt. Data: inserting new dentry. Work: insert into dcache hash. Errors:
none. Caller line: not recorded. Current line: not recorded. Resume: returns to open path. #9.
Return. do_filp_open. Values: name pointer 0xffff8bd572708638, name t_e.txt. Data: returned file
points to newly allocated name storage. Work: open completes. Errors: none. Caller line: not
recorded. Current line: not recorded. Resume: returns to user space. #10. Call. do_filp_open entry.
Values: name pointer 0xffff8bd55debc020, name /tmp/t_m.txt. Data: user-space open of missing file.
Work: begin lookup for basename t_m.txt. Errors: none. Caller line: not recorded. Current line: not
recorded. Resume: will return with error or file. #11. Call. __d_lookup_rcu entry. Values: hash
2802308728, length 3, name tmp/t_m.txt. Data: RCU prefix lookup. Work: prefix lookup. Errors: none.
Caller line: not recorded. Current line: not recorded. Resume: returns to lookup path. #12. Call.
__d_lookup_rcu entry. Values: hash 2543581516, length 7, name t_m.txt. Data: RCU basename lookup.
Work: fast path lookup. Errors: none. Caller line: not recorded. Current line: not recorded. Resume:
returns to lookup path. #13. Call. d_lookup entry. Values: hash 2543581516, length 7, name t_m.txt.
Data: exact lookup key. Work: slow path lookup. Errors: none. Caller line: not recorded. Current
line: not recorded. Resume: returns with hit/miss. #14. Return. d_lookup return. Values: NULL. Data:
cache miss. Work: miss triggers allocation. Errors: none. Caller line: not recorded. Current line:
not recorded. Resume: control continues to allocate dentry. #15. Call. __d_alloc entry. Values: name
pointer 0xffff8bd55debc025. Data: points to basename start in /tmp/t_m.txt. Work: allocate dentry
name storage and copy. Errors: none. Caller line: not recorded. Current line: not recorded. Resume:
returns new dentry pointer. #16. Return. __d_alloc return. Values: name pointer 0xffff8bd5727080f8.
Data: newly allocated dentry name storage for t_m.txt. Work: allocation completed. Errors: none.
Caller line: not recorded. Current line: not recorded. Resume: control continues to insert. #17.
Call. __d_add entry. Values: name pointer 0xffff8bd5727080f8, name t_m.txt. Data: inserting dentry.
Work: insert into dcache hash. Errors: none. Caller line: not recorded. Current line: not recorded.
Resume: returns to open path. #18. Call. do_filp_open entry. Values: name pointer
0xffff8bd55debc020, name l_m.txt. Data: user-space open of missing file. Work: begin lookup for
basename l_m.txt. Errors: none. Caller line: not recorded. Current line: not recorded. Resume: will
return with error or file. #19. Call. __d_lookup_rcu entry. Values: hash 2166850383, length 7, name
l_m.txt. Data: RCU lookup. Work: fast path lookup. Errors: none. Caller line: not recorded. Current
line: not recorded. Resume: returns to lookup path. #20. Call. d_lookup entry. Values: hash
2166850383, length 7, name l_m.txt. Data: exact lookup key. Work: slow path lookup. Errors: none.
Caller line: not recorded. Current line: not recorded. Resume: returns with hit/miss. #21. Return.
d_lookup return. Values: NULL. Data: cache miss. Work: miss triggers allocation. Errors: none.
Caller line: not recorded. Current line: not recorded. Resume: control continues to allocate dentry.
#22. Call. __d_alloc entry. Values: name pointer 0xffff8bd55debc020. Data: points to basename start
in l_m.txt. Work: allocate dentry name storage and copy. Errors: none. Caller line: not recorded.
Current line: not recorded. Resume: returns new dentry pointer. #23. Return. __d_alloc return.
Values: name pointer 0xffff8bd572708878. Data: newly allocated dentry name storage for l_m.txt.
Work: allocation completed. Errors: none. Caller line: not recorded. Current line: not recorded.
Resume: control continues to insert. #24. Call. __d_add entry. Values: name pointer
0xffff8bd572708878, name l_m.txt. Data: inserting dentry. Work: insert into dcache hash. Errors:
none. Caller line: not recorded. Current line: not recorded. Resume: returns to open path. #25.
Call. do_filp_open entry. Values: name pointer 0xffff8bd55debc020, name /mnt/loopfs/a.txt. Data:
user-space open on loopback ext2. Work: begin lookup for basename a.txt. Errors: none. Caller line:
not recorded. Current line: not recorded. Resume: will return with file pointer. #26. Call.
__d_lookup_rcu entry. Values: hash 4289119505, length 3, name mnt/loopfs/a.txt. Data: RCU prefix
lookup. Work: prefix lookup. Errors: none. Caller line: not recorded. Current line: not recorded.
Resume: returns to lookup path. #27. Call. __d_lookup_rcu entry. Values: hash 1683324524, length 6,
name loopfs/a.txt. Data: RCU intermediate prefix lookup. Work: prefix lookup. Errors: none. Caller
line: not recorded. Current line: not recorded. Resume: returns to lookup path. #28. Call.
__d_lookup_rcu entry. Values: hash 3711754354, length 5, name a.txt. Data: RCU basename lookup.
Work: fast path lookup. Errors: none. Caller line: not recorded. Current line: not recorded. Resume:
returns to lookup path. #29. Call. d_lookup entry. Values: hash 3711754354, length 5, name a.txt.
Data: exact lookup key. Work: slow path lookup. Errors: none. Caller line: not recorded. Current
line: not recorded. Resume: returns with hit/miss. #30. Return. d_lookup return. Values: NULL. Data:
cache miss. Work: miss triggers allocation. Errors: none. Caller line: not recorded. Current line:
not recorded. Resume: control continues to allocate dentry. #31. Call. __d_alloc entry. Values: name
pointer 0xffff8bd55debc02c. Data: points to basename start in /mnt/loopfs/a.txt. Work: allocate
dentry name storage and copy. Errors: none. Caller line: not recorded. Current line: not recorded.
Resume: returns new dentry pointer. #32. Return. __d_alloc return. Values: name pointer
0xffff8bd572708b78. Data: newly allocated dentry name storage for a.txt. Work: allocation completed.
Errors: none. Caller line: not recorded. Current line: not recorded. Resume: control continues to
insert. #33. Call. __d_add entry. Values: name pointer 0xffff8bd572708b78, name a.txt. Data:
inserting new dentry. Work: insert into dcache hash. Errors: none. Caller line: not recorded.
Current line: not recorded. Resume: returns to open path. #34. Return. do_filp_open. Values: name
pointer 0xffff8bd572708b78, name a.txt. Data: returned file points to newly allocated name storage.
Work: open completes. Errors: none. Caller line: not recorded. Current line: not recorded. Resume:
returns to user space. #35. Call. do_filp_open entry. Values: name pointer 0xffff8bd55debc020, name
l_e.txt. Data: user-space open of existing file. Work: lookup for l_e.txt. Errors: none. Caller
line: not recorded. Current line: not recorded. Resume: will return with file pointer. #36. Call.
__d_lookup_rcu entry. Values: hash 440978933, length 7, name l_e.txt. Data: RCU lookup. Work: fast
path lookup. Errors: none. Caller line: not recorded. Current line: not recorded. Resume: returns to
lookup path. #37. Return. d_lookup return. Values: pointer 0xffff8bd55868a0f8, name l_e.txt. Data:
cache hit. Work: reuse cached dentry. Errors: none. Caller line: not recorded. Current line: not
recorded. Resume: control returns to open path. #38. Return. do_filp_open. Values: name pointer
0xffff8bd55868a0f8, name l_e.txt. Data: open returns cached dentry name storage. Work: open
completes. Errors: none. Caller line: not recorded. Current line: not recorded. Resume: returns to
user space. #39. Call. d_delete entry. Values: pointer 0xffff8bd55868a0f8, name l_e.txt. Data:
unlink removal. Work: delete dentry from hash. Errors: none. Caller line: not recorded. Current
line: not recorded. Resume: returns to unlink path. #40. Call. d_delete entry. Values: pointer
0xffff8bd572708638, name t_e.txt. Data: unlink removal. Work: delete dentry from hash. Errors: none.
Caller line: not recorded. Current line: not recorded. Resume: returns to unlink path. #41. Call.
do_filp_open entry. Values: name pointer 0xffff8bd543611020, name /proc/sys/vm/drop_caches. Data:
control write to drop caches. Work: open drop_caches for eviction. Errors: none. Caller line: not
recorded. Current line: not recorded. Resume: returns to user space. #42. Return. do_filp_open.
Values: name pointer 0xffff8bd6fce05db8, name drop_caches. Data: control file opened. Work: enables
eviction. Errors: none. Caller line: not recorded. Current line: not recorded. Resume: returns to
user space. #43. Call. __dentry_kill entry. Values: pointer 0xffff8bd55868a0f8, name l_e.txt. Data:
eviction of cached dentry. Work: reclaim dentry. Errors: none. Caller line: not recorded. Current
line: not recorded. Resume: returns to shrinker. #44. Call. __dentry_kill entry. Values: pointer
0xffff8bd572708638, name t_e.txt. Data: eviction of cached dentry. Work: reclaim dentry. Errors:
none. Caller line: not recorded. Current line: not recorded. Resume: returns to shrinker. #45. Call.
do_filp_open entry. Values: name pointer 0xffff8bd55debc020, name l_e.txt. Data: post-eviction open.
Work: lookup after eviction. Errors: none. Caller line: not recorded. Current line: not recorded.
Resume: returns with file pointer. #46. Call. __d_lookup_rcu entry. Values: hash 440978933, length
7, name l_e.txt. Data: RCU lookup after eviction. Work: fast path lookup. Errors: none. Caller line:
not recorded. Current line: not recorded. Resume: returns to open path. #47. Return. do_filp_open.
Values: name pointer 0xffff8bd549b4e1b8, name l_e.txt. Data: post-eviction return pointer differs
from pre-eviction pointer 0xffff8bd55868a0f8. Work: open completes. Errors: none. Caller line: not
recorded. Current line: not recorded. Resume: returns to user space. #48. Call. do_filp_open entry.
Values: name pointer 0xffff8bd55debc020, name /tmp/t_e.txt. Data: post-eviction open. Work: lookup
after eviction. Errors: none. Caller line: not recorded. Current line: not recorded. Resume: returns
with file pointer. #49. Call. d_lookup entry. Values: hash 1830572521, length 7, name t_e.txt. Data:
lookup key. Work: slow path lookup. Errors: none. Caller line: not recorded. Current line: not
recorded. Resume: returns with hit/miss. #50. Return. d_lookup return. Values: NULL. Data: miss
post-eviction. Work: triggers rebuild. Errors: none. Caller line: not recorded. Current line: not
recorded. Resume: control continues to allocate. #51. Call. __d_alloc entry. Values: name pointer
0xffff8bd55debc025. Data: basename pointer. Work: allocate new name storage. Errors: none. Caller
line: not recorded. Current line: not recorded. Resume: returns new dentry pointer. #52. Return.
__d_alloc return. Values: name pointer 0xffff8bd54429b9f8. Data: new name storage for t_e.txt. Work:
allocation completed. Errors: none. Caller line: not recorded. Current line: not recorded. Resume:
control continues to insert. #53. Call. __d_add entry. Values: name pointer 0xffff8bd54429b9f8, name
t_e.txt. Data: insert new dentry. Work: insert into dcache. Errors: none. Caller line: not recorded.
Current line: not recorded. Resume: returns to open path. #54. Return. do_filp_open. Values: name
pointer 0xffff8bd54429b9f8, name t_e.txt. Data: rebuilt pointer differs from pre-eviction pointer
0xffff8bd572708638. Work: open completes. Errors: none. Caller line: not recorded. Current line: not
recorded. Resume: returns to user space.

Wide-Screen Diagrams (Trace View)

Diagram 1 — t_e.txt miss → alloc → insert → return
```text
open("/tmp/t_e.txt")
  -> do_filp_open entry 0xffff8bd55debc020
  -> d_lookup hash 1830572521 len 7 "t_e.txt" -> NULL
  -> __d_alloc entry 0xffff8bd55debc025
  -> __d_alloc return 0xffff8bd572708638
  -> __d_add entry 0xffff8bd572708638
  -> do_filp_open return 0xffff8bd572708638
```

Diagram 2 — a.txt miss on loopback ext2
```text
open("/mnt/loopfs/a.txt")
  -> do_filp_open entry 0xffff8bd55debc020
  -> d_lookup hash 3711754354 len 5 "a.txt" -> NULL
  -> __d_alloc entry 0xffff8bd55debc02c
  -> __d_alloc return 0xffff8bd572708b78
  -> __d_add entry 0xffff8bd572708b78
  -> do_filp_open return 0xffff8bd572708b78
```

Diagram 3 — cache hit for l_e.txt before deletion
```text
open("l_e.txt")
  -> d_lookup hash 440978933 len 7 "l_e.txt" -> 0xffff8bd55868a0f8
  -> do_filp_open return 0xffff8bd55868a0f8
```

Diagram 4 — unlink deletion + eviction
```text
unlink("l_e.txt") -> d_delete 0xffff8bd55868a0f8
unlink("/tmp/t_e.txt") -> d_delete 0xffff8bd572708638
drop_caches -> __dentry_kill 0xffff8bd55868a0f8 (l_e.txt)
drop_caches -> __dentry_kill 0xffff8bd572708638 (t_e.txt)
drop_caches -> __dentry_kill 0xffff8bd5727080f8 (t_m.txt)
drop_caches -> __dentry_kill 0xffff8bd572708878 (l_m.txt)
drop_caches -> __dentry_kill 0xffff8bd572708b78 (a.txt)
```

Diagram 5 — rebuild after eviction (t_e.txt)
```text
open("/tmp/t_e.txt") after drop_caches
  -> d_lookup hash 1830572521 len 7 "t_e.txt" -> NULL
  -> __d_alloc return 0xffff8bd54429b9f8
  -> __d_add entry 0xffff8bd54429b9f8
  -> do_filp_open return 0xffff8bd54429b9f8
```

Diagram 6 — post-eviction lookup for l_e.txt
```text
open("l_e.txt") after drop_caches
  -> __d_lookup_rcu hash 440978933 len 7 "l_e.txt"
  -> do_filp_open return 0xffff8bd549b4e1b8
```
