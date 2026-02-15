---
layout: default
title: "Stage 2 Return - Print Version"
---

================================================================================
STAGE 2 (RETURN): KERNEL SPACE - TRACING do_filp_open RETURN
================================================================================

PREREQUISITE: You traced the ARGUMENTS of do_filp_open().
Now we trace the RETURN VALUE: "struct file *".

SOURCE CODE:
    https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/drivers/trace_do_filp_open/trace_do_filp_open.c

================================================================================
AXIOM 0: THE CALL RETURN
================================================================================

FUNCTION:
    struct file *do_filp_open(int dfd, struct filename *pathname, ...)

RETURN REGISTER (x86_64):
    RAX holds the return value.

Success: RAX > 0xffff800000000000 (Valid Kernel Pointer)
Failure: RAX > -4095 (MAX_ERRNO in include/linux/err.h)

DERIVATION OF FAILURE CHECK:
1. include/linux/err.h:18  #define MAX_ERRNO 4095
2. include/linux/err.h:28  IS_ERR_VALUE(x) ... >= (unsigned long)-MAX_ERRNO
3. ∴ Error range is [0xfffffffffffff001, 0xffffffffffffffff] in 64-bit.
4. Any pointer below this range is VALID.

================================================================================
AXIOM 1: WHAT IS STRUCT FILE? (Kernel 6.14+ Reality)
================================================================================

SOURCE: include/linux/fs.h / vmlinux (via GDB)

struct file {
    ...
    struct path     f_path;      // The dentry/mnt pair
    struct inode    *f_inode;    // The vnode/inode
    const struct file_operations *f_op;
    file_ref_t      f_ref;       // <-- CHANGED: Replaces atomic_long_t f_count
    unsigned int    f_flags;     // O_RDWR, etc.
    fmode_t         f_mode;      // FMODE_READ | FMODE_WRITE
    loff_t          f_pos;       // File offset
    ...
}

AXIOMATIC VERIFICATION:
We presumed `f_count`. The compiler failed.
GDB `ptype struct file` revealed `f_ref`.
We adapted. We do not guess. We trace.

================================================================================
AXIOM 2: ATOMICITY OF REFERENCE COUNTING
================================================================================

Field: file_ref_t f_ref (wraps atomic_long_t);

WHY ATOMIC?
1. File objects are SHARED. (fork(), dup(), threads).
2. Multiple CPUs may call fput() or get_file() simultaneously.
3. RWM (Read-Modify-Write) race condition exists on "f_count++".

THE FIX:
    atomic_long_inc(&f->f_ref.counter); // via helpers

THE TRACE:
    To READ this value safely in our probe, the direct member access failed.
    We MUST use the accessor macro:
    file_count(ret_file)

    Under the hood (x86_64):
    - READ is naturally atomic for aligned 64-bit loads (MOV instruction).
    - LOCK prefix is NOT used for READ.
    - LOCK prefix IS used for INC/DEC/ADD (RWM).

================================================================================
AXIOM 3: THE FILENAME MATCH
================================================================================

INPUT:  pathname->name ("somefile")
OUTPUT: ret_file->f_path.dentry->d_name.name

OBSERVATION:
    They match string-for-string.

DERIVATION:
    1. do_filp_open() calls path_openat().
    2. path_openat() -> link_path_walk() parses input name "somefile".
    3. lookup calls d_alloc() (fs/dcache.c:1622 __d_alloc).
    4. fs/dcache.c:1660: memcpy(dname, name->name, name->len);
    5. fs/dcache.c:1664: smp_store_release(&dentry->d_name.name, dname);
    6. ∴ The dentry's name IS a copy of the input component name.

================================================================================
TRACE OUTPUT ANALYSIS
================================================================================

[  123.456] ret_file is a pointer: ffff88800abc1200
[  123.456] ret_file->f_pos: 0
[  123.456] ret_file->f_flags: 0x8002 (O_RDWR | O_LARGEFILE)
[  123.456] ret_file->f_count: 1 (via file_count())
[  123.456] ret_file->f_path.dentry->d_name.name: somefile

This confirms our understanding of the file object creation.

================================================================================
NEXT STEP: THE FILE DESCRIPTOR
================================================================================

We have a struct file *.
User Space needs an INT (fd).

Function: fd_install(fd, f) maps them.

We will trace this mapping next.
