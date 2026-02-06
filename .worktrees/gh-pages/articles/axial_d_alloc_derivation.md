---
layout: default
title: "Axial Derivation: __d_alloc Mechanics"
---

# AXIAL DERIVATION: __d_alloc (THE SETTLEMENT)

01. **PREMISE**: Function `__d_alloc` allocates the metadata container for a filename.
02. **AXIOM**: Allocation choice depends on `name->len` vs `DNAME_INLINE_LEN`.

--------------------------------------------------------------------------------
01. STRUCT DENTRY LAYOUT (KERNEL 6.14.0-37-GENERIC)
--------------------------------------------------------------------------------

| Offset | Member | Size | Note |
| :--- | :--- | :--- | :--- |
| +0 | `d_flags` | 4 | |
| +4 | `d_seq` | 4 | |
| +8 | `d_hash` | 16 | |
| +24 | `d_parent` | 8 | |
| **+32** | `d_name` | **16** | `struct qstr` |
| +48 | `d_inode` | 8 | |
| **+56** | `d_iname` | **32** | Inline Buffer |

--------------------------------------------------------------------------------
02. THE BRANCHING LOGIC (INLINE ↔ EXTERNAL)
--------------------------------------------------------------------------------

**CONST**: `DNAME_INLINE_LEN` = 32

**ALGORITHM**:
```c
if (name->len < DNAME_INLINE_LEN) {
    // CASE A: SMALL NAME
    dentry->d_name.name = dentry->d_iname; // +56
} else {
    // CASE B: LARGE NAME
    dentry->d_name.name = kmalloc(name->len + 1, ...);
}
```

**NUMERICAL PROOF**:
- **Test Input**: "test_file_1770" (14 chars).
- **Condition**: `14 < 32` → **TRUE**.
- **Settlement**: `d_name.name` = `&dentry + 56`.

--------------------------------------------------------------------------------
03. THE SETTLEMENT MEMCPY
--------------------------------------------------------------------------------

**SOURCE**: `fs/dcache.c`
```c
memcpy(dname, name->name, name->len);
```

**X86_64 TRACE CONVERGENCE**:
01. **Input Ptr** (`RDI` in `getname`): `0x7ffe...` (User Address)
02. **Transient Ptr** (`RAX` in `getname`): `0xffff...020` (Kernel Stack/Slab)
03. **Settled Ptr** (`RAX` in `__d_alloc`): `0xffff...6f8` (Persistent Slab)

**AXIOM**: Address 03 is the final home of the string. It is the address stored in the dentry's `d_name.name` pointer.

--------------------------------------------------------------------------------
04. ADDRESS DEREFERENCE AXIOMS (+64, +8, +32)
--------------------------------------------------------------------------------

01. `file` → `f_path` (+64)
02. `f_path` → `dentry` (+8)
03. `dentry` → `d_name` (+32, struct qstr)
04. `d_name` → `name` (+8, char *)

**CONVERGENCE**: Dereferencing `file + 64 + 8` then taking that pointer `+ 32 + 8` MUST yield the **Settled Ptr**.

[✓] __d_alloc DERIVATION COMPLETE.
