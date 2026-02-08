---
layout: default
title: "Textbook: Stage 2 (getname)"
---

# Stage 2 — Kernel Entry: getname()

## Axioms
1. A printed address is a number that can be compared.
2. If two printed addresses are equal, they are the same value.
3. If a subtraction is computed, the result is a byte offset.

## Code Path (Kernel)
`do_sys_openat2` calls `getname(filename)` before `do_filp_open`.

## What Stage 2 Proves
- `getname()` copies the user string into a kernel buffer.
- The kernel uses `struct filename->name` as the kernel string pointer.

## Evidence Pattern (What to Record)
- User pointer and kernel pointer for the same string.
- Equality/inequality between those pointers.

## Outcome
Stage 2 ends at the kernel buffer. No cache or dentry claims are made here.
