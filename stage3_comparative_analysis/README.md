# Stage 3 Comparative Analysis
## Comparing VFS Paths: Create vs Open Existing

### Overview

This tool compares the kernel VFS path taken when:
1. **Creating a new file** (with O_CREAT flag)
2. **Opening an existing file** (cache hit)

### Key Differences Captured

| Function | Scenario A (Create) | Scenario B (Open) |
|----------|-------------------|------------------|
| `d_alloc()` | ✅ Called (allocates new dentry) | ❌ Not called |
| `vfs_create()` | ✅ Called (filesystem create) | ❌ Not called |
| `d_instantiate()` | ✅ Called (links dentry to inode) | ❌ Not called |
| `__d_lookup_rcu()` | ❌ Not called | ✅ Called (fast lookup) |
| `d_revalidate()` | ❌ Not called | ✅ Called (verify dentry) |
| `lookup_fast()` | Miss (not in cache) | Hit (in cache) |

### Files

```
stage3_comparative_analysis/
├── user_create.c           # Creates file with O_CREAT
├── user_open.c             # Opens existing file
├── driver_comparative.c    # Kernel probe driver
├── Makefile               # Build everything
├── analyze.sh             # Automated testing script
├── PLAN.md                # Detailed plan
└── results/               # Generated results
    ├── scenario_a_creation.log
    ├── scenario_b_open.log
    └── analysis.txt
```

### Quick Start

```bash
# Build everything
make

# Run automated analysis
chmod +x analyze.sh
./analyze.sh

# Or run manually:

# Test 1: File Creation
make test-create

# Test 2: Open Existing
make test-open

# Compare results
diff results/scenario_a_creation.log results/scenario_b_open.log
```

### Manual Testing

#### Scenario A: Create File
```bash
# Terminal 1: Monitor
dmesg -w

# Terminal 2: Test
sudo insmod driver_comparative.ko target_comm="user_create"
./user_create test_file.txt
sudo rmmod driver_comparative

# Check which functions were called
dmesg | grep PROBE
```

#### Scenario B: Open Existing
```bash
# Terminal 1: Monitor
dmesg -w

# Terminal 2: Test
sudo insmod driver_comparative.ko target_comm="user_open"
./user_open test_file.txt
sudo rmmod driver_comparative

# Check which functions were called
dmesg | grep PROBE
```

### Expected Results

#### Creation Path (Scenario A)
```
[PROBE:001] ENTRY: do_sys_openat2
[PROBE:002] ENTRY: do_filp_open
[PROBE:003] ENTRY: path_openat
[PROBE:004] ENTRY: path_init
[PROBE:005] ENTRY: link_path_walk path="test_file.txt"
[PROBE:006] ENTRY: open_last_lookups
[PROBE:007] ENTRY: lookup_open
[PROBE:008] ENTRY: lookup_fast
[PROBE:009] ENTRY: d_alloc [D_ALLOC] Allocating NEW dentry (CREATION PATH)
[PROBE:010] ENTRY: vfs_create [VFS_CREATE] Calling filesystem create
[PROBE:011] ENTRY: d_instantiate [D_INSTANTIATE] Linking dentry to inode
[PROBE:012] ENTRY: vfs_open
...
```

#### Lookup Path (Scenario B)
```
[PROBE:001] ENTRY: do_sys_openat2
[PROBE:002] ENTRY: do_filp_open
[PROBE:003] ENTRY: path_openat
[PROBE:004] ENTRY: path_init
[PROBE:005] ENTRY: link_path_walk path="test_file.txt"
[PROBE:006] ENTRY: open_last_lookups
[PROBE:007] ENTRY: lookup_open
[PROBE:008] ENTRY: lookup_fast
[PROBE:009] ENTRY: __d_lookup_rcu [D_LOOKUP_RCU] Fast RCU lookup (CACHE HIT PATH)
[PROBE:010] ENTRY: d_revalidate [D_REVALIDATE] Validating dentry
[PROBE:011] ENTRY: vfs_open
...
```

### Probed Functions

The driver probes 21 VFS functions:

**Entry Points:**
- `do_sys_openat2` - System call entry
- `do_filp_open` - File open dispatcher

**Path Resolution:**
- `path_openat` - Main open path
- `path_init` - Initialize path walking
- `link_path_walk` - Walk path components

**Lookup Stage:**
- `open_last_lookups` - Final lookup stage
- `lookup_open` - Open or create
- `lookup_fast` - Fast cache lookup

**Dentry Operations:**
- `__d_lookup_rcu` - RCU dentry lookup
- `d_lookup` - Dentry lookup
- `d_alloc` - Allocate new dentry
- `d_alloc_parallel` - Parallel allocation
- `d_instantiate` - Link dentry to inode
- `d_revalidate` - Validate dentry

**Filesystem Operations:**
- `vfs_create` - Create file
- `vfs_open` - Open file
- `do_dentry_open` - Open dentry

**File Allocation:**
- `alloc_empty_file` - Allocate struct file
- `init_file` - Initialize file

**Hash Operations:**
- `full_name_hash` - Compute name hash

### Hash/Salt Analysis

Both scenarios compute the same hash for the filename using `full_name_hash()`. The difference is:

- **Creation**: Hash computed during `d_alloc()` for new dentry
- **Open**: Hash computed during `__d_lookup_rcu()` to find existing dentry

The salt comes from the parent directory's dentry and should match in both scenarios.

### Troubleshooting

**Driver won't load:**
```bash
# Check dmesg for errors
dmesg | tail -20

# Check if functions exist
cat /proc/kallsyms | grep do_sys_openat2
```

**No probe output:**
- Ensure `target_comm` matches your program name ("user_create" or "user_open")
- Check that probe functions exist in your kernel
- Run without filter: `sudo insmod driver_comparative.ko`

**System crash:**
- See `KERNEL_CRASH_CAPTURE_GUIDE.md` in parent directory
- Use netconsole for remote logging
- Test one driver at a time

### Safety

- Filter by process name to avoid probe spam
- Test with simple files first
- Keep crash capture ready
- Do NOT use `copy_from_user()` in probe handlers

### Next Steps

1. Build: `make`
2. Test: `./analyze.sh`
3. Review: `cat results/analysis.txt`
4. Compare: Look for differences in function paths

### References

- `PLAN.md` - Detailed implementation plan
- `../KERNEL_CRASH_CAPTURE_GUIDE.md` - How to capture kernel crashes
- `../STAGE3_BUILD_*/PROGRESS_LOG.txt` - Build log
