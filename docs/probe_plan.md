# Probe Plan

List of kernel functions to instrument for the filename string journey, component walk, and caching logic:

1. `do_filp_open` – kernel filename buffer arrival and `struct file` return.
2. `link_path_walk` – advances pathname pointer through slashes.
3. `walk_component` – builds each component `qstr` (name/len/hash).
4. `lookup_fast` / `d_lookup` / `__d_lookup_rcu` – cache miss/hit decision using component `qstr`.
5. `__d_alloc` – allocates `dentry->d_name.name` and copies the basename.
6. `__d_add` – inserts the new name pointer into the dcache.
7. `do_filp_open` return probe (kretprobe) to confirm the returned pointer equals the cached name.
8. `d_delete` – pointer seen when unlink removes the entry.
9. `__dentry_kill` – pointer seen during cache eviction (`drop_caches`).
10. `path_openat` / `lookup_slow` – to observe fallback when fast path fails.

This file remains untracked (not committed) per your request.
