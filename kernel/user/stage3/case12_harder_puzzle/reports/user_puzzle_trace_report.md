# Trace Report: user_puzzle.c

- Userspace source: `kernel/user/stage3/case12_harder_puzzle/user_puzzle.c`
- Driver source: `kernel/drivers/stage3/case12_harder_puzzle/trace_user_puzzle/trace_user_puzzle.c`
- Status: pending

## Objective
- Capture `do_filp_open` entry/return and `__d_alloc` entry/return.

## Commands
```bash
make kernel/drivers/stage3/case12_harder_puzzle/trace_user_puzzle/trace_user_puzzle.ko
# build userspace binary target as needed
sudo insmod trace_user_puzzle.ko target_comm="user_puzzle"
# run userspace program
sudo dmesg | tail -n 400
sudo rmmod trace_user_puzzle
```

## Notes
- Add parsed timeline and branch-path proof here.
