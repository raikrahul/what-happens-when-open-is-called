# Axiomatic Proof: Hash Consistency & Duplicates

## 1. The Single Source of Truth
The kernel uses **one** function to calculate hashes for dentries: `full_name_hash()` (which wraps `partial_name_hash`).

### Evidence A: Read Path (Lookup)
**File**: `fs/namei.c` -> `link_path_walk` -> `hash_name`
```c
hash = init_name_hash(nd->path.dentry);
// ... loop ...
nd->last.hash = end_name_hash(hash);
```
**Result**: `0x78a2c1d2`.

### Evidence B: Write Path (Creation)
**File**: `fs/dcache.c` -> `d_alloc_parallel` (or `d_alloc`)
The dentry is initialized with the name and hash **provided by the lookup**.
When `do_create` makes a new file, it uses the **SAME `nd` structure** that `link_path_walk` just filled.
It does **NOT** recalculate the hash. It blindly trusts the one from the lookup.

**Conclusion**: Since the "Write" uses the result of the "Read", they are guaranteed identical.

---

## 2. Hash Collisions != Duplicates
**Question**: "Is this the reason I cannot have two files of same name?"
**Answer**: **NO.**

### Scenario 1: Hash Collision (Allowed)
*   File A: "foo" -> Hash 0x10
*   File B: "bar" -> Hash 0x10
*   **Result**: Both go into Bucket 0x10.
*   **Structure**: `Bucket[0x10] -> dentry("foo") -> dentry("bar") -> NULL`
*   **Lookup "foo"**:
    *   Jump to Bucket 0x10.
    *   Check 1: Hash 0x10 == 0x10? YES. Name "foo" == "foo"? YES. -> **FOUND**.
*   **Lookup "bar"**:
    *   Jump to Bucket 0x10.
    *   Check 1: Hash 0x10 == 0x10? YES. Name "foo" == "bar"? NO. -> Next.
    *   Check 2: Hash 0x10 == 0x10? YES. Name "bar" == "bar"? YES. -> **FOUND**.

### Scenario 2: Name Duplicate (Forbidden)
*   File A: "foo" (Already exists)
*   User tries to create "foo".
*   **Logic**:
    *   Lookup "foo" -> Finds existing dentry.
    *   Kernel sees `dentry->d_inode` is NOT NULL (It exists).
    *   `open(O_CREAT | O_EXCL)`? -> Error `-EEXIST`.

**The Duplicate Check** happens by **String Comparison** (`dentry_cmp`), not by Hash Collision. You can have a billion hash collisions, but you cannot have two identical byte-strings in the same parent.
