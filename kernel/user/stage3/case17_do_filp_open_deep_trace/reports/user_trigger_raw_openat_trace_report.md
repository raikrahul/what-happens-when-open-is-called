# Trace Report: user_trigger_raw_openat.S

- Userspace source: `kernel/user/stage3/case17_do_filp_open_deep_trace/user_trigger_raw_openat.S`
- Driver source: `kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger_raw_openat/trace_user_trigger_raw_openat.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case17_do_filp_open_deep_trace/trace_user_trigger_raw_openat/trace_user_trigger_raw_openat.ko
# build userspace binary target as needed
sudo insmod trace_user_trigger_raw_openat.ko target_comm="user_trigger_ra"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_trigger_raw_openat
```

## Notes
- Add parsed timeline and branch-path proof here.
