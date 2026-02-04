# THE METAMORPHOSIS OF OPEN

> **Goal**: Track the symbol `open` from Text -> Object -> Link -> Library.
> **Constraint**: Primate Math. Address tracking.

## 01. SOURCE CODE (The Egg)
**Cmd**: `cat minimal_open.c`
```c
int main() { open("...", 2); }
```
**Observation**: The user wrote "open".

## 02. PREPROCESSOR (The Larva)
**Cmd**: `gcc -E minimal_open.c | tail`
```c
int main() { int fd = open("somefile", 02); }
```
**Derivation**: The token `open` is UNCHANGED. It is still just "open".
**Check**: No `#define open __open64` was found in the output.

## 03. COMPILATION (The Pupa - Object File)
**Cmd**: `gcc -c minimal_open.c -o minimal_open.o`
**Cmd**: `readelf -r minimal_open.o`
```text
Relocation section '.rela.text':
Offset          Type            Sym. Value    Sym. Name
000000000021    R_X86_64_PLT32  000000000000  open - 4
```
**Derivation**:
1.  The compiler does NOT know where `open` is.
2.  It creates a **Relocation Record** (Type `PLT32`).
3.  It puts a placeholder in the code (`00 00 00 00`).
**Cmd**: `objdump -d minimal_open.o`
```assembly
20:   e8 00 00 00 00          call   25 <main+0x25>
```
**Math**: The address is `00 00 00 00` (The void).

## 04. LINKING (The Butterfly - Binary)
**Cmd**: `gcc minimal_open.o -o minimal_open`
**Cmd**: `objdump -d minimal_open | grep "call"`
```assembly
1169:   e8 e2 fe ff ff          call   1050 <open@plt>
```
**Derivation**:
1.  The Linker replaced `00 00 00 00` with `e2 fe ff ff`.
2.  Math: `0x116e (Next IP) + 0xfffffffffffee2 = 0x1050`.
3.  `open` is now `open@plt`.

## 05. DYNAMIC RESOLUTION (The Nectar - Runtime)
**Question**: Who is `open` really?
**Cmd**: `nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep -w "open"`
```text
000000000011b150 W open@@GLIBC_2.2.5
```
**Observation**:
1.  `W` means **Weak Symbol**.
2.  It is an Alias.

**Cmd**: `readelf -s /lib/x86_64-linux-gnu/libc.so.6 | grep 11b150`
```text
   272: 000000000011b150   280 FUNC    GLOBAL DEFAULT   17 __open_nocancel
   ...
   1763: 000000000011b150   280 FUNC    WEAK   DEFAULT   17 open@@GLIBC_2.2.5
```
**CRITICAL DERIVATION**:
1.  `open` has address `...11b150`.
2.  `__open_nocancel` has address `...11b150`.
3.  **Therefore**: `open` IS `__open_nocancel` (or `__libc_open`).

## 06. THE TRUTH
The function making the syscall is NOT just `open`.
It is `__open_nocancel` inside `libc`.

**Visual Chain**:
`open` (Source) -> `R_X86_64_PLT32` (Object) -> `open@plt` (Binary) -> `__open_nocancel` (Libc) -> `syscall` (Kernel).
