#!/bin/bash
echo 1 | sudo -S rmmod trace_d_lookup 2>/dev/null || true
echo 1 | sudo -S insmod /home/r/Desktop/what-happens-when-open-is-called/kernel/drivers/stage3/case1/trace_path_init/trace_d_lookup.ko
cd /home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case1
./demo_dup_names
echo 1 | sudo -S dmesg | tail -n 100 | grep -E '\[D_LOOKUP\]|Target:'
