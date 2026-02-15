# Trace Report: case7_symlink_fast.c

- Userspace source: `kernel/user/stage3/case7_symlink_fast/case7_symlink_fast.c`
- Driver source: `kernel/drivers/stage3/case7_symlink_fast/trace_case7_symlink_fast/trace_case7_symlink_fast.c`
- Module: `trace_case7_symlink_fast`
- Binary: `kernel/user/stage3/case7_symlink_fast/case7_symlink_fast.out`
- Run timestamp: `2026-02-15T13:22:45`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 9
- do_filp_open.ret: 9
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 7
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case7_symlink_fast/trace_case7_symlink_fast
kernel/user/stage3/case7_symlink_fast/case7_symlink_fast.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case7_symlink_fast/trace_case7_symlink_fast/trace_case7_symlink_fast.ko target_comm="case7_symlink_f"
sudo rmmod trace_case7_symlink_fast
```

## Dmesg
`kernel/user/stage3/case7_symlink_fast/reports/case7_symlink_fast_dmesg.txt`
