# Trace Report: user_trigger_exists.c

- Userspace source: `kernel/user/stage3/case16_do_filp_open_trace/user_trigger_exists.c`
- Driver source: `kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case16_do_filp_open_trace/trace_user_trigger_exists/trace_user_trigger_exists.ko
# build userspace binary target as needed
sudo insmod trace_user_trigger_exists.ko target_comm="user_trigger_ex"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_trigger_exists
```

## Notes
- Add parsed timeline and branch-path proof here.
