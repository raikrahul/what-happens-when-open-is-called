# Trace Report: test_vfs_trace.c

- Userspace source: `kernel/user/stage3/case1/test_vfs_trace.c`
- Driver source: `kernel/drivers/stage3/case1/trace_test_vfs_trace/trace_test_vfs_trace.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case1/trace_test_vfs_trace/trace_test_vfs_trace.ko
# build userspace binary target as needed
sudo insmod trace_test_vfs_trace.ko target_comm="test_vfs_trace"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_test_vfs_trace
```

## Notes
- Add parsed timeline and branch-path proof here.
