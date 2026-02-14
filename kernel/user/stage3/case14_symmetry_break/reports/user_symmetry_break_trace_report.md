# Trace Report: user_symmetry_break.c

- Userspace source: `kernel/user/stage3/case14_symmetry_break/user_symmetry_break.c`
- Driver source: `kernel/drivers/stage3/case14_symmetry_break/trace_user_symmetry_break/trace_user_symmetry_break.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case14_symmetry_break/trace_user_symmetry_break/trace_user_symmetry_break.ko
# build userspace binary target as needed
sudo insmod trace_user_symmetry_break.ko target_comm="user_symmetry_b"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_symmetry_break
```

## Notes
- Add parsed timeline and branch-path proof here.
