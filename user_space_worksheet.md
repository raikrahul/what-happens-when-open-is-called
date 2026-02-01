# AXIOMATIC WORKSHEET: THE USER SPACE ODYSSEY

> **JOB**: Repair your mental model of "Function Calls".
> **METHOD**: Brute force arithmetic. No "magic".
> **TOOLS**: Pen, Paper, Calculator (Hex/Decimal/Binary).

---

## 01. THE ADDRESS CALCULATION (The Loader's Math)

**CONTEXT**: 
The Operating System loads `libc.so.6` at a random address (ASLR) to prevent hackers from guessing where code is. Your program calls `open`. Your program doesn't know where `open` is. The dynamic linker must calculate it.

**DATA**:
*   `LIBC_BASE` = `0x00007ffff7c00000` (Start of Library in RAM)
*   `OPEN_OFFSET` = `0x000000000011b150` (Location of code inside the file)
*   `PLT_JUMP_SLOT` = `0x3fd0` (Where the answer must be written)

**CALCULATE**:
1.  **Target Address** = `LIBC_BASE` + `OPEN_OFFSET`
    *   *Why*: To find where the CPU must jump.
    *   *Formula*: `0x7ffff7c00000 + 0x11b150`
    *   _Your Answer_: ____________________
    *   _Expected_: `0x7ffff7d1b150` ✓

2.  **Distance to GOT** = `PLT_JUMP_SLOT` - `0x1050` (PLT Start)
    *   *Why*: To see how far the jump is relative to code.
    *   *Formula*: `0x3fd0 - 0x1050`
    *   _Your Answer_: ____________________

---

## 02. THE FLAG LOGIC (The Bitwise Check)

**CONTEXT**:
The `open` function is variadic (can take extra arguments). It needs to know: "Do I need to look for a 3rd argument (Mode)?". It decides this by checking if `O_CREAT` is set in your flags.

**DATA**:
*   `USER_FLAGS` (O_RDWR) = `2` (Decimal) = `0000 0010` (Binary)
*   `O_CREAT_MASK` = `0x40` (Hex) = `64` (Decimal) = `0100 0000` (Binary)
*   `CPU_REGISTER` (r10d) = `USER_FLAGS`

**CALCULATE**:
3.  **Bitwise AND** = `USER_FLAGS` & `O_CREAT_MASK`
    *   *Why*: The instruction `and $0x40, %r10d` executes this.
    *   *Operation*: `0000 0010` AND `0100 0000`
    *   _Your Answer_: ____________________
    *   _Expected_: `0` (Zero Flag Set = TRUE) ✓

4.  **Jump Decision** = IF (Result != 0) GOTO LOAD_ARGS
    *   *Why*: `jne` instruction usage.
    *   *Logic*: Since Result is 0, do we Jump? (Yes/No)
    *   _Your Answer_: ____________________ (No)

---

## 03. THE THREAD SAFETY CHECK (The Optimization)

**CONTEXT**:
`libc` wants to know: "Are there other threads running?". If not, it can avoid expensive lock operations. It checks a global variable.

**DATA**:
*   `SINGLE_THREADED_VAR` = `1` (Integer)
*   `CHECK_VALUE` = `0` (Integer)

**CALCULATE**:
5.  **Comparison** = `SINGLE_THREADED_VAR` != `CHECK_VALUE`
    *   *Why*: `cmpb $0x0, 0xefeae(%rip)`
    *   *Operation*: `1 != 0`
    *   _Your Answer_: ____________________ (True/False)

6.  **Path Selection**: IF (True) GOTO FAST_PATH
    *   *Why*: `je` vs `jne` logic.
    *   *Logic*: Instructions usually branch on equality. Code was `jne` (Jump if Not Equal) to cancellation? No, logic was `je` (Jump if Equal) to something else.
    *   *Refinement*: GDB showed `je 0x...1f4`.
    *   _Task_: If 1 != 0, ZF=0. `je` does NOT jump. It falls through? Wait, analyze the trace. 
    *   *Trace*: `0x7ffff7d1b192: je 0x7ffff7d1b1f4`.
    *   *Observation*: It did NOT jump. It went to `0x7ffff7d1b194`.
    *   *Conclusion*: Function stayed in "Fast Path".

---

## 04. THE REGISTER SHUFFLE (The Transformation)

**CONTEXT**:
You called `open(file, flags)`.
The Kernel expects `openat(dir, file, flags, mode)`.
The registers must be moved.

**DATA**:
*   `OLD_RDI` (File) = Address `0x555555556004`
*   `OLD_RSI` (Flags) = `2`
*   `AT_FDCWD` = `-100` (Decimal)

**CALCULATE**:
7.  **New RDI (Directory)** = Two's Complement of `-100` (32-bit).
    *   *Why*: `mov $0xffffff9c,%edi`.
    *   *Math*: `~100 + 1`
    *   *100 in Hex*: `0x64`.
    *   *Invert*: `0xFFFFFF9B`.
    *   *Add 1*: `0xFFFFFF9C`.
    *   _Your Answer_: ____________________

8.  **New RSI (File)** = `OLD_RDI`
    *   *Why*: `mov %r12, %rsi`.
    *   _Your Answer_: ____________________

9.  **New RDX (Flags)** = `OLD_RSI`
    *   *Why*: `mov %ebx, %edx`.
    *   _Your Answer_: ____________________

10. **New RAX (Syscall)** = `256 + 1`
    *   *Why*: `mov $0x101, %eax`.
    *   _Your Answer_: ____________________

---

## 05. FAILURE PREDICTIONS (What could go wrong?)

1.  **Segfault**: If `LIBC_BASE` + `OPEN_OFFSET` calculated wrong -> Jump to Garbage.
2.  **Logic Error**: If `O_CREAT` check failed -> It would try to read a 3rd argument from `RDX`. `RDX` is garbage/uninitialized in your `main`. Result -> Random File Permissions.
3.  **Syscall Error**: If `RAX` was `2` (old open) instead of `257` (new openat), kernel might reject it or handle it differently? (Actually `2` is `open`, so it would work, but `libc` force-upgrades to `openat`).

---

**FINAL CHECK**:
Did you derive every number?
Did you use the calculator?
Do you trust the `0xffffff9c` now?

✓ ∴ Q.E.D.
