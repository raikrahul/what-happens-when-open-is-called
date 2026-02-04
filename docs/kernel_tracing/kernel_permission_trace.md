# KERNEL PERMISSION TRACE: THE PRIMATE MATH

## 1. Input Data (User Space)
*   **Source:** `open(..., O_RDWR)`
*   **Header:** `/usr/include/asm-generic/fcntl.h`
*   **Value:** `O_RDWR` = `00000002` (Octal) = `0000 0010` (Binary)

## 2. Kernel Transformation (The Lookup)
**File:** `/usr/src/linux-source-6.8.0/include/linux/fs.h`
**Macro:** `#define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])`

**Derivation:**
1.  **Masking:** `2 & 3` = `2` (Index)
2.  **String Literal:** `"\004\002\006\006"`
3.  **Lookup:** `String[2]` = `\006`
4.  **Result:** `6` (`0000 0110`)

## 3. Kernel Constants (The Target)
**File:** `/usr/src/linux-source-6.8.0/include/linux/fs.h`
```c
#define MAY_WRITE 0x00000002
#define MAY_READ  0x00000004
```
**Correlation:**
`6` = `4 | 2` = `MAY_READ | MAY_WRITE`

## 4. The Source Code Logic (fs/open.c)
**Line 1209:** `int acc_mode = ACC_MODE(flags);`
*   `acc_mode` becomes `6`.

## 5. The Logic Gate (fs/namei.c)
**Function:** `inode_permission(inode, mask)`
**Variable:** `mask` is `acc_mode` (`6`).

**Structure:** `inode->i_mode` (from `stat`)
*   Example: `0644` (Owner: `rw-` / `110`)
*   Owner Bits: `110` (Binary)

**Bitwise Operation:**
```c
// (InodeBits & Mask) == Mask
(0x06 & 0x06) == 0x06
// 110 & 110 == 110
// TRUE -> Access Granted
```
