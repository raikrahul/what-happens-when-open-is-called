ERROR DOCUMENTATION: BRUTAL VERBATIM RECORD
Generated: 2026-02-12
Format: No filler. No adjectives. No adverbs. No summaries.

---

DOCUMENTATION SKIPPED:

1. kernel/Documentation/trace/kprobes.rst - Safety and Limitations section
2. kernel/Documentation/core-api/printk-formats.rst - %s usage in atomic context  
3. kernel/Documentation/x86/interrupts.rst - Page fault handling in IRQ
4. include/linux/err.h - IS_ERR() macro purpose and range
5. fs/namei.c:2427-2523 - link_path_walk implementation details
6. fs/namei.c:2526-2631 - path_init implementation details
7. ERROR_AUDIT.md - All 5 compilation errors documented
8. MISTAKES_SESSION_DRIVER_CRASH.md - 30 errors already catalogued
9. Kernel 6.14 changelog - struct file member changes
10. Kernel 6.14 changelog - struct dentry layout changes

---

MISREAD DOCUMENTATION:

Line 41-42: is_target() uses strcmp(current->comm, TARGET_COMM)
Misread: current->comm access safe means all data access safe
Actual: current->comm is safe. f->name is not. Context affects ALL memory access.

Line 50: struct my_filename *f = (struct my_filename *)regs->si
Misread: regs->si contains valid pointer because probe placed correctly
Actual: regs->si contains whatever was in register. No validation performed.

Line 53: if (f && (unsigned long)f > 0xffff000000000000)
Misread: Validation complete
Actual: Validated container pointer. Did not validate contents (f->name).

Line 55-56: pr_info("[trace_open] Input Addr: 0x%px | Val: %s\n", f->name, f->name)
Misread: TODO comment says print with %s, so print with %s
Actual: TODO is instruction, not safety guarantee. Must add validation.

Lines 74-89: Offsets +64, +8, +48, +8
Misread: Offsets correct for kernel 6.14
Actual: No verification with ptype /o in GDB. Assumed without checking.

Line 91: pr_info("[trace_open] Result Addr: 0x%px | Val: %s\n", name, name)
Misread: Same pattern as line 55-56
Actual: Same crash potential. No learning from previous error.

Lines 105-113: __d_alloc entry handler
Misread: qstr_ptr validation sufficient
Actual: name_ptr extracted from qstr_ptr not validated. name not validated.

Lines 130-135: alloc_ret handler  
Misread: IS_ERR(dentry_ptr) and NULL check sufficient
Actual: dname_ptr calculated from dentry_ptr not validated before print.

Line 150, 161: rp_open.maxactive = 20; rp_alloc.maxactive = 20
Misread: 20 is appropriate value
Actual: Default (0) usually sufficient. Value arbitrary, not derived.

Lines 140-174: Module init function
Misread: Return value checks sufficient
Actual: No symbol existence check. No kernel config check. No version check.

---

NOT READ EXACTLY:

ERROR_AUDIT.md Error 4:
"struct file has no member named f_count...replaced by f_ref"
Not read: ALL kernel structs change between versions
Result: Assumed offsets (+48 for d_name) correct without verification

ERROR_AUDIT.md Page 3:
"Error pointers are in range [-4095, -1]"
Not applied: To all extracted pointers (f->name, name, dname_ptr)
Result: Some pointers passed validation that should not have

kprobes.rst (assumed content):
"Kprobe handlers run in atomic context. Any operation that may sleep or fault is forbidden."
Not read: Before writing code
Result: Used %s format specifier (causes fault on bad pointer)

printk-formats.rst (assumed content):
"Avoid using printk format specifiers that may cause memory access like %s in interrupt handlers."
Not read: Until crash occurred
Result: Used %s twice in open_entry, once in open_ret

include/linux/err.h:
"IS_ERR() checks if pointer is in error range [-4095, -1]"
Not read: Exact range definition
Result: Used IS_ERR() for return values but not for extracted pointers

fs/namei.c:2427:
"static int link_path_walk(const char *name, struct nameidata *nd)"
Not read: Implementation details
Result: Did not understand depth tracking, symlink handling, component processing

fs/namei.c:2441-2443:
"if (unlikely(!*name)) { nd->dir_mode = 0; return 0; }"
Not read: Hardening short-circuit logic
Result: Did not understand empty path handling

fs/namei.c:2452:
"err = may_lookup(idmap, nd)"
Not read: Permission check per component
Result: Did not understand why idmap called inside loop

fs/namei.c:2457-2479:
switch(lastword) with LAST_DOTDOT, LAST_DOT, LAST_NORM
Not read: Component classification logic
Result: Did not understand hash_name optimization

fs/namei.c:2507-2521:
Symlink handling with depth tracking
Not read: Stack push/pop logic for nested symlinks
Result: Did not understand depth++ and depth-- operations

---

ORTHOGONAL THOUGHT PROCESS FILE:

See: docs/error_audit_brutal.md

---

QUESTIONS FOR SLOPPY BRAIN:

Why assume pointer valid after validating container?
Why use %s in interrupt context without checking docs?
Why implement TODO comments literally without safety analysis?
Why trust memory over verification?
Why skip documentation that would prevent crash?
Why assume offsets correct without GDB verification?
Why validate some pointers but not others?
Why ignore 30 documented errors in MISTAKES_SESSION_DRIVER_CRASH.md?
Why assume kernel structs immutable?
Why trust TODO comments as safety guarantees?
Why skip kprobes.rst safety section?
Why use arbitrary maxactive value?
Why not verify symbol existence before registration?
Why assume current->comm safe means all access safe?
Why ignore compiler warnings about compiler mismatch?
Why not use probe_kernel_read() for safe memory access?
Why assume f->name at offset 0 without checking struct layout?
Why validate return pointers but not extracted pointers?
Why use permissive kernel space check (> 0xffff000000000000)?
Why not implement graceful degradation on invalid pointers?
Why assume interrupt context same as process context?

---

CODE THAT SHOULD HAVE BEEN WRITTEN:

```c
// Safe pattern (not implemented)
char name_buf[256];
if (probe_kernel_read(name_buf, f->name, sizeof(name_buf)) == 0) {
    pr_info("Name: %s\n", name_buf);
}

// Validation (not implemented)
if (!f || !f->name) {
    pr_info("[trace_open] Warning: invalid input pointer\n");
    return 0;
}

// IS_ERR check (not applied to extracted pointers)
if (IS_ERR(name) || IS_ERR(dname_ptr)) {
    return 0;
}

// Strict kernel space check (not used)
if ((unsigned long)ptr < 0xffff800000000000) {
    return 0;  // User space or invalid
}
```

---

FILES MODIFIED AFTER ERRORS:

trace_do_filp_open.c: Changed %s to %px
trace_do_filp_open.c: Added NULL checks
trace_do_filp_open.c: Added IS_ERR checks

---

STABLE STATE: Unknown. Fix applied. Kernel stability after fix not verified.

---

END OF DOCUMENTATION
