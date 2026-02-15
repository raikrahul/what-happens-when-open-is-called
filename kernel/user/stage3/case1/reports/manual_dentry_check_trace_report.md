# Trace Report: manual_dentry_check.c

- Userspace source: `kernel/user/stage3/case1/manual_dentry_check.c`
- Driver source: `kernel/drivers/stage3/case1/trace_manual_dentry_check/trace_manual_dentry_check.c`
- Module: `trace_manual_dentry_check`
- Binary: `kernel/user/stage3/case1/manual_dentry_check.out`
- Run timestamp: `2026-02-15T13:22:18`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 8
- do_filp_open.ret: 8
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 2

## Commands
```bash
make -C kernel/drivers/stage3/case1/trace_manual_dentry_check
kernel/user/stage3/case1/manual_dentry_check.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_manual_dentry_check/trace_manual_dentry_check.ko target_comm="manual_dentry_c"
sudo rmmod trace_manual_dentry_check
```

## Dmesg
`kernel/user/stage3/case1/reports/manual_dentry_check_dmesg.txt`
