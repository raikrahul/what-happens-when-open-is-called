# Trace Report: multi_path_open.c

- Userspace source: `kernel/user/stage3/multi_path_open.c`
- Driver source: `kernel/drivers/stage3/stage3/trace_multi_path_open/trace_multi_path_open.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/stage3/trace_multi_path_open/trace_multi_path_open.ko
# build userspace binary target as needed
sudo insmod trace_multi_path_open.ko target_comm="multi_path_open"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_multi_path_open
```

## Notes
- Add parsed timeline and branch-path proof here.
