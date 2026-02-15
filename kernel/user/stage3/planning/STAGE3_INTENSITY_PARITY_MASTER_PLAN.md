# Stage3 Intensity Parity Master Plan (Planning Only)

Date: 2026-02-15
Mode: Planning only. No implementation in this document.

## 1) Problem Statement (inside-out)
- Required outcome: Stage3 content quality and depth must match Stage1/Stage2 intensity.
- Scope unit: each Stage3 case page must have parity across Explanation/Textbook/Worksheet/Proof.
- Scale: Stage3 has 16 active case IDs in web map (`1..8,10..17`) plus artifact-rich backend coverage (41 pair runs).
- Constraint: add proofs per stage/sub-stage, plus new drivers and new userspace programs where evidence is weak.

## 2) Baseline Data (measured, no action)
- Stage1 explanation html: 878 lines, 21488 chars.
- Stage1 worksheet html: 876 lines, 26721 chars.
- Stage2 explanation html: 333 lines, 11024 chars.
- Stage2 worksheet html: 359 lines, 11119 chars.
- Stage2b explanation html: 308 lines, 15535 chars.
- Stage2b worksheet html: 436 lines, 17215 chars.
- Stage3 case structures currently mostly uniform file counts (`md=4/html=4`, case1 has 5/5).
- Gap question: structural uniformity exists; depth uniformity is unknown.

## 3) Inside-Out Work Decomposition

### 3.1 Core Quality Axes
- Axis A: factual density per page.
- Axis B: derivation depth per page.
- Axis C: reproducibility of proof claims.
- Axis D: trace-to-claim closure (claim line linked to probe evidence line).
- Axis E: exercise hardness progression (base -> axiom -> hard).
- Axis F: cross-case comparability (same metrics across cases).

### 3.2 Minimum Deliverables Per Case
- D1: Explanation page with branch-level narrative + proof hooks.
- D2: Textbook page with invariant list + evidence mapping table.
- D3: Worksheet page with hand-trace instructions + numeric checks.
- D4: Proof page with command list, outputs, and pass/fail marks.
- D5: Dedicated driver variant for case-specific signal.
- D6: Dedicated userspace trigger aligned to one claim set.
- D7: Case summary report tying D1..D6.

### 3.3 Minimum Deliverables Per Sub-Stage (E/T/W/P)
- E: “what path branch happened” with links to real logs.
- T: “why branch is valid” with invariants and constraints.
- W: “what user calculates” with explicit arithmetic tasks.
- P: “what command reproduces claim” with raw output pointers.

## 4) Counter-Question Matrix (grilling tasks, no solutions)

### 4.1 Scope Questions
- Q1: Should Stage3 include case9 placeholder as real case or remain reserved?
- Q2: Should case16 be one page or split into `16a do_filp_open` and `16b do_sys_openat2`?
- Q3: Should case8 remain one case with 7 userspace binaries or split into 8a..8g?
- Q4: Should `case0_misc` be public learning content or internal artifact only?

### 4.2 Proof Questions
- Q5: What is the proof granularity: per function call, per branch, or per syscall?
- Q6: Does each claim require one probe pair or two independent probe paths?
- Q7: Which claims require negative proof (what did NOT happen)?
- Q8: Must each proof include one failure trace and one success trace?

### 4.3 Quality Questions
- Q9: What numeric threshold defines “Stage1/2 parity” in depth terms?
- Q10: Is parity measured by page length, invariant count, or exercise hardness?
- Q11: Should each worksheet have fixed number of orthogonal calculations?
- Q12: Should each case include one cross-case comparison table?

### 4.4 Engineering Questions
- Q13: How many new drivers are mandatory vs optional?
- Q14: Do we fork one driver per claim or one driver per case?
- Q15: What triggers new userspace code creation instead of reusing existing binaries?
- Q16: How do we prevent probe bloat and kernel instability while increasing depth?

### 4.5 Publication Questions
- Q17: Should all raw dmesg logs be public?
- Q18: Should heavy proof artifacts stay in repo but only summarized on site?
- Q19: Should Stage3 index show maturity labels (`draft`, `verified`, `teaching-ready`)?
- Q20: Should paid pack and open docs share identical depth or staggered depth?

## 5) Case-by-Case Planning Ledger (tasks expected, no implementation)

### Case 1
- Check existing proof richness vs Stage1 baseline.
- Audit current `proofs.md` uniqueness and reusability.
- Determine whether new driver needed for branch not yet isolated.
- Define two new worksheet orthogonal tasks.

### Case 2
- Validate deep miss claim closure to dcache miss evidence.
- Check if negative dentry proof is explicit and reproducible.
- Decide if extra userspace path variants are required.
- Define one failure-mode table.

### Case 3
- Validate deep hit path vs miss contrast.
- Ensure cache-hit indicators are explicit.
- Add requirement for hit/miss side-by-side proof table.
- Decide if retprobe-only evidence is enough.

### Case 4
- Validate create flow branch ownership.
- Ensure create permission checks are isolated.
- Determine new userspace permutations (`O_CREAT/O_EXCL` combos).
- Define proof for create success and create denial.

### Case 5
- Validate mount-jump semantics.
- Determine proof boundaries across mount namespace assumptions.
- Define branch table for `follow_managed` transitions.
- Decide if additional mount test fixture is required.

### Case 6
- Validate symlink loop proof and ELOOP closure.
- Ensure loop counter visibility in logs.
- Define two loop-edge worksheet tasks.
- Decide if dedicated loop-depth userspace generator needed.

### Case 7
- Validate fast symlink resolve path.
- Ensure distinction from case6 loop branch.
- Define speed/path-depth comparative table.
- Decide whether one more probe around `step_into` needed.

### Case 8
- Validate multi-program case coherence.
- Partition claims by program subtype (create/rename/hash collision).
- Define one proof bundle per subtype.
- Decide if one aggregated page reduces clarity.

### Case 10
- Validate rename investigation baseline.
- Ensure rename lock behavior evidence.
- Define before/after name-state worksheet tasks.
- Decide if cross-directory rename variant needed.

### Case 11
- Validate bulk rename scaling claims.
- Ensure repeated-operation counters and invariants.
- Define batch-size stress worksheet.
- Decide whether to add high-N userspace generator.

### Case 12
- Validate harder puzzle claim boundaries.
- Ensure puzzle invariants explicitly testable.
- Define anti-memorization worksheet tasks.
- Decide if puzzle checker driver must be case-specific.

### Case 13
- Validate salt avalanche/hash sensitivity claims.
- Ensure hash input/output lines are recorded.
- Define arithmetic-based hash comparison worksheet.
- Decide if deterministic seed exposure is required.

### Case 14
- Validate symmetry break claim with paired inputs.
- Ensure both symmetric and asymmetric paths are logged.
- Define mirrored-input worksheet checks.
- Decide if additional collision fixture needed.

### Case 15
- Validate deep trace depth progression.
- Ensure depth-indexed logs and termination conditions.
- Define long-path worksheet with pass counters.
- Decide if path-depth auto-generator required.

### Case 16
- Split planning internally into 16A and 16B.
- Validate call-front (do_sys_openat2) vs deep-open (do_filp_open) claims.
- Define bridge table from syscall-level to lower path-level evidence.
- Decide if two separate web cases improve clarity.

### Case 17
- Validate missing-file deep trace and dentry lingering claims.
- Ensure allocation-before-error proof closure is strict.
- Define pointer-class worksheet tasks and failure prediction table.
- Decide if extra proof around cache persistence window needed.

## 6) Proof Model Planning (no commands executed here)
- PM1: Every claim must map to at least one `entry` and one `ret` event.
- PM2: Every claim must have explicit contradiction condition.
- PM3: Every contradiction must map to remediation task.
- PM4: Every case must include reproducible command block and expected signature block.
- PM5: Every case must include pass/fail scorecard with thresholds.

## 7) New Driver Planning Envelope (no implementation)
- Driver tier G0: baseline probes (already broad).
- Driver tier G1: branch-isolation drivers per case.
- Driver tier G2: contradiction drivers (prove non-occurrence).
- Driver tier G3: stress/scale drivers for heavy cases (8/11/15).
- Planning question: exact symbol set per tier and per case.

## 8) New Userspace Program Planning Envelope (no implementation)
- User tier U0: existing trigger programs.
- User tier U1: variant generators for flags/path depth/name patterns.
- User tier U2: adversarial inputs for contradiction proof.
- User tier U3: deterministic replay harness for CI.
- Planning question: case-by-case minimal additions vs overproduction risk.

## 9) Quality Intensity Rubric Draft (planning)
- R1: invariant count per case page.
- R2: numeric exercises per worksheet.
- R3: independent proof paths per claim.
- R4: failure prediction coverage.
- R5: cross-case compare matrix presence.
- R6: reproducibility score (fresh machine runability).
- R7: reader effort score (how much hand work required).

## 10) Error Ledger Planning (to be filled during execution)
For each error discovered during execution, record:
- `file:line` -> wrong -> should be
- why sloppy -> what missed -> prevent rule
- proof impact -> coverage impact -> user confusion risk

## 11) Execution Gates (planning only)
- Gate A: case page completeness (E/T/W/P all present).
- Gate B: proof closure (claim -> evidence line -> pass/fail).
- Gate C: worksheet hardness (base + axiom + hard).
- Gate D: naming integrity (no anomalous folder aliases).
- Gate E: rerun stability (full sweep pass).
- Gate F: publication parity (site links match repository artifacts).

## 12) Counter-Risk Planning
- Risk: content volume rises but depth doesn’t rise.
- Risk: generated pages become repetitive and low signal.
- Risk: proofs become opaque to readers.
- Risk: kernel safety issues from too many probes.
- Risk: stale links after renames.
- Risk: branch mismatch (`main` vs `gh-pages`) causing false-live state.

## 13) Validation Planning
- V1: local site render validation.
- V2: live URL link-status validation.
- V3: artifact-path existence validation.
- V4: per-case proof-file completeness validation.
- V5: rerun summary validation against previous snapshot.

## 14) Cargo Planning Note
- Current scan result: no `Cargo.toml` / `Cargo.lock` in repository.
- Planning requirement: keep explicit preflight check in every phase; if Cargo appears later, add Rust build/test gates.

## 15) Phase Plan (planning only)
- Phase P0: finalize rubric + case contracts.
- Phase P1: case-by-case gap audit vs rubric.
- Phase P2: create missing proof artifacts and contradiction checks.
- Phase P3: create new drivers/userspace where audit demands.
- Phase P4: rewrite Stage3 sub-pages to parity depth.
- Phase P5: run full tests + live validation + error ledger closure.
- Phase P6: publish + verify + regression watchlist.

## 16) Open Questions Blocking Execution Start
- OQ1: strict parity target = Stage1 line density or Stage2 pedagogy pattern?
- OQ2: case9 inclusion policy.
- OQ3: public exposure policy for raw logs.
- OQ4: one-driver-per-claim vs one-driver-per-case policy.
- OQ5: expected number of new userspace programs per case.
- OQ6: whether paid-pack-only deep proofs are allowed or all public.

## 17) No-Solution Compliance
- This document is planning-only.
- No driver/user code changes defined here.
- No proof claims marked complete here.
