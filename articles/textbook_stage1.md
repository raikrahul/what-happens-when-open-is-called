---
layout: default
title: "Textbook: Stage 1 (User Space → Syscall)"
---

# Stage 1 — User Space to Syscall Boundary

## Axioms
1. A printed address is a number that can be compared.
2. If two printed addresses are equal, they are the same value.
3. If a subtraction is computed, the result is a byte offset.

## Code (User Space)
```c
int fd = open("somefile", O_RDWR);
```

## What Stage 1 Proves
- The filename string exists in user space as a user pointer.
- The syscall boundary receives that user pointer before any kernel copy.

## Evidence Pattern (What to Record)
- User pointer value at the boundary.
- Any numeric transformation of flags or arguments.

## Outcome
Stage 1 stops at the syscall boundary. No kernel copy is claimed here.
