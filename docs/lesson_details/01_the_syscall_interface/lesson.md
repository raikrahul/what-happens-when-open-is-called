# LESSON 01: THE SYSCALL INTERFACE
> **Goal**: Transform "file.txt" (String) into Registers (Hardware).

01. **Axiom**: The Kernel is a Fortress. You cannot just jump to its code.
02. **Axiom**: The CPU provides a Gate. The instruction is `syscall`.
03. **Axiom**: The Protocol (ABI) tells you where to put the tickets.

## THE MATH OF REGISTERS (x86_64 System V ABI)
01. We want to call `open(filename, flags, mode)`.
02. `filename` is a pointer (64-bit address).
03. `flags` is an integer (32-bit).
04. `mode` is an integer (32-bit).
05. `open` acts as function #2 in the Kernel Table.

| Register | Purpose | Value (Example) |
| :--- | :--- | :--- |
| **RAX** | Syscall Number | 2 (sys_open) |
| **RDI** | Argument 1 | 0x7fffffffe (Address of "file.txt") |
| **RSI** | Argument 2 | 0 (O_RDONLY) |
| **RDX** | Argument 3 | 0 (Mode ignored for read) |

## THE TRANSITION
01. User fills RDI, RSI, RDX, RAX.
02. User executes `syscall`.
03. CPU imposes **Ring 0** (God Mode).
04. CPU jumps to address stored in **MSR_LSTAR**.
05. Kernel wakes up.

## PROOF: SKELETON CODE
01. Open `proofs/00_register_dump.c`.
02. We will use Inline Assembly to see this happen.
