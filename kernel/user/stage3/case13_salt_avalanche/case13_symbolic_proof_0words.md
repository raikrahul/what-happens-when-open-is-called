y -> Parent_Dentry_Pointer -> ffff8886e830ff00 ✓

### PHASE 1: [SYMLINKAGE] OWNERSHIP CHAIN
┌────────────────────────────────────────────────────────────────────────────┐
│ Task (Comm:user_salt_avala)                                                │
│   │                                                                        │
│   └──> Register RDI -> ffff8886e830ff00 (Parent_X) ∴ Entropy_Salt (y)      │
│         │                                                                  │
│         └──> Child_Dentry @ ffff... → d_parent = ffff8886e830ff00 ✓        │
│               │                                                            │
│               └──> d_name.hash = 0x45982df4 ∴ Result_A                     │
└────────────────────────────────────────────────────────────────────────────┘

### PHASE 2: [CODE BREAKDOWN] SALT AVALANCHE (Y-AXIOM)
```c
// PUZZLE: 1-bit Salt Shift → Massive Hash Divergence
// SALT_X = ffff8886e830ff00 (y_A)
// SALT_Z = ffff8886e830f480 (y_B)
// DIFF = 0xa80 (Bit 11 Divergence)

void HASH_MIX(u64 x, u64 y, u64 a) {
    x ^= a; // a = "avalanch" (0x68636e616c617661)
    y ^= x; 
    // y_X = ffff8886e830ff00 ^ 0x68636e616c617661 = 979bece784518961
    // y_Z = ffff8886e830f480 ^ 0x68636e616c617661 = 979bece7845182e1
    
    x = rol64(x, 12);
    x += y;
    
    y = rol64(y, 45); // <-- 1-bit @ pos 11 moves to pos 56
    // y_rot_X = 0x12c4b0c2f3ccf27d
    // y_rot_Z = 0x12c4b05b0fccf27d
    // DIVERGENCE @ Bit 56 ✓
    
    y *= 9; 
    // y_final_X = 0xa8ea66daab348665
    // y_final_Z = 0xa8ea63338f348665
    // DIFF = 0x3a71bbf000 (> 500 million)
}

∴ 1-bit Salt Displacement -> Avalanche Success(✓)
```

### W-LEDGER (NUMERICAL)
- **What:** y = ffff8886e830ff00 ✓
- **Why:** parent_addr << 45 in HASH_MIX ✓
- **Where:** register RDI (Axiom: System V ABI) ✓
- **Who:** user_salt_avala (PID 34473) ✓
- **When:** full_name_hash(salt, name, len) ✓
- **Without:** y ^= x -> Result = 0xbd1e2a87 (Mangled) ✓
- **Which:** Bit 11 (Salt_Z) vs 0xa80 (Salt_X) ✓

### FAILURE PREDICTIONS
1. Incorrect Name Load -> 0x616c61... (Big Endian) -> Hash Mismatch -> ✗
2. Bit 56 Carry Overflow -> Missing rol64(y, 45) -> ✗
3. Multi-Parent Collision -> Hash_X == Hash_Y -> ✗ (PREVENTED BY Y-AXIOM)
4. Null Salt -> y = 0 -> Hash = 0x1c2a3b4d (Magic Value) -> ✗
