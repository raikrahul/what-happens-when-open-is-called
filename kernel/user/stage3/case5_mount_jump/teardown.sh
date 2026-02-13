#!/bin/bash
MNT="/tmp/mnt_stage3"
sudo umount $MNT 2>/dev/null
rm -f ext2.img case5_mount_jump
