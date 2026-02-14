# Trace Report: puzzle_verify.c

- Userspace source: `kernel/user/stage3/case12_harder_puzzle/puzzle_verify.c`
- Driver source: `kernel/drivers/stage3/case12_harder_puzzle/trace_puzzle_verify/trace_puzzle_verify.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case12_harder_puzzle/trace_puzzle_verify/trace_puzzle_verify.ko
# build userspace binary target as needed
sudo insmod trace_puzzle_verify.ko target_comm="puzzle_verify"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_puzzle_verify
```

## Notes
- Add parsed timeline and branch-path proof here.
