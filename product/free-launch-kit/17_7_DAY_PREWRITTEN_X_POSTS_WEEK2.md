# 7-Day Prewritten X Posts (Week 2: Objection-Driven)

Use these for week 2. Focus: answer objections with hard logs, then route to pro pack.

## Shared Links
- Product page: `https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/docs/product/index.md`
- Free worksheet: `https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/kernel/user/stage3/case17_do_filp_open_deep_trace/worksheet_lingering_dentry_proof.md`
- Objection matrix: `https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/product/free-launch-kit/14_OBJECTION_RESPONSE_MATRIX.md`
- Pro spec: `https://github.com/raikrahul/what-happens-when-open-is-called/blob/main/product/free-launch-kit/13_PRO_CASE_PACK_SPEC.md`

---

## Day 8
### Post A
Objection: “That pointer is stale junk.”

Response:
- no-fault read `rc=0`
- `d_name.hash` matches trace hash
- `d_name.name` bytes match filename

That is not random memory; that is verifiable state.

Worksheet:
<free worksheet link>

### Post B
If you claim stale pointer, provide 3 lines:
1) your target pointer
2) read `rc`
3) recovered `d_name` text

No 3 lines, no claim.

---

## Day 9
### Post A
Objection: “Same pointer proves same object forever.”

No.
Address equality can be allocator reuse.
You need context fields + timeline.

That is why pro pack includes reuse-ambiguity drills.

### Post B
Minimal identity check set:
- pointer
- hash
- len
- parent
- inode
- run timestamp

Anything less is weak evidence.

---

## Day 10
### Post A
Objection: “If `do_filp_open` fails, intermediate steps don’t matter.”

Wrong for forensics.
`ERR_PTR(-ENOENT)` is final result only.
Allocation + lookup state still happened and is inspectable.

### Post B
Proof pattern:
`__d_alloc RET` exists + `do_filp_open RET err=2`

Failure result does not erase intermediate path state.

---

## Day 11
### Post A
Objection: “Hash match is enough to call it same file.”

No.
Need parent + name check.

Same hash can still be wrong candidate.

### Post B
Decision rule:
hash pass + parent pass + name pass + inode context

Only then call it a match.

---

## Day 12
### Post A
Objection: “This only works on your kernel.”

Good objection.
That is why each pack has:
- kernel version
- filesystem
- probeability checks
- smoke test

### Post B
Never trust cross-version claims without rerunning probe chain.
One symbol shift can invalidate the narrative.

Compatibility doc:
<compatibility link>

---

## Day 13
### Post A
Objection: “You are overfitting one case.”

Answer:
- week 1: baseline myth-breakers
- week 2: objection responses
- next: matrix across variants

This is iterative evidence, not one-shot storytelling.

### Post B
Want harder version?
Pro pack focuses on invalidation conditions and edge matrices.

---

## Day 14
### Post A (Week-2 recap)
Week-2 objection wins:
1) stale-pointer objection handled
2) pointer-equality objection handled
3) hash-only objection handled
4) cross-version objection handled

Everything answered with logs + checks.

### Post B (Pro CTA)
If you want decision-ready workflow:
- advanced worksheet
- failure matrix
- anti-crash safety gates

Pro spec:
<pro spec link>

---

## Week-2 Reply Pack
1. `Good objection. Please post pointer + rc + recovered name bytes.`
2. `Address equality alone is insufficient; include parent/hash/len/inode.`
3. `Can you share kernel version and fs type before we compare results?`
4. `I’ll accept your claim if your 3-line proof chain is complete.`
5. `This objection is included in the matrix; I can share the exact check set.`
