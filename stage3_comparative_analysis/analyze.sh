#!/bin/bash
#
# analyze.sh - Automated comparative analysis script
# Tests both scenarios and generates comparison report
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Create results directory
mkdir -p results

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=============================================="
echo "VFS Comparative Analysis Tool"
echo "=============================================="
echo ""

# Check if driver is compiled
if [ ! -f "driver_comparative.ko" ]; then
    echo -e "${YELLOW}Driver not compiled. Building...${NC}"
    make driver
fi

# Check if user programs are compiled
if [ ! -f "user_create" ] || [ ! -f "user_open" ]; then
    echo -e "${YELLOW}User programs not compiled. Building...${NC}"
    make userspace
fi

TEST_FILE="test_file.txt"

echo "Step 1: Testing File Creation (O_CREAT)"
echo "----------------------------------------"

# Remove file if exists
rm -f "$TEST_FILE"

# Clear dmesg and load driver
echo "Loading driver..."
sudo dmesg -C
sudo insmod driver_comparative.ko target_comm="user_create"

# Run creation test
echo "Running user_create..."
./user_create "$TEST_FILE"

# Unload driver
echo "Unloading driver..."
sudo rmmod driver_comparative

# Capture logs
echo "Capturing logs..."
sudo dmesg | grep -E "\[PROBE:|\[D_" > results/scenario_a_creation.log

echo -e "${GREEN}✓ Scenario A complete${NC}"
echo ""

echo "Step 2: Testing File Open (Existing)"
echo "-------------------------------------"

# Clear dmesg and load driver
echo "Loading driver..."
sudo dmesg -C
sudo insmod driver_comparative.ko target_comm="user_open"

# Run open test
echo "Running user_open..."
./user_open "$TEST_FILE"

# Unload driver
echo "Unloading driver..."
sudo rmmod driver_comparative

# Capture logs
echo "Capturing logs..."
sudo dmesg | grep -E "\[PROBE:|\[D_" > results/scenario_b_open.log

echo -e "${GREEN}✓ Scenario B complete${NC}"
echo ""

echo "Step 3: Analysis"
echo "----------------"

# Count function calls
echo "Function call counts:" > results/analysis.txt
echo "" >> results/analysis.txt

echo "Scenario A (Creation):" >> results/analysis.txt
grep "ENTRY:" results/scenario_a_creation.log | wc -l | xargs echo "  Total probe hits: " >> results/analysis.txt
grep -c "D_ALLOC" results/scenario_a_creation.log | xargs -I{} echo "  d_alloc() calls: {}" >> results/analysis.txt
grep -c "VFS_CREATE" results/scenario_a_creation.log | xargs -I{} echo "  vfs_create() calls: {}" >> results/analysis.txt
grep -c "D_INSTANTIATE" results/scenario_a_creation.log | xargs -I{} echo "  d_instantiate() calls: {}" >> results/analysis.txt
grep -c "D_LOOKUP_RCU" results/scenario_a_creation.log | xargs -I{} echo "  __d_lookup_rcu() calls: {}" >> results/analysis.txt

echo "" >> results/analysis.txt
echo "Scenario B (Open Existing):" >> results/analysis.txt
grep "ENTRY:" results/scenario_b_open.log | wc -l | xargs echo "  Total probe hits: " >> results/analysis.txt
grep -c "D_ALLOC" results/scenario_b_open.log | xargs -I{} echo "  d_alloc() calls: {}" >> results/analysis.txt
grep -c "VFS_CREATE" results/scenario_b_open.log | xargs -I{} echo "  vfs_create() calls: {}" >> results/analysis.txt
grep -c "D_INSTANTIATE" results/scenario_b_open.log | xargs -I{} echo "  d_instantiate() calls: {}" >> results/analysis.txt
grep -c "D_LOOKUP_RCU" results/scenario_b_open.log | xargs -I{} echo "  __d_lookup_rcu() calls: {}" >> results/analysis.txt

# Generate diff
echo "" >> results/analysis.txt
echo "Differences:" >> results/analysis.txt
echo "-----------" >> results/analysis.txt

# Functions unique to creation
echo "" >> results/analysis.txt
echo "Functions UNIQUE to Scenario A (Creation):" >> results/analysis.txt
grep "ENTRY:" results/scenario_a_creation.log | awk '{print $4}' | sort -u > /tmp/funcs_a.txt
grep "ENTRY:" results/scenario_b_open.log | awk '{print $4}' | sort -u > /tmp/funcs_b.txt
comm -23 /tmp/funcs_a.txt /tmp/funcs_b.txt | while read func; do
    echo "  + $func" >> results/analysis.txt
done

# Functions unique to open
echo "" >> results/analysis.txt
echo "Functions UNIQUE to Scenario B (Open Existing):" >> results/analysis.txt
comm -13 /tmp/funcs_a.txt /tmp/funcs_b.txt | while read func; do
    echo "  + $func" >> results/analysis.txt
done

cat results/analysis.txt

echo ""
echo "=============================================="
echo -e "${GREEN}Analysis Complete!${NC}"
echo "=============================================="
echo ""
echo "Results saved in:"
echo "  - results/scenario_a_creation.log"
echo "  - results/scenario_b_open.log"
echo "  - results/analysis.txt"
echo ""
echo "Key differences to look for:"
echo "  • Scenario A should show: d_alloc, vfs_create, d_instantiate"
echo "  • Scenario B should show: __d_lookup_rcu, d_revalidate"
