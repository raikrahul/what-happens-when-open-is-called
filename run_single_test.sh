#!/bin/bash
# Test runner for individual test cases with proper logging

RESULTS_DIR="$1"
TEST_NAME="$2"
DRIVER="$3"
TEST_PROG="$4"
TEST_DIR="$5"

LOG_FILE="${RESULTS_DIR}/${TEST_NAME}_$(date +%s).log"

echo "=== TEST: $TEST_NAME ===" > "$LOG_FILE"
echo "Timestamp: $(date)" >> "$LOG_FILE"
echo "Driver: $DRIVER" >> "$LOG_FILE"
echo "Test Program: $TEST_PROG" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Clear dmesg
sudo dmesg -C 2>/dev/null

echo "[$(date)] Loading driver: $(basename $DRIVER)" >> "$LOG_FILE"
if sudo insmod "$DRIVER" 2>&1 >> "$LOG_FILE"; then
    echo "[$(date)] Driver loaded successfully" >> "$LOG_FILE"
else
    echo "[$(date)] ERROR: Failed to load driver" >> "$LOG_FILE"
    echo "STATUS: FAILED" >> "$LOG_FILE"
    exit 1
fi

echo "" >> "$LOG_FILE"
echo "[$(date)] Running test program: $(basename $TEST_PROG)" >> "$LOG_FILE"
cd "$TEST_DIR"
if timeout 10 "./$(basename $TEST_PROG)" 2>&1 >> "$LOG_FILE"; then
    echo "[$(date)] Test program completed" >> "$LOG_FILE"
else
    echo "[$(date)] Test program exited with error or timeout" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"
echo "=== KERNEL MESSAGES ===" >> "$LOG_FILE"
sudo dmesg >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "[$(date)] Unloading driver" >> "$LOG_FILE"
sudo rmmod "$(basename $DRIVER .ko)" 2>&1 >> "$LOG_FILE" || echo "[$(date)] Warning: Failed to unload driver" >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "=== TEST END: $TEST_NAME ===" >> "$LOG_FILE"
echo "STATUS: COMPLETED" >> "$LOG_FILE"

cat "$LOG_FILE"
