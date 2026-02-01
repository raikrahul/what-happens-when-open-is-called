# THE IMPOSSIBLE JUMP: USER SPACE RESOLUTION

> **PUZZLE**: How does immutable code (`call`) invoke a randomized target (`ASLR`)?
> **ANSWER**: Runtime Address of `open` is **`0x7ffff7d1b150`**.

## 01. THE STATIC PARADOX
**Code**: `call 0x555555555050` (in `main`)
**Binary File**: Read-Only.
**Problem**: The binary cannot know `0x7ffff...`. It assumes `open` is at `0x5050`.

## 02. THE TRAMPOLINE (PLT) MECHANISM
**Address**: `0x555555555050`
**Instruction**: `jmp QWORD PTR [rip+0x2f76]`
**Machine Code**: `ff 25 76 2f 00 00` at `0x555555555054`
**Next RIP**: `0x55555555505a` (Address of next instruction)

## 03. THE CALCULATION (RIP RELATIVE)
**Equation**: `Next IP` + `Offset` = `Storage Address`
**Values**:
  `0x55555555505a`  (Next RIP)
+ `0x000000002f76`  (Offset)
------------------
  **`0x555555557fd0`**  (Global Offset Table Entry)

## 04. THE LOOKUP (GOT)
**Address**: `0x555555557fd0`
**Type**: Read/Write Memory (Data Segment).
**Content**: `0x00007ffff7d1b150` (Populated by `ld-linux` at load time).

## 05. THE VERIFICATION
**Target**: `0x7ffff7d1b150`
**Mapping**: `0x7ffff7c00000` (Libc Base) + `0x11b150` (Offset).
**Segment**: `0x7ffff7c28000` - `0x7ffff7db0000` (`r-xp`).
**Conclusion**: The CPU jumps to valid executable code in `libc.so.6`.

## SUMMARY OF CHAIN
1.  **Main** calls **PLT** (`0x5050`).
2.  **PLT** calculates **GOT** address (`0x7fd0`).
3.  **GOT** holds **Libc** address (`0x...150`).
4.  **CPU** redirects to **Libc**.

**Q.E.D.**
