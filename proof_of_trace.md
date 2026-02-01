# PROOF OF EXECUTION TRACE

> **Goal**: Validate `execution_trace_debugger.txt` (L1-L59) with concrete evidence.
> **Source**: `gdb` batch session (Step 497).

## 01. CALL SITE PROOF
**Claim**: Arguments are `somefile` and `2 (O_RDWR)`. Next is `0x1050`.
**Evidence**:
```assembly
0x555555555155 <+12>:    mov    $0x2,%esi             ; RSI = 2 (Arg 2)
0x55555555515a <+17>:    lea    0xea3(%rip),%rax      ; RAX = Address of String
0x555555555161 <+24>:    mov    %rax,%rdi             ; RDI = RAX (Arg 1)
0x555555555169 <+32>:    call   0x555555555050 <open@plt>
```
*Note: GDB shows `0x5050` (PIE offset), which matches the static `1050` relative offset.*

## 02. TRAMPOLINE PROOF
**Claim**: `open@plt` jumps to `open@got.plt`.
**Evidence**:
```assembly
0x555555555054 <+4>:     jmp    *0x2f76(%rip)         # 0x555555557fd0 <open@got.plt>
```
**Math**: `0x505a` (Next IP) + `0x2f76` = `0x7fd0`.
**Runtime**: The dynamic linker put the address of `__libc_open64` here.

## 03. LIBRARY ENTRY PROOF
**Claim**: Execution lands at `__libc_open64`. Prologue saves registers.
**Evidence**:
```assembly
0x7ffff7d1b150 <__libc_open64>:      endbr64 
0x7ffff7d1b154 <__libc_open64+4>:    push   %rbp
0x7ffff7d1b155 <__libc_open64+5>:    mov    %esi,%r10d  ; Save flags (2) to R10
0x7ffff7d1b158 <__libc_open64+8>:    mov    %rsp,%rbp
...
0x7ffff7d1b163 <__libc_open64+19>:   sub    $0x60,%rsp  ; Reserve 96 bytes
```

## 04. MODE LOGIC PROOF
**Claim**: Code checks `O_CREAT` (0x40).
**Evidence**:
```assembly
0x7ffff7d1b17a <__libc_open64+42>:   and    $0x40,%r10d ; Check bit 6 (64)
0x7ffff7d1b17e <__libc_open64+46>:   jne    ...         ; Jump if set
```
**Calculation**:
User input: `2` (Binary `0000 0010`)
O_CREAT: `64` (Binary `0100 0000`)
Result: `0000 0010 & 0100 0000` = `0`.
**Conclusion**: `Zero Flag` is set. `jne` does NOT jump. Code falls through.

## 05. THREAD SAFETY PROOF
**Claim**: Checks `__libc_single_threaded`.
**Evidence**:
```assembly
0x7ffff7d1b18b <__libc_open64+59>:   cmpb   $0x0,0xefeae(%rip)
```
**Runtime Data**:
`gdb` command `p *(int*)0x7ffff7e0b040` returned `$2 = 1`.
*Wait, correction*: My manual trace assumed 0. The output shows `1`.
**Correction**: The `cmpb` compares with 0. The value is 1. `1 != 0`.
**Impact**: The jump `je` at `<+66>` will NOT be taken if it expects equality?
Let's check logic: `je 0x...1f4`.
If value is 1 (Single Threaded optimization ON?), it might jump.
Actually, let's look at the symbol name in GDB output: `0x7ffff7e0b040 <__libc_single_threaded>`.
If it is 1, it means "Single Threaded".
If it is 0, it means "Multi Threaded" (safety needed).

## 06. ARGUMENT TRANSLATION PROOF
**Evidence** (From previous trace, valid for Fast Path):
```assembly
mov    $0xffffff9c,%edi ; -100 (AT_FDCWD)
mov    $0x101,%eax      ; 257 (openat)
syscall
```
**Math**: `0x101` = 256 + 1 = 257.
