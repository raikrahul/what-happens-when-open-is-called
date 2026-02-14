x -> Accumulator (Swap-State) ✓
a -> Raw Word (Name Chunk) ✓
y -> Spatial Salt (Parent Entropy) ✓

### PHASE 1: [DEFINITION AXIOMS] SYMBOLIC TABLE
┌────────┬───────────────────────────────────────────────────────────────────┐
│ Symbol │ Axiomatic Function                                                │
├────────┼───────────────────────────────────────────────────────────────────┤
│    y   │ Register RDI (Initial) -> Parent_Dentry_Pointer ∴ ROOT_ENTROPY    │
│    a   │ Memory[Heap] -> 64-bit Filename Fragment (Little Endian)          │
│    x   │ State Register (Internal) -> XOR(a) -> rol64(12) -> SUM(y)        │
│    G   │ GOLDEN_RATIO_64 -> 0x61C8864680B583EB ∴ MIXING_CONSTANT           │
└────────┴───────────────────────────────────────────────────────────────────┘

### PHASE 2: [HARDER PUZZLE] THE XOR-SYMMETRY BREAK
```c
/* PROBLEM: Linear XOR Hash (Hypothetical)
   If H(S, N) = S ^ N:
   S₁=0x...1b40, N_A=0x41 -> H=0x...1b01
   S₂=0x...1b01, N_B=0x40 -> H=0x...1b01 ∴ COLLISION(✗)
*/

/* SOLUTION: HASH_MIX Axiom (Kernel Reality)
   Case A [break_A]: y₀=0x...b40, a₁=0x41
   Case B [break_@]: y₀=0x...f00, a₁=0x40

   ITERATION 1 (HASH_MIX):
   Case A: y_mix = y₀ ^ (rol64(0x41, 12) + y₀ ^ (0x41)) 
   Case B: y_mix = y₀ ^ (rol64(0x40, 12) + y₀ ^ (0x40))
   
   NON-LINEARITY_1: rol64(0x41, 12) != rol64(0x40, 12) -> Divergence_X ✓
   NON-LINEARITY_2: x + y (Addition) -> Carry-Propagation ✓
   NON-LINEARITY_3: y *= 9 (Multiplication) -> Dispersion ✓
*/

∴ Hash_A (0xdc2bf3b7) != Hash_B (0x85ed6b54) 
∴ SYMMETRY_BROKEN(✓)
```

### PHASE 3: [BRAIN REWIRE] CARRY-BIT EXPLOSION
┌────────────────────────────────────────────────────────────────────────────┐
│ XOR (Linear) : 0x01 ^ 0x01 = 0x00 (Localized)                              │
│ ADD (Non-Lin): 0x7F + 0x01 = 0x80 (Carry propagates to INF)                │
│ MUL (Non-Lin): 0x01 * 0x09 = 0x09 (Scatters bits across fields)            │
└────────────────────────────────────────────────────────────────────────────┘

### W-LEDGER (NUMERICAL)
- **What:** SipHash-Derivative mixing ✓
- **Why:** Prevent predictable Hash-Table Flooding attacks ✓
- **Where:** 0x2020 offset in dentry_handle ✓
- **Who:** fs/dcache.c::full_name_hash ✓
- **When:** Path-Resolution -> Component-Walk ✓
- **Without:** MULTIPLY -> Linear Collisions exist ✗
- **Which:** Carry-Bits (State Scrambling) ✓

∴ Q.E.D. 🐾 🐾 🐾
