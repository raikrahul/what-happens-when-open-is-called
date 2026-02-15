# Trace Report: case6_symlink_loop.c

- Userspace source: `kernel/user/stage3/case6_symlink_loop/case6_symlink_loop.c`
- Driver source: `kernel/drivers/stage3/case6_symlink_loop/trace_case6_symlink_loop/trace_case6_symlink_loop.c`
- Module: `trace_case6_symlink_loop`
- Binary: `kernel/user/stage3/case6_symlink_loop/case6_symlink_loop.out`
- Run timestamp: `2026-02-15T13:49:25`
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
make -C kernel/drivers/stage3/case6_symlink_loop/trace_case6_symlink_loop
kernel/user/stage3/case6_symlink_loop/case6_symlink_loop.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case6_symlink_loop/trace_case6_symlink_loop/trace_case6_symlink_loop.ko target_comm="case6_symlink_l"
sudo rmmod trace_case6_symlink_loop
```

## Dmesg
`kernel/user/stage3/case6_symlink_loop/reports/case6_symlink_loop_dmesg.txt`
