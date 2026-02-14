# Trace Report: demo_thread_safety.c

- Userspace source: `kernel/user/stage3/case1/demo_thread_safety/demo_thread_safety.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_thread_safety/trace_demo_thread_safety.c`
- Module: `trace_demo_thread_safety`
- Binary: `kernel/user/stage3/case1/demo_thread_safety/demo_thread_safety.out`
- Run timestamp: `2026-02-15T01:15:03`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 13
- do_filp_open.ret: 13
- __d_alloc.entry: 5
- __d_alloc.ret: 5

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 7

## Commands
```bash
make -C kernel/drivers/stage3/case1/trace_demo_thread_safety
kernel/user/stage3/case1/demo_thread_safety/demo_thread_safety.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_demo_thread_safety/trace_demo_thread_safety.ko target_comm="demo_thread_saf"
sudo rmmod trace_demo_thread_safety
```

## Dmesg
`kernel/user/stage3/case1/reports/demo_thread_safety_dmesg.txt`
