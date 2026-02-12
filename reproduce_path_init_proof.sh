#!/bin/bash
# reproduce_path_init_proof.sh
# Purpose: Prove the AT_FDCWD branch in path_init on a live Ubuntu system.

set -e

# -- STEP 0: THE PRIMATE'S TOOLKIT --
echo "[1] Installing necessary binary analysis tools..."
sudo apt-get update
sudo apt-get install -y build-essential libelf-dev libdw-dev libdwarf-dev binutils gawk

# -- STEP 1: LOCATING THE KERNEL MAP --
# We look for the source directory where we compiled fs/namei.o
KSRC="/usr/src/linux-hwe-6.17-6.17.0"
if [ ! -d "$KSRC" ]; then
    echo "ERROR: Kernel source not found at $KSRC"
    exit 1
fi

# -- STEP 2: GENERATING THE BINARY EVIDENCE --
# Assume we have compiled fs/namei.o previously or trigger a refresh
echo "[2] Using fs/namei.o to extract instruction offsets..."
OBJ_FILE="$KSRC/fs/namei.o"

# -- STEP 3: CALCULATING THE NUMERICAL JUMP --
echo "[3] Disassembling path_init to find the AT_FDCWD check (-100 = 0x9c)..."
objdump -d "$OBJ_FILE" > /tmp/namei.asm

# Identify where path_init starts
START_HEX=$(grep "<path_init>:" /tmp/namei.asm | head -n 1 | cut -d' ' -f1 | sed 's/^0*//' | tr -d ':')
START_DEC=$((16#$START_HEX))

# Find the instruction AFTER the jump (jne) following the -100 (0x9c) check
# We search for 'cmp' with 0x9c, then the next line ('jne'), then the line after that (Target)
TARGET_HEX=$(grep -A 2 "83 ff 9c" /tmp/namei.asm | tail -n 1 | cut -d':' -f1 | tr -d ' ')
TARGET_DEC=$((16#$TARGET_HEX))

OFFSET=$((TARGET_DEC - START_DEC))

echo "Numerical Reconstruction:"
echo " - path_init hex start: 0x$START_HEX (Dec: $START_DEC)"
echo " - Branch body hex start: 0x$TARGET_HEX (Dec: $TARGET_DEC)"
echo " - PHYSICAL OFFSET (Dec): $OFFSET"

# -- STEP 4: FORGING THE PROBE --
echo "[4] Creating and loading the live kprobe for offset +$OFFSET..."
WORK_DIR="/tmp/proof_work"
mkdir -p "$WORK_DIR" && cd "$WORK_DIR"

cat <<EOF > trace_offset.c
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>

static struct kprobe kp = {
    .symbol_name = "path_init",
    .offset = $OFFSET,
};

static int handler_pre(struct kprobe *p, struct pt_regs *regs) {
    /* Filter for our trigger command 'mkdir' */
    if (current->comm[0] == 'm' && current->comm[1] == 'k') {
        pr_info("[REPRODUCTION PROOF] HIT OFFSET +$OFFSET INSIDE AT_FDCWD BRANCH! pid=%d comm=%s\n", 
                current->pid, current->comm);
    }
    return 0;
}

static int __init pk_init(void) {
    kp.pre_handler = handler_pre;
    return register_kprobe(&kp);
}

static void __exit pk_exit(void) {
    unregister_kprobe(&kp);
}

module_init(pk_init)
module_exit(pk_exit)
MODULE_LICENSE("GPL");
EOF

cat <<EOF > Makefile
obj-m += trace_offset.o
KDIR := /lib/modules/\$(shell uname -r)/build
all:
	make -C \$(KDIR) M=\$(PWD) modules
clean:
	make -C \$(KDIR) M=\$(PWD) clean
EOF

make
sudo insmod trace_offset.ko

# -- STEP 5: TRIGGERING THE SYSTEM --
echo "[5] Triggering path resolution by running 'mkdir'..."
mkdir -p /tmp/test_proof_branch_dir

# -- STEP 6: THE VERDICT --
echo "[6] Final Verification..."
if dmesg | tail -n 50 | grep -q "REPRODUCTION PROOF"; then
    echo "--------------------------------------------------"
    echo "SUCCESS: CPU reached Offset +$OFFSET inside the branch."
    echo "Mapping this physical offset to C Source Code:"
    addr2line -e "$OBJ_FILE" $(printf "0x%x" $TARGET_DEC) -f -p -i
    echo "--------------------------------------------------"
else
    echo "FAILURE: Probe not hit. Check dmesg for errors."
fi

# Cleanup
sudo rmmod trace_offset
