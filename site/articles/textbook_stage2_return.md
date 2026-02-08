---
layout: default
title: "Textbook: Stage 2 Return (Cache and Reuse)"
---

# Stage 2 Return — Cache, Copy, Insert, Return

## Axioms
1. A printed address is a number that can be compared.
2. If two printed addresses are equal, they are the same value.
3. If a subtraction is computed, the result is a byte offset.
4. `d_lookup return: NULL` is a miss.
5. `__d_add entry: X` is the cached name pointer.
6. `do_filp_open return: X` is the file name pointer.

## Basename Offset
`SRC − IN = 0x5` for `/tmp/…` and `SRC − IN = 0xC` for `/mnt/loopfs/…`.  
These match the prefix lengths, so the copy starts at the basename.

## Copy → Insert → Return → Hit
If the same address appears at:
`__d_alloc return = __d_add entry = do_filp_open return = later d_lookup return`,  
then one cached name pointer is reused.

## Miss → Alloc
`d_lookup return = NULL` followed by `__d_alloc` proves allocation on miss.

## Negative Dentry
Missing file: first open inserts a pointer; second open returns the same pointer with `fd = -1`.

## Evict → Reuse or Rebuild
`__dentry_kill` prints a pointer that was previously a hit.  
After drop_caches: different pointer ⇒ new allocation; same pointer ⇒ allocator reuse.

## Outcome
All claims are equalities, inequalities, or subtractions on printed addresses.
