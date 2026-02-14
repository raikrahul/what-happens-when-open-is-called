# Stage 3 Comparative Analysis Plan
## Goal: Compare VFS Paths - Create vs Open Existing

### Objective
Create two test scenarios that capture and compare the kernel VFS path taken when:
1. **Scenario A**: Creating a new file (O_CREAT flag)
2. **Scenario B**: Opening an existing file (no O_CREAT)

### Expected Differences

#### Scenario A (O_CREAT - File Creation Path):
- `do_sys_openat2()` → entry point
- `do_filp_open()` → open preparation
- `path_openat()` → path resolution
- `path_init()` → initialize nameidata
- `link_path_walk()` → walk path components
- `open_last_lookups()` → final lookup
- `lookup_open()` → **CRITICAL**: Creates dentry if not exists
- `lookup_fast()` → cache lookup (will miss)
- `d_alloc()` → **ALLOCATES new dentry**
- `d_instantiate()` → **LINKS dentry to inode**
- `vfs_create()` → **CALLS filesystem create**
- `vfs_open()` → open the new file
- `alloc_empty_file()` → allocate struct file
- `init_file()` → initialize file

#### Scenario B (Open Existing - Lookup Path):
- `do_sys_openat2()` → entry point
- `do_filp_open()` → open preparation
- `path_openat()` → path resolution
- `path_init()` → initialize nameidata
- `link_path_walk()` → walk path components
- `open_last_lookups()` → final lookup
- `lookup_open()` → lookup existing
- `lookup_fast()` → cache lookup (will **HIT**)
- `__d_lookup_rcu()` → **FAST dentry lookup**
- `d_revalidate()` → verify dentry still valid
- `vfs_open()` → open existing file
- `alloc_empty_file()` → allocate struct file
- `init_file()` → initialize file

### Key Differences to Capture

1. **d_alloc() vs d_lookup()** - Creation allocates, opening looks up
2. **vfs_create()** - Only called in creation path
3. **d_instantiate()** - Only called in creation path
4. **d_revalidate()** - Called in lookup path
5. **__d_lookup_rcu()** - Fast path only for existing files
6. **lookup_fast()** - Returns different results (miss vs hit)
7. **Hash computation** - Different for new vs existing dentries

### Probe Points

```c
// Entry points
"do_sys_openat2"      // System call entry
"do_filp_open"        // File open dispatcher
"path_openat"         // Main open path

// Path resolution
"path_init"           // Initialize path walking
"link_path_walk"      // Walk path components
"open_last_lookups"   // Final lookup stage

// Lookup vs Create divergence
"lookup_open"         // Opens or creates
"lookup_fast"         // Fast cache lookup
"__d_lookup_rcu"      // RCU dentry lookup

// Creation specific (Scenario A only)
"d_alloc"             // Allocate new dentry
"d_alloc_parallel"    // Parallel dentry alloc
"d_instantiate"       // Link dentry to inode
"vfs_create"          // Filesystem create
"security_inode_create" // Security check

// Opening (both scenarios)
"vfs_open"            // Open file
"do_dentry_open"      // Open dentry
"alloc_empty_file"    // Allocate struct file
"init_file"           // Initialize file

// Hash/Salt (both scenarios)
"full_name_hash"      // Compute name hash
"d_hash"              // Hash dentry name
```

### Test Procedure

1. **Setup**:
   ```bash
   # Terminal 1: Monitor kernel log
   sudo dmesg -C
   sudo dmesg -w > scenario_a.log &
   
   # Terminal 2: Run test
   cd /stage3_comparative_analysis
   ```

2. **Scenario A (Create)**:
   ```bash
   # Ensure file doesn't exist
   rm -f test_file.txt
   
   # Load driver
   sudo insmod driver_comparative.ko target_comm="user_create"
   
   # Run creation test
   ./user_create test_file.txt
   
   # Unload driver
   sudo rmmod driver_comparative
   ```

3. **Scenario B (Open)**:
   ```bash
   # Terminal 1: New log file
   sudo dmesg -C
   sudo dmesg -w > scenario_b.log &
   
   # Terminal 2: Open existing
   sudo insmod driver_comparative.ko target_comm="user_open"
   ./user_open test_file.txt
   sudo rmmod driver_comparative
   ```

4. **Analysis**:
   ```bash
   # Compare function calls
   diff scenario_a.log scenario_b.log
   
   # Count unique functions in each
   grep "PROBE:" scenario_a.log | sort | uniq -c > scenario_a_functions.txt
   grep "PROBE:" scenario_b.log | sort | uniq -c > scenario_b_functions.txt
   
   # Show differences
   diff scenario_a_functions.txt scenario_b_functions.txt
   ```

### Files to Create

1. **user_create.c** - Creates file with O_CREAT
2. **user_open.c** - Opens existing file
3. **driver_comparative.c** - Comprehensive VFS probe driver
4. **Makefile** - Build both user and kernel code
5. **analyze.sh** - Automated test and analysis script
6. **README.md** - Instructions

### Expected Output

#### Scenario A Log (Creation):
```
[PROBE] ENTRY: do_sys_openat2 (flags=0x241)  // O_CREAT|O_WRONLY|O_TRUNC
[PROBE] ENTRY: do_filp_open
[PROBE] ENTRY: path_openat
[PROBE] ENTRY: path_init
[PROBE] ENTRY: link_path_walk path="test_file.txt"
[PROBE] ENTRY: open_last_lookups
[PROBE] ENTRY: lookup_open (LOOKUP_CREATE)
[PROBE] ENTRY: lookup_fast (MISS - not in cache)
[PROBE] ENTRY: d_alloc (NEW DENTRY ALLOCATED)  <-- KEY DIFFERENCE
[PROBE] ENTRY: vfs_create                      <-- KEY DIFFERENCE
[PROBE] ENTRY: d_instantiate                   <-- KEY DIFFERENCE
[PROBE] ENTRY: vfs_open
[PROBE] ENTRY: alloc_empty_file
[PROBE] ENTRY: init_file
[PROBE] EXIT: do_sys_openat2 (fd=3)
```

#### Scenario B Log (Open Existing):
```
[PROBE] ENTRY: do_sys_openat2 (flags=0x1)     // O_RDONLY
[PROBE] ENTRY: do_filp_open
[PROBE] ENTRY: path_openat
[PROBE] ENTRY: path_init
[PROBE] ENTRY: link_path_walk path="test_file.txt"
[PROBE] ENTRY: open_last_lookups
[PROBE] ENTRY: lookup_open
[PROBE] ENTRY: lookup_fast (HIT - in cache)
[PROBE] ENTRY: __d_lookup_rcu                 <-- KEY DIFFERENCE
[PROBE] ENTRY: d_revalidate                   <-- KEY DIFFERENCE
[PROBE] ENTRY: vfs_open
[PROBE] ENTRY: alloc_empty_file
[PROBE] ENTRY: init_file
[PROBE] EXIT: do_sys_openat2 (fd=3)
```

### Hash/Salt Verification

Both scenarios should show:
- Hash computation via `full_name_hash()`
- Salt application in dentry hash
- Hash table lookup in `__d_lookup()`

The hash SHOULD match for the same filename in both scenarios.
The salt comes from the parent directory's dentry.

### Directory Structure

```
stage3_comparative_analysis/
├── user_create.c              # Create file program
├── user_open.c                # Open file program
├── driver_comparative.c       # VFS probe driver
├── Makefile                   # Build everything
├── analyze.sh                 # Run tests and analyze
├── README.md                  # Instructions
└── results/                   # Generated logs
    ├── scenario_a.log
    ├── scenario_b.log
    └── comparison.txt
```

## Implementation Steps

1. Create directory structure
2. Write user_create.c
3. Write user_open.c
4. Write driver_comparative.c with all probe points
5. Write Makefile
6. Write analyze.sh script
7. Test and verify

## Success Criteria

- [ ] Both user programs compile and run
- [ ] Driver loads without crash
- [ ] Scenario A shows d_alloc() and vfs_create()
- [ ] Scenario B shows __d_lookup_rcu() and cache hit
- [ ] Hash values match between scenarios
- [ ] Clear difference in function call paths
- [ ] Analysis script generates comparison report
