TASK PLANNING DOCUMENT - FILE CREATION VS OPEN PATH TRACING
================================================================================
Timestamp: 2026-02-13 19:48:00
Task ID: CREATE_VS_OPEN_TRACE_ANALYSIS
Status: PLANNING PHASE - QUESTIONING AND DECOMPOSITION
================================================================================

================================================================================
SECTION 1: CORE OBJECTIVE DECOMPOSITION
================================================================================

GOAL 1.1: Create Driver A (File Creation Path)
----------------------------------------------
What functions to probe when O_CREAT is used on non-existent file?
- do_sys_openat2 (entry/exit)
- do_filp_open (entry/exit)  
- path_openat (entry/exit)
- path_init (entry/exit)
- alloc_empty_file (entry/exit)
- init_file (entry/exit)
- link_path_walk (entry/exit)
- lookup_open (entry/exit) - CRITICAL: This is where creation happens
- vfs_create (entry/exit)
- d_alloc (entry/exit) - allocates new dentry
- d_instantiate (entry/exit)
- may_o_create (entry/exit)
- lookup_fast (entry/exit) - will fail, leading to creation

QUESTIONS FOR DRIVER A:
Q1.1.1: When exactly does kernel decide "file not exists, need to create"?
  - Is it in lookup_open() checking dentry->d_inode == NULL?
  - At what line in namei.c does this check occur?
  - What is the exact condition: if (!dentry->d_inode) or if (IS_ERR(dentry))?

Q1.1.2: What is the exact call sequence from open() to vfs_create()?
  - do_sys_openat2 → ? → ? → vfs_create
  - How many function calls deep?
  - What are the intermediate functions?

Q1.1.3: How does kernel allocate inode during creation?
  - Is it via inode->i_op->create()?
  - What filesystem-specific function is called?
  - How to trace ext4_create vs xfs_create vs generic?

Q1.1.4: What hash computation happens during creation?
  - full_name_hash() - what parameters?
  - Hash of filename only or filename+parent salt?
  - What is the salt value (parent->d_name.hash)?

Q1.1.5: Memory allocation tracing:
  - How many kmalloc/kzalloc calls during creation?
  - Size of each allocation?
  - Address ranges of allocated objects?

GOAL 1.2: Create Driver B (File Open Path - Existing File)
-----------------------------------------------------------
Same functions as Driver A, but different behavior:
- lookup_fast() will SUCCEED (return dentry)
- No call to vfs_create()
- No call to d_alloc() for new dentry (may call __d_lookup_rcu)
- dentry->d_inode exists (non-NULL)

QUESTIONS FOR DRIVER B:
Q1.2.1: What is the exact success path in lookup_open()?
  - if (dentry->d_inode) { return dentry; } - at what offset?
  - How many instructions executed vs creation path?

Q1.2.2: Fast path vs slow path:
  - When does __d_lookup_rcu() get called?
  - When does slow lookup (d_lookup) happen?
  - What triggers RCU vs non-RCU path?

Q1.2.3: Permission checking differences:
  - may_o_create() only in creation path?
  - may_open() in both paths?
  - inode_permission() calls?

Q1.2.4: Dentry reference counting:
  - dget() calls in open path?
  - dput() calls?
  - Reference count values (before/after)?

================================================================================
SECTION 2: USERSPACE PROGRAM REQUIREMENTS
================================================================================

PROGRAM A: create_file.c
------------------------
What should it do?
- Create a uniquely named file (timestamp-based?)
- Use O_CREAT | O_WRONLY | O_TRUNC flags
- Write some identifiable data
- Close file
- Print the filename for Program B to use

QUESTIONS:
Q2.1.1: Filename generation:
  - Use /tmp/test_create_$(date +%s).txt?
  - Or fixed name in current directory?
  - How to ensure file doesn't exist before test?

Q2.1.2: Timing considerations:
  - Sleep between create and open to ensure dmesg capture?
  - How to synchronize with driver loading?
  - Should driver be loaded before or after fork?

Q2.1.3: Error handling:
  - What if create fails?
  - Check errno values?
  - Retry logic needed?

PROGRAM B: open_existing.c
--------------------------
What should it do?
- Open the file created by Program A (read filename from argv or fixed path)
- Use O_RDONLY flag (no O_CREAT!)
- Read and verify data
- Close file

QUESTIONS:
Q2.2.1: File identification:
  - Pass filename as command-line argument?
  - Or use fixed well-known filename?
  - What if Program A failed?

Q2.2.2: Verification:
  - Should Program B verify the data written by Program A?
  - What verification mechanism?
  - Hash check or simple string compare?

Q2.2.3: Cleanup:
  - Should Program B delete the file after opening?
  - Or leave it for analysis?
  - When to unlink?

================================================================================
SECTION 3: FUNCTION TRACING INVENTORY
================================================================================

TIER 1: Entry Points (Must Probe)
---------------------------------
1. do_sys_openat2 (fs/open.c)
   - Entry: capture dfd, filename, flags, mode
   - Exit: capture return value (fd or error)
   - Registers: rdi=dfd, rsi=filename, rdx=flags, r10=mode (x86_64 syscall)

2. do_filp_open (fs/namei.c)
   - Entry: capture nd, op, flags
   - Exit: capture struct file* or ERR_PTR

3. path_openat (fs/namei.c)
   - Entry: capture nd, op, flags
   - Called by: do_filp_open
   - Returns: struct file*

TIER 2: Path Initialization (Must Probe)
----------------------------------------
4. path_init (fs/namei.c)
   - Entry: capture name, flags, nd
   - Critical: AT_FDCWD (-100) vs fd lookup branch
   - Returns: updated name pointer
   - Line ~2576: if (unlikely(dfd == AT_FDCWD))

5. set_nameidata (fs/namei.c)
   - Entry: capture nd, dfd, name
   - Initializes nameidata structure
   - Stack depth tracking

6. alloc_empty_file (fs/file_table.c)
   - Entry: capture flags, cred
   - Returns: struct file* (not yet linked to dentry)
   - Called before path lookup!

7. init_file (fs/file_table.c)
   - Entry: capture file, flags, cred
   - Initializes file->f_mode, f_op, etc.
   - Returns: 0 or error

TIER 3: Path Walking (Must Probe)
---------------------------------
8. link_path_walk (fs/namei.c)
   - Entry: capture name, nd
   - Core path resolution function
   - Returns: 0 or error (-ENOENT, -EACCES, etc.)
   - Line ~2427: static int link_path_walk(...)

9. walk_component (fs/namei.c)
   - Entry: capture nd, flags
   - Processes each path component
   - Returns: 0 or error

10. lookup_fast (fs/namei.c)
    - Entry: capture nd, dentry
    - Fast lookup using RCU
    - Returns: dentry or NULL

11. __d_lookup_rcu (fs/dcache.c)
    - Entry: capture parent, name, seq
    - Hash table lookup
    - Returns: dentry or NULL

TIER 4: Creation-Specific Functions (Creation Path Only)
--------------------------------------------------------
12. lookup_open (fs/namei.c)
    - Entry: capture nd, dentry, file, op, got_write
    - CRITICAL DECISION POINT
    - Line ~3654: if (dentry->d_inode) { return dentry; }  // EXISTS
    - Else: continue to creation
    - Returns: dentry or ERR_PTR

13. vfs_create (fs/namei.c)
    - Entry: capture idmap, dir, dentry, mode, want_excl
    - Actual file creation
    - Calls dir->i_op->create()

14. may_o_create (fs/namei.c)
    - Entry: capture idmap, dir, dentry
    - Permission check before creation
    - Returns: 0 or -EACCES

15. d_alloc (fs/dcache.c)
    - Entry: capture parent, name
    - Allocates new dentry structure
    - Size: sizeof(struct dentry) ≈ 256 bytes

16. d_alloc_parallel (fs/dcache.c)
    - Alternative to d_alloc for parallel operations
    - When is this used vs d_alloc?

17. d_instantiate (fs/dcache.c)
    - Entry: capture dentry, inode
    - Links dentry to newly created inode
    - Sets dentry->d_inode = inode

18. full_name_hash (include/linux/stringhash.h)
    - Entry: capture salt, name, len
    - Computes hash of filename
    - Salt = parent->d_name.hash
    - Returns: u32 hash value

19. hash_name (fs/namei.c)
    - Entry: capture name
    - Processes each character: hash = hash * 33 + c
    - Returns: hash value

TIER 5: Open-Specific Functions (Open Path Only)
------------------------------------------------
20. may_open (fs/namei.c)
    - Entry: capture idmap, nd, acc_mode, op
    - Permission check for opening existing file
    - Called when dentry->d_inode exists

21. finish_open (fs/open.c)
    - Entry: capture file, dentry, op, opened
    - Completes file open after successful lookup
    - Sets file->f_path.dentry

22. do_open (fs/namei.c)
    - Entry: capture idmap, nd, file, op
    - Handles actual open logic
    - Returns: 0 or error

TIER 6: Completion Functions (Both Paths)
-----------------------------------------
23. terminate_walk (fs/namei.c)
    - Entry: capture nd
    - Cleanup after path resolution
    - Returns: void

24. restore_nameidata (fs/namei.c)
    - Entry: capture nd
    - Restores previous nameidata
    - Stack unwinding

25. fd_install (fs/file_table.c)
    - Entry: capture fd, file
    - Installs file in fd table
    - fd = current->files->fd_array[fd] = file

================================================================================
SECTION 4: DATA COLLECTION REQUIREMENTS
================================================================================

FOR EACH FUNCTION CALL, CAPTURE:
-------------------------------
1. Timestamp (nanosecond precision)
2. CPU core ID
3. Process PID and comm
4. Function name and source line
5. All input parameters with values
6. Return value
7. Duration (entry to exit)
8. Call stack depth

SPECIFIC DATA POINTS:
--------------------
A. File Creation Path Data:
   - Filename being created
   - Parent directory dentry pointer
   - Parent directory hash (salt)
   - Computed filename hash
   - New dentry pointer
   - New inode pointer
   - Creation timestamp
   - Permission bits

B. File Open Path Data:
   - Filename being opened
   - Existing dentry pointer
   - Existing inode pointer
   - Inode reference count before/after
   - File mode verification
   - Open flags

C. Comparison Metrics:
   - Number of function calls: create vs open
   - Total cycles/instructions: create vs open
   - Memory allocations: create vs open
   - Hash computations: create vs open
   - Lock acquisitions: create vs open

================================================================================
SECTION 5: ANALYSIS DOCUMENT STRUCTURE
================================================================================

MARKDOWN OUTPUT REQUIREMENTS:
-----------------------------

Section 1: Executive Summary
  - Total functions traced in each path
  - Execution time comparison
  - Key finding: divergence point

Section 2: Complete Call Graphs
  - Create path: full call sequence with arrows
  - Open path: full call sequence with arrows
  - Side-by-side comparison

Section 3: Intersection Analysis
  - List of functions called in BOTH paths
  - For each: same or different behavior?
  - Parameter differences
  - Return value differences

Section 4: Divergence Point Analysis
  - Exact function name
  - Exact line number
  - Exact condition: if (dentry->d_inode)
  - Assembly instructions showing branch

Section 5: Creation-Specific Path
  - Functions only called when creating
  - Memory allocation details
  - Hash computation details
  - Inode creation flow

Section 6: Open-Specific Path  
  - Functions only called when opening existing
  - Fast lookup path
  - Permission checks
  - Reference counting

Section 7: Reconvergence Points
  - Where do paths meet again?
  - Common cleanup code
  - File installation (fd_install)

Section 8: Performance Metrics
  - Instruction counts
  - Cache behavior
  - Lock contention
  - Syscall latency

Section 9: Memory Layout Diagrams
  - struct file layout
  - struct dentry layout
  - struct inode layout
  - Pointer relationships

Section 10: Mathematical Analysis
  - Hash collision probability
  - Dentry cache hit rates
  - Time complexity: O(n) for path depth

================================================================================
SECTION 6: CODE COMMENT REQUIREMENTS (DETAILED SPEC)
================================================================================

EVERY CODE COMMENT MUST INCLUDE:
--------------------------------
1. Variable values with concrete numbers
   - BAD:  "// id is the user id"
   - GOOD: "// id = 42 → 0x2A → stored at offset 0x00 in struct user (4 bytes)"

2. Memory address calculations
   - BAD:  "// pointer to struct file"
   - GOOD: "// file = 0xffff8c77a3b2c400 → kmalloc(256) at 2026-02-13 19:48:32.123456789"

3. Hash computations
   - BAD:  "// compute hash"
   - GOOD: "// hash = 0x58bf7e6f = ((0x0 * 33 + 't') * 33 + 'e') * 33 + 's' ... [full expansion]"

4. Size calculations
   - BAD:  "// allocate memory"
   - GOOD: "// kmalloc(256) = 256 bytes → 4 cache lines (64 bytes each) at addresses 0xA000-0xA0FF"

5. Timing information
   - BAD:  "// function called"
   - GOOD: "// entry: t=1234567890123ns, exit: t=1234567890456ns, duration: 333ns"

6. Reference counts
   - BAD:  "// increment refcount"
   - GOOD: "// dget(dentry): refcount 2 → 3 at 0xffff8c77a3b2c400+0x18 (offset of d_lockref)"

EXAMPLE COMMENT STYLE:
---------------------
```c
// filename = "test_file.txt" (14 chars + '\0' = 15 bytes)
// stored at 0x7ffeefbff8a0 on stack
// parent->d_name.hash = 0x8a3b2c1d (salt)
// hash computation:
//   h = 0x8a3b2c1d (initial salt)
//   h = ((h << 5) + h) + 't' = 0x1476643be + 0x74 = 0x147664432
//   h = ((h << 5) + h) + 'e' = 0x28ecc8864 + 0x65 = 0x28ecc88c9
//   ... [continue for all 14 characters]
//   final hash = 0x58bf7e6f (stored in dentry->d_name.hash)
```

================================================================================
SECTION 7: REMAINING QUESTIONS TO ANSWER
================================================================================

Q7.1: How to ensure trace capture doesn't cause kernel crash?
  - Use safe printk formats (%px not %s)
  - Validate all pointers before dereference
  - Use probe_kernel_read() for string access
  - Set maxactive appropriately

Q7.2: How to correlate traces between two drivers?
  - Use common timestamp source?
  - Include sequence numbers?
  - Match by filename being processed?

Q7.3: What if file creation fails?
  - Error path tracing needed?
  - How to distinguish ENOSPC vs EACCES vs other errors?

Q7.4: Race conditions?
  - What if another process creates file between check and create?
  - How does kernel handle this?
  - Should we trace the retry logic?

Q7.5: Filesystem-specific variations?
  - ext4 vs xfs vs tmpfs behavior differences?
  - Should we test on specific filesystem?
  - How to make results general?

Q7.6: Kernel version dependencies?
  - Are function signatures stable across 6.x kernels?
  - What if probe points change?
  - How to detect and adapt?

Q7.7: Dmesg buffer overflow?
  - How many trace messages expected?
  - Dmesg buffer size: 16384 lines default?
  - Strategy to capture all without loss?

Q7.8: Analysis tool requirements?
  - Custom parser for dmesg output?
  - Format: timestamp|pid|function|params|return?
  - Automated diff generation?

================================================================================
SECTION 8: SUCCESS CRITERIA
================================================================================

MINIMUM SUCCESS:
---------------
✓ Driver A compiles and loads
✓ Driver B compiles and loads  
✓ Userspace A creates file without error
✓ Userspace B opens file without error
✓ Dmesg contains traces from both drivers
✓ Markdown document created

FULL SUCCESS:
------------
✓ All 25+ functions traced in both paths
✓ Exact divergence point identified (line number)
✓ Complete intersection list generated
✓ Memory layout diagrams created
✓ Performance metrics calculated
✓ Mathematical analysis included
✓ Code comments follow strict numerical format

================================================================================
SECTION 9: IMPLEMENTATION ORDER
================================================================================

PHASE 1: Planning (Current)
  ✓ Document requirements
  ✓ List all functions to trace
  → Next: Identify exact kernel line numbers

PHASE 2: Driver Development
  → Create Driver A skeleton
  → Add probes one by one
  → Test compile and load
  → Create Driver B similarly

PHASE 3: Userspace Development
  → Create Program A
  → Create Program B
  → Test both programs without drivers

PHASE 4: Integration Testing
  → Load Driver A + Run Program A
  → Save dmesg output
  → Load Driver B + Run Program B
  → Save dmesg output

PHASE 5: Analysis
  → Parse dmesg outputs
  → Generate call graphs
  → Identify intersections/differences
  → Create markdown document

PHASE 6: Documentation
  → Add detailed comments to code
  → Verify all numerical examples
  → Final review and sync

================================================================================
END OF PLANNING DOCUMENT
Next Step: Begin Phase 2 - Driver Development
================================================================================
