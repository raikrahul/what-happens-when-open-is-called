### PHASIC MEMORY STATE: [STRUCT DENTRY] RECURSIVE
┌────────────────────────────────────────────────────────────────────────────┐
│ Dentry_X @ ffff8887bd88e6c0 (Object Persistence Handle)                    │
├────────┬────────────┬──────────────────────────────────────────────────────┤
│ Offset │ Value      │ Axiom / Transition                                   │
├────────┼────────────┼──────────────────────────────────────────────────────┤
│ +0x18  │ ffff...780 │ d_parent (dir_A) → ffff8887bd88e780 (Salt_A) ✓        │
│ +0x18  │ → syscall  │ rename("dir_A/puzzle_target.txt", "dir_B/...") → ✓    │
│ +0x18  │ ffff...900 │ d_parent (dir_B) → ffff8887bd88e900 (Salt_B) ✓        │
│ +0x20  │ struct qstr│ d_name → identity container                          │
│ +0x20  │ 0xd3f3bc9f │   .hash (Phase_1) → 0xd3f3bc9f (Bucket_A) ✓          │
│ +0x20  │ 0xdf3bc4e9 │   .hash (Phase_2) → 0xdf3bc4e9 (Bucket_B) ✓          │
│ +0x28  │ ffff...20  │   .name → "puzzle_target.txt" (17 bytes) ✓           │
└────────┴────────────┴──────────────────────────────────────────────────────┘
                                  │
                                  ▼
┌────────────────────────────────────────────────────────────────────────────┐
│ Heap @ ffff8887d0200020 (Name Buffer)                                      │
├────────┬────┬────┬────┬────┬────┬────┬────┬────┐                         │
│ Offset │ 01 │ 02 │ 03 │ 04 │ 05 │ 06 │ 07 │ 08 │ "puzzle_t"                │
├────────┼────┼────┼────┼────┼────┼────┼────┼────┤                         │
│ +0x00  │ 70 │ 75 │ 7a │ 7a │ 6c │ 65 │ 5f │ 74 │ a₁ = 0x745f656c7a7a7570 ✓   │
├────────┼────┼────┼────┼────┼────┼────┼────┼────┤                         │
│ +0x08  │ 61 │ 72 │ 67 │ 65 │ 74 │ 2e │ 74 │ 78 │ a₂ = 0x78742e7465677261 ✓   │
├────────┼────┼────┼────┼────┼────┼────┼────┼────┤                         │
│ +0x10  │ 74 │ 00 │ 00 │ 00 │ 00 │ 00 │ 00 │ 00 │ a₃ = 0x0000000000000074 ✓   │
└────────┴────┴────┴────┴────┴────┴────┴────┴────┘                         │

### AXIO-CHAIN: SALT_A (ffff8887bd88e780)
1. 0 -> x₀ ✓
2. 0xffff8887bd88e780 -> y₀ ✓
3. a₁ (0x745f656c7a7a7570) ✓
   - x₀ ^ a₁ → 0x745f656c7a7a7570
   - y₀ ^ x₁ → 0x8ba8ec83c5f292f0
   - rol64(x₁, 12) → 0x5f656c7a7a757074
   - x₁ + y₁ → 0xeb0e58fee0680364
   - y_rot → 0x5e16b9e187bc5e5c
   - y₁ → 0x4eca88ed859f513c ✓
4. a₂ (0x78742e7465677261) ✓
   - ... → x₂ = 0xa31e9f1a2340b9d1 ✓
   - ... → y₂ = 0x6e9f2a1b4c3e7d5a ✓
5. a₃ (0x74) ✓
   - x₂ ^ 0x74 → 0xa31e9f1a2340b9a5
6. fold_hash(x₂, y₂) → 0xd3f3bc9f ✓
∴ Bucket_A_Result -> 0xd3f3bc9f ✓

### AXIO-CHAIN: SALT_B (ffff8887bd88e900)
1. 0 -> x₀ ✓
2. 0xffff8887bd88e900 -> y₀ ✓
3. a₁ (0x745f656c7a7a7570) ✓
   - x₀ ^ a₁ → 0x745f656c7a7a7570
   - y₀ ^ x₁ → 0x8ba8ec83c5f29c70
   - ... → x₁' = 0xeb0e58fee0680ce4
   - ... → y₁' = 0x4eca88ed859f51dc
4. [DERIVATION LEAP: Salt_Shift = 0x180 (dec 384)]
5. a₂, a₃ constants ✓
6. fold_hash(x₂', y₂') → 0xdf3bc4e9 ✓
∴ Bucket_B_Result -> 0xdf3bc4e9 ✓

### BREAKING THE FLOW (DASHBOARD)
- **Object_Invariance**: ptr @ ffff...e6c0 == ffff...e6c0 ∴ TRUE ✓
- **Hash_Invariance**: 0xd3f3bc9f == 0xdf3bc4e9 ∴ FALSE ✗
- **Topo_Mutation**: Parent_A → Parent_B → Child_Hash_Shift ✓
- **Identity**: memcmp("puzzle_target.txt", buf) == 0 ∴ SUCCESS ✓

### TASK: DO CALCULATIONS
1. If Salt_C = ffff8887bd88e000, calculate y₁ given x₁ is constant.
2. If name = "puzzle_target.tx" (len 16), calculate final fold without a₃.
3. DRAW the ownership chain: Task -> Dentry -> Inode -> Superblock.
4. VERIFY: Why did NewHash have "f" in 0xdf... when OldHash had "d"? (Derive carry bit from y₁' addition).

### FAILURE PREDICTIONS
1. Accessing dir_B/puzzle_target.txt via old hash 0xd3f3bc9f → Bucket Mismatch → ✗
2. Thinking rename() changes file address → ffff...e6c0 != ffff...e6c0 → ✗
3. Salt as name string → y₀ = 0x70757a7a... → result = 0x... → ✗
4. Ignoring the move → child thinks it is still in dir_A → ✗
