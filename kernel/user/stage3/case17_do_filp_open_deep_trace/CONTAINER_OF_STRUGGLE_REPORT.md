# Container-Of Struggle Report

## Scope
- Topic: `container_of`, macro parsing, `dentry/sb/parent` reverse mapping.
- Goal: stop guesswork, enforce checks.

## Mistake Log
1. Mistake: treated `member` as type.
- Fact: `member` is field name token.
- Check: `container_of(ptr, struct X, node)` -> `node` is field name.

2. Mistake: thought `sb` pointer can recover unique `parent dentry` by `container_of`.
- Fact: many dentries share one `sb`.
- Result: reverse mapping `sb -> one parent dentry` is not defined.

3. Mistake: mixed up member-slot address with pointed object address.
- Needed by `container_of`: `&obj.member`.
- Had in kernel case: `obj.member` value (pointer target), not member-slot address.

4. Mistake: saw `a=(b)` as suspicious syntax.
- Fact: `a=b` and `a=(b)` are same for simple `b`.
- Macro reason: parsing safety for expression arguments.

5. Mistake: confusion on `typeof(((type *)0)->member)`.
- Fact: compile-time type extraction using struct field token.
- No runtime dereference.

6. Mistake: expected parent in `__d_alloc`.
- Fact: `__d_alloc(sb,name)` has no parent arg.
- Parent attached later in `d_alloc_parallel`.

## Kernel Facts Confirmed
1. `d_alloc_parallel(parent,name,wq)` calls `__d_alloc(parent->d_sb,name)`.
2. In `__d_alloc` return state:
- `dentry->d_parent = dentry`
- `dentry->d_inode = NULL`
3. In `d_alloc_parallel` later:
- `new->d_parent = dget_dlock(parent)`
4. Missing-file proof chain:
- `__d_alloc` shows dentry object created.
- filesystem lookup leaves negative (`d_inode==NULL`).
- `do_filp_open` returns `ERR_PTR(-ENOENT)`.

## Numeric Core
1. `container = member_ptr - offsetof(type, member)`.
2. Works only when `member_ptr == &container.member`.
3. Fails when input is shared target pointer value.

## Your Error Pattern
1. Jumped from pointer value to ownership claim.
2. Reused one arithmetic idea across non-isomorphic pointers.
3. Skipped parse-level macro expansion checks.

## Orthogonal Questions (run every time)
1. Input pointer class?
- member-slot address OR pointed-object address OR shared object address?

2. Cardinality?
- one-to-one OR many-to-one?

3. Recoverability?
- unique inverse exists OR not?

4. Stage?
- allocation-only OR parent-attached OR inode-attached?

5. Proof line?
- which probe line proves each claim?

## Minimal Discipline Rules
1. No claim without one line of code + one line of log.
2. No reverse mapping claim without cardinality check.
3. No macro claim without preprocessor expansion check.
4. No pointer claim without pointer-class label.

## Next Hand Tasks (you write)
1. In driver TODO block, label each pointer as:
- `slot_addr`
- `target_addr`
- `container_addr`

2. Build table per run:
- `run_id`
- `parent`
- `sb`
- `new_dentry`
- `new_dentry->d_parent`
- `inode`
- `filp_ret_err`

3. Write one invariant per run:
- at `__d_alloc` return: `new_dentry->d_parent == new_dentry`
- at `do_filp_open` return (missing file): `err == 2`
