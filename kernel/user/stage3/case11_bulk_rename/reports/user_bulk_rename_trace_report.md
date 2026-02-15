# Trace Report: user_bulk_rename.c

- Userspace source: `kernel/user/stage3/case11_bulk_rename/user_bulk_rename.c`
- Driver source: `kernel/drivers/stage3/case11_bulk_rename/trace_user_bulk_rename/trace_user_bulk_rename.c`
- Module: `trace_user_bulk_rename`
- Binary: `kernel/user/stage3/case11_bulk_rename/user_bulk_rename`
- Run timestamp: `2026-02-15T23:32:05`
- Final status: `pass_probe_hits`

## Probe Counts
- do_filp_open.entry: 110
- do_filp_open.ret: 110
- __d_alloc.entry: 0
- __d_alloc.ret: 0

## Return Signature Counts
- ERR_PTR(-ENOENT) observed (fffffffffffffffe): 6
- Non-error pointer returns observed: 104

## Commands
```bash
make -C kernel/drivers/stage3/case11_bulk_rename/trace_user_bulk_rename
kernel/user/stage3/case11_bulk_rename/user_bulk_rename
sudo dmesg -C
sudo insmod kernel/drivers/stage3/case11_bulk_rename/trace_user_bulk_rename/trace_user_bulk_rename.ko target_comm="user_bulk_renam"
sudo rmmod trace_user_bulk_rename
```

## Dmesg
`kernel/user/stage3/case11_bulk_rename/reports/user_bulk_rename_dmesg.txt`
