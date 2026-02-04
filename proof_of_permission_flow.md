# KERNEL PERMISSION TRACE: SOURCE PROOF

## 1. USER SPACE REQ
**Syscall:** `open("file", O_RDWR)`
**Header:** `/usr/include/asm-generic/fcntl.h`
**Value:** `O_RDWR` = `2` (`0000 0010`)

## 2. KERNEL ENTRY (TRANSIT)
**Proof:** `/usr/src/linux-source-6.8.0/fs/open.c:1388`
**Function:** `do_sys_openat2`
**Data State:** `flags` = `2` passed in register.

**Proof:** `/usr/src/linux-source-6.8.0/fs/namei.c:3780`
**Function:** `path_openat`
**Action:** Starts the path walk loop.

## 3. TRANSFORMATION (LOOKUP)
**Source:** `include/linux/fs.h`
**Macro:** `ACC_MODE(x)` = `"\004\002\006\006"[(x)&O_ACCMODE]`
**Result:** `\006` (Decimal `6`)

**Proof:** `/usr/src/linux-source-6.8.0/fs/open.c` (Logic inferred from `op->acc_mode`)
**State:** `acc_mode` = `6` (`110`) at VFS layer creation.

**Proof:** `/usr/src/linux-source-6.8.0/fs/open.c:1084`
**Function:** `vfs_open`
**Action:** Uses the `struct file` with the transformed mode.

## 4. LOGIC GATE (CHECK)
**Proof:** `/usr/src/linux-source-6.8.0/fs/namei.c:504`
**Function:** `inode_permission(inode, mask)`
**Input:** `mask` = `6`
**Target:** `inode->i_mode` (e.g., `0644` -> Owner `110`)

**Gate Logic:**
```c
/* fs/namei.c Logic Derivation */
if ((inode->i_mode & mask) == mask) return 0;
```
**Calc:** `(110 & 110) == 110` -> **TRUE**

## 5. REJECTION (FAILURE)
**Target:** `inode->i_mode` (e.g., `0640` -> Other `000`)
**Gate:** `(ModeBits & Mask) == Mask`
**Calc:** `(000 & 110) == 110` -> `0 != 6` -> **FALSE**
**Return:** `-EACCES` (-13)
