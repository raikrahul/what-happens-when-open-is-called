# Failure-First Backlog (30-Day)

Use this as the canonical wrong-claim queue.

## Rule
Each item must map to:
1. one probe chain
2. one worksheet
3. one paid CTA

## Backlog (Top 20)
1. Wrong claim: `ENOENT means no dentry ever existed`.
- Proof target: `__d_alloc RET` + `do_filp_open RET err=2`.
- Free asset: case17 worksheet.
- Paid delta: lingering pointer validation matrix.

2. Wrong claim: `dentry always implies inode`.
- Proof target: `d_inode=0x0` negative dentry examples.
- Free asset: negative dentry table.
- Paid delta: multi-run negative/positive transitions.

3. Wrong claim: `open() failure gives no useful kernel object state`.
- Proof target: qstr hash/len/name on failure path.
- Free asset: hash/len worksheet.
- Paid delta: collision and alias stress set.

4. Wrong claim: `libc noise makes syscall tracing unusable`.
- Proof target: raw `openat` syscall trigger.
- Free asset: `openat_raw` demo.
- Paid delta: side-by-side libc vs raw trace workbook.

5. Wrong claim: `container_of can reverse any pointer relation`.
- Proof target: sb pointer non-unique inverse example.
- Free asset: container_of worksheet.
- Paid delta: pointer-class forensic drills.

6. Wrong claim: `same filename means same dentry forever`.
- Proof target: cache/drop/rebuild runs.
- Free asset: pointer continuity worksheet.
- Paid delta: eviction/reallocation ambiguity matrix.

7. Wrong claim: `hash match proves same file`.
- Proof target: parent mismatch and name checks.
- Free asset: dcache matching rules.
- Paid delta: crafted collision exercises.

8. Wrong claim: `do_filp_open returning ERR_PTR means no intermediate work`.
- Proof target: pre-return allocations and lookup steps.
- Free asset: call chain timeline.
- Paid delta: timeline reconstruction lab.

9. Wrong claim: `kprobes cannot safely inspect pointers`.
- Proof target: no-fault pointer check module.
- Free asset: pointer checker mini driver.
- Paid delta: safe inspection checklist with anti-crash gates.

10. Wrong claim: `if process exits, evidence is gone`.
- Proof target: post-exit pointer check run.
- Free asset: lingering dentry case.
- Paid delta: delayed-read survivability experiments.

11. Wrong claim: `all fs paths hit atomic_open`.
- Proof target: ext4 non-atomic path validation.
- Free asset: function branch map.
- Paid delta: filesystem-variant behavior pack.

12. Wrong claim: `d_lookup miss means no dentry object will exist`.
- Proof target: `d_lookup NULL` then `d_alloc_parallel` then `__d_alloc`.
- Free asset: miss->alloc worksheet.
- Paid delta: race-focused miss path set.

13. Wrong claim: `pointer equality always means object identity over time`.
- Proof target: allocator reuse caveat.
- Free asset: equality caveat note.
- Paid delta: identity-vs-address verification lab.

14. Wrong claim: `one successful trace is sufficient proof`.
- Proof target: multi-run consistency requirements.
- Free asset: run-count checklist.
- Paid delta: confidence scoring worksheet.

15. Wrong claim: `d_parent must be self forever from __d_alloc`.
- Proof target: self at birth, parent attached later.
- Free asset: state transition chart.
- Paid delta: transition timeline exercises.

16. Wrong claim: `qstr name storage is always external`.
- Proof target: inline shortname path for len=30.
- Free asset: storage decision worksheet.
- Paid delta: long-name external buffer tests.

17. Wrong claim: `ENOENT came directly from __d_alloc`.
- Proof target: filesystem lookup and later fail point.
- Free asset: fail-location map.
- Paid delta: per-function error provenance table.

18. Wrong claim: `dentry has backpointer list of open files`.
- Proof target: reverse mapping requires task/fd scan.
- Free asset: ownership direction note.
- Paid delta: safe reverse scan design worksheet.

19. Wrong claim: `all pointer reads are safe if kernel mode`.
- Proof target: no-fault API necessity.
- Free asset: pointer safety snippet.
- Paid delta: crash pattern catalog.

20. Wrong claim: `viral content must be simplified and vague`.
- Proof target: high-detail numeric posts + engagement loop.
- Free asset: failure-first thread template.
- Paid delta: advanced thread pack.
