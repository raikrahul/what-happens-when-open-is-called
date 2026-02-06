---
layout: default
title: "Stage 2 Return"
---

Overview

This stage proves where the filename string lives at return time and whether it was copied or reused from cache. We track five points and show that the returned struct file always points to the dentry name, which is either copied in __d_alloc or reused from d_lookup.

What We Trace

[O] IN  do_filp_open entry      -> struct filename name
[A] SRC __d_alloc entry         -> struct qstr name
[A] DST __d_alloc return        -> dentry d_name.name
[O] OUT do_filp_open return     -> file f_path.dentry.d_name.name
[L] HIT d_lookup return         -> dentry d_name.name

Two Paths

Allocation path:
[O] IN -> [A] SRC -> [A] DST -> [O] OUT

Cache hit path:
[O] IN -> [L] HIT -> [O] OUT

d_lookup checks cache first. If it returns NULL, __d_alloc runs and copies the name. If it returns a dentry, the cached dentry name is reused and no allocation happens.

Source Of The Name

The user string is copied into kernel memory by getname. That kernel copy is stored in struct filename and is visible at [O] IN.

How The Copy Happens

__d_alloc receives a struct qstr and copies qstr.name into the new dentry name buffer. That gives:
- [A] SRC is the source pointer
- [A] DST is the destination pointer

On the allocation path, [A] DST equals [O] OUT, so the returned struct file points at the copied name.

How Cache Reuse Happens

d_lookup returns an existing dentry when a cached entry is found. In that case:
- [L] HIT is the cached dentry name pointer
- [O] OUT equals [L] HIT

So the returned struct file points at the existing cached name without a new copy.

Error Case

If open fails, do_filp_open returns an error and no struct file is returned. You will see [O] IN but no [O] OUT for that open.

Driver Filter

The driver filters by process name. Default is matrix_open. For minimal_open, load with:

sudo insmod trace_do_filp_open.ko target_comm=minimal_open

For matrix_open, load with:

sudo insmod trace_do_filp_open.ko target_comm=matrix_open

Test Expectations

minimal_open (long name) shows allocation path:
- [O] IN equals [A] SRC
- [A] DST equals [O] OUT
- later [L] HIT equals [O] OUT

matrix_open shows both paths:
- existing file uses cache hit path with [L] HIT equals [O] OUT
- new file uses allocation path with [A] DST equals [O] OUT
- missing file shows no [O] OUT

Conclusion

For successful opens, the returned struct file always points to the dentry name. That name is either copied in __d_alloc or reused from d_lookup. This is why the same pointer is observed at [O] OUT on both paths.
