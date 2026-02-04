# GDB DISASSEMBLY ANALYSIS: __libc_open64

> **Goal**: Read the raw assembly from `gdb` and confirm the `openat` hypothesis.

## 01. THE KEY INSTRUCTIONS
The disassembly shows two paths (threading related), but both converge on the **SYSCALL**.

### Path A (Instructions +73 to +83)
```assembly
0x7ffff7d1b199 <+73>:    mov    $0xffffff9c,%edi   ; RDI = -100 (AT_FDCWD)
0x7ffff7d1b19e <+78>:    mov    $0x101,%eax        ; RAX = 257 (openat)
0x7ffff7d1b1a3 <+83>:    syscall                   ; THE TRAP
```

### Path B (Instructions +190 to +195)
```assembly
0x7ffff7d1b20e <+190>:   mov    $0x101,%eax        ; RAX = 257 (openat)
0x7ffff7d1b213 <+195>:   syscall                   ; THE TRAP
```

## 02. AXIOMATIC CONFIRMATION
1.  **Syscall Number**: `0x101` in Hex is `257` in Decimal.
    - `grep 257 /usr/include/asm/unistd_64.h` -> `__NR_openat`.
2.  **Argument 1**: `0xffffff9c` in Hex (Two's Compliment) is `-100`.
    - `grep -r AT_FDCWD /usr/include/linux/fcntl.h` -> `-100`.

## 03. CONCLUSION
The `gdb` output logically proves that `__libc_open64` sets up registers for `sys_openat`, not `sys_open`.

NEW THINGS INTRODUCED WITHOUT DERIVATION: NONE.
