#!/bin/bash
# run.sh for Stage 3 Scenarios
# Usage: ./run.sh <case_number>

CASE=$1
if [ -z "$CASE" ]; then
    echo "Usage: $0 <case_number>"
    exit 1
fi

DIR="case${CASE}_"
TARGET_DIR=$(ls -d case${CASE}_* 2>/dev/null)

if [ -z "$TARGET_DIR" ]; then
    echo "Case $CASE not found."
    exit 1
fi

cd "$TARGET_DIR"
./setup.sh
# Note: Driver insertion and dmesg monitoring 
# should be handled by the specialized stage3 driver scripts
./case${CASE}_*
