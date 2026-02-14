#!/usr/bin/env bash
set -e

# Setup folders
CUR_DIR=$(pwd)
TRACES_DIR="$CUR_DIR/traces"
mkdir -p "$TRACES_DIR"

echo "Step 1: Compiling everything..."
make clean > /dev/null
make > /dev/null
gcc -o user_create_simple user_create_simple.c
gcc -o user_open_existing user_open_existing.c
gcc -o user_create_long user_create_long.c
gcc -o user_create_deep user_create_deep.c
gcc -o user_hash_collision user_hash_collision.c

# Clean up previous runs
rm -f creation_proof.txt creation_proof_long_name_*.txt subdir/creation_proof_deep.txt collision_*.txt
rmdir subdir 2>/dev/null || true

function run_test() {
    local name=$1
    local driver=$2
    local binary=$3
    local logfile="$TRACES_DIR/trace_$name.txt"

    echo "--- Running $name ---"
    echo "1" | sudo -S dmesg -C
    echo "1" | sudo -S insmod "$driver.ko"
    ./"$binary" > /dev/null
    echo "1" | sudo -S rmmod "$driver"
    echo "1" | sudo -S dmesg > "$logfile"
    echo "Done. Log saved to $logfile"
}

# 1. Creation Proof (Simple)
echo "--- Running simple_create ---"
echo "1" | sudo -S dmesg -C
echo "1" | sudo -S insmod "driver_creation_probe.ko"
CREATED_FILE=$(./user_create_simple | awk '{print $NF}')
echo "1" | sudo -S rmmod "driver_creation_probe"
echo "1" | sudo -S dmesg > "$TRACES_DIR/trace_simple_create.txt"

# 2. Lookup Proof (Simple)
echo "--- Running simple_lookup ---"
echo "1" | sudo -S dmesg -C
echo "1" | sudo -S insmod "driver_lookup_probe.ko"
./user_open_existing "$CREATED_FILE" > /dev/null
echo "1" | sudo -S rmmod "driver_lookup_probe"
echo "1" | sudo -S dmesg > "$TRACES_DIR/trace_simple_lookup.txt"

# 3. Long Name Proof
run_test "long_create" "driver_creation_probe" "user_create_long"

# 4. Deep Path (Salt check)
run_test "deep_create" "driver_creation_probe" "user_create_deep"

# 5. Collision Check
run_test "collision" "driver_creation_probe" "user_hash_collision"

echo "Step 2: Analysis Complete. Traces in $TRACES_DIR"
