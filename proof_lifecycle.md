# THE LIFECYCLE OF OPEN: FROM SCRATCH

## 01. THE SOURCE (TEXT)
**File**: `minimal_open.c`
**State**: `open("file", O_RDWR)`
**Fact**: It is just text.

## 02. THE COMPILER (THE BLANK)
**Command**: `gcc -c`
**File**: `minimal_open.o`
**Instruction**: `e8 00 00 00 00` (Call 0)
**Fact**: The Compiler does not know where `open` is.

## 03. THE STATIC LINKER (THE STRUCTURE)
**Command**: `ld ...`
**File**: `minimal_open` (Executable)
**Instruction**: `e8 e2 fe ff ff` (Call PLT)
**PLT Code**: `jmp *GOT` (Jump to Address Book)
**GOT Value**: `0x1030` (Points back to Resolver)
**Fact**: The Linker builds the Bridge, but the Address Book is empty (lazy).

## 04. THE RUNTIME (THE RESOLUTION)
**Experiment**: Trace `0x3fd0` (GOT Slot) from program start.

**[BEFORE EXECUTION]**
At `_start` (Instruction 0):
`0x555555557fd0 <open@got.plt>:  0x0000000000001030`
*   **Analysis**: It points to `0x1030` (Static Resolver in PLT).
*   **Meaning**: "I don't know the address yet."

**[AFTER EXECUTION]**
At `main` (Runtime):
`0x555555557fd0 <open@got.plt>:  0x00007ffff7d1b150`
*   **Analysis**: It points to Libc (`0x7ffff...`).
*   **Meaning**: "Address Found and Patched."

**Conclusion**: The GOT is a **Mutable Board**. It starts with a Question (`1030`) and ends with an Answer (`7ffff...`).

## 05. THE RESULT
**Subsequent Calls**: Jump directly to `0x7ffff...`.
