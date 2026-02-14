# Trace Report: user_deep_create.c

- Userspace source: `kernel/user/stage3/case15_deep_trace/user_deep_create.c`
- Driver source: `kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create/trace_user_deep_create.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case15_deep_trace/trace_user_deep_create/trace_user_deep_create.ko
# build userspace binary target as needed
sudo insmod trace_user_deep_create.ko target_comm="user_deep_creat"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_deep_create
```

## Notes
- Add parsed timeline and branch-path proof here.
