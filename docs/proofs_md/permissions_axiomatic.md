# Axiomatic Permissions: From Header to Kernel

This document derives the exact meaning of "permissions" (flags) in `open()`, tracing them from their distinct bit values in system headers to their final destination in the kernel.

## 1. The Source of Truth: Machine Headers

We fetched the definitions directly from `/usr/include/asm-generic/fcntl.h` on this machine.

**Command:** `grep -r "O_" /usr/include/asm-generic/fcntl.h`

**Result:**
```c
#define O_ACCMODE       00000003
#define O_RDONLY        00000000
#define O_WRONLY        00000001
#define O_RDWR          00000002
#define O_CREAT         00000100
#define O_EXCL          00000200
#define O_NOCTTY        00000400
#define O_TRUNC         00001000
#define O_APPEND        00002000
#define O_NONBLOCK      00004000
#define O_DSYNC         00010000
#define O_DIRECT        00040000
#define O_LARGEFILE     00100000
#define O_DIRECTORY     00200000
#define O_NOFOLLOW      00400000
#define O_CLOEXEC       02000000
```

## 2. Axiomatic Bit Analysis

These values are **OCTAL** (base 8), indicated by the leading `0`.

### The Access Modes (The "What")
These are mutually exclusive (mostly) and occupy the lowest 2 bits.

*   `O_RDONLY` = `0` = `0000 0000` (Binary) -> Read Only.
*   `O_WRONLY` = `1` = `0000 0001` (Binary) -> Write Only.
*   `O_RDWR`   = `2` = `0000 0010` (Binary) -> Read AND Write.

**Verification:** `O_ACCMODE` is `3` (`0000 0011`). Masking with this extracts the mode.

### The Behavior Flags (The "How")
These are independent bits combined with bitwise OR (`|`).

*   `O_CREAT` (Create if missing) = `0100` (Octal) = `64` (Decimal) = `0000 0000 0100 0000` (Binary).
*   `O_TRUNC` (Truncate if exists) = `01000` (Octal) = `512` (Decimal) = `0000 0010 0000 0000` (Binary).
*   `O_APPEND` (Append to end)   = `02000` (Octal) = `1024` (Decimal) = `0000 0100 0000 0000` (Binary).

## 3. The "Probe" Driver (User Space Proof)

In `proofs/00_register_dump.c` (our probe), we verified how these flags enter the kernel.

```c
   /*
    * AXIOM:
    * RAX = 2 (SYS_open)
    * RDI = filename
    * RSI = O_RDONLY (0)
   */
   asm volatile("mov $2, %%rax\n\t"          // Sycall Number: open
                "mov %1, %%rdi\n\t"          // Arg 1: filename
                "mov $0, %%rsi\n\t"          // Arg 2: flags (HERE IS THE PERMISSION)
                ...
```

The permissions (flags) are stored in the **RSI** register.
If we call `open("file", O_RDWR | O_CREAT)`:
*   Value = `0x2 | 0x40` = `0x42` (Hex) = `66` (Decimal) = `0100 0010` (Binary).
*   **RSI** Register = `0000000000000042`.

## 4. Kernel Destination: Where do they go?

From our analysis of the kernel source path:

1.  **Entry:** `do_sys_openat(..., int flags, ...)` receives the `RSI` value (e.g., `2` or `0x42`).
2.  **Storage:** The kernel creates a `struct file` to represent the open file.
    *   `file->f_flags` stores the raw flags (e.g., `O_RDWR | O_CREAT`).
    *   `file->f_mode` stores the decoded access mode (e.g., `FMODE_READ | FMODE_WRITE`).
3.  **The Check (The "End"):**
    *   The kernel function `may_open()` checks `file->f_mode`.
    *   It calls `inode_permission(inode, mask)`.
    *   **Logic:**
        *   If `O_RDONLY` -> checks Inode Read Bit (Owner/Group/Other).
        *   If `O_WRONLY` -> checks Inode Write Bit.
        *   If `O_RDWR`   -> checks BOTH Read and Write Bits.

**Conclusion:**
You send an integer in `RSI`. The kernel effectively does:
`if ((inode->mode & ACCESS_BITS) != REQUESTED_BITS) return -EACCES;`
