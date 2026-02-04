# PROOF: THE WRAPPER (USER SPACE FINALE)

## 01. THE DISASSEMBLY (THE CODE)
**Command**: `disassemble open` (in GDB)
**Address**: `0x7ffff7d1b150`

```asm
   0x7ffff7d1b199 <+73>:    mov    $0xffffff9c,%edi
   0x7ffff7d1b19e <+78>:    mov    $0x101,%eax
   0x7ffff7d1b1a3 <+83>:    syscall
```

## 02. LINE 1: THE MAGIC CONSTANT
**Instruction**: `mov $0xffffff9c, %edi`
**Value**: `0xffffff9c` (Hex) = `-100` (Decimal).
**Axiom**: `grep AT_FDCWD /usr/include/linux/fcntl.h` returns `-100`.
**Meaning**: "Use Current Working Directory".
**Derivation**: The first argument (`rdi`) is set to `AT_FDCWD`.

## 03. LINE 2: THE SYSCALL NUMBER
**Instruction**: `mov $0x101, %eax`
**Value**: `0x101` (Hex) = `257` (Decimal).
**Axiom**: `grep 257 /usr/include/asm/unistd_64.h` returns `__NR_openat`.
**Meaning**: "I am requesting Syscall #257 (OpenAt)."
**Discovery**: Glibc uses `openat` to implement `open`.

## 04. LINE 3: THE TRANSITION
**Instruction**: `syscall`
**Action**: The CPU switches from Ring 3 (User) to Ring 0 (Kernel).
**Next Step**: The Kernel takes over.

**Q.E.D.**
We have proven that `open()` converts your filename into `openat(AT_FDCWD, filename, ...)` and executes Syscall #257.
