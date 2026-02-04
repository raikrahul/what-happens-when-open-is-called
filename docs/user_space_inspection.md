# THE IMPOSSIBLE JUMP: USER SPACE RESOLUTION

> **PUZZLE**: How does immutable code (`call`) invoke a randomized target (`ASLR`)?
> **ANSWER**: Runtime Address of `open` is **`0x7ffff7d1b150`**.

## 01. THE STATIC PARADOX
**Code**: `call 0x555555555050` (in `main`)
**Binary File**: Read-Only.
**Problem**: The binary cannot know `0x7ffff...`. It assumes `open` is at `0x5050`.


## 01.5 THE INVISIBLE LINKER
**Command**: `gcc minimal_open.o` is a LIE. It runs `collect2` -> `ld`.
**Actual Command**:
```bash
ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
   /usr/lib/x86_64-linux-gnu/Scrt1.o \  # Startup Code (_start)
   /usr/lib/x86_64-linux-gnu/crti.o \   # Init Code
   minimal_open.o \                     # YOUR CODE
   -lc \                                # Libc (open lives here)
   /usr/lib/x86_64-linux-gnu/crtn.o \   # Shutdown Code
   -o minimal_open
```
**Observation**: You provide 1 file. The Linker combines 6 files.
**Result**: `_start` (from Scrt1.o) calls `main` (from minimal_open.o).

## 02. THE TRAMPOLINE (PLT) MECHANISM
**Address**: `0x0000000000001050`
**Instruction**: `jmp QWORD PTR [rip+0x2f76]`
**Machine Code**: `ff 25 76 2f 00 00` at `1054`
**Next RIP**: `105a` (Address of next instruction)


## 03. THE CALCULATION (RIP RELATIVE)
**Equation**: `Next IP` + `Offset` = `Storage Address`
**Values**:
  `0x000000000000105a`  (Next RIP: verified from objdump `1054 + 6 bytes`)
+ `0x0000000000002f76`  (Offset: from machine code `ff 25 76 2f...`)
------------------
  **`0x0000000000003fd0`**  (Global Offset Table Entry)

## 04. THE LOOKUP (GOT)
**Address**: `0x0000000000003fd0`
**Type**: Read/Write Memory (Data Segment).
**Binding**: Validated by `readelf -r`: `000000003fd0 ... R_X86_64_JUMP_SLOT ... open`
**Content**: `0x00007ffff7d1b150` (Populated by `ld-linux` at load time).

## 05. THE VERIFICATION
**Target**: `0x7ffff7d1b150`
**Mapping**: `0x7ffff7c00000` (Libc Base from `/proc/maps`) + `0x11b150` (Offset from `readelf`).
**Math**: `0x7ffff7c00000 + 0x11b150 = 0x7ffff7d1b150`.
**Conclusion**: The CPU jumps to valid executable code in `libc.so.6`.

## SUMMARY OF CHAIN
1.  **Main** calls **PLT** (`1050`).
2.  **PLT** calculates **GOT** address (`3fd0`).
3.  **GOT** holds **Libc** address (`...150`).
4.  **CPU** redirects to **Libc**.

**Q.E.D.**
