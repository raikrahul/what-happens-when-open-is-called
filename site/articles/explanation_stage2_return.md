---
layout: default
title: "Stage 2 Return"
---

Title

Stage 2 Return: Axiomatic Trace of Filename Pointer and Hash Lookup

Problem Statement

A user program calls open with a filename string. Show where the filename string is copied, where a cached name is reused, which pointer is returned by do_filp_open, and which hash values are used for lookup. Use only data observed on this machine and derive each conclusion from prior lines.

Axioms

Axiom 1. The open call passes a filename string from user space into the kernel.
Axiom 2. do_filp_open receives a struct filename and returns a struct file.
Axiom 3. __d_alloc is called when a new dentry is allocated and copies a name into dentry storage.
Axiom 4. d_lookup returns an existing dentry on a cache hit and returns NULL on a cache miss.
Axiom 5. kprobe at function entry can read input pointers at that entry.
Axiom 6. kretprobe at function return can read the return pointer at that return.
Axiom 7. Equality of two printed pointers means the pointers have the same numeric value.
Axiom 8. If no return pointer is printed for a call, then no valid struct file pointer was returned for that call.
Axiom 9. The string "/tmp/" has length 5.
Axiom 10. If dmesg prints "[L] HASH: H L S" then hashing was performed for name string S with length L and hash value H at d_lookup entry.
Axiom 11. A lookup key is the pair (name string, length) shown in a hash line.

Definitions

Definition 1. [O] IN is the pointer printed at do_filp_open entry.
Definition 2. [A] SRC is the pointer printed at __d_alloc entry.
Definition 3. [A] DST is the pointer printed at __d_alloc return.
Definition 4. [O] OUT is the pointer printed at do_filp_open return.
Definition 5. [L] HIT is the pointer printed at d_lookup return.
Definition 6. [L] HASH is the hash line printed at d_lookup entry.

Observed Data (Pointers)

minimal_open:
[O] IN  = 0xffff8bd543615020
[A] SRC = 0xffff8bd543615020
[A] DST = 0xffff8bd7c7ef4978
[O] OUT = 0xffff8bd7c7ef4978
[L] HIT = 0xffff8bd7c7ef4978

matrix_open:

l_e.txt first open:
[O] IN  = 0xffff8bd54d665020
[A] SRC = 0xffff8bd54d665020
[A] DST = 0xffff8bd54e2801b8
[O] OUT = 0xffff8bd54e2801b8

/tmp/t_e.txt first open:
[O] IN  = 0xffff8bd54d665020
[A] SRC = 0xffff8bd54d665025
[A] DST = 0xffff8bd54e2803f8
[O] OUT = 0xffff8bd54e2803f8

l_m.txt:
[O] IN  = 0xffff8bd54d665020
[A] SRC = 0xffff8bd54d665020
[A] DST = 0xffff8bd54e280638
[O] OUT not observed

cache hits after 2 seconds:
[L] HIT = 0xffff8bd54e2801b8 (l_e.txt)
[L] HIT = 0xffff8bd54e2803f8 (t_e.txt)

Observed Data (Hashes, dmesg)

matrix_open:
[L] HASH: 440978933 7 l_e.txt
[L] HASH: 1830572521 7 t_e.txt
[L] HASH: 440978933 7 l_e.txt
[L] HASH: 1830572521 7 t_e.txt

minimal_open:
[L] HASH: 938270691 64 test_file_very_long_name_to_force_external_allocation_1770400761
[L] HASH: 938270691 64 test_file_very_long_name_to_force_external_allocation_1770400761

hash_open:
[L] HASH: 1675155717 7 l_m.txt
[L] HASH: 2543581516 7 t_m.txt
[L] HASH: 1675155717 7 l_m.txt
[L] HASH: 2543581516 7 t_m.txt

Derivation

Step 1. minimal_open: [O] IN equals [A] SRC because both are 0xffff8bd543615020.
By Axiom 7, the copy source equals the input name pointer.

Step 2. minimal_open: [A] DST equals [O] OUT because both are 0xffff8bd7c7ef4978.
By Axiom 7, the returned struct file points to the copied name.

Step 3. minimal_open: [L] HIT equals [O] OUT because both are 0xffff8bd7c7ef4978.
By Axiom 4 and Axiom 7, a later cache hit returns the same dentry name pointer.

Step 4. l_e.txt first open: [O] IN equals [A] SRC because both are 0xffff8bd54d665020.
By Axiom 7, the copy source equals the input name pointer.

Step 5. l_e.txt first open: [A] DST equals [O] OUT because both are 0xffff8bd54e2801b8.
By Axiom 7, the returned struct file points to the copied name.

Step 6. /tmp/t_e.txt first open: compute the difference:
0xffff8bd54d665025 - 0xffff8bd54d665020 = 0x5 = 5.
By Axiom 9, the prefix "/tmp/" is 5 bytes, so the copy source pointer starts after that prefix.
Therefore the copy source points to the basename "t_e.txt".

Step 7. /tmp/t_e.txt first open: [A] DST equals [O] OUT because both are 0xffff8bd54e2803f8.
By Axiom 7, the returned struct file points to the copied name.

Step 8. l_m.txt: [O] OUT is not observed.
By Axiom 8, no valid struct file pointer was returned for that open.

Step 9. cache hits after 2 seconds: the two [L] HIT values equal earlier [O] OUT values:
0xffff8bd54e2801b8 equals the earlier [O] OUT for l_e.txt.
0xffff8bd54e2803f8 equals the earlier [O] OUT for t_e.txt.
By Axiom 4 and Axiom 7, cache hits return the same dentry name pointers.

Step 10. Each [L] HASH line shows a hash value H, a length L, and a name string S.
By Axiom 10, hashing was performed for each S with length L and hash H.
By Axiom 11, each lookup key is the pair (S, L) shown on its line.

Step 11. The hash keys and values are:
(l_e.txt, 7) -> 440978933
(t_e.txt, 7) -> 1830572521
(l_m.txt, 7) -> 1675155717
(t_m.txt, 7) -> 2543581516
(test_file_very_long_name_to_force_external_allocation_1770400761, 64) -> 938270691

Conclusion

From the observed data and the axioms above, the returned struct file pointer equals the dentry name pointer. On allocation, __d_alloc copies the name and [O] OUT equals [A] DST. On cache hit, d_lookup returns an existing dentry and [L] HIT equals the prior [O] OUT. The hash values printed at d_lookup entry prove that each lookup computed a hash on the exact name string used as the key.
