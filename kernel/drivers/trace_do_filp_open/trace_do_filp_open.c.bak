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
static int open_entry(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target())
    return 0;
  struct my_filename *f = (struct my_filename *)regs->si;
  if (f && (unsigned long)f > 0xffff000000000000)
    pr_info("[trace_open] Input Addr: 0x%px | Val: %s\n", f->name, f->name);
  return 0;
}

// 1. do_filp_open RET
static int open_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (!is_target())
    return 0;
  struct file *f = (struct file *)regs->ax;
  if (!IS_ERR(f) && f->f_path.dentry) {
    struct dentry *d = f->f_path.dentry;
    pr_info("[trace_open] Result Addr: 0x%px | Val: %s\n", d->d_name.name,
            d->d_name.name);
  }
  return 0;
}

// 2. __d_alloc ENTRY: Capture Memcpy Source
static int alloc_entry(struct kprobe *p, struct pt_regs *regs) {
  if (!is_target())
    return 0;
  struct qstr *q = (struct qstr *)regs->si;
  pr_info("[trace_alloc] Copy Source: 0x%px\n", q->name);
  /* Note: We refrain from dump_stack() to avoid kernel crashes */
  return 0;
}

// 2. __d_alloc RET
static int alloc_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (!is_target())
    return 0;
  struct dentry *d = (struct dentry *)regs->ax;
  if (d && !IS_ERR(d))
    pr_info("[trace_alloc] Copy Dest:   0x%px\n", d->d_name.name);
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
