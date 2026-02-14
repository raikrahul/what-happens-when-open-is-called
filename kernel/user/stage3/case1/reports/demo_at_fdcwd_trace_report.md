# Trace Report: demo_at_fdcwd.c

- Userspace source: `kernel/user/stage3/case1/demo_at_fdcwd/demo_at_fdcwd.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_at_fdcwd/trace_demo_at_fdcwd.c`
- Module: `trace_demo_at_fdcwd`
- Binary: `kernel/user/stage3/case1/demo_at_fdcwd/demo_at_fdcwd.out`
- Run timestamp: `2026-02-15T01:14:58`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 11
- do_filp_open.ret: 11
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 5

## Commands
```bash
make -C kernel/drivers/stage3/case1/trace_demo_at_fdcwd
kernel/user/stage3/case1/demo_at_fdcwd/demo_at_fdcwd.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_demo_at_fdcwd/trace_demo_at_fdcwd.ko target_comm="demo_at_fdcwd.o"
sudo rmmod trace_demo_at_fdcwd
```

## Dmesg
`kernel/user/stage3/case1/reports/demo_at_fdcwd_dmesg.txt`
