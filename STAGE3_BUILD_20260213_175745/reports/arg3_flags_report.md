# DRIVER REPORT: ARG3 - THE FLAGS
**Trace Date:** 2026-02-05
**Module:** `trace_flags.ko`
**Target:** `do_filp_open()`

## 1. STRATEGY: WHY THIS DRIVER?
After `getname` secures the filename, `do_filp_open` is the central hub for opening the file. It takes the `struct filename` and an `op` structure containing the intent.
We trace this to verify how the user's `O_RDWR` (0x2) is transformed into kernel-internal permission bits.

## 2. THE RAW DATA (Captured Trace)
We captured 3 events. The first two were for shared libraries (O_RDONLY). The third was our specific `open()` call:

```text
[26076.351538] #3. do_filp_open. op_ptr=0xffffd19712c4fd84.
[26076.351544]     open_flag=0x8002 (Expected 0x8002)
[26076.351549]     acc_mode=0x6  (Expected 0x6)
[26076.351553]     intent=0x100
[26076.351557]     [✓] AXIOM: open_flag == O_RDWR | O_LARGEFILE
[26076.351562]     [✓] AXIOM: acc_mode == MAY_READ | MAY_WRITE
```

### PSEUDO-DEBUGGER STEP
```text
#2.Call: do_filp_open(dfd=-100, filename=0xffff898345cef000, op=0xffffd19712c4fd84)
   Values: RDX=0xffffd19712c4fd84
   Data: struct open_flags { open_flag=0x8002, acc_mode=0x6, intent=0x100 }
   Work: Resolve flags. Determine if file needs creation. Check permissions.
   Errors: CHECKED. Valid pointer.
   Real Value: 0x8002 (O_RDWR | O_LARGEFILE)
   Real Data: 0x6 (Read+Write Permission)
   Caller: do_sys_openat2 (fs/open.c:1404)
   Current: fs/namei.c
```

## 3. AXIOMATIC VERIFICATION

### A. Flag Transformation
- **User Input:** `O_RDWR` = `0x2`
- **Implicit Flag:** `O_LARGEFILE` = `0x8000` (Always set on 64-bit Linux unless O_NOLARGEFILE?)
- **Result:** `0x8000 | 0x2 = 0x8002`
- **Observed:** `0x8002`
    - **Conclusion:** The kernel automatically upgrades open calls to Large File support.

### B. Access Mode Calculation
- **Goal:** Convert "flags" to "permissions".
- **Formula:** `flags & O_ACCMODE`?
- **Mapping:**
    - `O_RDONLY (0)` → `MAY_READ (4)`
    - `O_WRONLY (1)` → `MAY_WRITE (2)`
    - `O_RDWR   (2)` → `MAY_READ | MAY_WRITE (6)`
- **Observed:** `0x6`
    - **Conclusion:** Our request for Read/Write was correctly mapped to kernel permission bits 4 and 2.

## 4. WHAT WE LEARNED
1.  **Implicit Behavior:** The kernel adds `O_LARGEFILE` without us asking.
2.  **Internal Struct:** The `struct open_flags` passed to `do_filp_open` is fully populated *before* this function is called (likely in `build_open_flags`).
3.  **Stack Allocation:** The `op` pointer `0xffffd19712c4fd84` is a stack address (ends in `...fd84`, typical for kernel stack). Unlike `filename` which was a heap/slab pointer (`0xffff89...`), this struct lives on the caller's stack.

## 5. NEXT STEP
We have the **Name** (Driver 1) and the **Intent** (Driver 2).
The function `do_filp_open` will return a `struct file *`.
We need to see the **Result** (the file object) and finally the **Return Value** (the FD).

**Next Driver:** `return_fd` (Tracing `fd_install` to see the binding of FD=3 to the File Object).
