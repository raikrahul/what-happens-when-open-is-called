# Step-by-Step Linking Process: From Object File to Executable

## Initial State: Object File (`minimal_open.o`)

### 1. Your Source Code
```c
int main() {
    int fd1 = open("file", O_RDWR);
    int fd2 = open("otherfile", O_RDWR);
}
```

### 2. Object File Disassembly
```assembly
main:
   20:	e8 00 00 00 00     call   25 <main+0x25>     ; First open() - ZEROS!
   3c:	e8 00 00 00 00     call   41 <main+0x41>     ; Second open() - ZEROS!
```

### 3. Relocation Entries (What needs fixing)
```
Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000021  000500000004 R_X86_64_PLT32    0000000000000000 open - 4
00000000003d  000500000004 R_X86_64_PLT32    0000000000000000 open - 4
```
- **Offset 21**: First call location (20 + 1 for call instruction encoding)
- **Type 4**: `R_X86_64_PLT32` - needs PLT relocation
- **Symbol open**: External function in libc

## Linking Process: What `ld` Does

### 4. Linker Creates PLT Section
The linker decides **where** PLT goes based on:
- Memory layout requirements
- Section alignment
- Existing sections in the final executable
- Randomization (ASLR)

**Why 0x1050?** This is the address the linker chose for:
- After `.text` section (your main code at ~0x1060)
- Before other sections
- Proper alignment for code sections

### 5. PLT Structure Created by Linker
```
Address    What Linker Creates
---------  -------------------
0x1050     open@plt:
           jmp *got_entry(%rip)  ; Jump to GOT entry
           nop                   ; Padding
```

### 6. GOT Structure Created by Linker
```
Address    What Linker Creates
---------  -------------------
0x3fd0     open@got:  
           .quad 0x0000000000000000  ; Initially zero, patched at runtime
```

### 7. Your Code Gets Fixed
```assembly
; Before linking:
20: e8 00 00 00 00     call   25 <main+0x25>  ; Zeros!

; After linking:
1169: e8 e2 fe ff ff   call   1050 <open@plt> ; Now calls PLT!
```

**How the fix works:**
- `1169 + 5 + ffffffe2 = 1050` (PC-relative calculation)
- Linker calculates: `target - next_instruction_address`

## How PLT Knows Which Function

### 8. One PLT Entry Per Function
```
0x1050  <open@plt>      ; Stub for open()
0x1060  <printf@plt>    ; Stub for printf() (if used)
0x1070  <malloc@plt>    ; Stub for malloc() (if used)
...etc
```

### 9. One GOT Entry Per Function
```
0x3fd0  <open@got>      ; Data for open()
0x3fd8  <printf@got>    ; Data for printf() (if used)
0x3e00  <malloc@got>    ; Data for malloc() (if used)
...etc
```

### 10. The Mapping Process
```
Symbol name → PLT stub address → GOT entry address
"open"      → 0x1050           → 0x3fd0
"printf"    → 0x1060           → 0x3fd8
"malloc"    → 0x1070           → 0x3e00
```

## Runtime Process

### 11. First Call to open()
```
1. Your code: call 1050 <open@plt>
2. PLT stub at 1050: jmp *0x2f76(%rip)  → jumps to GOT at 0x3fd0
3. GOT at 0x3fd0: contains address of dynamic linker
4. Dynamic linker: 
   - Finds "open" in libc.so.6
   - Gets real address: 0x7f1234567890
   - Patches GOT: 0x3fd0 = 0x7f1234567890
   - Calls real open()
```

### 12. Second Call to open()
```
1. Your code: call 1050 <open@plt>
2. PLT stub at 1050: jmp *0x2f76(%rip)  → jumps to GOT at 0x3fd0
3. GOT at 0x3fd0: now contains 0x7f1234567890
4. Direct jump to real open() (no dynamic linker needed!)
```

## Memory Layout Summary

```
Virtual Memory Layout:
+-------------------+ 0x1000
| Code sections     |
| .text (your main) | ~0x1060
| .plt              | ~0x1050
| open@plt code     | 0x1050: jmp *got_entry
+-------------------+
+-------------------+
| Data sections     |
| .got              | ~0x3fb8
| open@got data     | 0x3fd0: [real address]
+-------------------+
+-------------------+
| Other sections... |
+-------------------+
```

## Key Rules

1. **PLT = Code**: Executable instructions that redirect calls
2. **GOT = Data**: Addresses that get patched at runtime
3. **One-to-One**: Each external function gets one PLT entry + one GOT entry
4. **Address Calculation**: Linker chooses addresses based on memory layout
5. **First Call**: Goes through dynamic linker
6. **Subsequent Calls**: Direct jump via patched GOT

## Verification Commands

```bash
# See object file with relocations
objdump -d minimal_open.o
readelf -r minimal_open.o

# See final executable
objdump -d minimal_open | grep plt
readelf -x .got minimal_open

# See the connection
objdump -d minimal_open | grep -A 2 "open@plt"
# Look at the jmp instruction address and calculate GOT location
```

This complete process shows how zeros in object files become resolved function calls through the PLT/GOT mechanism.