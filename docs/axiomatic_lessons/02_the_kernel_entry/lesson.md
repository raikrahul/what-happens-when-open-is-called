# LESSON 02: THE KERNEL ENTRY
> **Goal**: Cross the boundary from Ring 3 (User) to Ring 0 (Kernel).

01. **Axiom**: Ring 3 is the "Playpen". Ring 0 is the "Control Room".
02. **Axiom**: To leave the playpen, you must trigger a Trap.

## THE MECHANISM (Hardware)
01. You executed `syscall`.
02. The CPU looks at a special register called `MSR_LSTAR` (Long System Target Address Register).
03. This register contains the address of `entry_SYSCALL_64` function in the kernel.
04. The CPU saves your return address to `RCX`.
05. The CPU jumps to `entry_SYSCALL_64`.
06. **Ring Change**: You are now in Ring 0.

## THE ROUTING (Software)
01. `entry_SYSCALL_64` is Assembly code.
02. It builds the stack for the kernel.
03. It looks at `RAX` (which you set to 2).
04. It looks up index 2 in `sys_call_table`.
05. `sys_call_table[2]` points to `__x64_sys_openat` (or `sys_open`).

## YOUR JOB
1.  We cannot "prove" this in userspace easily without crashing.
2.  But we can verify the address of `sys_call_table` if we had root and /proc/kallsyms.
3.  For now, trust the Axiom B03 (`MSR_LSTAR`).
