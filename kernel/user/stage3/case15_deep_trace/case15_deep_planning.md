# CASE 15: DEEP MACRO-AXIOMATIC TRACE (PLANNING)

## 01. TASK GRILLING & COUNTER-QUESTIONS

### [SUB-TASK 1] FUNCTIONAL CHAIN ALIGNMENT
**The Problem**: The path from `openat()` to `full_name_hash` involves complex branch points. 
**The GRILL**:
- **Q1.1**: If `lookup_fast` succeeds in the creation case (e.g. file exists), the logic bypasses `lookup_open`. How do we force the "Not Existing" path? 
  - *Counter*: We must use a unique filename per binary run (e.g. `somefileNew_TIMESTAMP.txt`).
- **Q1.2**: `do_sys_openat2` is the entry, but `do_filp_open` is where the `nameidata` (nd) is initialized. Do we need to trace `nd` internals (`nd->path`, `nd->last`)?
- **Q1.3**: In Case 2 (Opening), we must prove `lookup_fast` hits. What if the dentry is evicted between File 1 closure and File 2 opening?
  - *Counter*: We must ensure no `drop_caches` or high memory pressure between runs.

### [SUB-TASK 2] VARIABLE CAPTURE (THE 1:1 MATCH)
**The Problem**: Captured memory addresses are transient.
**The GRILL**:
- **Q2.1**: How to demonstrate a 1:1 match between `parent_ptr` (salt) in Creation vs `parent_ptr` in Lookup?
  - *Fact*: If the salt changes, the hash changes. The user wants a match. We must prove why they match or why they differ axiomatically.
- **Q2.2**: The user wants "Real data of each variable". 
  - *Fact*: This includes `struct filename *name`, `struct open_flags op`, `struct path *path`.
  - *Challenge*: Many of these are on the stack. `kprobe` at function entry captures arguments (registers). Capturing *mid-function* state requires instruction offsets.

### [SUB-TASK 3] KERNEL LINE MAPPING (6.17.0-14-GENERIC)
**Target Files**: `fs/open.c`, `fs/namei.c`, `fs/dcache.c`.

| Function | Start Line | Key Event / Variable |
| :--- | :--- | :--- |
| `do_sys_openat2` | 1420 | Entry: `dfd`, `filename`, `open_how` |
| `do_filp_open` | 1381 | Call Site: `AT_FDCWD`, `tmp` (filename) |
| `path_openat` | 4077 | `struct nameidata nd`, `op->intent` |
| `path_init` | 567 | `nd->path` initialization |
| `link_path_walk` | 2315 | Component iteration logic |
| `open_last_lookups`| 3768 | `lookup_fast_for_open` call site |
| `lookup_open` | 3618 | `d_alloc_parallel` (CREATION ONLY) |
| `d_alloc_parallel` | 2542 | `hash = name->hash` (Bit Mixing) |
| `__d_lookup_rcu` | 2253 | `dentry_cmp` (OPENING ONLY) |
| `do_open` | 3851 | `vfs_open` call site |
| `vfs_open` | 1008 | `f_op->open` (Final Transition) |

### [SUB-TASK 4] PSEUDO-DEBUGGER FORMAT SPEC
`#1.Call. path_openat. nd=ffff88... flags=0x... Work: Starting lookup loop. Errors: None. Real value: 0x... Real data: pathname="somefileNew.txt". Caller Line Number: do_filp_open:1437. Current: path_openat:4077`.

---

## 02. PROPOSED CALL CHAINS (THE INSIDE-OUT)

### MISSION A: CREATION PATH (O_CREAT | O_EXCL)
1. `do_sys_openat2` (Entry: dfd, filename, flags, mode)
2. `do_filp_open` (Init: nd)
3. `path_openat` (Main Loop)
4. `path_init` (Start from Root/CWD)
5. `link_path_walk` (Iterates components)
6. `open_last_lookups` (Final component logic)
7. `lookup_open` (Allocates new dentry)
8. `d_alloc_parallel` (Mixed Step)
9. `full_name_hash` (Bit-wise Axiom)
10. `vfs_create` (Inode initialization)
11. `do_open` (Final FMODE checks)

### MISSION B: OPENING PATH (O_RDONLY)
1. `do_sys_openat2`
2. `do_filp_open`
3. `path_openat`
4. `path_init`
5. `link_path_walk`
6. `lookup_fast` (RCU Check: parent+hash)
7. `__d_lookup_rcu` (Axiomatic Matching)
8. `do_open`
9. `vfs_open`

---

## 03. TASK REPORT (THE EXPECTED OUTCOME)

### Report Structure (Case 15 Folder)
- **15.1: Creation_Trace.txt**: The long-form debugger output for the first binary.
- **15.2: Open_Trace.txt**: The long-form debugger output for the second binary.
- **15.3: Macro_Axiom_Proof.md**: The 1:1 comparison matrix, pointer by pointer.

### Sample Line (The Format)
`#1.Call. path_openat. nd=ffff88... flags=0x... Work: Starting lookup loop. Errors: None. Real value: 0x... Real data: pathname="somefileNew.txt". Caller Line Number: do_filp_open:1234. Current: path_openat:1`.

---

## 04. NEXT SUB-TASKS (THE ATTACK PLAN)
1.  [ ] **Axiomatic Mapping**: Fetch exact line numbers for 6.17.0-14-generic for each function in `fs/namei.c` and `fs/open.c`.
2.  [ ] **Driver Design**: Code two drivers (or one multi-mode driver) that captures:
    - Stack pointers (RSP).
    - Base pointers (RBP).
    - Argument registers (RDI, RSI, RDX, RCX, R8, R9).
    - Return values (RAX).
3.  [ ] **User Binary**: Create `user_case15_create.c` and `user_case15_open.c`.
4.  [ ] **Numerical Proof**: Extract HASH (Creation) vs HASH (Lookup) and prove bitwise identity.

**GRILLING STATUS: ONGOING. DO NOT WRITE CODE. 🐾**

## 05. MISTAKES (THE FLOGGING)

### Error 1: Missing d_alloc_parallel
Line: driver_deep_trace.c:27 → Removed `d_alloc_parallel` claiming non-existence → Must restore `d_alloc_parallel`.
Why Sloppy: Assumptions without `grep` → Missed checking `/proc/kallsyms` → Prevent: Always verify symbols with `grep` before coding.

### Error 2: Symbol Mismatch (try 1)
Line: driver_deep_trace.c:31 → `lookup_open` probed directly → Must probe `lookup_open.isra.0` (Compiler Optimization).
Why Sloppy: Ignored GCC optimizations (SRA) → Missed `kallsyms` exact match check → Prevent: `cat /proc/kallsyms | grep func` before defining probe list.

### Error 3: Pointer Dereference Risk
Line: driver_deep_trace.c:69 → `*(const char **)regs->si` assumes `struct filename` layout → Must use `offsetof` or verify `struct filename` definition.
Why Sloppy: Used heuristic without verification → Missed `struct filename` definition check → Prevent: Check `fs/namei.c` definition or use `gdb` offset.

### Error 4: Unnecessary Filtering Complexity
Line: driver_deep_trace.c:75 → `strncmp(current->comm...)` checks task name → Should use PID filtering or more robust task check.
Why Sloppy: Text comparison is fragile → Missed PID-based filtering → Prevent: Pass target PID to driver via debugfs or module param.

### Error 5: Unchecked Return Value
Line: user_deep_create.c:8 → `unlink` return ignored → Should check errno != ENOENT.

### Error 6: Execution Blocked (Authentication)
Line: Driver Load → `sudo insmod` requires password → Interactive prompt failed in automation.
Why Sloppy: Dependent on interactive shell → Missed non-interactive execution plan → Prevent: Use `sudo -S` or pre-configure `visudo` for testing.
