# Trace Report: demo_toctou.c

- Userspace source: `kernel/user/stage3/case1/demo_toctou/demo_toctou.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_toctou/trace_demo_toctou.c`
- Module: `trace_demo_toctou`
- Binary: `kernel/user/stage3/case1/demo_toctou/demo_toctou`
- Run timestamp: `2026-02-15T23:31:59`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 21
- do_filp_open.ret: 21
- __d_alloc.entry: 12
- __d_alloc.ret: 12

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 15

## Commands
```bash
make -C kernel/drivers/stage3/case1/trace_demo_toctou
kernel/user/stage3/case1/demo_toctou/demo_toctou
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_demo_toctou/trace_demo_toctou.ko target_comm="demo_toctou"
sudo rmmod trace_demo_toctou
```

## Dmesg
`kernel/user/stage3/case1/reports/demo_toctou_dmesg.txt`
