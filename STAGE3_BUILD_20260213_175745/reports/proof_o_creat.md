# PROOF OF O_CREAT VALUE

**Command**: `grep -r "O_CREAT" /usr/include/asm-generic/fcntl.h`
**Output**: `#define O_CREAT 00000100`

**Derivation**:
1.  The number starts with `0`, which means it is **OCTAL** (Base 8).
2.  Octal `100` = (1 * 8^2) + (0 * 8^1) + (0 * 8^0).
3.  Calculation: `1 * 64 + 0 + 0 = 64`.
4.  Hexadecimal: `64` in decimal is `0x40`.

**Conclusion**: The instruction `and $0x40, %r10d` is indeed checking for `O_CREAT`.
