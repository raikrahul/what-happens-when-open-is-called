#!/bin/bash
#
# Comprehensive Driver Build and Test Script
# Captures kernel panics and saves vmcore dumps
#

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RESULTS_DIR="${SCRIPT_DIR}/TEST_RESULTS_$(date +%Y%m%d_%H%M%S)"
PROGRESS_FILE="${RESULTS_DIR}/progress_test_run.txt"
VMCORE_DIR="/var/crash"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1" | tee -a "$PROGRESS_FILE"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1" | tee -a "$PROGRESS_FILE"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$PROGRESS_FILE"
}

# Initialize
init() {
    log_info "Initializing test run..."
    mkdir -p "$RESULTS_DIR"
    log_info "Results directory: $RESULTS_DIR"
    log_info "Progress file: $PROGRESS_FILE"
    
    # Check kdump status
    log_info "Checking kdump configuration..."
    if systemctl is-active --quiet kdump-tools; then
        log_info "kdump-tools is ACTIVE - crash dumps will be captured"
    else
        log_warn "kdump-tools is NOT active - crash dumps may not be captured!"
        log_warn "Attempting to start kdump..."
        sudo systemctl start kdump-tools || true
    fi
    
    # Clear old dmesg
    sudo dmesg -C
    log_info "Cleared kernel message buffer"
}

# Compile drivers for a specific case
compile_case_drivers() {
    local case_dir="$1"
    local case_name=$(basename "$case_dir")
    
    log_info "Compiling drivers for $case_name..."
    
    cd "$case_dir"
    
    # Clean previous builds
    make clean 2>/dev/null || true
    
    # Build drivers
    if make 2>&1 | tee "${RESULTS_DIR}/${case_name}_build.log"; then
        log_info "✓ $case_name drivers compiled successfully"
        
        # List compiled .ko files
        find . -name "*.ko" -type f >> "${RESULTS_DIR}/${case_name}_drivers.txt"
        return 0
    else
        log_error "✗ $case_name driver compilation FAILED"
        return 1
    fi
}

# Compile userspace programs
compile_userspace() {
    local case_dir="$1"
    local case_name=$(basename "$case_dir")
    
    log_info "Compiling userspace programs for $case_name..."
    
    cd "$case_dir"
    
    # Find and compile user_*.c files
    for user_c in user_*.c; do
        if [ -f "$user_c" ]; then
            local prog_name="${user_c%.c}"
            if gcc -o "$prog_name" "$user_c" -Wall 2>&1 | tee -a "${RESULTS_DIR}/${case_name}_build.log"; then
                log_info "  ✓ Compiled $prog_name"
            else
                log_warn "  ✗ Failed to compile $user_c"
            fi
        fi
    done
}

# Run a test with a driver
run_test() {
    local case_dir="$1"
    local case_name=$(basename "$case_dir")
    local driver="$2"
    local test_prog="$3"
    local test_id="${case_name}_$(basename "$driver" .ko)_$(basename "$test_prog")"
    
    log_info "Running test: $test_id"
    
    local test_log="${RESULTS_DIR}/${test_id}_$(date +%s).log"
    
    # Record test start
    echo "=== TEST START: $test_id ===" >> "$test_log"
    echo "Timestamp: $(date)" >> "$test_log"
    echo "Driver: $driver" >> "$test_log"
    echo "Test Program: $test_prog" >> "$test_log"
    echo "" >> "$test_log"
    
    # Clear dmesg before test
    sudo dmesg -C
    
    # Load driver
    log_info "  Loading driver: $(basename "$driver")"
    if sudo insmod "$driver" 2>&1 >> "$test_log"; then
        log_info "  ✓ Driver loaded"
    else
        log_error "  ✗ Failed to load driver"
        echo "DRIVER LOAD FAILED" >> "$test_log"
        return 1
    fi
    
    # Run test program
    log_info "  Running: $(basename "$test_prog")"
    cd "$case_dir"
    if timeout 10 "./$(basename "$test_prog")" 2>&1 >> "$test_log"; then
        log_info "  ✓ Test program completed"
    else
        log_warn "  ! Test program exited with error or timeout"
    fi
    
    # Collect dmesg
    echo "" >> "$test_log"
    echo "=== KERNEL MESSAGES ===" >> "$test_log"
    sudo dmesg >> "$test_log"
    
    # Unload driver
    log_info "  Unloading driver"
    sudo rmmod "$(basename "$driver" .ko)" 2>&1 >> "$test_log" || true
    
    echo "" >> "$test_log"
    echo "=== TEST END: $test_id ===" >> "$test_log"
    echo "Timestamp: $(date)" >> "$test_log"
    
    # Check for vmcore (in case of crash)
    check_vmcore "$test_id"
    
    return 0
}

# Check for crash dumps
check_vmcore() {
    local test_id="$1"
    
    # Check if any new vmcore files exist
    local latest_vmcore=$(find "$VMCORE_DIR" -name "vmcore*" -type f -mmin -1 2>/dev/null | head -1)
    
    if [ -n "$latest_vmcore" ]; then
        log_warn "  ⚠ KERNEL CRASH DETECTED!"
        log_warn "  ⚠ vmcore saved at: $latest_vmcore"
        
        # Copy vmcore info
        echo "" >> "$PROGRESS_FILE"
        echo "!!! KERNEL CRASH DETECTED !!!" >> "$PROGRESS_FILE"
        echo "Test: $test_id" >> "$PROGRESS_FILE"
        echo "vmcore: $latest_vmcore" >> "$PROGRESS_FILE"
        echo "Timestamp: $(date)" >> "$PROGRESS_FILE"
        echo "!!! END CRASH REPORT !!!" >> "$PROGRESS_FILE"
        echo "" >> "$PROGRESS_FILE"
        
        # Save vmcore metadata
        ls -lh "$latest_vmcore" > "${RESULTS_DIR}/${test_id}_vmcore_info.txt"
        
        return 1
    fi
    
    return 0
}

# Main execution
main() {
    log_info "========================================="
    log_info "STAGE 3 DRIVER COMPREHENSIVE TEST SUITE"
    log_info "========================================="
    log_info ""
    
    init
    
    # Define test cases
    declare -A CASES
    CASES["case8"]="/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case8_creation_proof"
    CASES["case10"]="/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case10_rename_investigation"
    CASES["case11"]="/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case11_bulk_rename"
    CASES["case12"]="/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case12_harder_puzzle"
    CASES["case13"]="/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case13_salt_avalanche"
    CASES["case14"]="/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case14_symmetry_break"
    CASES["case15"]="/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case15_deep_trace"
    CASES["case15_solution"]="/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case15_deep_trace_solution"
    
    # Phase 1: Compile all drivers
    log_info ""
    log_info "========================================="
    log_info "PHASE 1: COMPILING ALL DRIVERS"
    log_info "========================================="
    
    for case_name in "${!CASES[@]}"; do
        compile_case_drivers "${CASES[$case_name]}"
    done
    
    # Phase 2: Compile userspace programs
    log_info ""
    log_info "========================================="
    log_info "PHASE 2: COMPILING USERSPACE PROGRAMS"
    log_info "========================================="
    
    for case_name in "${!CASES[@]}"; do
        compile_userspace "${CASES[$case_name]}"
    done
    
    # Phase 3: Run tests
    log_info ""
    log_info "========================================="
    log_info "PHASE 3: RUNNING TESTS"
    log_info "========================================="
    log_info "WARNING: Tests may cause kernel panics!"
    log_info "vmcore dumps will be saved to: $VMCORE_DIR"
    log_info ""
    
    # Test Case 8
    log_info "--- Testing Case 8: Creation Proof ---"
    run_test "${CASES[case8]}" "${CASES[case8]}/driver_salt_probe.ko" "${CASES[case8]}/user_create_simple" || true
    run_test "${CASES[case8]}" "${CASES[case8]}/driver_lookup_probe.ko" "${CASES[case8]}/user_open_existing" || true
    run_test "${CASES[case8]}" "${CASES[case8]}/driver_creation_probe.ko" "${CASES[case8]}/user_create_simple" || true
    run_test "${CASES[case8]}" "${CASES[case8]}/driver_collision_probe.ko" "${CASES[case8]}/user_hash_collision" || true
    run_test "${CASES[case8]}" "${CASES[case8]}/driver_rename_probe.ko" "${CASES[case8]}/user_rename" || true
    
    # Test Case 10
    log_info "--- Testing Case 10: Rename Investigation ---"
    run_test "${CASES[case10]}" "${CASES[case10]}/driver_dir_rename_probe.ko" "${CASES[case10]}/user_dir_rename" || true
    
    # Test Case 11
    log_info "--- Testing Case 11: Bulk Rename ---"
    run_test "${CASES[case11]}" "${CASES[case11]}/driver_bulk_rename_probe.ko" "${CASES[case11]}/user_bulk_rename" || true
    
    # Test Case 12
    log_info "--- Testing Case 12: Harder Puzzle ---"
    run_test "${CASES[case12]}" "${CASES[case12]}/driver_puzzle_probe.ko" "${CASES[case12]}" || true
    
    # Test Case 13
    log_info "--- Testing Case 13: Salt Avalanche ---"
    run_test "${CASES[case13]}" "${CASES[case13]}/driver_salt_avalanche.ko" "${CASES[case13]}/user_salt_avalanche" || true
    
    # Test Case 14
    log_info "--- Testing Case 14: Symmetry Break ---"
    run_test "${CASES[case14]}" "${CASES[case14]}/driver_symmetry_break.ko" "${CASES[case14]}/user_symmetry_break" || true
    
    # Test Case 15
    log_info "--- Testing Case 15: Deep Trace ---"
    run_test "${CASES[case15]}" "${CASES[case15]}/driver_deep_trace.ko" "${CASES[case15]}/user_deep_create" || true
    
    # Test Case 15 Solution
    log_info "--- Testing Case 15 Solution: Smart Trace ---"
    run_test "${CASES[case15_solution]}" "${CASES[case15_solution]}/driver_smart_trace.ko" "${CASES[case15]}/user_deep_open" || true
    
    # Summary
    log_info ""
    log_info "========================================="
    log_info "TEST RUN COMPLETE"
    log_info "========================================="
    log_info "Results saved to: $RESULTS_DIR"
    log_info "Progress log: $PROGRESS_FILE"
    
    # Check for any crash dumps
    local crash_count=$(find "$VMCORE_DIR" -name "vmcore*" -type f -mmin -60 2>/dev/null | wc -l)
    if [ "$crash_count" -gt 0 ]; then
        log_warn ""
        log_warn "⚠ ATTENTION: $crash_count kernel crash dump(s) detected!"
        log_warn "Check $VMCORE_DIR for vmcore files"
        log_warn "Also check ${RESULTS_DIR} for test logs"
    else
        log_info ""
        log_info "✓ No kernel crashes detected in this test run"
    fi
    
    log_info ""
    log_info "To analyze a crash dump:"
    log_info "  crash /var/crash/vmcore-<timestamp> /usr/lib/debug/boot/vmlinux-$(uname -r)"
}

# Run main function
main "$@"
