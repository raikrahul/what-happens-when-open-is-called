# PLT-GOT Mathematical Relationship

## The Core Mathematical Relationship

### Equation 1: GOT Address Calculation
```
got_address = plt_instruction_address + instruction_length + displacement
```

Where:
- `plt_instruction_address` = where the `jmp` instruction is in PLT
- `instruction_length` = 6 bytes for `jmp *disp(%rip)`
- `displacement` = the 32-bit value in the instruction

### Equation 2: PLT-to-GOT Mapping
```
GOT[index] = GOT_base + (index * 8)
```

## Step-by-Step Mathematical Proof

### Step 1: Find GOT Base Address
From readelf:
```
.got section starts at: 0x3fb8
```

### Step 2: Calculate Each GOT Entry

**For open():**
```
PLT instruction: 0x1054  jmp *0x2f76(%rip)
GOT address = 0x1054 + 6 + 0x2f76 = 0x3fd0
```

**Verification:**
```
open is 3rd external function (index 3)
GOT[3] = 0x3fb8 + (3 * 8) = 0x3fb8 + 24 = 0x3fd0 ✓
```

**For __cxa_finalize():**
```
PLT instruction: 0x1044  jmp *0x2fae(%rip)  
GOT address = 0x1044 + 6 + 0x2fae = 0x3ff8
```

**Verification:**
```
cxa is 8th external function (index 8)
GOT[8] = 0x3fb8 + (8 * 8) = 0x3fb8 + 64 = 0x3ff8 ✓
```

## The Mathematical Pattern

### GOT Index Assignment
The linker assigns indices based on symbol processing order:
```
Index 0: Reserved (linker data)
Index 1: Reserved (linker data)  
Index 2: PLT[0] entry      → GOT[2] = 0x3fb8 + 16 = 0x3fc8
Index 3: open()           → GOT[3] = 0x3fb8 + 24 = 0x3fd0
Index 4: (unused)         → GOT[4] = 0x3fb8 + 32 = 0x3fd8
Index 5: (unused)         → GOT[5] = 0x3fb8 + 40 = 0x3fe0
Index 6: (unused)         → GOT[6] = 0x3fb8 + 48 = 0x3fe8
Index 7: (unused)         → GOT[7] = 0x3fb8 + 56 = 0x3ff0
Index 8: __cxa_finalize   → GOT[8] = 0x3fb8 + 64 = 0x3ff8
```

### Displacement Calculation (Reverse Engineering)
The linker calculates displacements using:
```
displacement = target_got_address - (plt_instruction_address + 6)
```

**For open():**
```
target_got = 0x3fd0
plt_instr = 0x1054
displacement = 0x3fd0 - (0x1054 + 6) = 0x3fd0 - 0x105a = 0x2f76 ✓
```

**For __cxa_finalize():**
```
target_got = 0x3ff8  
plt_instr = 0x1044
displacement = 0x3ff8 - (0x1044 + 6) = 0x3ff8 - 0x104a = 0x2fae ✓
```

## Complete Mathematical Relationship

### From Object File to Runtime:

**Object file (zeros):**
```
call open() → e8 00 00 00 00
```

**Linker calculation:**
```
1. Assign open to GOT[3] → 0x3fb8 + 24 = 0x3fd0
2. Create PLT entry at 0x1050
3. Calculate displacement: 0x3fd0 - (0x1054 + 6) = 0x2f76
4. Patch call: displacement = 0x1050 - (0x1169 + 5) = -0x11e → e2 fe ff ff
```

**Executable (calculated):**
```
call open@plt → e8 e2 fe ff ff
PLT[open] → jmp *0x2f76(%rip)
GOT[open] → initially 0, later real address
```

**Runtime (patched):**
```
GOT[open] → 0x7f1234567890 (real open address)
```

## Key Mathematical Insights

1. **GOT is just an array**: `GOT[index] = base + index * 8`
2. **Displacements are calculated backwards**: `disp = target - source`
3. **PLT entries are systematic**: 16 bytes each
4. **Index assignment follows symbol order**: Deterministic based on linker processing

The relationship is pure arithmetic - the linker assigns GOT indices, then calculates the displacements needed to reach those indices from each PLT instruction.