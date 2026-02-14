# Trace Report: demo_o_tmpfile.c

- Userspace source: `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_o_tmpfile/trace_demo_o_tmpfile.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_demo_o_tmpfile/trace_demo_o_tmpfile.ko
# build userspace binary target as needed
sudo insmod trace_demo_o_tmpfile.ko target_comm="demo_o_tmpfile"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_demo_o_tmpfile
```

## Notes
- Add parsed timeline and branch-path proof here.
