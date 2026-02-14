#!/bin/bash

# Master Test Script for File Creation vs Open Path Tracing
# Timestamp: 2026-02-13 20:16:00
# Usage: sudo ./run_full_test.sh

set -e  # Exit on error

# Configuration
TEST_DIR="/home/r/Desktop/what-happens-when-open-is-called/CREATE_VS_OPEN_TRACE"
DRIVERS_DIR="$TEST_DIR/drivers"
USERSPACE_DIR="$TEST_DIR/userspace"
LOGS_DIR="$TEST_DIR/logs"
RESULTS_DIR="$TEST_DIR/results"

# Create directories
mkdir -p "$LOGS_DIR" "$RESULTS_DIR"

# Log file
TEST_LOG="$LOGS_DIR/test_$(date +%Y%m%d_%H%M%S).log"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$TEST_LOG"
}

log "========================================"
log "FILE CREATION VS OPEN PATH - FULL TEST"
log "========================================"
log "Test started at: $(date)"
log "Kernel: $(uname -r)"
log "========================================"

# Phase 1: File Creation Path Test
log ""
log "PHASE 1: FILE CREATION PATH TEST"
log "--------------------------------"

log "Step 1.1: Clear dmesg buffer"
dmesg -C
log "dmesg cleared"

log "Step 1.2: Load Driver A (trace_create_path.ko)"
cd "$DRIVERS_DIR"
if lsmod | grep -q "trace_create_path"; then
    log "Driver A already loaded, unloading first..."
    rmmod trace_create_path
fi
insmod trace_create_path.ko
dmesg | tail -5 | tee -a "$TEST_LOG"
log "Driver A loaded successfully"
sync

log "Step 1.3: Run create_test_file program"
cd "$USERSPACE_DIR"
log "Creating test file..."
./create_test_file 2>&1 | tee -a "$TEST_LOG"
CREATED_FILE=$(ls -t /tmp/test_create_*.txt 2>/dev/null | head -1)
if [ -z "$CREATED_FILE" ]; then
    log "ERROR: Failed to create test file"
    exit 1
fi
log "Created file: $CREATED_FILE"

log "Step 1.4: Capture creation path traces"
cd "$TEST_DIR"
dmesg | grep "\[A\." > "$RESULTS_DIR/creation_trace.log" 2>&1 || true
CREATION_COUNT=$(wc -l < "$RESULTS_DIR/creation_trace.log" 2>/dev/null || echo "0")
log "Captured $CREATION_COUNT trace entries from Driver A"

log "Step 1.5: Unload Driver A"
cd "$DRIVERS_DIR"
rmmod trace_create_path
log "Driver A unloaded"
sync

log "Step 1.6: Save creation trace"
cp "$RESULTS_DIR/creation_trace.log" "$RESULTS_DIR/creation_trace_$(date +%Y%m%d_%H%M%S).log"
log "Creation trace saved"

# Phase 2: File Open Path Test
log ""
log "PHASE 2: FILE OPEN PATH TEST"
log "----------------------------"

log "Step 2.1: Clear dmesg buffer"
dmesg -C
log "dmesg cleared"

log "Step 2.2: Load Driver B (trace_open_path.ko)"
cd "$DRIVERS_DIR"
if lsmod | grep -q "trace_open_path"; then
    log "Driver B already loaded, unloading first..."
    rmmod trace_open_path
fi
insmod trace_open_path.ko
dmesg | tail -5 | tee -a "$TEST_LOG"
log "Driver B loaded successfully"
sync

log "Step 2.3: Run open_existing_file program"
cd "$USERSPACE_DIR"
log "Opening existing file: $CREATED_FILE"
./open_existing_file "$CREATED_FILE" 2>&1 | tee -a "$TEST_LOG"
log "File opened successfully"

log "Step 2.4: Capture open path traces"
cd "$TEST_DIR"
dmesg | grep "\[B\." > "$RESULTS_DIR/open_trace.log" 2>&1 || true
OPEN_COUNT=$(wc -l < "$RESULTS_DIR/open_trace.log" 2>/dev/null || echo "0")
log "Captured $OPEN_COUNT trace entries from Driver B"

log "Step 2.5: Unload Driver B"
cd "$DRIVERS_DIR"
rmmod trace_open_path
log "Driver B unloaded"
sync

log "Step 2.6: Save open trace"
cp "$RESULTS_DIR/open_trace.log" "$RESULTS_DIR/open_trace_$(date +%Y%m%d_%H%M%S).log"
log "Open trace saved"

# Phase 3: Analysis
log ""
log "PHASE 3: TRACE ANALYSIS"
log "-----------------------"

cd "$TEST_DIR"
log "Generating comparison analysis..."

# Extract unique functions called
echo "" > "$RESULTS_DIR/analysis.txt"
echo "TRACE COMPARISON ANALYSIS" >> "$RESULTS_DIR/analysis.txt"
echo "=========================" >> "$RESULTS_DIR/analysis.txt"
echo "Generated: $(date)" >> "$RESULTS_DIR/analysis.txt"
echo "" >> "$RESULTS_DIR/analysis.txt"

echo "FILE CREATION PATH (Driver A):" >> "$RESULTS_DIR/analysis.txt"
echo "-------------------------------" >> "$RESULTS_DIR/analysis.txt"
echo "Total trace entries: $CREATION_COUNT" >> "$RESULTS_DIR/analysis.txt"
echo "" >> "$RESULTS_DIR/analysis.txt"
echo "Functions called:" >> "$RESULTS_DIR/analysis.txt"
cat "$RESULTS_DIR/creation_trace.log" | awk '{print $3}' | sort | uniq -c | sort -rn >> "$RESULTS_DIR/analysis.txt"

echo "" >> "$RESULTS_DIR/analysis.txt"
echo "FILE OPEN PATH (Driver B):" >> "$RESULTS_DIR/analysis.txt"
echo "---------------------------" >> "$RESULTS_DIR/analysis.txt"
echo "Total trace entries: $OPEN_COUNT" >> "$RESULTS_DIR/analysis.txt"
echo "" >> "$RESULTS_DIR/analysis.txt"
echo "Functions called:" >> "$RESULTS_DIR/analysis.txt"
cat "$RESULTS_DIR/open_trace.log" | awk '{print $3}' | sort | uniq -c | sort -rn >> "$RESULTS_DIR/analysis.txt"

log "Analysis complete: $RESULTS_DIR/analysis.txt"

# Phase 4: Summary
log ""
log "========================================"
log "TEST COMPLETE"
log "========================================"
log "Creation trace: $CREATION_COUNT entries"
log "Open trace: $OPEN_COUNT entries"
log "Created file: $CREATED_FILE"
log "Results: $RESULTS_DIR/"
log "Logs: $LOGS_DIR/"
log "Test log: $TEST_LOG"
log "========================================"

# Final sync
sync
log "All data synced to filesystem"

exit 0
