#!/bin/bash
# Comprehensive Stage 3 Test Runner
# Runs all userspace programs and collects results

BASE_DIR="/home/r/Desktop/what-happens-when-open-is-called"
RESULTS_DIR="$BASE_DIR/kernel/user/stage3/STAGE3_RESULTS_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$RESULTS_DIR"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     STAGE 3: COMPREHENSIVE VFS TRACE EXECUTION             ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo "Results will be saved to: $RESULTS_DIR"
echo ""

# Function to run a test and capture output
run_test() {
    local case_name="$1"
    local program="$2"
    local description="$3"
    local output_file="$RESULTS_DIR/${case_name}_${program}.txt"
    
    echo "════════════════════════════════════════════════════════════" | tee -a "$RESULTS_DIR/summary.txt"
    echo "CASE: $case_name | PROGRAM: $program" | tee -a "$RESULTS_DIR/summary.txt"
    echo "DESCRIPTION: $description" | tee -a "$RESULTS_DIR/summary.txt"
    echo "TIMESTAMP: $(date)" | tee -a "$RESULTS_DIR/summary.txt"
    echo "" | tee -a "$RESULTS_DIR/summary.txt"
    
    # Check if program exists
    if [ ! -f "$program" ]; then
        echo "  ⚠️  Program not found, attempting to compile..." | tee -a "$RESULTS_DIR/summary.txt"
        local src_file="${program}.c"
        if [ -f "$src_file" ]; then
            gcc -o "$program" "$src_file" 2>&1 | tee -a "$RESULTS_DIR/summary.txt"
        fi
    fi
    
    # Run the program
    if [ -f "$program" ]; then
        echo "  ▶️  Running: ./$program" | tee -a "$RESULTS_DIR/summary.txt"
        echo "--- OUTPUT ---" > "$output_file"
        timeout 10 ./"$program" 2>&1 | tee -a "$output_file" "$RESULTS_DIR/summary.txt"
        local exit_code=${PIPESTATUS[0]}
        echo "--- END OUTPUT (exit code: $exit_code) ---" >> "$output_file"
        echo "  Exit code: $exit_code" | tee -a "$RESULTS_DIR/summary.txt"
    else
        echo "  ❌ Program not available" | tee -a "$RESULTS_DIR/summary.txt"
    fi
    echo "" | tee -a "$RESULTS_DIR/summary.txt"
}

cd "$BASE_DIR/kernel/user/stage3"

echo "STARTING EXECUTION OF ALL STAGE 3 PROGRAMS..."
echo ""

# ============================================
# CASE 8: CREATION PROOF (Most recent and comprehensive)
# ============================================
echo "📁 CASE 8: CREATION PROOF"
cd "$BASE_DIR/kernel/user/stage3/case8_creation_proof"

run_test "case8" "user_create_simple" "Simple file creation with O_CREAT | O_EXCL"
run_test "case8" "user_create_deep" "Deep path creation test"
run_test "case8" "user_create_long" "Long filename creation test"
run_test "case8" "user_open_existing" "Opening an existing file"
run_test "case8" "user_hash_collision" "Hash collision detection test"
run_test "case8" "user_rename" "File rename operation test"
run_test "case8" "derive_hash" "Derive and display hash computation"

# ============================================
# CASE 10: RENAME INVESTIGATION
# ============================================
echo "📁 CASE 10: RENAME INVESTIGATION"
cd "$BASE_DIR/kernel/user/stage3/case10_rename_investigation"

run_test "case10" "user_dir_rename" "Directory rename operations"

# ============================================
# CASE 11: BULK RENAME
# ============================================
echo "📁 CASE 11: BULK RENAME"
cd "$BASE_DIR/kernel/user/stage3/case11_bulk_rename"

run_test "case11" "user_bulk_rename" "Bulk rename stress test"

# ============================================
# CASE 12: HARDER PUZZLE
# ============================================
echo "📁 CASE 12: HARDER PUZZLE"
cd "$BASE_DIR/kernel/user/stage3/case12_harder_puzzle"

run_test "case12" "user_puzzle" "Harder puzzle challenge"
run_test "case12" "puzzle_verify" "Puzzle verification"

# ============================================
# CASE 13: SALT AVALANCHE
# ============================================
echo "📁 CASE 13: SALT AVALANCHE"
cd "$BASE_DIR/kernel/user/stage3/case13_salt_avalanche"

run_test "case13" "user_salt_avalanche" "Salt avalanche hash demonstration"

# ============================================
# CASE 14: SYMMETRY BREAK
# ============================================
echo "📁 CASE 14: SYMMETRY BREAK"
cd "$BASE_DIR/kernel/user/stage3/case14_symmetry_break"

run_test "case14" "user_symmetry_break" "Symmetry breaking test"

# ============================================
# CASE 15: DEEP TRACE
# ============================================
echo "📁 CASE 15: DEEP TRACE"
cd "$BASE_DIR/kernel/user/stage3/case15_deep_trace"

run_test "case15" "user_deep_open" "Deep trace: open existing file"
run_test "case15" "user_deep_create" "Deep trace: create new file"

# ============================================
# CASE 2-7: EARLIER CASES
# ============================================
echo "📁 CASES 2-7: EARLIER TESTS"

cd "$BASE_DIR/kernel/user/stage3/case2_deep_miss"
run_test "case2" "case2_deep_miss" "Deep miss - cache miss scenario"

cd "$BASE_DIR/kernel/user/stage3/case3_deep_hit"
run_test "case3" "case3_deep_hit" "Deep hit - cache hit scenario"

cd "$BASE_DIR/kernel/user/stage3/case4_create_flow"
run_test "case4" "case4_create_flow" "File creation flow"

cd "$BASE_DIR/kernel/user/stage3/case5_mount_jump"
run_test "case5" "case5_mount_jump" "Mount point traversal"

cd "$BASE_DIR/kernel/user/stage3/case6_symlink_loop"
run_test "case6" "case6_symlink_loop" "Symlink loop detection"

cd "$BASE_DIR/kernel/user/stage3/case7_symlink_fast"
run_test "case7" "case7_symlink_fast" "Fast symlink handling"

# ============================================
# CASE 1: VARIOUS DEMOS
# ============================================
echo "📁 CASE 1: FOUNDATIONAL DEMOS"
cd "$BASE_DIR/kernel/user/stage3/case1"

run_test "case1" "case1_relative" "Relative path opening"
run_test "case1" "demo_at_fdcwd" "AT_FDCWD demonstration"
run_test "case1" "demo_dup_names" "Duplicate name handling"
run_test "case1" "demo_o_path" "O_PATH flag test"
run_test "case1" "demo_o_path_dir" "O_PATH with directories"
run_test "case1" "demo_o_tmpfile" "O_TMPFILE demonstration"
run_test "case1" "demo_thread_safety" "Thread safety test"
run_test "case1" "demo_toctou" "TOCTOU race condition"
run_test "case1" "vfs_trigger" "VFS trigger test"

# Generate final summary
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                   EXECUTION COMPLETE                       ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Results saved to: $RESULTS_DIR"
echo ""
echo "Summary of all tests:"
cat "$RESULTS_DIR/summary.txt"

# Create index file
cat > "$RESULTS_DIR/INDEX.md" << 'INDEXEOF'
# Stage 3 Test Results Index

## Execution Date
Generated: $(date)

## Test Cases Executed

### Case 1: Foundational Demos
Basic VFS operations and edge cases

### Case 2-7: Core Scenarios
- Cache hits/misses
- File creation
- Mount traversal
- Symlink handling

### Case 8: Creation Proof (Axiomatic)
Comprehensive hash derivation and proof

### Case 9-15: Advanced Topics
- Rename operations
- Bulk operations
- Salt avalanche
- Symmetry breaking
- Deep tracing

## How to Read Results
Each test case has:
- `{case}_{program}.txt` - Full output
- `summary.txt` - Condensed summary
- Exit codes documented

## Next Steps
Review results in summary.txt for anomalies or crashes.
INDEXEOF

echo ""
echo "✅ All tests completed. Check $RESULTS_DIR for detailed results."
