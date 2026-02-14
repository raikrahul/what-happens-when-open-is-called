# Trace Report: user_create_long.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/user_create_long.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_user_create_long/trace_user_create_long.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case8_creation_proof/trace_user_create_long/trace_user_create_long.ko
# build userspace binary target as needed
sudo insmod trace_user_create_long.ko target_comm="user_create_lon"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_create_long
```

## Notes
- Add parsed timeline and branch-path proof here.
