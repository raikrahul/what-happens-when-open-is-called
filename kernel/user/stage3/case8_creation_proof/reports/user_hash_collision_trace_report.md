# Trace Report: user_hash_collision.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/user_hash_collision.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_user_hash_collision/trace_user_hash_collision.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case8_creation_proof/trace_user_hash_collision/trace_user_hash_collision.ko
# build userspace binary target as needed
sudo insmod trace_user_hash_collision.ko target_comm="user_hash_colli"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_hash_collision
```

## Notes
- Add parsed timeline and branch-path proof here.
