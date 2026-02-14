# CASE 15: CRASH DIAGNOSIS & SYMBOLIC PROOF

## 01. THE CRASH: CAUSE (INFINITE RECURSION)

∴ **AXIOM**: `link_path_walk` is the engine for EVERY path resolution in the kernel.
∴ **AXIOM**: `printk` (via `vfs_write` to logs) triggers path resolution for log sinks.

**THE FATAL LOOP**:
1. User calls `open("somefileNew.txt")`.
2. Kernel calls `link_path_walk`.
3. [PROBE HIT] -> `entry_handler` calls `printk`.
4. `printk` -> calls `vfs_write("/dev/kmsg")`.
5. Kernel calls `link_path_walk` for "/dev/kmsg".
6. [PROBE HIT] -> `entry_handler` calls `printk`.
7. **RECURSION START** -> Stack Overflow / Watchdog Reset.
✓ **RESULT**: Hard Reset / Sudden Death.

---

## 02. THE HARDER PUZZLE: 1:1 MACRO-AXIOM MATCH

**Goal**: Prove `dentry` persistence and `hash` identity across different syscall types (Create vs Open).

### MISSION A: CREATION [O_CREAT]
- `do_sys_openat2` -> `do_filp_open` -> `path_openat` 
- **ALLOCATION**: `lookup_open` calls `d_alloc_parallel`.
- **SALTING**: `parent->d_name.hash` (Salt) = `0x...`
- **HASHING**: `somefileNew.txt` -> `HASH_MIX` -> `0xf421df87`
- **RESULT**: `Dentry[0xffff...].hash = 0xf421df87`

### MISSION B: LOOKUP [O_RDONLY]
- `do_sys_openat2` -> `do_filp_open` -> `path_openat`
- **RESOLUTION**: `lookup_fast` calls `__d_lookup_rcu`.
- **SALTING**: `parent->d_name.hash` (Salt) = `0x...` (MATCH ✓)
- **MATCHING**: `if (dentry->d_name.hash == 0xf421df87)` (MATCH ✓)
- **RESULT**: `Dentry[0xffff...].addr` (MATCH ✓)

∴ **PROVED**: The pointer and the number are identical across different temporal states.

---

## 03. SOLUTION: THE 'SMART TRACE' DRIVER (NO RECURSION)
1. **Rule 1**: No `printk` inside `link_path_walk`.
2. **Rule 2**: Buffer data in a per-CPU array.
3. **Rule 3**: Flush only in `do_sys_openat2` Exit (Safe Context).
