/*
 * TRACE DRIVER: MUSCLE MEMORY CHALLENGE (6.14 KERNEL)
 * =================================================
 *
 * TARGET 1: do_filp_open (0xffffffff817de3a0).
 * WHY: VFS Entry Point. Receives the user-string metadata (The Handover).
 *
 * TARGET 2: __d_alloc (0xffffffff817e9370).
 * WHY: Dentry Allocation. Destination for the filename string (The Settlement).
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

// 1. do_filp_open ENTRY: THE HANDOVER
static int open_entry(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  /*
   * TODO [01]: IDENTIFY THE HANDOVER
   * -------------------------------
   * AXIOM: x86_64 ABI -> Arg 2: RSI.
   * TASK: Extract 'struct my_filename *' from RSI.
   * PRINT: "[trace_open] Input Addr: 0x%px | Val: %s\n", addr, string
   */

  return 0;
}

// 1. do_filp_open RET: THE GENTLEMEN'S CHAIN
static int open_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  /*
   * TODO [02]: MANUAL DEREFERENCE CHAIN
   * ----------------------------------
   * AXIOM: Result residing in RAX.
   * TASK: Follow the pointers using raw offsets (No helper functions).
   * OFFSETS (6.14): f_path: RAX + 64 | dentry: f_path + 8 | d_name: dentry + 32
   * | name: d_name + 8. PRINT: "[trace_open] Result Addr: 0x%px | Val: %s\n",
   * addr, string
   */

  return 0;
}

// 2. __d_alloc ENTRY: THE MEMCPY SOURCE
static int alloc_entry(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  /*
   * TODO [03]: CAPTURE THE SOURCE
   * ----------------------------
   * AXIOM: __d_alloc(struct super_block *sb, const struct qstr *name).
   * RSI = struct qstr *.
   * TASK: Extract the value of 'qstr->name' (offset +8).
   * PRINT: "[trace_alloc] Copy Source: 0x%px\n", addr
   */

  return 0;
}

// 2. __d_alloc RET: THE SETTLEMENT
static int alloc_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  /*
   * TODO [04]: CAPTURE THE DESTINATION
   * -------------------------------
   * AXIOM: RAX = struct dentry *.
   * TASK: Extract the address of dentry->d_shortname.string (offset +56).
   * PRINT: "[trace_alloc] Copy Dest: 0x%px\n", addr
   */

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
