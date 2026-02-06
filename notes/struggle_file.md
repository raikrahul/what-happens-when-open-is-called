# Struggle Log: The Path to Bit-Perfect Tracing (Kernel 6.14)

This file documents the technical friction points, crashes, and "struggles" encountered while deriving the filename journey from user space to the kernel dentry.

## 01. The Offset Mirage (+48 vs +32)
*   **Struggle**: Initial development assumed `struct dentry` layout from older kernel references where `d_name` was at offset `+48`.
*   **Crash/Failure**: Resulted in reading ASCII string data ("test_fil") as a pointer address, leading to a Kernel Oops (NULL pointer dereference or invalid address access).
*   **Resolution**: Audited `/usr/src/linux-headers-6.14.0-37-generic/include/linux/dcache.h`. Verified `d_name` is at `+32` and `name` ptr is at `+8` (Total `+40`). Corrected driver logic. [✓] FIXED.

## 02. The Version Paradox (6.8 vs 6.14)
*   **Struggle**: Local source code was pinned to `6.8.0`, but the active kernel was `6.14.0`.
*   **Struggle**: `struct file` had different refcount types (`atomic_long_t` vs `file_ref_t`).
*   **Resolution**: Implemented a "Runtime Identity Proof" logic. Acknowledged the newer kernel version and prioritized headers at `/usr/src/linux-headers-6.14.0-37-generic` for all offset derivations. [✓] SYNCHRONIZED.

## 03. The Iframe & Deployment Loop
*   **Struggle**: Configuring GitHub Pages to display deep-linked artifacts led to 404 errors.
*   **Struggle**: Adding `.nojekyll` was initially missed, then incorrectly applied, causing the site theme to break and links to cycle between the hub and articles.
*   **Resolution**: Verified folder structures via `ls -R`. Fixed pathing in `stage2_return.html` to point to `articles/` explicitly. Implemented a robust `git push` workflow to the `gh-pages` branch. [✓] DEPLOYED.

## 04. Kernel Memory Safety (The segfault gate)
*   **Struggle**: Dereferencing `fn->name` in `trace_filename.c` without a preceding `IS_ERR(fn)` check.
*   **Failure**: If `getname()` returns `-EFAULT` (e.g., bad user address), the driver tries to read memory at `0xfffffffffffffff2`, causing an immediate system freeze.
*   **Resolution**: Enforced "Safety First" rules in all drivers. Every pointer from a return register (`RAX`) is now passed through `IS_ERR()` and verified to be in the kernel range (`> 0xffff...`) before use. [✓] SECURED.

## 05. The Gentlemen's Chain Convergence
*   **Struggle**: Proving that the string created in `__d_alloc` at one address is the same one returned in `do_filp_open`.
*   **Resolution**: Designed a 4-point trace (`open_entry`, `alloc_entry`, `alloc_ret`, `open_ret`). Used unique filenames (`test_file_$(date +%s)`) to bypass the dentry cache, forcing the `__d_alloc` path to trigger every time. [✓] PROVEN.
