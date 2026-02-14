# Kernel Trace Product

## Free Pack
- Case17 trace flow:
  - `do_filp_open` entry/return
  - `d_alloc_parallel` entry
  - `__d_alloc` entry/return
- Files:
  - `kernel/user/stage3/case17_do_filp_open_deep_trace/driver.c`
  - `kernel/user/stage3/case17_do_filp_open_deep_trace/worksheet_lingering_dentry_proof.md`

## Pro Direction
- More case packs
- Harder forensic worksheets
- Guided review sessions

## Additional Product Docs
- FAQ: `docs/product/buyer_faq.md`
- Compatibility: `docs/product/kernel_compatibility.md`
- Licensing boundary: `docs/product/licensing_boundary.md`
- Monthly changelog: `docs/product/CHANGELOG_2026_02.md`
- Packs index: `PACKS.md`

## Start Here (5 commands)
```bash
cd kernel/user/stage3/case17_do_filp_open_deep_trace
make
sudo insmod ./driver.ko target_comm=openat_raw target_name=missing_case17_raw_syscall
./openat_raw
sudo dmesg | tail -n 200
```

## Terminal Screencast
- File: `docs/product/case17_quick_demo.typescript`
- Note: terminal cast format for now (no paid video tooling required)

## Buy / Support
- GitHub Sponsors (when enabled)
- Private case packs and review sessions
