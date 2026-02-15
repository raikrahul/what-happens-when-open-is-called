
# Argument 2: struct list_lru *lru

## What
**Definition**: The "List Manager".
**Is it a Linked List?**: No, it is a *Container* of lists.
**Type**: `struct list_lru *`.

## Structure Hierarchy (The "Russian Doll")
1.  **Top Level**: `struct list_lru` (The Manager)
    *   Contains: `struct list_lru_node *node` (Array of per-node structures).
    *   Contains: `struct xarray xa` (Map of MemCG ID -> List).
2.  **Mid Level**: `struct list_lru_memcg` (The Shelf)
    *   Allocated dynamically for each Cgroup.
    *   Contains: `struct list_lru_one node[]` (Array per NUMA node).
3.  **Bottom Level**: `struct list_lru_one` (The Actual List)
    *   Contains: `struct list_head list` (**HERE IS THE LINKED LIST**).
    *   Contains: `long nr_items` (Count).
    *   Contains: `spinlock_t lock`.

## Visual Map
`lru` (Arg 2)
  ↓
`lru->xa[objcg_id]` (Lookup)
  ↓
`mlru` (MemCG Specific Structure)
  ↓
`mlru->node[nid]` (NUMA Specific Structure)
  ↓
`mlru->node[nid].list` (The `struct list_head`)
  ↓
`Box A` <-> `Box B` <-> `Box C` (The Actual Objects linked via `d_lru`)

## Data
**Arg 2**: `&dentry_lru` (Global variable in `fs/dcache.c`).
**Address**: `0xffffffff8a002000` (Static Kernel Data).
