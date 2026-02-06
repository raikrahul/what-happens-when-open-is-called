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

static char *SYMBOL_OPEN = "do_filp_open";
static char *SYMBOL_ALLOC = "__d_alloc";
static char *SYMBOL_LOOKUP = "d_lookup";
static char *SYMBOL_HASH = "full_name_hash";

/* Robust struct filename matches kernel definition for 6.8+ */
struct my_filename {
  const char *name;
  const __user char *uptr;
  int refcnt;
  struct qstr name_attr;
};

static struct kprobe kp_open, kp_alloc, kp_lookup;
static struct kretprobe rp_open, rp_alloc, rp_lookup, rp_hash;

static char *target_comm = "matrix_open";
module_param(target_comm, charp, 0644);

static inline int is_target(void) {
  return (strcmp(current->comm, target_comm) == 0);
}

static int open_entry(struct kprobe *p, struct pt_regs *regs) {
  struct my_filename *f = (struct my_filename *)regs->si;
  if (is_target() && f && (unsigned long)f > 0xffff000000000000 && f->name &&
      (unsigned long)f->name > 0xffff000000000000) {
    pr_info("[O] IN: 0x%px | %s\n", f->name, f->name);
  }
  return 0;
}

static int open_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct file *f = (struct file *)regs->ax;
  if (is_target() && !IS_ERR(f) && f &&
      (unsigned long)f > 0xffff000000000000 && f->f_path.dentry) {
    void *n = (void *)f->f_path.dentry->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000) {
      pr_info("[O] OUT: 0x%px | %s\n", n, (char *)n);
    }
  }
  return 0;
}

static int alloc_entry(struct kprobe *p, struct pt_regs *regs) {
  struct qstr *q = (struct qstr *)regs->si;
  if (is_target() && q && (unsigned long)q > 0xffff000000000000 && q->name &&
      (unsigned long)q->name > 0xffff000000000000) {
    /* dump_stack() removed for safety. Pure axial address logging only. */
    pr_info("[A] SRC: 0x%px\n", q->name);
  }
  return 0;
}

static int alloc_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->ax;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000) {
      pr_info("[A] DST: 0x%px\n", n);
    }
  }
  return 0;
}

static int lookup_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->ax;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000) {
      pr_info("[L] HIT: 0x%px | %s\n", n, (char *)n);
    }
  }
  return 0;
}

static int lookup_entry(struct kprobe *p, struct pt_regs *regs) {
  struct qstr *q = (struct qstr *)regs->si;
  if (is_target() && q && (unsigned long)q > 0xffff000000000000 && q->name &&
      (unsigned long)q->name > 0xffff000000000000) {
    pr_info("[L] HASH: %u %u %s\n", q->hash, q->len, q->name);
  }
  return 0;
}

struct hash_entry_data {
  const char *name;
  unsigned int len;
  unsigned long salt;
};

static int hash_entry(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct hash_entry_data *d = (struct hash_entry_data *)ri->data;
  d->salt = (unsigned long)regs->di;
  d->name = (const char *)regs->si;
  d->len = (unsigned int)regs->dx;
  return 0;
}

static int hash_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct hash_entry_data *d = (struct hash_entry_data *)ri->data;
  unsigned int h = (unsigned int)regs->ax;
  if (is_target() && d->name && (unsigned long)d->name > 0xffff000000000000) {
    pr_info("[H] %u %u 0x%px %s\n", h, d->len, (void *)d->salt, d->name);
  }
  return 0;
}

static int __init trace_do_filp_open_init(void) {
  int r;
  kp_open.symbol_name = SYMBOL_OPEN;
  kp_open.pre_handler = open_entry;
  if ((r = register_kprobe(&kp_open)) < 0)
    return r;

  rp_open.kp.symbol_name = SYMBOL_OPEN;
  rp_open.handler = open_ret;
  rp_open.maxactive = 20;
  if ((r = register_kretprobe(&rp_open)) < 0)
    goto e1;

  kp_alloc.symbol_name = SYMBOL_ALLOC;
  kp_alloc.pre_handler = alloc_entry;
  if ((r = register_kprobe(&kp_alloc)) < 0)
    goto e2;

  rp_alloc.kp.symbol_name = SYMBOL_ALLOC;
  rp_alloc.handler = alloc_ret;
  rp_alloc.maxactive = 20;
  if ((r = register_kretprobe(&rp_alloc)) < 0)
    goto e3;

  rp_lookup.kp.symbol_name = SYMBOL_LOOKUP;
  rp_lookup.handler = lookup_ret;
  rp_lookup.maxactive = 20;
  if ((r = register_kretprobe(&rp_lookup)) < 0)
    goto e4;

  kp_lookup.symbol_name = SYMBOL_LOOKUP;
  kp_lookup.pre_handler = lookup_entry;
  if ((r = register_kprobe(&kp_lookup)) < 0)
    goto e5;

  rp_hash.kp.symbol_name = SYMBOL_HASH;
  rp_hash.handler = hash_ret;
  rp_hash.entry_handler = hash_entry;
  rp_hash.data_size = sizeof(struct hash_entry_data);
  rp_hash.maxactive = 20;
  if ((r = register_kretprobe(&rp_hash)) < 0)
    goto e6;

  return 0;
e6:
  unregister_kprobe(&kp_lookup);
e5:
  unregister_kretprobe(&rp_lookup);
e4:
  unregister_kretprobe(&rp_alloc);
e3:
  unregister_kprobe(&kp_alloc);
e2:
  unregister_kretprobe(&rp_open);
e1:
  unregister_kprobe(&kp_open);
  return r;
}

static void __exit trace_do_filp_open_exit(void) {
  unregister_kretprobe(&rp_hash);
  unregister_kprobe(&kp_lookup);
  unregister_kretprobe(&rp_lookup);
  unregister_kretprobe(&rp_alloc);
  unregister_kprobe(&kp_alloc);
  unregister_kretprobe(&rp_open);
  unregister_kprobe(&kp_open);
}

module_init(trace_do_filp_open_init);
module_exit(trace_do_filp_open_exit);
