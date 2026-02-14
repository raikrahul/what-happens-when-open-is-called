# Known Breakage by Kernel Version

| Kernel | Status | Notes |
|---|---|---|
| 6.17.0-14-generic | Verified | Case17 probes validated (`do_filp_open`, `d_alloc_parallel`, `__d_alloc`) |
| 6.8.x | Partial | symbols may differ; re-verify probeability before run |
| Other versions | Unknown | run symbol/probe smoke test first |

## Smoke Test
1. module load
2. target trigger run
3. dmesg contains expected chain
4. module unload
