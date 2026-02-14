# COMPREHENSIVE PLANNING DOCUMENT
## VFS Path Analysis: File Creation vs File Opening
**Date:** 2026-02-13  
**Time:** 19:25 IST  
**Kernel Version:** 6.17.0-14-generic  
**Goal:** Prove and document the different code paths taken when opening an existing file vs creating a new file

---

## 1. TASK DECOMPOSITION - GRILLING THE REQUIREMENTS

### 1.1 Primary Goal Analysis
**Original Request:**
- Create NEW folder with 2 drivers
- Create 2 userspace programs
- Driver 1: Trace file CREATION (d_alloc, dentry creation)
- Driver 2: Trace file OPENING (hash matching in linked list)
- User 1: Create file
- User 2: Open file and verify hash matches

### 1.2 Core Questions That Must Be Answered

#### Q1: What EXACTLY does "prove the path" mean?
- Does it mean function call sequence?
- Does it mean data structure transformations?
- Does it mean timing/synchronization differences?
- Does it mean lock acquisition patterns?
- **UNKNOWN - NEEDS CLARIFICATION**

#### Q2: What is the "intersection" of both paths?
- Functions called in BOTH cases?
- Data structures accessed in BOTH cases?
- Locks held in BOTH cases?
- Memory allocations in BOTH cases?
- **UNKNOWN - NEEDS ANALYSIS**

#### Q3: What are the "uncommon things"?
- Functions ONLY called in creation?
- Functions ONLY called in opening?
- Different hash calculations?
- Different dentry states?
- **UNKNOWN - NEEDS TRACING**

#### Q4: Where exactly do paths diverge?
- At which function call?
- At which conditional branch?
- At which data structure check?
- At which return path?
- **CRITICAL - DETERMINES PROBE PLACEMENT**

---

## 2. KERNEL SOURCE ANALYSIS

### 2.1 Entry Points Identified

**System Call Flow:**
```
1. do_sys_openat2() → Entry point from userspace
2. do_filp_open()    → Sets up nameidata, calls path_openat()
3. path_openat()     → Main path resolution logic
```

### 2.2 Path Resolution Functions

**From /usr/src/linux-hwe-6.17-6.17.0/fs/namei.c:**

#### A. path_openat() [Line 4034]
- Takes: struct nameidata, open_flags, lookup_flags
- Returns: struct file pointer
- Calls: link_path_walk() → open_last_lookups()

#### B. open_last_lookups() [Line 3768]
**CRITICAL DECISION POINT:**
```c
Line 3786: dentry = lookup_fast_for_open(nd, open_flag);
Line 3790: if (likely(dentry)) goto finish_lookup;  // FILE EXISTS PATH
Line 3793: if (!(open_flag & O_CREAT)) {  // NO CREATE FLAG
    return ERR_PTR(-ECHILD);  // FILE NOT FOUND, CANNOT CREATE
}
// Continue to lookup_open() for creation...
```

#### C. lookup_open() [Line 3618]
**THE DIVERGENCE POINT:**
```c
Line 3635: dentry = d_lookup(dir, &nd->last);  // Try to find existing
Line 3637: for (;;) {
Line 3638:     if (!dentry) {
Line 3638:         dentry = d_alloc_parallel(dir, &nd->last, &wq);  // CREATE PATH
// ...
Line 3654: if (dentry->d_inode) {
Line 3655:     return dentry;  // FILE EXISTS - POSITIVE CACHE HIT
// ...
Line 3674: if (open_flag & O_CREAT) {
Line 3679:     create_error = may_o_create(...);  // CHECK CREATE PERMISSIONS
Line 3693: if (d_in_lookup(dentry)) {
Line 3694:     res = dir_inode->i_op->lookup(...);  // LOOKUP IN FILESYSTEM
```

### 2.3 Dentry Cache (dcache) Functions

**From /usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c:**

#### A. d_alloc() [Line 1767]
```c
struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
{
    struct dentry *dentry = __d_alloc(parent->d_sb, name);
    // Allocates new dentry with given name
    // Called when: File does NOT exist and O_CREAT is set
}
```

#### B. __d_lookup_rcu() [Line 2253]
```c
struct dentry *__d_lookup_rcu(const struct dentry *parent,
                              const struct qstr *name,
                              unsigned *seqp)
{
    // Fast RCU-based lookup
    // Called when: Looking up file (exists or not)
    // Returns: dentry if found, NULL if not found
}
```

#### C. __d_lookup() [Line 2362]
```c
struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
{
    // Slower non-RCU lookup
    // Called when: RCU lookup fails or in non-RCU mode
}
```

#### D. d_alloc_parallel() [Line 2542]
```c
struct dentry *d_alloc_parallel(struct dentry *parent,
                                const struct qstr *name,
                                wait_queue_head_t *wq)
{
    struct dentry *new = __d_alloc(parent->d_sb, name);
    // For parallel allocation - waits if another thread creating same dentry
}
```

### 2.4 Hash Calculation

**From include/linux/stringhash.h:**
```c
extern unsigned int __pure full_name_hash(const void *salt, const char *, unsigned int);
```

**Key Points:**
- Uses `parent dentry pointer` as salt
- This means: Same filename in different directories = different hash
- This explains Case 12's hash change when moving directories

---

## 3. PATH ANALYSIS - WHERE DO THEY DIVERGE?

### 3.1 Common Path (INTERSECTION)

**Functions Called in BOTH Cases:**
1. do_sys_openat2()
2. do_filp_open()
3. path_openat()
4. link_path_walk()
5. lookup_fast() / __d_lookup_rcu() - Attempt to find file
6. open_last_lookups()

**Data Structures Accessed:**
- struct nameidata
- struct dentry (parent)
- struct qstr (filename)
- dcache hash table

**Locks Held:**
- RCU read lock (initial phase)
- rename_lock (briefly)

### 3.2 File EXISTS Path (Open Existing)

**Unique Functions:**
1. lookup_fast_for_open() - Finds dentry in cache
2. d_revalidate() - Verifies dentry is still valid
3. f_op->open() - Filesystem-specific open
4. do_dentry_open() - Setup file structure

**Key Decision Point:**
```
lookup_open() line 3654:
if (dentry->d_inode) {
    // FILE EXISTS
    return dentry;  // Go directly to open
}
```

**State Changes:**
- d_count incremented
- file structure allocated
- fd allocated
- inode referenced

### 3.3 File NOT EXISTS Path (Create New)

**Unique Functions:**
1. d_alloc_parallel() or d_alloc() - Create new dentry
2. may_o_create() - Check creation permissions
3. vfs_create() - Filesystem-specific create
4. dir_inode->i_op->lookup() - Verify doesn't exist
5. d_instantiate() - Link dentry to inode
6. d_rehash() - Add to hash table

**Key Decision Points:**
```
lookup_open() line 3637-3638:
if (!dentry) {
    dentry = d_alloc_parallel(...);  // CREATE DENTRY
}

lookup_open() line 3674-3682:
if (open_flag & O_CREAT) {
    create_error = may_o_create(...);  // CHECK PERMS
}
```

**State Changes:**
- NEW dentry allocated
- NEW inode allocated (filesystem-specific)
- Dentry hashed
- File marked "created" (FMODE_CREATED)

### 3.4 The DIVERGENCE Point

**Location:** lookup_open() in namei.c

**Exact Line:** 3654
```c
if (dentry->d_inode) {
    /* Cached positive dentry: will open in f_op->open */
    return dentry;
}
```

**What Happens Here:**
- AFTER: d_lookup() or d_alloc() has returned a dentry
- CHECK: Does dentry->d_inode exist?
- IF YES: File exists path (return immediately)
- IF NO: Continue to creation logic (may_o_create, vfs_create)

---

## 4. CRITICAL QUESTIONS FOR IMPLEMENTATION

### 4.1 Driver 1 (Creation Path) Questions

#### Q4.1.1: Which probes are ESSENTIAL?
- MUST HAVE: d_alloc() or d_alloc_parallel() to prove new dentry
- MUST HAVE: vfs_create() to prove filesystem creation
- SHOULD HAVE: d_instantiate() to prove dentry-inode linking
- NICE TO HAVE: d_rehash() to prove hash table insertion

#### Q4.1.2: What data must be captured?
- Parent dentry pointer (for salt verification)
- Hash value before and after creation
- Filename being created
- Timestamp for ordering

#### Q4.1.3: What are the crash risks?
- NULL dentry->d_name.name (fixed in earlier analysis)
- IS_ERR() checks missing
- Concurrent dentry freeing
- **MITIGATION:** Add NULL checks, use safe_dname() helper

### 4.2 Driver 2 (Opening Path) Questions

#### Q4.2.1: Which probes are ESSENTIAL?
- MUST HAVE: __d_lookup_rcu() or __d_lookup() to prove hash lookup
- MUST HAVE: d_revalidate() to prove dentry validation
- SHOULD HAVE: lookup_fast() to prove fast path taken
- NICE TO HAVE: f_op->open() (if symbol available)

#### Q4.2.2: What proves "hash matching"?
- Seeing __d_lookup_rcu() return non-NULL dentry
- Hash value matches what was created
- Parent dentry matches
- **PROOF:** Same hash + Same parent = Same file

#### Q4.2.3: What proves file was FOUND vs NOT FOUND?
- __d_lookup_rcu() returns dentry ≠ NULL → FOUND
- __d_lookup_rcu() returns NULL → NOT FOUND
- But then slow lookup happens... need to trace that too

### 4.3 Userspace Program Questions

#### Q4.3.1: How to ensure deterministic testing?
- Use fixed directory (/tmp/test_vfs_$$/)
- Use fixed filename ("testfile.txt")
- Cleanup before test
- Sync filesystem

#### Q4.3.2: What does "verify hash matches" mean?
- Does it mean compare hash values in kernel logs?
- Does it mean compute hash in userspace?
- Does it mean verify dentry pointer is same?
- **UNKNOWN - NEEDS CLARIFICATION**

#### Q4.3.3: Timing issues?
- Driver must be loaded BEFORE userspace runs
- How to ensure probe captures all events?
- What if file is in cache from previous test?
- **SOLUTION:** Clear caches, use unique filenames

---

## 5. IMPLEMENTATION STRATEGY

### 5.1 Folder Structure
```
NEW_CASE_16_HASH_PROOF/
├── driver_creation_probe.c      # Driver 1: Trace d_alloc, vfs_create
├── driver_open_probe.c          # Driver 2: Trace __d_lookup_rcu, d_revalidate
├── user_create_file.c           # User 1: Create file with O_CREAT
├── user_open_file.c             # User 2: Open existing file
├── Makefile
└── README.md
```

### 5.2 Probe Strategy

#### Driver 1 (Creation) Probes:
1. **d_alloc()** - Confirms new dentry allocation
   - Args: parent dentry, qstr name
   - Capture: parent ptr, name, hash
   
2. **d_alloc_parallel()** - Alternative path
   - Args: parent dentry, qstr name, wait_queue
   - Capture: parent ptr, name, hash
   
3. **vfs_create()** - Confirms filesystem creation
   - Args: idmap, dir inode, dentry, mode, want_excl
   - Capture: dentry ptr, mode
   
4. **d_instantiate()** - Confirms dentry-inode link
   - Args: dentry, inode
   - Capture: both pointers

#### Driver 2 (Opening) Probes:
1. **__d_lookup_rcu()** - Fast RCU lookup
   - Args: parent dentry, qstr name, seqp
   - Capture: parent ptr, name, hash, return dentry
   
2. **__d_lookup()** - Slow lookup fallback
   - Args: parent dentry, qstr name
   - Capture: parent ptr, name, hash, return dentry
   
3. **d_revalidate()** - Dentry validation
   - Args: inode, name, dentry, flags
   - Capture: dentry ptr, result
   
4. **lookup_fast()** - High-level lookup
   - Args: nameidata
   - Capture: nd->path.dentry, nd->last.name

### 5.3 Userspace Strategy

#### User 1 (Create):
```c
// Step 1: Create directory
mkdir("/tmp/test_hash_proof", 0755);

// Step 2: Create file
fd = open("/tmp/test_hash_proof/myfile.txt", 
          O_CREAT | O_WRONLY | O_TRUNC, 0644);
write(fd, "test", 4);
close(fd);

// Step 3: Signal completion
printf("CREATE_COMPLETE: myfile.txt\n");
```

#### User 2 (Open):
```c
// Step 1: Open existing file
fd = open("/tmp/test_hash_proof/myfile.txt", O_RDONLY);

// Step 2: Read to verify
read(fd, buffer, sizeof(buffer));

// Step 3: Close
close(fd);

// Step 4: Verify hash matches
printf("OPEN_COMPLETE: myfile.txt\n");
// Hash verification: Compare kernel logs from both runs
```

---

## 6. VERIFICATION CRITERIA

### 6.1 Proof Requirements

#### Proof 1: Path Taken When File NOT There
**Evidence Needed:**
- [ ] d_alloc() or d_alloc_parallel() called
- [ ] vfs_create() called
- [ ] d_instantiate() called
- [ ] New dentry pointer logged
- [ ] Hash value logged (should match full_name_hash calculation)

#### Proof 2: Path Taken When File EXISTS
**Evidence Needed:**
- [ ] __d_lookup_rcu() returns non-NULL dentry
- [ ] d_revalidate() returns success
- [ ] lookup_fast() returns dentry
- [ ] Same hash value as creation
- [ ] Same parent dentry as creation

#### Proof 3: Intersection of Paths
**Evidence Needed:**
- [ ] Both paths call do_filp_open()
- [ ] Both paths call path_openat()
- [ ] Both paths call link_path_walk()
- [ ] Both paths access dcache hash table
- [ ] Both paths use full_name_hash() with same salt

#### Proof 4: Uncommon Things
**Evidence Needed:**
- [ ] d_alloc() ONLY in creation path
- [ ] vfs_create() ONLY in creation path
- [ ] d_instantiate() ONLY in creation path
- [ ] __d_lookup_rcu returning NULL handled differently
- [ ] FMODE_CREATED flag set ONLY in creation

#### Proof 5: Divergence Point
**Evidence Needed:**
- [ ] lookup_open() is the divergence function
- [ ] Line 3654 check: `if (dentry->d_inode)`
- [ ] Creation: Falls through to may_o_create()
- [ ] Opening: Returns immediately at line 3656
- [ ] Both: Start from same lookup_open() entry

---

## 7. RISK ANALYSIS

### 7.1 Technical Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Kernel crash from NULL pointer | Medium | High | Add NULL checks to all drivers |
| Symbol not found (function inlined) | Medium | Medium | Check kallsyms, use alternatives |
| Probe misses events (timing) | Low | Medium | Use kretprobe, increase maxactive |
| Race conditions | Low | High | Use atomic operations, per-cpu buffers |
| Different kernel version | Low | High | Verify offsets, use BTF if available |

### 7.2 Known Vulnerabilities (From Previous Analysis)

**driver_rename_probe.c (lines 19-22):**
```c
// VULNERABLE:
printk("... OLD: Name='%s' ...", dentry->d_name.name);
// FIX NEEDED: Check if d_name.name is NULL
```

**Must Add to ALL New Drivers:**
```c
static const char *safe_dname(struct dentry *d) {
    if (!d || !d->d_name.name)
        return "(null)";
    return d->d_name.name;
}
```

---

## 8. OPEN QUESTIONS

### 8.1 Clarification Needed from User

1. **"Prove the path"** - Does this mean function call graph, or data flow, or both?

2. **"Intersection"** - Should we document shared functions, shared data, or both?

3. **"Uncommon things"** - Should we focus on function differences, state differences, or timing differences?

4. **"Where paths diverge"** - Do you want the exact line number, function name, or conditional branch?

5. **"Verify hash matches"** - Should userspace parse kernel logs, or just verify file content?

6. **Crash history** - Which specific drivers crashed your system? Can you share dmesg logs?

7. **Test iterations** - How many times should we run each test for statistical confidence?

8. **Output format** - Do you want logs, visual diagrams, or structured data (JSON)?

### 8.2 Assumptions Made

1. Test files will be in /tmp/ (cleared on reboot)
2. Kernel has kprobes enabled
3. Functions are not inlined (symbols available)
4. Single-threaded testing (no concurrent access)
5. ext4 filesystem (standard Ubuntu)
6. No SELinux/AppArmor blocking

---

## 9. NEXT STEPS

### Phase 1: Clarification (BEFORE coding)
- [ ] Get answers to Section 8.1 questions
- [ ] Confirm folder name
- [ ] Confirm exact probe list
- [ ] Confirm output format

### Phase 2: Implementation
- [ ] Create folder structure
- [ ] Implement Driver 1 (creation)
- [ ] Implement Driver 2 (opening)
- [ ] Implement User 1 (create)
- [ ] Implement User 2 (open)
- [ ] Add NULL safety checks
- [ ] Create Makefile

### Phase 3: Testing
- [ ] Compile all components
- [ ] Test creation path
- [ ] Test opening path
- [ ] Collect kernel logs
- [ ] Verify hash matching
- [ ] Document divergence point

### Phase 4: Documentation
- [ ] Update this planning doc with findings
- [ ] Create path diagram (ASCII art)
- [ ] Write final report
- [ ] Log everything in progress file

---

## 10. TIMELINE ESTIMATE

| Phase | Estimated Time | Dependencies |
|-------|---------------|--------------|
| Clarification | 30 min | User availability |
| Implementation | 2-3 hours | After clarification |
| Testing | 1-2 hours | After implementation |
| Documentation | 1 hour | After testing |
| **Total** | **5-7 hours** | - |

---

## 11. RELATED FILES REFERENCES

**Progress Log:**
- `/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case1/progress_log.txt`
- `/home/r/Desktop/what-happens-when-open-is-called/TEST_RESULTS_20260213_191751/FINAL_TEST_SUMMARY.txt`

**Kernel Source:**
- `/usr/src/linux-hwe-6.17-6.17.0/fs/namei.c` (path resolution)
- `/usr/src/linux-hwe-6.17-6.17.0/fs/dcache.c` (dentry cache)
- `/usr/src/linux-hwe-6.17-6.17.0/include/linux/stringhash.h` (hash functions)

**Existing Drivers (Reference):**
- `/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case8_creation_proof/` (creation probes)
- `/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case12_harder_puzzle/` (d_move, hash change)

---

**END OF PLANNING DOCUMENT**

**Status:** AWAITING CLARIFICATION BEFORE PROCEEDING  
**Next Action:** Answer questions in Section 8.1  
**Risk Level:** MEDIUM (known crash vulnerabilities must be avoided)
