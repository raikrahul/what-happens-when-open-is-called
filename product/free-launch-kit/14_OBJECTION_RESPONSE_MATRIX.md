# Objection Response Matrix

## Purpose
Map common objections to prebuilt numeric/log responses.

| Objection | Response Check 1 | Response Check 2 | Response Check 3 | Artifact |
|---|---|---|---|---|
| `ENOENT means no dentry` | `__d_alloc RET exists` | `d_inode=0x0` | `do_filp_open err=2` | case17 worksheet |
| `pointer is stale junk` | no-fault read rc=0 | name hash matches trace | name bytes match target | pointer-check log |
| `same pointer proves nothing` | multi-run table required | reuse caveat note | context fields compared | pro matrix |
| `hash match is enough` | parent check required | name check required | inode check required | dcache worksheet |
| `libc ruins trace` | raw syscall trigger run | target_comm filtered | clean 5-line chain | runbook |

## Response SLA
- reply with checks within 24h
- include one direct artifact link
