# Argument 1: `struct kmem_cache *s`

## What
**Definition**: The "Factory Blueprint" pointer.
**Numerical Analog**: The Molder.
*   **Input**: `s` (Pointer to `dentry_cache`).
*   **Output**: Exact 192-byte dentry object.
*   **Value`: `0xffff888100042300` (Kernel Virtual Address of the structure).

## Why
**Focus**: Efficiency (0% Internal Fragmentation).
**Numerical Comparison**:
*   **Without `s` (Generic `kmalloc` / Power of 2)**:
    *   Request: 192 bytes.
    *   Allocator: Smallest bucket is 256 bytes.
    *   Allocated: 256 bytes.
    *   Waste: $256 - 192 = 64$ bytes (25%).
*   **With `s` (Specialized Cache)**:
    *   `s->size` = 192.
    *   Allocator: Takes 192-byte slot from 192-byte slab.
    *   Allocated: 192 bytes.
    *   Waste: 0 bytes (0%).

## Where
**Location**: `mm/slab.h` / `mm/slub.c`.
**Memory Map (The Struct Itself)**:
*   `s` @ `0xffff888100042300`
    *   `+0x00` `cpu_slab`: Per-CPU array pointer.
    *   `+0x18` `size`: 192 (Total size).
    *   `+0x1C` `object_size`: 192 (Payload size).
    *   `+0x20` `offset`: 0 (Free pointer location).
    *   `+0x60` `name`: "dentry" (String pointer).

## Who
**Creator**: `kmem_cache_create`.
**Consumer**: `kmem_cache_alloc_lru`.
**Example**:
1.  Boot time: `vfs_caches_init()` calls `kmem_cache_create("dentry", ...)`. -> Returns `s`.
2.  Runtime: `__d_alloc` calls `kmem_cache_alloc_lru(s, ...)`.

## When
**Static**: Created once at boot ($t=0$).
**Dynamic**: Used continuously ($t=0 \to \infty$).
**Frequency**:
*   `dentry_cache`: 1,000,000+ allocs/sec.
*   `EXT4-fs`: 100 allocs/sec.

## Without
**Consequence**: Loss of Type Safety & Constructors.
**Numerical Example**:
*   **With `s`**: `s->ctor` (Constructor) is called.
    *   Initialize `d_lock` spinlock automatically.
    *   Cost to user: 0 instructions (Done by slab).
*   **Without `s`**: User gets raw memory zeroed.
    *   User must call `spin_lock_init`.
    *   Cost to user: 50 instructions.
    *   Risk: User forgets. Kernel Panic.

## Which
**Variable**: `dentry_cache` (Global Variable).
**Selection**:
*   `files_cachep` (for `struct file`).
*   `names_cachep` (for generic strings).
*   `inode_cachep` (for `struct inode`).
*   `s` is the pointer to one of these specific globals.
