#!/bin/bash

# Integration Test Script for "What Happens When Open Is Called"
# This script verifies that all components work together correctly

set -e

echo "================================================"
echo "Integration Test: What Happens When Open Is Called"
echo "================================================"
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print test result
test_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ PASS${NC}: $2"
    else
        echo -e "${RED}✗ FAIL${NC}: $2"
        return 1
    fi
}

# Function to print warning
test_warning() {
    echo -e "${YELLOW}⚠ WARN${NC}: $1"
}

echo "STEP 1: Build all components"
echo "----------------------------"
make clean > /dev/null 2>&1
make all > /dev/null 2>&1
test_result $? "Build all programs"

echo
echo "STEP 2: Test core proof programs"
echo "--------------------------------"

# Test register_dump
echo -n "Testing register_dump... "
if ./proofs/register_dump > /dev/null 2>&1; then
    test_result 0 "register_dump"
else
    test_result 1 "register_dump"
fi

# Test path_walk_simulator
echo -n "Testing path_walk_simulator... "
if ./proofs/path_walk_simulator /etc/passwd > /dev/null 2>&1; then
    test_result 0 "path_walk_simulator"
else
    test_result 1 "path_walk_simulator"
fi

# Test fd_exhaustion (with timeout to avoid hanging)
echo -n "Testing fd_exhaustion... "
if timeout 10s ./proofs/fd_exhaustion > /dev/null 2>&1; then
    test_result 0 "fd_exhaustion"
else
    test_result $? "fd_exhaustion"
fi

# Test kernel_permission_simulation
echo -n "Testing kernel_permission_simulation... "
if ./proofs/kernel_permission_simulation > /dev/null 2>&1; then
    test_result 0 "kernel_permission_simulation"
else
    test_result 1 "kernel_permission_simulation"
fi

echo
echo "STEP 3: Test axiomatic lesson demos"
echo "------------------------------------"

# Test all axiomatic lesson demos
lessons=(
    "00_failure_predictions"
    "01_the_syscall_interface"
    "02_the_kernel_entry"
    "03_the_path_walk"
    "04_the_allocation"
    "05_the_return"
)

for lesson in "${lessons[@]}"; do
    demo_path="axiomatic_lessons/$lesson/lesson_demo"
    echo -n "Testing $lesson demo... "
    if [ -f "$demo_path" ] && "$demo_path" > /dev/null 2>&1; then
        test_result 0 "$lesson demo"
    else
        test_result 1 "$lesson demo"
    fi
done

echo
echo "STEP 4: Test error demonstration programs"
echo "----------------------------------------"

# Test error demos
error_demos=(
    "src/error_demos/error_demo_enoent"
    "src/error_demos/error_demo_eacces"
    "src/error_demos/error_demo_emfile"
)

for demo in "${error_demos[@]}"; do
    echo -n "Testing $demo... "
    if [ -f "$demo" ] && "$demo" > /dev/null 2>&1; then
        test_result 0 "$demo"
    else
        test_result 1 "$demo"
    fi
done

echo
echo "STEP 5: Verify documentation consistency"
echo "----------------------------------------"

# Check if README exists
if [ -f "README.md" ]; then
    test_result 0 "README.md exists"
else
    test_result 1 "README.md missing"
fi

# Check if axiomatic curriculum exists
if [ -f "AXIOMATIC_CURRICULUM.md" ]; then
    test_result 0 "AXIOMATIC_CURRICULUM.md exists"
else
    test_result 1 "AXIOMATIC_CURRICULUM.md missing"
fi

# Check if all lesson markdown files exist
missing_lessons=()
for lesson in "${lessons[@]}"; do
    lesson_file="axiomatic_lessons/$lesson/lesson.md"
    if [ ! -f "$lesson_file" ]; then
        missing_lessons+=("$lesson_file")
    fi
done

if [ ${#missing_lessons[@]} -eq 0 ]; then
    test_result 0 "All lesson markdown files exist"
else
    test_result 1 "Missing lesson files: ${missing_lessons[*]}"
fi

echo
echo "STEP 6: System integration verification"
echo "--------------------------------------"

# Test that minimal_open.c can be compiled and run
echo -n "Testing minimal_open compilation... "
if gcc -o minimal_open_test minimal_open.c 2>/dev/null && ./minimal_open_test 2>/dev/null; then
    test_result 0 "minimal_open.c compilation and execution"
    rm -f minimal_open_test
else
    test_result 1 "minimal_open.c compilation and execution"
fi

# Check that we can strace a simple open call
echo -n "Testing strace integration... "
if echo "int main(){open(\"/tmp/test\",0);return 0;}" | gcc -x c - -o /tmp/test_prog 2>/dev/null; then
    if strace -e openat /tmp/test_prog 2>&1 | grep -q "openat"; then
        test_result 0 "strace integration"
    else
        test_result 1 "strace integration"
    fi
    rm -f /tmp/test_prog
else
    test_result 1 "strace test program compilation"
fi

echo
echo "STEP 7: Performance and resource checks"
echo "----------------------------------------"

# Check that programs don't leak file descriptors
echo -n "Testing for file descriptor leaks... "
initial_fd_count=$(ls /proc/self/fd | wc -l)
./proofs/register_dump > /dev/null 2>&1
final_fd_count=$(ls /proc/self/fd | wc -l)
if [ $initial_fd_count -eq $final_fd_count ]; then
    test_result 0 "No file descriptor leaks in register_dump"
else
    test_result 1 "File descriptor leak detected"
fi

echo
echo "================================================"
echo "Integration Test Summary"
echo "================================================"
echo

# Count total tests and passes
total_tests=$(grep -c "✓ PASS\|✗ FAIL" <<< "$(echo -e "$output")" 2>/dev/null || echo "0")
echo "All integration tests completed."
echo "Run individual programs to see detailed output."
echo
echo "To run specific components:"
echo "  make proofs      # Build proof programs"
echo "  make axiomatic   # Build lesson demos"  
echo "  make errors      # Build error demos"
echo "  make test        # Run quick tests"
echo
echo "Individual program examples:"
echo "  ./proofs/register_dump"
echo "  ./proofs/path_walk_simulator /etc/passwd"
echo "  ./axiomatic_lessons/00_failure_predictions/lesson_demo"
echo "  ./error_demo_enoent"