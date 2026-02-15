# Dentry Cache LRU: Mechanics and Logic

## What
Definition: 1 Hash Map (Lookup) + 1 Linked List (Reclaim).
Numerical Analog (Rental Car Hub):
*   **Database (Hash map)**: Plate "ABC-123" → Slot 42. (O(1) Search).
*   **Return Queue (LRU list)**: First car in, first car cleaned. (Temporal Order).
*   **Capacity**: 100 slots. 101st car arrives → Oldest car in queue is sold/evicted.

## Why
Efficiency: Prevents $O(N)$ linear scans for victims.
Numerical Scenario:
*   Total Objects: 1,000,000.
*   Scan Cost: 10 ns / check.
*   **With LRU Head**: 10 ns to find victim.
*   **Without LRU (Scan)**: 10,000,000 ns to find victim.
*   ∴ Efficiency Gain: 1,000,000x.

## Where
*   **Object Link**: `dentry->d_lru` (Offset: 115).
*   **Container**: `sb->s_dentry_lru` (`struct list_lru`).
*   **Lookup Table**: `dentry_hashtable` (Size: $2^{20}$ buckets).

## Who
*   **Provider**: `dput()` (Last ref → Queue).
*   **Consumer**: `dget()` (Active ref ← Remove from Queue).
*   **Executioner**: `dentry_lru_isolate()` (Callback during Memory Pressure).

## When
*   Refcount = 0 → `d_lru_add`.
*   Refcount > 0 → `d_lru_del`.
*   `nr_free_pages` < `pages_low` → `list_lru_walk` triggers.

## Without
State: Memory exhaustion + OOM Kill.
Result: `d_alloc()` fails → System cannot resolve "/bin/ls" → OS hangs.

## Which
Rule: `list_add_tail` (Enqueue) + `list_first_entry` (Dequeue).
∴ The Head is always the Oldest.

## Puzzle
You have 7 numbered drawers. Each time you use a tool, you move it to drawer 7 and slide all others left.
Question: Which drawer contains the tool you haven't touched in the longest time?
Answer: Drawer 1. (Numeric proof: $t_{1} < t_{2} < \dots < t_{7}$).

## Concrete Example: Path Resolution Lifecycle
1.  Process (PID: 501) calls `open("/home/user/file.txt")`.
2.  `d_alloc()` creates dentry "file.txt". Refcount: 1.
3.  `d_rehash()` adds to Hash Map bucket #3402. (Visible to others).
4.  Process terminates. `dput()` called.
5.  Refcount: 1 → 0. (No users).
6.  `d_lru_add()`: `dentry->d_lru` linked to `sb->s_dentry_lru` TAIL.
7.  System RAM usage hits 99%. Reclaim starts.
8.  `list_lru_walk` picks HEAD of `sb->s_dentry_lru`.
9.  Head is "file.txt" (Oldest).
10. `__dentry_kill()`:
    *   `__d_drop()`: Removed from Hash Map.
    *   `iput()`: Inode freed/synced.
    *   `kmem_cache_free()`: Memory returned to pool.
