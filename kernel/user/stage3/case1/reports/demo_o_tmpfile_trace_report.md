# Trace Report: demo_o_tmpfile.c

- Userspace source: `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.c`
- Driver source: `kernel/drivers/stage3/case1/trace_demo_o_tmpfile/trace_demo_o_tmpfile.c`
- Module: `trace_demo_o_tmpfile`
- Binary: `kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.out`
- Run timestamp: `2026-02-15T13:07:57`
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
make -C kernel/drivers/stage3/case1/trace_demo_o_tmpfile
kernel/user/stage3/case1/demo_o_tmpfile/demo_o_tmpfile.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case1/trace_demo_o_tmpfile/trace_demo_o_tmpfile.ko target_comm="demo_o_tmpfile."
sudo rmmod trace_demo_o_tmpfile
```

## Dmesg
`kernel/user/stage3/case1/reports/demo_o_tmpfile_dmesg.txt`
