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
static char *SYMBOL_D_LOOKUP = "__d_lookup";
static char *SYMBOL_D_LOOKUP_RCU = "__d_lookup_rcu";
static char *SYMBOL_HASH = "full_name_hash";
static char *SYMBOL_ADD = "d_add";
static char *SYMBOL_D_ADD = "__d_add";
static char *SYMBOL_ADD_CI = "d_add_ci";
static char *SYMBOL_REHASH = "d_rehash";
static char *SYMBOL_DELETE = "d_delete";
static char *SYMBOL_DROP = "d_drop";
static char *SYMBOL_DPUT = "dput";
static char *SYMBOL_DENTRY_KILL = "__dentry_kill";

/* Robust struct filename matches kernel definition for 6.8+ */
struct my_filename {
  const char *name;
  const __user char *uptr;
  int refcnt;
  struct qstr name_attr;
};

static struct kprobe kp_open, kp_alloc, kp_lookup;
static struct kprobe kp_d_lookup, kp_d_lookup_rcu;
static struct kprobe kp_add, kp_d_add, kp_add_ci, kp_rehash;
static struct kprobe kp_delete, kp_dput, kp_dentry_kill;
static struct kprobe kp_drop;
static struct kretprobe rp_open, rp_alloc, rp_lookup, rp_hash;
static int kp_d_lookup_reg;
static int kp_d_lookup_rcu_reg;

static char *target_comm = "matrix_open";
module_param(target_comm, charp, 0644);

static inline int is_target(void) {
  return (strcmp(current->comm, target_comm) == 0);
}

static inline int is_name_of_interest(const char *n) {
  if (!n)
    return 0;
  if (strcmp(n, "l_e.txt") == 0)
    return 1;
  if (strcmp(n, "t_e.txt") == 0)
    return 1;
  if (strcmp(n, "l_m.txt") == 0)
    return 1;
  if (strcmp(n, "t_m.txt") == 0)
    return 1;
  if (strcmp(n, "a.txt") == 0)
    return 1;
  if (strncmp(n, "test_file_very_long_name_to_force_external_allocation_",
              57) == 0)
    return 1;
  return 0;
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
  if (!is_target())
    return 0;
  if (!d || IS_ERR(d)) {
    pr_info("d_lookup return: NULL\n");
    return 0;
  }
  if ((unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000)
      pr_info("d_lookup return: 0x%px | %s\n", n, (char *)n);
  }
  return 0;
}

static int lookup_entry(struct kprobe *p, struct pt_regs *regs) {
  struct qstr *q = (struct qstr *)regs->si;
  if (is_target() && q && (unsigned long)q > 0xffff000000000000 && q->name &&
      (unsigned long)q->name > 0xffff000000000000) {
    pr_info("d_lookup entry: hash %u length %u name %s\n", q->hash, q->len,
            q->name);
  }
  return 0;
}

static int d_lookup_entry(struct kprobe *p, struct pt_regs *regs) {
  struct qstr *q = (struct qstr *)regs->si;
  if (is_target() && q && (unsigned long)q > 0xffff000000000000 && q->name &&
      (unsigned long)q->name > 0xffff000000000000) {
    pr_info("__d_lookup entry: hash %u length %u name %s\n", q->hash, q->len,
            q->name);
  }
  return 0;
}

static int d_lookup_rcu_entry(struct kprobe *p, struct pt_regs *regs) {
  struct qstr *q = (struct qstr *)regs->si;
  if (is_target() && q && (unsigned long)q > 0xffff000000000000 && q->name &&
      (unsigned long)q->name > 0xffff000000000000) {
    pr_info("__d_lookup_rcu entry: hash %u length %u name %s\n", q->hash,
            q->len, q->name);
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
    pr_info("full_name_hash return: %u length %u salt 0x%px name %s\n", h,
            d->len, (void *)d->salt, d->name);
  }
  return 0;
}

static int add_entry(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->di;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000)
      pr_info("d_add entry: 0x%px | %s\n", n, (char *)n);
  }
  return 0;
}

static int d_add_entry(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->di;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000)
      pr_info("__d_add entry: 0x%px | %s\n", n, (char *)n);
  }
  return 0;
}

static int add_ci_entry(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->di;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000)
      pr_info("d_add_ci entry: 0x%px | %s\n", n, (char *)n);
  }
  return 0;
}

static int rehash_entry(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->di;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000)
      pr_info("d_rehash entry: 0x%px | %s\n", n, (char *)n);
  }
  return 0;
}

static int delete_entry(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->di;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000 &&
        is_name_of_interest((char *)n))
      pr_info("d_delete entry: 0x%px | %s\n", n, (char *)n);
  }
  return 0;
}

static int drop_entry(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->di;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000 &&
        is_name_of_interest((char *)n))
      pr_info("d_drop entry: 0x%px | %s\n", n, (char *)n);
  }
  return 0;
}

static int dput_entry(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->di;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000 &&
        is_name_of_interest((char *)n))
      pr_info("dput entry: 0x%px | %s\n", n, (char *)n);
  }
  return 0;
}

static int dentry_kill_entry(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *d = (struct dentry *)regs->di;
  if (is_target() && d && (unsigned long)d > 0xffff000000000000) {
    void *n = (void *)d->d_name.name;
    if (n && (unsigned long)n > 0xffff000000000000 &&
        is_name_of_interest((char *)n))
      pr_info("__dentry_kill entry: 0x%px | %s\n", n, (char *)n);
  }
  return 0;
}

static int __init trace_do_filp_open_init(void) {
  int r;
  int add_ok = 0;
  int d_add_ok = 0;
  int add_ci_ok = 0;
  int rehash_ok = 0;
  int del_ok = 0;
  int drop_ok = 0;
  int dput_ok = 0;
  int kill_ok = 0;
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

  kp_d_lookup.symbol_name = SYMBOL_D_LOOKUP;
  kp_d_lookup.pre_handler = d_lookup_entry;
  if (register_kprobe(&kp_d_lookup) == 0)
    kp_d_lookup_reg = 1;

  kp_d_lookup_rcu.symbol_name = SYMBOL_D_LOOKUP_RCU;
  kp_d_lookup_rcu.pre_handler = d_lookup_rcu_entry;
  if (register_kprobe(&kp_d_lookup_rcu) == 0)
    kp_d_lookup_rcu_reg = 1;

  kp_add.symbol_name = SYMBOL_ADD;
  kp_add.pre_handler = add_entry;
  if ((r = register_kprobe(&kp_add)) == 0)
    add_ok = 1;

  kp_d_add.symbol_name = SYMBOL_D_ADD;
  kp_d_add.pre_handler = d_add_entry;
  if ((r = register_kprobe(&kp_d_add)) == 0)
    d_add_ok = 1;

  kp_add_ci.symbol_name = SYMBOL_ADD_CI;
  kp_add_ci.pre_handler = add_ci_entry;
  if ((r = register_kprobe(&kp_add_ci)) == 0)
    add_ci_ok = 1;

  kp_rehash.symbol_name = SYMBOL_REHASH;
  kp_rehash.pre_handler = rehash_entry;
  if ((r = register_kprobe(&kp_rehash)) == 0)
    rehash_ok = 1;

  kp_delete.symbol_name = SYMBOL_DELETE;
  kp_delete.pre_handler = delete_entry;
  if ((r = register_kprobe(&kp_delete)) == 0)
    del_ok = 1;

  kp_drop.symbol_name = SYMBOL_DROP;
  kp_drop.pre_handler = drop_entry;
  if ((r = register_kprobe(&kp_drop)) == 0)
    drop_ok = 1;

  kp_dput.symbol_name = SYMBOL_DPUT;
  kp_dput.pre_handler = dput_entry;
  if ((r = register_kprobe(&kp_dput)) == 0)
    dput_ok = 1;

  kp_dentry_kill.symbol_name = SYMBOL_DENTRY_KILL;
  kp_dentry_kill.pre_handler = dentry_kill_entry;
  if ((r = register_kprobe(&kp_dentry_kill)) == 0)
    kill_ok = 1;

  rp_hash.kp.symbol_name = SYMBOL_HASH;
  rp_hash.handler = hash_ret;
  rp_hash.entry_handler = hash_entry;
  rp_hash.data_size = sizeof(struct hash_entry_data);
  rp_hash.maxactive = 20;
  if ((r = register_kretprobe(&rp_hash)) < 0)
    goto e6;

  if (!add_ok)
    pr_info("optional probe not registered: %s\n", SYMBOL_ADD);
  if (!d_add_ok)
    pr_info("optional probe not registered: %s\n", SYMBOL_D_ADD);
  if (!add_ci_ok)
    pr_info("optional probe not registered: %s\n", SYMBOL_ADD_CI);
  if (!rehash_ok)
    pr_info("optional probe not registered: %s\n", SYMBOL_REHASH);
  if (!del_ok)
    pr_info("optional probe not registered: %s\n", SYMBOL_DELETE);
  if (!drop_ok)
    pr_info("optional probe not registered: %s\n", SYMBOL_DROP);
  if (!dput_ok)
    pr_info("optional probe not registered: %s\n", SYMBOL_DPUT);
  if (!kill_ok)
    pr_info("optional probe not registered: %s\n", SYMBOL_DENTRY_KILL);
  if (!kp_d_lookup_reg)
    pr_info("optional probe not registered: %s\n", SYMBOL_D_LOOKUP);
  if (!kp_d_lookup_rcu_reg)
    pr_info("optional probe not registered: %s\n", SYMBOL_D_LOOKUP_RCU);

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
  if (kp_d_lookup_rcu_reg)
    unregister_kprobe(&kp_d_lookup_rcu);
  if (kp_d_lookup_reg)
    unregister_kprobe(&kp_d_lookup);
  unregister_kprobe(&kp_dentry_kill);
  unregister_kprobe(&kp_dput);
  unregister_kprobe(&kp_drop);
  unregister_kprobe(&kp_delete);
  unregister_kprobe(&kp_rehash);
  unregister_kprobe(&kp_add_ci);
  unregister_kprobe(&kp_d_add);
  unregister_kprobe(&kp_add);
  unregister_kprobe(&kp_lookup);
  unregister_kretprobe(&rp_lookup);
  unregister_kretprobe(&rp_alloc);
  unregister_kprobe(&kp_alloc);
  unregister_kretprobe(&rp_open);
  unregister_kprobe(&kp_open);
}

module_init(trace_do_filp_open_init);
module_exit(trace_do_filp_open_exit);
