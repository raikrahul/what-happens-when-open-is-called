# Trace Report: user_symmetry_break.c

- Userspace source: `kernel/user/stage3/case14_symmetry_break/user_symmetry_break.c`
- Driver source: `kernel/drivers/stage3/case14_symmetry_break/trace_user_symmetry_break/trace_user_symmetry_break.c`
- Module: `trace_user_symmetry_break`
- Binary: `kernel/user/stage3/case14_symmetry_break/user_symmetry_break.out`
- Run timestamp: `2026-02-15T13:49:07`
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
make -C kernel/drivers/stage3/case14_symmetry_break/trace_user_symmetry_break
kernel/user/stage3/case14_symmetry_break/user_symmetry_break.out
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case14_symmetry_break/trace_user_symmetry_break/trace_user_symmetry_break.ko target_comm="user_symmetry_b"
sudo rmmod trace_user_symmetry_break
```

## Dmesg
`kernel/user/stage3/case14_symmetry_break/reports/user_symmetry_break_dmesg.txt`
