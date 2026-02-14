# Trace Report: user_trigger_missing.c

- Userspace source: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_missing.c`
- Driver source: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing/trace_user_trigger_missing.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_missing/trace_user_trigger_missing.ko
# build userspace binary target as needed
sudo insmod trace_user_trigger_missing.ko target_comm="user_trigger_mi"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_trigger_missing
```

## Notes
- Add parsed timeline and branch-path proof here.
