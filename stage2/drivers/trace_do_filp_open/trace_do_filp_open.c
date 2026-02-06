/*
 * TRACE DRIVER: do_filp_open & __d_alloc
 * ======================================
 * Purpose: Axiomatically prove the identity of the file being opened
 * by tracing the data flow from Input (do_filp_open) -> Allocation
 * (__d_alloc) -> Output (struct file).
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
MODULE_DESCRIPTION("Axiomatic proof of filename identity via kprobes");

/*
 * ============================================================================
 * HELPER STRUCTURES
 * ============================================================================
 */

/*
 * struct my_filename:
 * Local definition to access 'name' pointer if struct filename is opaque.
 * Only the first field (const char *name) is strictly required for this trace.
 */
struct my_filename {
  const char *name;
  const __user char *uptr;
  int refcnt;
};

/*
 * struct open_flags:
 * Flags argument structure passed to do_filp_open.
 */
struct open_flags {
  int open_flag;
  umode_t mode;
  int acc_mode;
  int intent;
  int lookup_flags;
};

/*
 * ============================================================================
 * PROBE DEFINITIONS
 * ============================================================================
 */
static struct kprobe kp_open;
static struct kretprobe rp_open;
static struct kprobe kp_alloc;
static struct kretprobe rp_alloc;

#define TARGET_COMM "minimal_open"

/*
 * Helper: Filter to only trace our specific verification program.
 */
static inline int is_target_task(void) {
  return (strcmp(current->comm, TARGET_COMM) == 0);
}

/*
 * ============================================================================
 * PROBE 1: do_filp_open
 * Goal: Capture the INPUT pointer and string.
 * ============================================================================
 */
static int open_entry_handler(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target_task())
    return 0;

  /* AXIOM: RSI holds the 2nd argument (struct filename *) */
  struct my_filename *pathname = (struct my_filename *)regs->si;

  if (pathname && (unsigned long)pathname > 0xffff000000000000) {
    pr_info("[trace_open] Input pathname addr: 0x%px\n", pathname->name);
    pr_info("[trace_open] Input pathname val:  %s\n", pathname->name);
  }
  return 0;
}

static int open_ret_handler(struct kretprobe_instance *ri,
                            struct pt_regs *regs) {
  if (!is_target_task())
    return 0;

  /* AXIOM: RAX holds the return value (struct file *) */
  struct file *ret_file = (struct file *)regs->ax;

  if (!IS_ERR(ret_file) && ret_file->f_path.dentry) {
    struct dentry *dentry = ret_file->f_path.dentry;
    /* PROOF: Dereference final dentry to see if it matches input */
    pr_info("[trace_open] Result dentry name:  0x%px\n", dentry->d_name.name);
    pr_info("[trace_open] Result dentry val:   %s\n", dentry->d_name.name);
  } else if (IS_ERR(ret_file)) {
    pr_info("[trace_open] Failed: %ld\n", PTR_ERR(ret_file));
  }
  return 0;
}

/*
 * ============================================================================
 * PROBE 2: __d_alloc
 * Goal: Capture the MEMCPY source and destination.
 * This proves the bytes moved physically from Input -> Output logic.
 * ============================================================================
 */
static int alloc_entry_handler(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target_task())
    return 0;

  /* AXIOM: RSI holds 2nd arg (struct qstr *name), the source of copy */
  struct qstr *name = (struct qstr *)regs->si;

  if (name) {
    pr_info("[trace_alloc] Copy Source Addr:   0x%px\n", name->name);
    pr_info("[trace_alloc] Copy Source Val:    %s\n", name->name);
  }
  return 0;
}

static int alloc_ret_handler(struct kretprobe_instance *ri,
                             struct pt_regs *regs) {
  if (!is_target_task())
    return 0;

  /* AXIOM: RAX holds return value (struct dentry *), the destination container
   */
  struct dentry *dentry = (struct dentry *)regs->ax;

  if (dentry && !IS_ERR(dentry)) {
    /* PROOF: The dentry->d_name.name buffer is the destination of memcpy */
    pr_info("[trace_alloc] Copy Dest Addr:     0x%px\n", dentry->d_name.name);
    pr_info("[trace_alloc] Copy Dest Val:      %s\n", dentry->d_name.name);
  }
  return 0;
}

/*
 * ============================================================================
 * MODULE MANAGEMENT
 * ============================================================================
 */
static int __init trace_do_filp_open_init(void) {
  int ret;

  /* Register do_filp_open probes */
  kp_open.symbol_name = "do_filp_open";
  kp_open.pre_handler = open_entry_handler;
  ret = register_kprobe(&kp_open);
  if (ret < 0) {
    pr_err("Failed to register kp_open: %d\n", ret);
    return ret;
  }

  rp_open.kp.symbol_name = "do_filp_open";
  rp_open.handler = open_ret_handler;
  rp_open.maxactive = 20;
  ret = register_kretprobe(&rp_open);
  if (ret < 0) {
    pr_err("Failed to register rp_open: %d\n", ret);
    goto err_kp_open;
  }

  /* Register __d_alloc probes */
  kp_alloc.symbol_name = "__d_alloc";
  kp_alloc.pre_handler = alloc_entry_handler;
  ret = register_kprobe(&kp_alloc);
  if (ret < 0) {
    pr_err("Failed to register kp_alloc: %d\n", ret);
    goto err_rp_open;
  }

  rp_alloc.kp.symbol_name = "__d_alloc";
  rp_alloc.handler = alloc_ret_handler;
  rp_alloc.maxactive = 20;
  ret = register_kretprobe(&rp_alloc);
  if (ret < 0) {
    pr_err("Failed to register rp_alloc: %d\n", ret);
    goto err_kp_alloc;
  }

  pr_info("Trace module loaded: monitoring do_filp_open and __d_alloc\n");
  return 0;

/* Error Rollback */
err_kp_alloc:
  unregister_kprobe(&kp_alloc);
err_rp_open:
  unregister_kretprobe(&rp_open);
err_kp_open:
  unregister_kprobe(&kp_open);
  return ret;
}

static void __exit trace_do_filp_open_exit(void) {
  unregister_kretprobe(&rp_alloc);
  unregister_kprobe(&kp_alloc);
  unregister_kretprobe(&rp_open);
  unregister_kprobe(&kp_open);
  pr_info("Trace module unloaded\n");
}

module_init(trace_do_filp_open_init);
module_exit(trace_do_filp_open_exit);
