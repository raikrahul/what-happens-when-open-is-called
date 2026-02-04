# LESSON 05: THE RETURN
> **Goal**: Hand the Integer back to User.

01. **Axiom**: We are deep in Kernel stack. We must go back to User Ring 3.
02. **Axiom**: The result (`3`) must be placed in `RAX`.

## THE EXIT PATH
01. Kernel function `sys_open` finishes. Returns `3`.
02. `entry_SYSCALL_64` logic restores your registers (RDI, RSI, etc. are restored or clobbered depending on ABI).
03. CPU executes `sysretq` (or `iretq`).
04. **Ring Change**: Back to Ring 3.
05. Next instruction after `syscall` in your code executes.

## THE ERROR PATH
01. If Stage 0 or 3 failed (File not found), Kernel returns negative number internally (e.g. `-2` for ENOENT).
02. The glibc wrapper (User space) sees `-2`.
03. Protocol:
    - Put `-1` in `RAX` (Return value).
    - Put `2` in global variable `errno`.
04. You see `return -1`.

## FINAL PROOF
1.  Run `proofs/00_register_dump.c` again.
2.  Observe the positive return value.
3.  Change filename to "ghost.txt" in the C code.
4.  Observe the negative return value (raw syscall returns negative, wrapper handles errno).

## CONGRATULATIONS
You have traversed the system.
Input (String) -> Register -> Trap -> Inode -> File Object -> FD -> Return (Integer).
01. Axiom of Identity verified.
02. Axiom of Causality verified.
