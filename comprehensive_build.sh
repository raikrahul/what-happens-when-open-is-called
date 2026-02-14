#!/bin/bash

# Comprehensive Build Log with Timestamps
# Created: $(date '+%Y-%m-%d %H:%M:%S')

LOG_FILE="/home/r/Desktop/what-happens-when-open-is-called/COMPREHENSIVE_BUILD_LOG_$(date +%Y%m%d_%H%M%S).txt"

log_with_timestamp() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S.%3N')] $1" | tee -a "$LOG_FILE"
}

log_separator() {
    echo "" | tee -a "$LOG_FILE"
    echo "========================================" | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"
    sync
}

# Initialize log
log_with_timestamp "=== COMPREHENSIVE BUILD SESSION START ==="
log_with_timestamp "Working Directory: $(pwd)"
log_with_timestamp "Kernel: $(uname -r)"
log_separator

# Track statistics
DRIVERS_TOTAL=0
DRIVERS_SUCCESS=0
DRIVERS_FAILED=0
USERSPACE_TOTAL=0
USERSPACE_SUCCESS=0
USERSPACE_FAILED=0

################################################################################
# STAGE 3 - CASE 8: Creation Proof
################################################################################
log_with_timestamp "STAGE 3 - CASE 8: Creation Proof"
log_with_timestamp "Location: kernel/user/stage3/case8_creation_proof/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case8_creation_proof/

# Compile userspace programs
for src in user_create_simple.c user_create_deep.c user_create_long.c user_open_existing.c user_hash_collision.c user_rename.c derive_hash.c; do
    if [ -f "$src" ]; then
        USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
        log_with_timestamp "Compiling: $src"
        if gcc -Wall -o "${src%.c}.out" "$src" 2>&1 | tee -a "$LOG_FILE"; then
            log_with_timestamp "✓ SUCCESS: ${src%.c}.out"
            USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
        else
            log_with_timestamp "✗ FAILED: $src"
            USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
        fi
        sync
    fi
done

# Compile drivers
for src in driver_creation_probe.c driver_lookup_probe.c driver_salt_probe.c driver_collision_probe.c driver_rename_probe.c; do
    if [ -f "$src" ]; then
        DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
        log_with_timestamp "Compiling driver: $src"
        if make "${src%.c}.ko" 2>&1 | tee -a "$LOG_FILE"; then
            log_with_timestamp "✓ SUCCESS: ${src%.c}.ko"
            DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
        else
            log_with_timestamp "✗ FAILED: $src"
            DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
        fi
        sync
    fi
done

log_separator

################################################################################
# STAGE 3 - CASE 10: Rename Investigation
################################################################################
log_with_timestamp "STAGE 3 - CASE 10: Rename Investigation"
log_with_timestamp "Location: kernel/user/stage3/case10_rename_investigation/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case10_rename_investigation/

if [ -f "user_dir_rename.c" ]; then
    USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
    log_with_timestamp "Compiling: user_dir_rename.c"
    if gcc -Wall -o user_dir_rename.out user_dir_rename.c 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: user_dir_rename.out"
        USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: user_dir_rename.c"
        USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
    fi
    sync
fi

if [ -f "driver_dir_rename_probe.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: driver_dir_rename_probe.c"
    if make driver_dir_rename_probe.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: driver_dir_rename_probe.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: driver_dir_rename_probe.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# STAGE 3 - CASE 11: Bulk Rename
################################################################################
log_with_timestamp "STAGE 3 - CASE 11: Bulk Rename"
log_with_timestamp "Location: kernel/user/stage3/case11_bulk_rename/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case11_bulk_rename/

if [ -f "user_bulk_rename.c" ]; then
    USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
    log_with_timestamp "Compiling: user_bulk_rename.c"
    if gcc -Wall -o user_bulk_rename.out user_bulk_rename.c 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: user_bulk_rename.out"
        USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: user_bulk_rename.c"
        USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
    fi
    sync
fi

if [ -f "driver_bulk_rename_probe.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: driver_bulk_rename_probe.c"
    if make driver_bulk_rename_probe.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: driver_bulk_rename_probe.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: driver_bulk_rename_probe.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# STAGE 3 - CASE 12: Harder Puzzle
################################################################################
log_with_timestamp "STAGE 3 - CASE 12: Harder Puzzle"
log_with_timestamp "Location: kernel/user/stage3/case12_harder_puzzle/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case12_harder_puzzle/

for src in user_puzzle.c puzzle_verify.c; do
    if [ -f "$src" ]; then
        USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
        log_with_timestamp "Compiling: $src"
        if gcc -Wall -o "${src%.c}.out" "$src" 2>&1 | tee -a "$LOG_FILE"; then
            log_with_timestamp "✓ SUCCESS: ${src%.c}.out"
            USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
        else
            log_with_timestamp "✗ FAILED: $src"
            USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
        fi
        sync
    fi
done

if [ -f "driver_puzzle_probe.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: driver_puzzle_probe.c"
    if make driver_puzzle_probe.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: driver_puzzle_probe.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: driver_puzzle_probe.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# STAGE 3 - CASE 13: Salt Avalanche
################################################################################
log_with_timestamp "STAGE 3 - CASE 13: Salt Avalanche"
log_with_timestamp "Location: kernel/user/stage3/case13_salt_avalanche/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case13_salt_avalanche/

if [ -f "user_salt_avalanche.c" ]; then
    USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
    log_with_timestamp "Compiling: user_salt_avalanche.c"
    if gcc -Wall -o user_salt_avalanche.out user_salt_avalanche.c 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: user_salt_avalanche.out"
        USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: user_salt_avalanche.c"
        USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
    fi
    sync
fi

if [ -f "driver_salt_avalanche.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: driver_salt_avalanche.c"
    if make driver_salt_avalanche.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: driver_salt_avalanche.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: driver_salt_avalanche.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# STAGE 3 - CASE 14: Symmetry Break
################################################################################
log_with_timestamp "STAGE 3 - CASE 14: Symmetry Break"
log_with_timestamp "Location: kernel/user/stage3/case14_symmetry_break/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case14_symmetry_break/

if [ -f "user_symmetry_break.c" ]; then
    USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
    log_with_timestamp "Compiling: user_symmetry_break.c"
    if gcc -Wall -o user_symmetry_break.out user_symmetry_break.c 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: user_symmetry_break.out"
        USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: user_symmetry_break.c"
        USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
    fi
    sync
fi

if [ -f "driver_symmetry_break.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: driver_symmetry_break.c"
    if make driver_symmetry_break.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: driver_symmetry_break.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: driver_symmetry_break.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# STAGE 3 - CASE 15: Deep Trace
################################################################################
log_with_timestamp "STAGE 3 - CASE 15: Deep Trace"
log_with_timestamp "Location: kernel/user/stage3/case15_deep_trace/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case15_deep_trace/

for src in user_deep_create.c user_deep_open.c; do
    if [ -f "$src" ]; then
        USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
        log_with_timestamp "Compiling: $src"
        if gcc -Wall -o "${src%.c}.out" "$src" 2>&1 | tee -a "$LOG_FILE"; then
            log_with_timestamp "✓ SUCCESS: ${src%.c}.out"
            USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
        else
            log_with_timestamp "✗ FAILED: $src"
            USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
        fi
        sync
    fi
done

if [ -f "driver_deep_trace.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: driver_deep_trace.c"
    if make driver_deep_trace.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: driver_deep_trace.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: driver_deep_trace.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# STAGE 3 - CASE 15 Solution: Deep Trace Solution
################################################################################
log_with_timestamp "STAGE 3 - CASE 15 Solution: Smart Trace"
log_with_timestamp "Location: kernel/user/stage3/case15_deep_trace_solution/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case15_deep_trace_solution/

if [ -f "driver_smart_trace.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: driver_smart_trace.c"
    if make driver_smart_trace.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: driver_smart_trace.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: driver_smart_trace.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# STAGE 3 - CASE 1: Basic Demos
################################################################################
log_with_timestamp "STAGE 3 - CASE 1: Basic Demos"
log_with_timestamp "Location: kernel/user/stage3/case1/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case1/

# Compile basic demos
for src in case1_relative.c case2_deep_miss.c case3_deep_hit.c case4_create_flow.c case5_mount_jump.c case6_symlink_loop.c case7_symlink_fast.c demo_dup_names.c; do
    if [ -f "$src" ]; then
        USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
        log_with_timestamp "Compiling: $src"
        if gcc -Wall -o "${src%.c}.out" "$src" 2>&1 | tee -a "$LOG_FILE"; then
            log_with_timestamp "✓ SUCCESS: ${src%.c}.out"
            USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
        else
            log_with_timestamp "✗ FAILED: $src"
            USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
        fi
        sync
    fi
done

log_separator

################################################################################
# STAGE 3 - CASE 1: Subdirectories
################################################################################
log_with_timestamp "STAGE 3 - CASE 1: Subdirectory Demos"

# demo_at_fdcwd
if [ -f "demo_at_fdcwd/demo_at_fdcwd.c" ]; then
    USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
    log_with_timestamp "Compiling: demo_at_fdcwd/demo_at_fdcwd.c"
    if gcc -Wall -o demo_at_fdcwd/demo_at_fdcwd.out demo_at_fdcwd/demo_at_fdcwd.c 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: demo_at_fdcwd.out"
        USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: demo_at_fdcwd.c"
        USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
    fi
    sync
fi

# demo_o_path
if [ -f "demo_o_path/demo_o_path.c" ]; then
    USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
    log_with_timestamp "Compiling: demo_o_path/demo_o_path.c"
    if gcc -Wall -o demo_o_path/demo_o_path.out demo_o_path/demo_o_path.c 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: demo_o_path.out"
        USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: demo_o_path.c"
        USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
    fi
    sync
fi

# demo_o_tmpfile
if [ -f "demo_o_tmpfile/demo_o_tmpfile.c" ]; then
    USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
    log_with_timestamp "Compiling: demo_o_tmpfile/demo_o_tmpfile.c"
    if gcc -Wall -o demo_o_tmpfile/demo_o_tmpfile.out demo_o_tmpfile/demo_o_tmpfile.c 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: demo_o_tmpfile.out"
        USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: demo_o_tmpfile.c"
        USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# DRIVERS: Stage 3 Case 1
################################################################################
log_with_timestamp "DRIVERS: Stage 3 Case 1"
log_with_timestamp "Location: kernel/drivers/stage3/case1/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/drivers/stage3/case1/

# Main case1 driver
if [ -f "vfs_depth_probe.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: vfs_depth_probe.c"
    if make vfs_depth_probe.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: vfs_depth_probe.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: vfs_depth_probe.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

# trace_path_init drivers
cd trace_path_init/
for src in trace_path_init.c trace_d_lookup.c trace_lpw.c trace_lpw_v2.c trace_lpw_safe.c trace_lpw_v4.c trace_offset_proof.c; do
    if [ -f "$src" ]; then
        DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
        log_with_timestamp "Compiling driver: trace_path_init/$src"
        if make "${src%.c}.ko" 2>&1 | tee -a "$LOG_FILE"; then
            log_with_timestamp "✓ SUCCESS: ${src%.c}.ko"
            DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
        else
            log_with_timestamp "✗ FAILED: $src"
            DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
        fi
        sync
    fi
done

cd ..

# trace_do_sys_openat2
cd trace_do_sys_openat2/
if [ -f "trace_do_sys_openat2.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: trace_do_sys_openat2/trace_do_sys_openat2.c"
    if make trace_do_sys_openat2.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: trace_do_sys_openat2.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: trace_do_sys_openat2.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# OTHER DRIVERS
################################################################################
log_with_timestamp "OTHER DRIVERS"

# offset_audit
cd /home/r/Desktop/what-happens-when-open-is-called/kernel/drivers/offset_audit/
if [ -f "offset_audit.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: offset_audit/offset_audit.c"
    if make offset_audit.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: offset_audit.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: offset_audit.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

# trace_do_filp_open
cd /home/r/Desktop/what-happens-when-open-is-called/kernel/drivers/trace_do_filp_open/
if [ -f "trace_do_filp_open.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: trace_do_filp_open/trace_do_filp_open.c"
    if make trace_do_filp_open.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: trace_do_filp_open.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: trace_do_filp_open.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

# arg2_filename
cd /home/r/Desktop/what-happens-when-open-is-called/kernel/drivers/arg2_filename/
if [ -f "trace_filename.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: arg2_filename/trace_filename.c"
    if make trace_filename.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: trace_filename.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: trace_filename.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

# arg3_flags
cd /home/r/Desktop/what-happens-when-open-is-called/kernel/drivers/arg3_flags/
if [ -f "trace_flags.c" ]; then
    DRIVERS_TOTAL=$((DRIVERS_TOTAL + 1))
    log_with_timestamp "Compiling driver: arg3_flags/trace_flags.c"
    if make trace_flags.ko 2>&1 | tee -a "$LOG_FILE"; then
        log_with_timestamp "✓ SUCCESS: trace_flags.ko"
        DRIVERS_SUCCESS=$((DRIVERS_SUCCESS + 1))
    else
        log_with_timestamp "✗ FAILED: trace_flags.c"
        DRIVERS_FAILED=$((DRIVERS_FAILED + 1))
    fi
    sync
fi

log_separator

################################################################################
# PROOFS AND DEMOS
################################################################################
log_with_timestamp "PROOFS AND DEMOS"
log_with_timestamp "Location: kernel/proofs/ and kernel/demos/"

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/proofs/
for src in 00_register_dump.c 01_path_walk_simulator.c 02_empty_path_demo.c 02_fd_exhaustion.c 03_trinity_stat_demo.c 03_kernel_permission_simulation.c 04_benchmark_stat.c 05_random_stat.c 06_null_pointer_puzzle.c; do
    if [ -f "$src" ]; then
        USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
        log_with_timestamp "Compiling: proofs/$src"
        if gcc -Wall -o "${src%.c}.out" "$src" 2>&1 | tee -a "$LOG_FILE"; then
            log_with_timestamp "✓ SUCCESS: ${src%.c}.out"
            USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
        else
            log_with_timestamp "✗ FAILED: $src"
            USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
        fi
        sync
    fi
done

cd /home/r/Desktop/what-happens-when-open-is-called/kernel/demos/
for src in enoent_demo.c eacces_demo.c emfile_demo.c; do
    if [ -f "$src" ]; then
        USERSPACE_TOTAL=$((USERSPACE_TOTAL + 1))
        log_with_timestamp "Compiling: demos/$src"
        if gcc -Wall -o "${src%.c}.out" "$src" 2>&1 | tee -a "$LOG_FILE"; then
            log_with_timestamp "✓ SUCCESS: ${src%.c}.out"
            USERSPACE_SUCCESS=$((USERSPACE_SUCCESS + 1))
        else
            log_with_timestamp "✗ FAILED: $src"
            USERSPACE_FAILED=$((USERSPACE_FAILED + 1))
        fi
        sync
    fi
done

log_separator

################################################################################
# FINAL SUMMARY
################################################################################
log_with_timestamp "=== COMPREHENSIVE BUILD SESSION COMPLETE ==="
log_with_timestamp ""
log_with_timestamp "STATISTICS:"
log_with_timestamp "  Drivers:    $DRIVERS_SUCCESS / $DRIVERS_TOTAL succeeded ($DRIVERS_FAILED failed)"
log_with_timestamp "  Userspace:  $USERSPACE_SUCCESS / $USERSPACE_TOTAL succeeded ($USERSPACE_FAILED failed)"
log_with_timestamp "  Total:      $((DRIVERS_SUCCESS + USERSPACE_SUCCESS)) / $((DRIVERS_TOTAL + USERSPACE_TOTAL)) succeeded"
log_with_timestamp ""
log_with_timestamp "Log file: $LOG_FILE"
log_with_timestamp "End time: $(date '+%Y-%m-%d %H:%M:%S')"

# Final sync
sync
log_with_timestamp "Filesystem sync complete"

echo ""
echo "Build complete! Log saved to: $LOG_FILE"
echo "Drivers: $DRIVERS_SUCCESS/$DRIVERS_TOTAL | Userspace: $USERSPACE_SUCCESS/$USERSPACE_TOTAL"