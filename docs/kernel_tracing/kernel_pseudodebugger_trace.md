# KERNEL PSEUDO-DEBUGGER TRACE: OPEN() PERMISSIONS

**Goal:** Axiomatic verified trace of `open("file", O_RDWR)` -> Kernel Permission Check.
**Target File:** `/usr/src/linux-source-6.8.0` on Local Machine.
**User Input:** `flags = 2` (`O_RDWR`).
**Inode State:** `mode = 0644` (Owner: `rw-`).

---

### #1. CALL: do_sys_openat2
*   **Location:** `fs/open.c:1388` (Caller: System Call Entry)
*   **Values:** `dfd=-100`, `filename="file"`, `flags=2`, `mode=0`
*   **Real Data:** `RSI=0x2` (O_RDWR)
*   **Work:** Entry point. Initializes `struct open_how` with raw flags.
*   **Errors:** Checks if flags are valid integer.
*   **State:** Ring 0 Transition Complete.

### #2. CALL: getname
*   **Location:** `fs/namei.c:120` (Caller: `do_sys_openat2`)
*   **Values:** `filename="file"`
*   **Real Data:** `0x5555...` (User Ptr) -> `struct filename*` (Kernel Ptr)
*   **Work:** `strncpy_from_user`. Copies bytes from User Space to Kernel Heap.
*   **Why:** TOCTOU prevention. Kernel owns the string now.

### #3. CALL: path_openat
*   **Location:** `fs/namei.c:3780` (Caller: `do_sys_openat2`)
*   **Values:** `nd`, `op`, `flags=2`
*   **Real Data:** `op->open_flag = 2`
*   **Work:** Starts the "Path Walk" loop.
*   **Flow:** `link_path_walk` -> `walk_component` -> `lookup_fast`.

### #4. CALL: do_last
*   **Location:** `fs/namei.c:3580` (Caller: `path_openat`)
*   **Values:** `nd`, `file`, `op`
*   **Real Data:** `nd->inode` points to Inode `0x8899aabb` (Disk Inode).
*   **Work:** We found the file. Now we must open it.

### #5. CALL: vfs_open
*   **Location:** `fs/open.c:1084` (Caller: `do_last`)
*   **Values:** `path`, `file`
*   **Real Data:** `file->f_flags = 2`.
*   **Work:** Prepares `struct file` object. This is the **TRANSFORMATION POINT**.

### #6. COMPUTATION: ACC_MODE Transformation
*   **Location:** `fs/open.c:1209` (Inside `do_dentry_open`)
*   **Operation:** `acc_mode = ACC_MODE(flags)`
*   **Macro Source:** `include/linux/fs.h` -> `"\004\002\006\006"[(x)&O_ACCMODE]`
*   **Real Data:**
    *   `x = 2`
    *   `x & 3 = 2`
    *   `String[2] = \006` (Decimal 6)
*   **Result:** `acc_mode = 6` (`0000 0110` -> `MAY_READ | MAY_WRITE`)

### #7. CALL: may_open
*   **Location:** `fs/namei.c:3234` (Caller: `do_dentry_open`)
*   **Values:** `path`, `acc_mode=6`, `flag=2`
*   **Real Data:** `acc_mode` is passed as the **Requirement**.
*   **Work:** Checks file integrity (immutable? append-only?) and calls permission.

### #8. CALL: inode_permission
*   **Location:** `fs/namei.c:504` (Caller: `may_open`)
*   **Values:** `inode`, `mask=6`
*   **Real Data:** `inode->i_mode = 0644` (`...110 100 100`)
*   **Work:** Wrapper for `do_inode_permission`.

### #9. CALL: generic_permission
*   **Location:** `fs/namei.c:400` (Caller: `do_inode_permission`)
*   **Values:** `inode`, `mask=6`
*   **Real Data:**
    *   `mask = 0000 0110` (6)
    *   `check = 0000 0110` (from Inode Owner Bits)
*   **Work:** `acl_permission_check` -> `generic_permission_check`.

### #10. LOGIC GATE: The Bitwise Check
*   **Location:** `fs/namei.c` (inside `generic_permission`)
*   **Operation:** `(inode_bits & mask) == mask`
*   **Calculation:**
    *   `110` (Inode Granted) `&` `110` (Requested)
    *   Result: `110`
    *   `110 == 110` -> **TRUE**
*   **Return:** `0` (Success).

### #11. RETURN STACK
*   `generic_permission` -> `0`
*   `inode_permission` -> `0`
*   `may_open` -> `0`
*   `vfs_open` -> `0` (Returns `struct file*`)
*   `do_sys_openat2` -> Allocates FD `3`.
*   **User Space Result:** `3`.
