# Trace Report: derive_hash.c

- Userspace source: `kernel/user/stage3/case8_creation_proof/derive_hash.c`
- Driver source: `kernel/drivers/stage3/case8_creation_proof/trace_derive_hash/trace_derive_hash.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case8_creation_proof/trace_derive_hash/trace_derive_hash.ko
# build userspace binary target as needed
sudo insmod trace_derive_hash.ko target_comm="derive_hash"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_derive_hash
```

## Notes
- Add parsed timeline and branch-path proof here.
