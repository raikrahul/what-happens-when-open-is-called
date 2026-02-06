/*
 * TRACE DRIVER
 * ============
 *
 * TARGET 1: do_filp_open (fs/namei.c) [Addr: 0xffffffffacbde3a0]
 * Returns: struct file *
 * Args:    int dfd, struct filename *pathname, const struct open_flags *op
 * Logic:   Main entry point for opening files.
 * Interest:
 *   - ENTRY: Capture (struct filename *)->name [INPUT]
 *   - RET:   Capture (struct file *)->f_path.dentry->d_name.name [OUTPUT]
 *
 * TARGET 2: __d_alloc (fs/dcache.c) [Addr: 0xffffffffacbe9370]
 * Returns: struct dentry *
 * Args:    struct super_block *sb, const struct qstr *name
 * Logic:   Allocates dentry memory and copies the filename string.
 * Interest:
 *   - ENTRY: Capture (struct qstr *)->name [MEMCPY SRC]
 *   - RET:   Capture (struct dentry *)->d_name.name [MEMCPY DEST]
 *
 * PROOF:
 * INPUT (do_filp_open) == MEMCPY SRC (__d_alloc)
 * MEMCPY DEST (__d_alloc) == OUTPUT (do_filp_open)
 */

#include <linux/dcache.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/path.h>
#include <linux/ptrace.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <linux/types.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Antigravity");

/*
 * TRACED SYMBOLS
 * ==============
 * Readers can see exactly what we are hooking here.
 */
static char *SYMBOL_OPEN = "do_filp_open";
static char *SYMBOL_ALLOC = "__d_alloc";

struct my_filename {
  const char *name;
  const __user char *uptr;
  int refcnt;
};

static struct kprobe kp_open, kp_alloc;
static struct kretprobe rp_open, rp_alloc;
#define TARGET_COMM "minimal_open"

static inline int is_target(void) {
  return (strcmp(current->comm, TARGET_COMM) == 0);
}

// 1. do_filp_open ENTRY
// AXIOM: x86_64 ABI -> Arg 1: RDI, Arg 2: RSI, Arg 3: RDX.
// TARGET: do_filp_open(int dfd, struct filename *pathname, ...)
// RSI = Address of (struct filename) object.
// struct filename { const char *name; ... } -> name is at offset 0.
static int open_entry(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  /*
   * TODO [01]: ENTRY IDENTIFICATION
   * -------------------------------
   * AXIOM: x86_64 ABI -> Arg 1: RDI, Arg 2: RSI.
   * THE WHY: We catch the process at the handover point.
   * THE SURPRISE: RSI is NOT a 'char *'. It is a 'struct filename *'.
   *
   * TASK:
   * 1. Extract 'struct my_filename *' from RSI.
   * 2. Print: "[trace_open] Input Addr: 0x%px | Val: %s\n", f->name, f->name
   */

  return 0;
}

// 1. do_filp_open RET
// AXIOM: x86_64 ABI -> Return value resides in RAX.
// TARGET: struct file *
// NESTED CHAIN: file -> f_path (offset 0x38) -> dentry -> d_name (offset 0x28)
// -> name (offset 0x08)
static int open_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  /*
   * TODO [02]: THE GENTLEMEN'S CHAIN
   * -------------------------------
   * AXIOM: x86_64 ABI -> Return value resides in RAX.
   * THE WHY: Settlement point. The string has moved to the Dentry Cache.
   * THE SURPRISE: The original RSI address is no longer relevant for identity.
   *
   * TASK:
   * 1. Extract 'struct file *' from RAX.
   * 2. Implement the manual dereference chain:
   *    Chain: f -> f_path.dentry -> d_name.name
   * 3. Print: "[trace_open] Result Addr: 0x%px | Val: %s\n", name_ptr, name_ptr
   *
   * RAW DATA (Offsets):
   * f_path: RAX + 0x38
   * dentry: Read at f_path + 0x08
   * d_name: Read at dentry + 0x28
   * name:   Read at d_name + 0x08
   */

  return 0;
}

// 2. __d_alloc ENTRY: Capture Memcpy Source
// AXIOM: __d_alloc(struct super_block *sb, const struct qstr *name)
// RSI = Address of (struct qstr) 'name' object.
// struct qstr { unsigned int hash; unsigned int len; const char *name; }
// name->name is at offset 0x08.
static int alloc_entry(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  // TODO [03]:
  // 01. Extract 'struct qstr *' from RSI.
  // 02. Print the address of the source string (q->name).

  return 0;
}

// 2. __d_alloc RET
// TARGET: struct dentry *
// dentry->d_name.name is the destination buffer.
static int alloc_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  // TODO [04]:
  // 01. Extract 'struct dentry *' from RAX.
  // 02. Print the address of the destination string.

  return 0;
}

static int __init trace_do_filp_open_init(void) {
  int ret;

  kp_open.symbol_name = SYMBOL_OPEN;
  kp_open.pre_handler = open_entry;
  if ((ret = register_kprobe(&kp_open)) < 0)
    return ret;

  rp_open.kp.symbol_name = SYMBOL_OPEN;
  rp_open.handler = open_ret;
  rp_open.maxactive = 20;
  if ((ret = register_kretprobe(&rp_open)) < 0)
    goto err1;

  kp_alloc.symbol_name = SYMBOL_ALLOC;
  kp_alloc.pre_handler = alloc_entry;
  if ((ret = register_kprobe(&kp_alloc)) < 0)
    goto err2;

  rp_alloc.kp.symbol_name = SYMBOL_ALLOC;
  rp_alloc.handler = alloc_ret;
  rp_alloc.maxactive = 20;
  if ((ret = register_kretprobe(&rp_alloc)) < 0)
    goto err3;

  return 0;

err3:
  unregister_kprobe(&kp_alloc);
err2:
  unregister_kretprobe(&rp_open);
err1:
  unregister_kprobe(&kp_open);
  return ret;
}

static void __exit trace_do_filp_open_exit(void) {
  unregister_kretprobe(&rp_alloc);
  unregister_kprobe(&kp_alloc);
  unregister_kretprobe(&rp_open);
  unregister_kprobe(&kp_open);
}

module_init(trace_do_filp_open_init);
module_exit(trace_do_filp_open_exit);
