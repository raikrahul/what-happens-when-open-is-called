# Trace Report: user_open_existing.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/user_open_existing.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_user_open_existing/trace_user_open_existing.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case8_creation_proof/trace_user_open_existing/trace_user_open_existing.ko
# build userspace binary target as needed
sudo insmod trace_user_open_existing.ko target_comm="user_open_exist"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_open_existing
```

## Notes
- Add parsed timeline and branch-path proof here.
