# Trace Report: user_puzzle.c

- Userspace source: `kernel/user/stage3/case12_harder_puzzle/user_puzzle.c`
- Driver source: `kernel/drivers/stage3/case12_harder_puzzle/trace_user_puzzle/trace_user_puzzle.c`
- Module: `trace_user_puzzle`
- Binary: `kernel/user/stage3/case12_harder_puzzle/user_puzzle.out`
- Run timestamp: `2026-02-15T13:22:24`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 11
- do_filp_open.ret: 11
- __d_alloc.entry: 1
- __d_alloc.ret: 1

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 5

## Commands
```bash
make -C kernel/drivers/stage3/case12_harder_puzzle/trace_user_puzzle
kernel/user/stage3/case12_harder_puzzle/user_puzzle.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case12_harder_puzzle/trace_user_puzzle/trace_user_puzzle.ko target_comm="user_puzzle.out"
sudo rmmod trace_user_puzzle
```

## Dmesg
`kernel/user/stage3/case12_harder_puzzle/reports/user_puzzle_dmesg.txt`
