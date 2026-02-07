---
layout: default
title: "Stage 2 Return"
---

This report is a pointer‑trace, not a theory piece. Stage 1 proved open/openat → do_sys_openat2; Stage 2 proved getname() copies the user string into struct filename. This stage tracks the same pointer across the only places it can change: entry, copy, cache insert, lookup, return, and eviction. We trace these functions because they are the only points where the filename pointer is created, copied, inserted, returned, or reclaimed. The comparison is direct: __d_add prints the cached name address, do_filp_open return prints the file’s name address; equal means the file points at the cached name. Everything else in this document is the same kind of check: =, ≠, or subtraction on printed addresses.

USER SPACE CODE

```c
#include <fcntl.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main(void) {
    char filename[128];
    time_t now = time(NULL);
    snprintf(filename, sizeof(filename),
             "test_file_very_long_name_to_force_external_allocation_%ld", now);
    int fd = open(filename, O_RDWR | O_CREAT, 0644);
    printf("fd=%d\n", fd);
    sleep(5);
    close(fd);
    return 0;
}
```

WHY THIS CODE

The filename is 64 bytes long. This forces __d_alloc to use external allocation for dentry->d_name.name. Short names (< 36 bytes) use inline storage inside struct dentry. Long names allocate separate memory. We need external allocation to see the memcpy destination address differ from the dentry struct address.

SOURCE: /usr/src/linux-source-6.8.0/fs/dcache.c:1651
```c
if (name->len > DNAME_INLINE_LEN-1) {
    dname = kmalloc(name->len + 1, GFP_KERNEL);
    if (!dname) {
        kmem_cache_free(dentry_cache, dentry);
        return NULL;
    }
} else {
    dname = dentry->d_iname;
}
memcpy(dname, name->name, name->len);
```

DNAME_INLINE_LEN = 36 (include/linux/dcache.h:98)
Our filename length = 64 bytes > 36 bytes, so kmalloc runs, dname points to external buffer, memcpy copies to external buffer.

PROBES

Probes are placed only where the address can change or be reused: do_filp_open entry/return, __d_alloc entry/return, d_lookup return, __d_lookup_rcu return, __d_add entry, __dentry_kill entry. The sections below show the actual addresses from the current run; the numbers are the proof.

minimal_open.c
```c
snprintf(filename, sizeof(filename),
         "test_file_very_long_name_to_force_external_allocation_%ld", now);
int fd = open(filename, O_RDWR | O_CREAT, 0644);
sleep(5);
```
```
test_file_very_long_name_to_force_external_allocation_1770489275
name string = "test_file_very_long_name_to_force_external_allocation_1770489275"
└─ do_filp_open entry 0xffff8f29432f2020 (filename * -> name : const char *)
   └─ d_lookup entry hash=151322490 len=64 (qstr { name, len, hash })
      ├─ d_lookup return NULL (dentry * return = NULL)
      │  └─ __d_alloc entry 0xffff8f29432f2020 (qstr * -> name : const unsigned char *)
      │     └─ __d_alloc return 0xffff8f2bb97842b8 (dentry * -> d_name.name : const unsigned char *)
      │        └─ __d_add entry 0xffff8f2bb97842b8 (dentry * -> d_name.name)
      │           └─ do_filp_open return 0xffff8f2bb97842b8 (file * -> f_path.dentry->d_name.name)
      └─ d_lookup return 0xffff8f2bb97842b8 (dentry * -> d_name.name)
```
0xffff8f29432f2020 = copy source; 0xffff8f2bb97842b8 = __d_alloc return = __d_add entry = do_filp_open return = d_lookup return.

te_miss.c (after drop_caches block)
```c
const char *n2 = "/tmp/t_e.txt";
close(creat(n2, 0644));
drop_caches_if_root();
sleep(1);
open(n2, O_RDONLY);
```
name string = "/tmp/t_e.txt"
└─ do_filp_open entry 0xffff8f29465fd020 (filename * -> name : const char *)
   └─ d_lookup entry hash=1730118631 len=7 (qstr { name, len, hash })
      ├─ d_lookup return NULL (dentry * return = NULL)
      │  └─ __d_alloc entry 0xffff8f29465fd025 (qstr * -> name : const unsigned char *)
      │     └─ __d_alloc return 0xffff8f29406394b8 (dentry * -> d_name.name)
      │        └─ __d_add entry 0xffff8f29406394b8 (dentry * -> d_name.name)
      │           └─ do_filp_open return 0xffff8f29406394b8 (file * -> f_path.dentry->d_name.name)
      └─ d_lookup return 0xffff8f29406394b8 (dentry * -> d_name.name)
0xffff8f29465fd025 − 0xffff8f29465fd020 = 0x5 = 5 and "/tmp/" length = 5; 0xffff8f29406394b8 = __d_add = do_filp_open return.

tm_miss.c
```c
const char *n3 = "/tmp/t_m.txt";
drop_caches_if_root();
sleep(1);
int fd1 = open(n3, O_RDONLY);
printf("tm_miss first open fd=%d\n", fd1);
int fd2 = open(n3, O_RDONLY);
printf("tm_miss second open fd=%d\n", fd2);
```
stdout:
tm_miss first open fd=-1
tm_miss second open fd=-1
name string = "/tmp/t_m.txt"
└─ do_filp_open entry 0xffff8f294aea6020 (filename * -> name : const char *)
   └─ d_lookup entry hash=1429044786 len=7 (qstr { name, len, hash })
      ├─ d_lookup return NULL (dentry * return = NULL)
      │  └─ __d_lookup_rcu return NULL (dentry * return = NULL)
      │     └─ __d_alloc entry 0xffff8f294aea6025 (qstr * -> name : const unsigned char *)
      │        └─ __d_alloc return 0xffff8f29404744b8 (dentry * -> d_name.name)
      │           └─ __d_add entry 0xffff8f29404744b8 (dentry * -> d_name.name)
      └─ __d_lookup_rcu return 0xffff8f29404744b8 (second open, dentry * -> d_name.name)
do_filp_open return not printed (fd = -1). 0xffff8f294aea6025 − 0xffff8f294aea6020 = 0x5 = 5 and "/tmp/" length = 5; 0xffff8f29404744b8 appears at __d_add and at __d_lookup_rcu return on the second open.

lm_miss.c
```c
const char *n4 = "l_m.txt";
drop_caches_if_root();
sleep(1);
open(n4, O_RDONLY);
```
name string = "l_m.txt"
└─ do_filp_open entry 0xffff8f2940f32020 (filename * -> name : const char *)
   └─ d_lookup entry hash=4284383268 len=7 (qstr { name, len, hash })
      ├─ d_lookup return NULL (dentry * return = NULL)
      │  └─ __d_alloc entry 0xffff8f2940f32020 (qstr * -> name : const unsigned char *)
      │     └─ __d_alloc return 0xffff8f2961c271b8 (dentry * -> d_name.name)
      │        └─ __d_add entry 0xffff8f2961c271b8 (dentry * -> d_name.name)
      └─ d_lookup return 0xffff8f2961c271b8 (dentry * -> d_name.name)
0xffff8f2940f32020 = copy source; 0xffff8f2961c271b8 = cached name address.

a_miss.c
```c
const char *n5 = "/mnt/loopfs/a.txt";
drop_caches_if_root();
sleep(1);
open(n5, O_RDONLY);
```
name string = "/mnt/loopfs/a.txt"
└─ do_filp_open entry 0xffff8f29477d2020 (filename * -> name : const char *)
   └─ d_lookup entry hash=3098233830 len=5 (qstr { name, len, hash })
      ├─ d_lookup return NULL (dentry * return = NULL)
      │  └─ __d_alloc entry 0xffff8f29477d202c (qstr * -> name : const unsigned char *)
      │     └─ __d_alloc return 0xffff8f294ca50ab8 (dentry * -> d_name.name)
      │        └─ __d_add entry 0xffff8f294ca50ab8 (dentry * -> d_name.name)
      │           └─ do_filp_open return 0xffff8f294ca50ab8 (file * -> f_path.dentry->d_name.name)
      └─ d_lookup return 0xffff8f294ca50ab8 (dentry * -> d_name.name)
0xffff8f29477d202c − 0xffff8f29477d2020 = 0xC = 12 and "/mnt/loopfs/" length = 12; 0xffff8f294ca50ab8 = __d_add = do_filp_open return.

hits.c + delete.c + evict.c
```c
// hits.c
open(n1, O_RDONLY);
open(n2, O_RDONLY);

// delete.c
unlink(n1);
unlink(n2);

// evict.c
drop_caches_if_root();
```
Purpose: one pointer per name across hit → delete → evict (three separate runs).
l_e.txt
└─ d_lookup return 0xffff8f2995d00578 (dentry * -> d_name.name)
   └─ d_delete entry 0xffff8f2995d00578 (dentry * -> d_name.name)
      └─ __dentry_kill entry 0xffff8f2995d00578 (dentry * -> d_name.name)
t_e.txt
└─ d_lookup return 0xffff8f2ba0a0b3f8 (dentry * -> d_name.name)
   └─ d_delete entry 0xffff8f2ba0a0b3f8 (dentry * -> d_name.name)
      └─ __dentry_kill entry 0xffff8f2ba0a0b3f8 (dentry * -> d_name.name)
Same pointer across hit → delete → evict for each name in this run.

rebuild.c
```c
// before drop_caches
open(n2, O_RDONLY);
// drop caches, then reopen
drop_caches_if_root();
sleep(1);
open(n2, O_RDONLY);
```
Purpose: new pointer after drop_caches for the same name.
t_e.txt
└─ before drop_caches: __d_add 0xffff8f294cae1cf8 -> do_filp_open return 0xffff8f294cae1cf8
└─ after  drop_caches: __d_add 0xffff8f294045e638 -> do_filp_open return 0xffff8f294045e638
0xffff8f294cae1cf8 − 0xffff8f294045e638 = 0xc6836c0 = 208156352 and 0xffff8f294045e638 ≠ 0xffff8f294cae1cf8.

post.c
```c
// before drop_caches
open(n1, O_RDONLY);
// drop caches, then reopen
drop_caches_if_root();
sleep(1);
open(n1, O_RDONLY);
```
Purpose: pointer change check on a second name after drop_caches.
l_e.txt
└─ before drop_caches: __d_add 0xffff8f2b77cdab78 -> do_filp_open return 0xffff8f2b77cdab78
└─ after  drop_caches: __d_add 0xffff8f2b77cdab78 -> do_filp_open return 0xffff8f2b77cdab78
0xffff8f2b77cdab78 − 0xffff8f2b77cdab78 = 0x0 = 0 and 0xffff8f2b77cdab78 = 0xffff8f2b77cdab78.

LESSON FROM THE PROBES (LONG STORY, NUMBERS FIRST)

We start with the only truth we have: the addresses printed by the probes. The program calls open on `/tmp/t_e.txt`. The kernel string pointer is `0xffff8f29465fd020`. The copy source pointer is `0xffff8f29465fd025`. Subtract them: `0xffff8f29465fd025 − 0xffff8f29465fd020 = 0x5 = 5`. Count `/tmp/`: five characters. So the copy source points at `t_e.txt`, not at `/tmp/t_e.txt`. That is the first fact. Next, `__d_alloc` returns `0xffff8f29406394b8`. That same number appears at `__d_add` and at `do_filp_open return`. Later, `d_lookup` returns `0xffff8f29406394b8` on a hit. That single number proves the chain: copy destination, cache insert, file return, and cache reuse are all the same address. Now we move to a missing file. In tm_miss, `d_lookup` returns NULL, so we know there’s a miss. `__d_alloc` still runs and returns `0xffff8f29404744b8`, and `__d_add` inserts that exact pointer. Second open returns `__d_lookup_rcu return: 0xffff8f29404744b8` even though `fd = −1`. Same pointer again: that is the negative‑dentry case in numbers. Now we drop caches. We see `__dentry_kill entry` printing a pointer that was previously a hit, so we know eviction happened. After drop_caches, the next open either returns a different address (new allocation) or the same one (allocator reuse). In this run, post.c shows the same address before and after; rebuild.c shows a different address. The evidence is the equality or inequality of the printed numbers. That is the whole story: subtract to prove basename, compare to prove reuse, observe NULL to prove miss, and read __dentry_kill to prove eviction. Everything else is commentary.

DRIVER

kernel/drivers/trace_do_filp_open/trace_do_filp_open.c

Kprobes: do_filp_open, __d_alloc, d_lookup, __d_lookup_rcu, __d_add
Kretprobes: do_filp_open, __d_alloc, d_lookup, __d_lookup_rcu

cd kernel/drivers/trace_do_filp_open && make
sudo insmod trace_do_filp_open.ko target_comm=minimal_open
cd kernel/user/stage2 && gcc -o minimal_open minimal_open.c && ./minimal_open
sudo dmesg | grep -E "\[O\]|\[A\]|d_lookup|__d_lookup_rcu|__d_add|__dentry_kill"
`[O]` = do_filp_open entry/return, `[A]` = __d_alloc entry/return, `d_lookup` = hit/miss, `__d_lookup_rcu` = RCU path, `__d_add` = cache insert, `__dentry_kill` = eviction.
sudo rmmod trace_do_filp_open
Repeat the same pattern for the other programs by changing `target_comm` to the program name (te_miss, tm_miss, lm_miss, a_miss, hits, delete, evict, rebuild, post) and running that binary before the same grep.

PREVIOUS WORK

Stage 1: User Space to Syscall Boundary
https://raikrahul.github.io/what-happens-when-open-is-called/stage1.html
Proved: open() -> PLT -> GOT -> libc -> openat() -> syscall

Stage 2 Entry: Kernel Space - Tracing getname()
https://raikrahul.github.io/what-happens-when-open-is-called/stage2.html
Proved: syscall -> do_sys_openat2 -> getname() copies user string to kernel buffer

Stage 2 Return: This Document
Proved: do_filp_open -> __d_alloc -> memcpy -> __d_add -> return file pointing to dentry name

Complete chain: User space open("file") -> libc openat(AT_FDCWD, "file", flags) -> syscall -> kernel do_sys_openat2 -> getname copies to kernel -> do_filp_open -> __d_alloc copies to dentry -> return struct file pointing to dentry name. Every step verified with printed addresses from actual runs on Linux 6.14.0-37-generic, Ubuntu 24.04, 2026-02-07.
