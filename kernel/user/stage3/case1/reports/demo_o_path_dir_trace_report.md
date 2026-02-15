# Trace Report: demo_o_path_dir.c

- Userspace source: `kernel/user/stage3/case1/demo_o_path/demo_o_path_dir.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_o_path_dir/trace_demo_o_path_dir.c`
- Module: `trace_demo_o_path_dir`
- Binary: `kernel/user/stage3/case1/demo_o_path/demo_o_path_dir`
- Run timestamp: `2026-02-15T23:31:55`
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
make -C kernel/drivers/stage3/case1/trace_demo_o_path_dir
kernel/user/stage3/case1/demo_o_path/demo_o_path_dir
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_demo_o_path_dir/trace_demo_o_path_dir.ko target_comm="demo_o_path_dir"
sudo rmmod trace_demo_o_path_dir
```

## Dmesg
`kernel/user/stage3/case1/reports/demo_o_path_dir_dmesg.txt`
