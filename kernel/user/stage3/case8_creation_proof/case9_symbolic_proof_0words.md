# Case 9: Symbolic Rename Proof (Zero Words)

## Phase 1: Object Invariance (Address)
∴ `dentry_old` → `ffff8887d8c30480` ✓
∴ `rename()` → `dentry_new` ✓
∴ `dentry_new` → `ffff8887d8c30480` ✓
∴ `ptr_old` == `ptr_new` ✓
∴ `Object_Invariance` → ✓

## Phase 2: Hash Invariance (Mathematical Identity)
∴ `name_old` = `"rename_proof_old.txt"` ✓
∴ `hash_old` → `0xf5846202` ✓
∴ `name_new` = `"rename_proof_new.txt"` ✓
∴ `hash_new` → `0xe1235064` ✓
∴ `hash_old` == `hash_new` ✗
∴ `Hash_Invariance` → ✗

## Phase 3: Structural Transition
∴ `__d_move` → `copy_name()` ✓
∴ `target->d_name.hash` → `dentry->d_name.hash` ✓
∴ `dentry_old` → `bucket_old` ✓
∴ `__d_rehash(dentry_old)` → `bucket_new` ✓
∴ `Spatial_Invariance` → ✗

## Q.E.D.
∴ `Dentry_Pointer` → ✓
∴ `Dentry_Hash` → ✗
