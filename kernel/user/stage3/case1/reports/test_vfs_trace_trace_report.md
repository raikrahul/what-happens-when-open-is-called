# Trace Report: test_vfs_trace.c

- Userspace source: `kernel/user/stage3/case1/test_vfs_trace.c`
- Driver source: `kernel/drivers/stage3/case1/trace_test_vfs_trace/trace_test_vfs_trace.c`
- Module: `trace_test_vfs_trace`
- Binary: `kernel/user/stage3/case1/test_vfs_trace.out`
- Run timestamp: `2026-02-15T13:49:00`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 12
- do_filp_open.ret: 12
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 8
- Non-error pointer returns observed: 4

## Commands
```bash
make -C kernel/drivers/stage3/case1/trace_test_vfs_trace
kernel/user/stage3/case1/test_vfs_trace.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_test_vfs_trace/trace_test_vfs_trace.ko target_comm="test_vfs_trace."
sudo rmmod trace_test_vfs_trace
```

## Dmesg
`kernel/user/stage3/case1/reports/test_vfs_trace_dmesg.txt`
