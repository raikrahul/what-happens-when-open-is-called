# EXECUTION TRACE: THE LONG WALK TO SYSCALL

> **Goal**: Account for every action between `call open` and `syscall`.
> **Source**: GDB Disassembly of `__libc_open64`.

## 01. THE CALL (User Space)
**Instruction**: `call 1050 <open@plt>`
**Explanation**: You aren't calling `libc` directly. You are calling a "Trampoline" in your own binary.
**Proof**: `objdump -d minimal_open`.

## 02. THE TRAMPOLINE (PLT)
**Address**: `0x1050`
**Instruction**: `jmp QWORD PTR [rip+0x2f76]`
**Explanation**: This looks at the Global Offset Table (GOT).
**Proof**: `gdb` showed `jmp *0x3fd0`.
**Derivation**: The **Dynamic Linker** has already written the address of `__libc_open64` into this slot.

## 03. THE ENTRY (Libc)
**Address**: `0x7ffff7d1b150`
**Instruction**: `endbr64`
**Explanation**: **End Branch 64**. A security instruction (Intel CET). If the previous instruction wasn't a valid call/jump, the CPU crashes.
**Derivation**: Protection against ROP attacks.

## 04. THE PROLOGUE (Stack Setup)
**Instructions**:
```assembly
push   %rbp
mov    %rsp,%rbp
push   %r12
push   %rbx
sub    $0x60,%rsp    ; Reserve 96 bytes on stack
```
**Explanation**: The function is saving your registers (`rbp`, `r12`, `rbx`) so it can use them, and making space for its own local variables.

## 05. THE CANARY (Stack Protection)
**Instruction**: `mov %fs:0x28,%rax`
**Explanation**: It reads a secret random number from "Thread Local Storage" (FS Register).
**Instruction**: `mov %rax,-0x48(%rbp)`
**Explanation**: It places this secret on the stack. Before returning, it will check if this number changed. If it did, it means a Buffer Overflow occurred.

## 06. THE CHECK (Cancellation)
**Instruction**: `and $0x40,%r10d` (Check `O_CREAT` flag? No, checking internal state).
**Instruction**: `cmpb $0x0,0xefeae(%rip)` (Check `__libc_single_threaded`)
**Explanation**:
-   **If 0 (Single Threaded)**: It takes the fast path (Path A).
-   **If 1 (Multi Threaded)**: It takes the slow path (Path B) to enable "Asynchronous Cancellation" (so you can kill a stuck thread).
**Proof**: Your GDB trace took **Path A** (Fast).

## 07. THE PREPARATION (Register Shuffle)
**Instructions**:
```assembly
mov    %r12,%rsi        ; Move Filename to RSI
mov    $0xffffff9c,%edi ; Move -100 (AT_FDCWD) to EDI
mov    $0x101,%eax      ; Move 257 (openat) to EAX
```
**Explanation**: The ABI requires arguments in specific registers. `libc` moves them into place.

## 08. THE TRAP (Kernel Entry)
**Instruction**: `syscall`
**Action**:
1.  CPU saves next instruction address to `RCX`.
2.  CPU saves flags to `R11`.
3.  CPU jumps to address in `MSR_LSTAR` (Kernel Mode).
**Limit**: This is the end of User Space.

## SUMMARY
1.  **Trampoline** (PLT jump).
2.  **Security** (Endbr64, Stack Canary).
3.  **Optimization** (Single vs Multi-thread check).
4.  **Translation** (open arguments -> openat arguments).
5.  **Trap** (Syscall).
