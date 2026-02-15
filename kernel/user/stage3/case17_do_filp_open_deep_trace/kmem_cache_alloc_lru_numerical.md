# kmem_cache_alloc_lru: Numerical Analysis

## What
**Definition**: Allocation + O(1) ID tagging + List Insertion.
**Numerical Analog (Warehouse)**:
*   **Input**: Request for Box (Size 256). Customer ID: 77.
*   **Process**:
    1.  Fetch Box from Shelf 0. (Address: 1000).
    2.  Stamp "77" on Box. (Tagging).
    3.  Write "1000" in Ledger #77. (Linking).
*   **Output**: Box 1000.
*   **Puzzle**: You have 5 baskets labeled A, B, C, D, E. You receive a red ball. You must put it in a basket such that you can retrieve *only* red balls later without looking at any other color.
    *   *Solution*: You need a specific "Red Ball" ledger telling you exactly which basket (A-E) contains red balls.

## Why
**Focus**: Reclaim Efficiency / Isolation.
**Numerical Comparison**:
*   **Scenario**: System Memory = 1,000,000 pages.
*   **Target**: Reclaim 50 pages from Container X (ID: 99).
*   **Without LRU**:
    *   Scan 1,000,000 pages.
    *   Check ID of each. (Cost = 1,000,000 checks).
    *   Found 50. Efficiency = 0.005%.
*   **With LRU**:
    *   Go to List #99.
    *   Pick first 50 items. (Cost = 50 checks).
    *   Efficiency = 100%.

## Where
**Location**: `slab_post_alloc_hook` (Post-processing).
**Numerical Sequence**:
1.  `0x00` -> `slab_alloc_node` (Get Raw Memory).
2.  `0x10` -> Check `memcg_kmem_online` (Control Bit = 1).
3.  `0x20` -> Check `lru` Pointer (Ptr != 0x0).
4.  `0x30` -> Execute Linking Logic.
*   **Analogy**: A car assembly line.
    *   Station 1: Install Engine (Allocate).
    *   Station 2 (The "Where"): Attach GPS Tracker linked to Owner's Phone (Link LRU).

## Who
**Identity**: `current->obj_cgroup`.
**Table**:
| Task ID | Cgroup ID | Ledger Index |
| :--- | :--- | :--- |
| PID 100 | 5 | `lru->xa[5]` |
| PID 101 | 5 | `lru->xa[5]` |
| PID 200 | 8 | `lru->xa[8]` |
*   **Fact**: PID 100 and 101 share the same accounting ledger.

## When
**Condition**: `memcg_kmem_online() == 1` AND `lru != NULL`.
**Logic Gate**:
*   Input A: Global Accounting Switch (0 or 1).
*   Input B: LRU Request (0 or 1).
*   Output: `A AND B`.
*   **Example**:
    *   Syscall `open()` -> `flags` include `__GFP_ACCOUNT`.
    *   Switch = 1.
    *   Result: Execute.

## Without
**Consequence**: Global Reclaim (The "OOM Killer" Chaos).
**Numbers**:
*   Limit: Container A has 1GB limit.
*   Usage: Container A allocates 1.1GB.
*   **Without**: Kernel cannot find specifically Container A's pages. Kernel panics or kills random process (maybe Container B).
*   **With**: Kernel walks List A, evicts 0.1GB. System stable.

## Which
**Selection**: Indirect Indexing.
**Map**:
1.  Global LRU Object (Address `0xA`).
2.  Cgroup ID (`5`).
3.  Lookup: `0xA + (5 * 8 bytes)` -> Pointer to List Head.
**Puzzle**: 
*   Library has 1000 books mixed on floor.
*   Patron 5 wants to return a book.
*   Librarian needs to know *exactly* which shelf carries books checked out by Patron 5.
*   *Mechanism*: `struct list_lru_memcg` is the shelf. `lru->xa` is the map from Patron ID to Shelf.

---

# Concrete Example: The 192-Byte Dentry

**Scenario**: A Docker container (ID: 42) opens a file.

1.  **Allocation**:
    *   Request: `kmem_cache_alloc_lru(dentry_cache, &dentry_lru, GFP_KERNEL)`.
    *   Slab Allocator: Returns Address `0xffff888123456700` (Object #7 in Slab Page).

2.  **Identification**:
    *   `current_obj_cgroup()` returns ID `42`.

3.  **Structure Check (Lazy)**:
    *   Check: `dentry_lru.xa[42]`.
    *   Value: `NULL`. (First time).
    *   Action: `kmalloc` new list header at `0xffff888199999900`.
    *   Store: `dentry_lru.xa[42] = 0xffff888199999900`.

4.  **Linking**:
    *   Slab Extension Array: `slab_obj_exts[7]`.
    *   Action: `slab_obj_exts[7].objcg = 42`.

5.  **Result**:
    *   Object `0xffff888123456700` provides the memory.
    *   If Cgroup 42 hits memory limit, Kernel looks at `dentry_lru.xa[42]`, finds this object, and reclaims it.
