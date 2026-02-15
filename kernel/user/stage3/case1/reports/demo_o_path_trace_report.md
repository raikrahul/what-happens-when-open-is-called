# Trace Report: demo_o_path.c

- Userspace source: `kernel/user/stage3/case1/demo_o_path/demo_o_path.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_o_path/trace_demo_o_path.c`
- Module: `trace_demo_o_path`
- Binary: `kernel/user/stage3/case1/demo_o_path/demo_o_path`
- Run timestamp: `2026-02-15T23:31:54`
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
make -C kernel/drivers/stage3/case1/trace_demo_o_path
kernel/user/stage3/case1/demo_o_path/demo_o_path
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_demo_o_path/trace_demo_o_path.ko target_comm="demo_o_path"
sudo rmmod trace_demo_o_path
```

## Dmesg
`kernel/user/stage3/case1/reports/demo_o_path_dmesg.txt`
