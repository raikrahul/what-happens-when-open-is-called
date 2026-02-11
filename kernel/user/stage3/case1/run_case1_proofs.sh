#!/bin/bash
set -e

# Configuration
DRIVER_DIR="../../../drivers/stage3/case1/trace_path_init"
DRIVER_KO="$DRIVER_DIR/trace_path_init.ko"
PROOF_FILE="proof.txt"

# Ensure we are in the correct directory
cd "$(dirname "$0")"

echo "=== Case 1 Trace Validation Script ==="
echo "Output will be appended to $PROOF_FILE"
echo "" > "$PROOF_FILE" # Clear the file initially

# Helper function to run a test case
run_test() {
    local demo_name="$1"
    local demo_cmd="$2"
    local target_comm="$3"
    
    echo "----------------------------------------------------------------" | tee -a "$PROOF_FILE"
    echo "Running Test: $demo_name" | tee -a "$PROOF_FILE"
    echo "Command: $demo_cmd" | tee -a "$PROOF_FILE"
    echo "Target Comm: $target_comm" | tee -a "$PROOF_FILE"
    echo "----------------------------------------------------------------" | tee -a "$PROOF_FILE"

    # 1. Clear dmesg
    echo "[*] Clearing dmesg..."
    sudo dmesg -C

    # 2. Insert module
    echo "[*] Loading driver with target_comm='$target_comm'..."
    if ! sudo insmod "$DRIVER_KO" target_comm="$target_comm"; then
        echo "Error: Failed to insert module. Is it already loaded?"
        sudo rmmod trace_path_init 2>/dev/null || true
        sudo insmod "$DRIVER_KO" target_comm="$target_comm"
    fi

    # 3. Run user-space code
    echo "[*] Executing user-space program..."
    # Run in a subshell to handle directory changes if needed, and capture output nicely
    # We suppress stdout/stderr of the app to keep the terminal clean, unless it's relevant?
    # The user asked to "read the dmesg", so app output might not be strictly required in proof.txt,
    # but it's good context. Let's redirect app output to /dev/null or a temp file.
    
    if eval "$demo_cmd > /dev/null 2>&1"; then
        echo "[*] App execution successful."
    else
        echo "[!] App execution returned error (expected for some demos like ENOENT)."
    fi

    # 4. Capture dmesg
    echo "[*] Capturing kernel trace..."
    echo "" >> "$PROOF_FILE"
    echo "--- DMESG OUTPUT ---" >> "$PROOF_FILE"
    sudo dmesg | grep "PATH_INIT" >> "$PROOF_FILE" || echo "(No PATH_INIT logs found)" >> "$PROOF_FILE"
    echo "" >> "$PROOF_FILE"

    # 5. Remove module
    echo "[*] Unloading driver..."
    sudo rmmod trace_path_init
    echo "[*] Done."
    echo ""
}

# Build driver first
echo "[BUILD] Building kernel driver..."
pushd "$DRIVER_DIR" >/dev/null
make clean >/dev/null
make >/dev/null
popd >/dev/null
echo "[BUILD] Driver built successfully."

# ---------------------------------------------------------
# Test 1: demo_at_fdcwd
# ---------------------------------------------------------
# Binary: demo_at_fdcwd/demo_at_fdcwd.out
# Comm: demo_at_fdcwd.o (from previous runs)
pushd demo_at_fdcwd >/dev/null
# Clean/Build just in case
# make clean && make
# But assuming binaries exist or using existing ones.
# Let's verify gcc compilation if needed, but for now assuming .out exist.
# Re-compile to be safe?
gcc -o demo_at_fdcwd.out demo_at_fdcwd.c
popd >/dev/null

run_test "demo_at_fdcwd" "./demo_at_fdcwd/demo_at_fdcwd.out" "demo_at_fdcwd.o"

# ---------------------------------------------------------
# Test 2: demo_toctou
# ---------------------------------------------------------
# Binary: demo_toctou/demo_toctou.out
# Comm: demo_toctou.out (fits in 16 chars)
pushd demo_toctou >/dev/null
gcc -o demo_toctou.out demo_toctou.c
popd >/dev/null

run_test "demo_toctou" "./demo_toctou/demo_toctou.out" "demo_toctou.out"

# ---------------------------------------------------------
# Test 3: demo_thread_safety
# ---------------------------------------------------------
# Binary: demo_thread_safety/demo_thread_safety.out
# Comm: demo_thread_saf (truncated)
pushd demo_thread_safety >/dev/null
gcc -o demo_thread_safety.out demo_thread_safety.c -lpthread
popd >/dev/null

run_test "demo_thread_safety" "./demo_thread_safety/demo_thread_safety.out" "demo_thread_saf"

# ---------------------------------------------------------
# Test 4: case1_relative
# ---------------------------------------------------------
# Binary: case1_relative/case1_relative.out
# Comm: case1_relative. (truncated)
pushd case1_relative >/dev/null
gcc -o case1_relative.out case1_relative.c
popd >/dev/null

run_test "case1_relative" "./case1_relative/case1_relative.out" "case1_relative."

# Final cleanup
echo "=== Validation Complete ==="
echo "Final dmesg clear..."
sudo dmesg -C
echo "Cleaned."
echo "Proofs written to $(readlink -f $PROOF_FILE)"
