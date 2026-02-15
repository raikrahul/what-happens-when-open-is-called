# Trace Report: demo_dup_names.c

- Userspace source: `kernel/user/stage3/case1/demo_dup_names.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_dup_names/trace_demo_dup_names.c`
- Module: `trace_demo_dup_names`
- Binary: `kernel/user/stage3/case1/demo_dup_names.out`
- Run timestamp: `2026-02-15T13:48:53`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 10
- do_filp_open.ret: 10
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 4

## Commands
```bash
make -C kernel/drivers/stage3/case1/trace_demo_dup_names
kernel/user/stage3/case1/demo_dup_names.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_demo_dup_names/trace_demo_dup_names.ko target_comm="demo_dup_names."
sudo rmmod trace_demo_dup_names
```

## Dmesg
`kernel/user/stage3/case1/reports/demo_dup_names_dmesg.txt`
