# AXIOMATIC INSPECTION: USER SPACE

> **RULE**: No new terms without derivation using `readelf`, `objdump`, or `grep`.
> **GOAL**: Trace `minimal_open` from Source Code -> Binary -> Kernel Transition.

## 01. THE SOURCE
**Cmd**: `cat minimal_open.c`
```c
#include <fcntl.h>
#include <unistd.h>
int main() { int fd = open("somefile", O_RDWR); }
```
**Axiom 1**: The user wrote `O_RDWR`.
**Question**: What number is `O_RDWR`?

## 02. THE PREPROCESSOR TRUTH
**Cmd**: `grep -r "define O_RDWR" /usr/include/asm-generic/fcntl.h`
**Output**: `#define O_RDWR 00000002`
**Derivation 1**: The compiler replaces `O_RDWR` with `2`.

## 03. THE COMPILATION
**Cmd**: `gcc -g -O0 minimal_open.c -o minimal_open`
**Axiom 2**: We now have a binary file named `minimal_open`.

## 04. THE BINARY TYPE (Identity)
**Cmd**: `hexdump -C -n 4 minimal_open`
**Output**: `7f 45 4c 46`
**Cmd**: `man ascii` (Lookup 45, 4C, 46) -> `E`, `L`, `F`.
**Derivation 2**: The file format is **ELF**.

## 05. THE INSTRUCTION TRACE (Main)
**Cmd**: `objdump -d -M intel minimal_open | grep -A 10 "<main>:"`
```assembly
1155:	be 02 00 00 00       	mov    esi,0x2
115a:	48 8d 05 a3 0e 00 00 	lea    rax,[rip+0xea3]
1161:	48 89 c7             	mov    rdi,rax
1169:	e8 e2 fe ff ff       	call   1050 <open@plt>
```
**Trace 1**:
1.  `esi` gets `0x2`. (Matches Derivation 1: O_RDWR=2).
2.  `rax` gets Address of String. (We will verify this next).
3.  `rdi` gets `rax`. (ABI Rule: RDI is arg 1).
4.  `call 1050`.

## 06. THE DATA TRACE (String)
**Cmd**: `readelf -x .rodata minimal_open`
**Output**: `somefile` is at offset `0x2004`.
**Math**: Instruction `115a` is at `1161` (next instruction). `0x1161 + 0xea3 = 0x2004`.
**Derivation 3**: `lea` calculated the exact address of "somefile".

## 07. THE TARGET TRACE (PLT)
**Question**: `call 1050`. What is at 1050?
**Cmd**: `objdump -d -M intel minimal_open | grep -A 2 "<open@plt>:"`
```assembly
1050:	f3 0f 1e fa          	endbr64
1054:	ff 25 76 2f 00 00    	jmp    QWORD PTR [rip+0x2f76]
```
**Math**: `0x105a (next) + 0x2f76 = 0x3fd0`.
**Derivation 4**: The code JUMPS to the address stored at `0x3fd0`.

## 08. THE GLOBAL OFFSET TABLE (GOT)
**Cmd**: `readelf -r minimal_open | grep 3fd0`
**Output**: `000000003fd0 ... R_X86_64_JUMP_SLOT ... open@GLIBC_2.2.5`
**Derivation 5**: The address at `0x3fd0` is filled by the **Dynamic Linker** at runtime with the location of `open` in `libc`.

## 09. THE EXTERNAL LIBRARY (Libc)
**Cmd**: `ldd minimal_open`
**Output**: `libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6`
**Derivation 6**: The code for `open` lives in `libc.so.6`.

## 10. THE KERNEL ENTRY (Syscall)
**Cmd**: `objdump -d /lib/x86_64-linux-gnu/libc.so.6 | grep -A 5 "<__open_nocancel>:"`
(finding the raw syscall wrapper)
**Output**:
```assembly
mov eax, 2
syscall
```
**Cmd**: `grep "__NR_open" /usr/include/asm/unistd_64.h` -> `#define __NR_open 2`
**Derivation 7**:
1.  `libc` puts `2` into `RAX`.
2.  `libc` executes `syscall` instruction.
3.  The CPU traps to Kernel.

## SUMMARY OF DERIVATIONS
01. `O_RDWR` -> `2` (Header).
02. `Arg 1` -> `RDI` (Assembly).
03. `Arg 2` -> `RSI` (Assembly).
04. `call open` -> `PLT` -> `GOT` -> `libc` (Linker).
05. `libc` -> `RAX=2` -> `syscall` (Kernel).
