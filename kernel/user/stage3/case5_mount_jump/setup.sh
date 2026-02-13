#!/bin/bash
# setup.sh for Case 5
# WARNING: Requires root/sudo for mounting
IMG="ext2.img"
MNT="/tmp/mnt_stage3"

sudo umount $MNT 2>/dev/null
rm -f $IMG
dd if=/dev/zero of=$IMG bs=1M count=10
mkfs.ext2 -F $IMG
mkdir -p $MNT
sudo mount -o loop $IMG $MNT
sudo touch $MNT/loop_file.txt
sudo chmod 644 $MNT/loop_file.txt
gcc -o case5_mount_jump case5_mount_jump.c
