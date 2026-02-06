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

// Module parameters for flexible targeting
static char *target_comm = "minimal_open";
static int target_pid = -1; // -1 means match any PID (use comm only)

module_param(target_comm, charp, 0644);
MODULE_PARM_DESC(target_comm, "Process name to trace (default: minimal_open)");

module_param(target_pid, int, 0644);
MODULE_PARM_DESC(target_pid,
                 "Specific PID to trace (-1 for any PID matching target_comm)");

// Optimized filter: checks PID first (fast integer compare), then comm
// Returns 1 if this is our target process, 0 otherwise
static inline int is_target(void) {
  // Early bail-out: check PID first (faster than string compare)
  if (target_pid != -1 && current->pid != target_pid)
    return 0;

  // Check process name
  return (strcmp(current->comm, target_comm) == 0);
}

// 1. do_filp_open ENTRY: THE HANDOVER
static int open_entry(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  // Extract struct filename pointer from RSI (second argument)
  struct my_filename *f = (struct my_filename *)regs->si;

  // Safety check: Ensure pointer is in kernel space (> 0xffff000000000000)
  // CRITICAL: f->name must also be validated before dereferencing
  if (f && (unsigned long)f > 0xffff000000000000 && f->name &&
      (unsigned long)f->name > 0xffff000000000000) {
    // Print pointer addresses only - NEVER dereference strings in interrupt
    // context Using %s in pr_info would cause page fault if f->name is invalid
    pr_info("[trace_open] Input: struct filename @ 0x%px | name @ 0x%px\n", f,
            f->name);
  }

  return 0;
}

// 1. do_filp_open RET: THE GENTLEMEN'S CHAIN
static int open_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  // 1. do_filp_open RET: THE GENTLEMEN'S CHAIN
  void *file_ptr = (void *)regs->ax;
  if (IS_ERR(file_ptr) || !file_ptr)
    return 0;

  // CHAIN: file -> f_path(+64) -> dentry(+8) -> d_name(+32) -> name(+8)
  void *dentry_ptr = *(void **)((unsigned long)file_ptr + 64 + 8);
  if (dentry_ptr) {
    void *name_ptr = *(void **)((unsigned long)dentry_ptr + 32 + 8);
    if (name_ptr && (unsigned long)name_ptr > 0xffff000000000000) {
      pr_info("[trace_open] Result Name Ptr: 0x%px\n", name_ptr);
    }
  }

  return 0;
}

// 2. __d_alloc ENTRY: THE MEMCPY SOURCE
static int alloc_entry(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  // RSI contains struct qstr * (second argument to __d_alloc)
  // qstr->name is at offset +8 (after hash:4 + len:4)
  void *qstr_ptr = (void *)regs->si;

  // Validate qstr_ptr is in kernel space before dereferencing
  if (!qstr_ptr || (unsigned long)qstr_ptr < 0xffff000000000000)
    return 0;

  // Extract name pointer from qstr (offset +8)
  char **name_ptr = (char **)((unsigned long)qstr_ptr + 8);
  char *name = *name_ptr;

  // Validate name pointer before printing - safety critical in interrupt
  // context
  if (name && (unsigned long)name > 0xffff000000000000) {
    pr_info("[trace_alloc] Copy Source: 0x%px\n", name);
  }

  return 0;
}

// 2. __d_alloc RET: THE SETTLEMENT
static int alloc_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (!is_target())
    return 0;

  // 2. __d_alloc RET: THE SETTLEMENT
  void *dentry_ptr = (void *)regs->ax;
  if (IS_ERR(dentry_ptr) || !dentry_ptr)
    return 0;

  // dentry -> d_name(+32) -> name(+8)
  void *dname_ptr = *(void **)((unsigned long)dentry_ptr + 32 + 8);
  if (dname_ptr && (unsigned long)dname_ptr > 0xffff000000000000) {
    pr_info("[trace_alloc] Copy Dest:   0x%px\n", dname_ptr);
  }

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
