# Trace Report: user_salt_avalanche.c

- Userspace source: `kernel/user/stage3/case13_salt_avalanche/user_salt_avalanche.c`
- Driver source: `kernel/drivers/stage3/case13_salt_avalanche/trace_user_salt_avalanche/trace_user_salt_avalanche.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case13_salt_avalanche/trace_user_salt_avalanche/trace_user_salt_avalanche.ko
# build userspace binary target as needed
sudo insmod trace_user_salt_avalanche.ko target_comm="user_salt_avala"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_salt_avalanche
```

## Notes
- Add parsed timeline and branch-path proof here.
