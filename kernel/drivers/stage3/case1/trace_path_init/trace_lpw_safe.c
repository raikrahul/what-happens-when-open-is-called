/*
 * trace_lpw_safe.c — Stage 3 / Case 1 combined kprobe driver
 *
 * Probed functions (4 functions × 2 probes = 8 probes):
 *   1. link_path_walk   — kprobe  (entry)  + kretprobe (return)
 *   2. walk_component   — kprobe  (entry)  + kretprobe (return)
 *   3. lookup_fast       — kprobe  (entry)  + kretprobe (return)
 *   4. __d_lookup_rcu    — kprobe  (entry)  + kretprobe (return)
 *
 * Note on d_revalidate:
 *   d_revalidate() is declared "static inline" in fs/namei.c:925.
 *   The compiler inlines it into lookup_fast().  No kallsyms symbol
 *   exists, so kprobe cannot attach.  Its effect is visible through
 *   lookup_fast's return value:
 *     - valid dentry ptr → revalidation passed  (or flag absent)
 *     - ERR_PTR(-ECHILD) → revalidation forced non-RCU retry
 *     - NULL             → dcache miss
 *
 *   Source (fs/namei.c:925-932):
 *     static inline int d_revalidate(...)
 *     {
 *         if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
 *             return dentry->d_op->d_revalidate(...);
 *         else
 *             return 1;
 *     }
 */

#include <linux/atomic.h>
#include <linux/dcache.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/namei.h>
#include <linux/path.h>
#include <linux/sched.h>
#include <linux/string.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Stage3 Case1: kprobe tracer for path resolution");

static char *target_comm = "demo_loop";
module_param(target_comm, charp, 0644);

static atomic_t step_counter = ATOMIC_INIT(0);

/* --------------------------------------------------------------------- */
/* Mirror of kernel-internal struct nameidata (6.17.0-14-generic).        */
/* struct nameidata is NOT exported to modules; we replicate its layout.  */
/* --------------------------------------------------------------------- */

#ifndef EMBEDDED_LEVELS
#define EMBEDDED_LEVELS 2
#endif

#ifndef vfsuid_t
typedef struct {
  uid_t val;
} my_vfsuid_t;
#else
typedef vfsuid_t my_vfsuid_t;
#endif

struct my_nameidata {
  struct path path;    /* current lookup position  */
  struct qstr last;    /* last component parsed    */
  struct path root;    /* root of the walk         */
  struct inode *inode; /* inode at current pos     */
  unsigned int flags, state;
  unsigned seq, next_seq, m_seq, r_seq;
  int last_type;
  unsigned depth;
  int total_link_count;
  struct {
    struct path link;
    void *done;
    const char *name;
    unsigned seq;
  } *stack, internal[EMBEDDED_LEVELS];
  void *filename;
  const char *pathname;
  void *saved;
  unsigned root_seq;
  int dfd;
  my_vfsuid_t dir_vfsuid;
  umode_t dir_mode;
};

/* --------------------------------------------------------------------- */
/* helpers                                                                */
/* --------------------------------------------------------------------- */

static const char *get_dname(struct dentry *d) {
  if (!d)
    return "NULL";
  if (!d->d_name.name)
    return "(anon)";
  return (const char *)d->d_name.name;
}

/* Kernel-space strings from nameidata are directly readable. */
static const char *safe_kstr(const char *ptr) {
  if (!ptr)
    return "(null)";
  return ptr;
}

/* ===================================================================== */
/* 1.  link_path_walk  — ENTRY                                           */
/*     Signature: int link_path_walk(const char *name,                   */
/*                                    struct nameidata *nd)               */
/*     Registers: %rdi = name,  %rsi = nd                                */
/* ===================================================================== */

static int kp_lpw_entry(struct kprobe *p, struct pt_regs *regs) {
  int step;
  const char *name;
  struct my_nameidata *nd;

  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  step = atomic_inc_return(&step_counter);
  name = (const char *)regs->di;
  nd = (struct my_nameidata *)regs->si;

  pr_info("#%d.Call [link_path_walk ENTRY]. "
          "Values [name=%px, nd=%px, flags=0x%x, depth=%u]. "
          "Data [CurDir=%s, path=%s].\n",
          step, name, nd, nd->flags, nd->depth, get_dname(nd->path.dentry),
          safe_kstr(name));
  return 0;
}

/* ----- link_path_walk  — RETURN --------------------------------------- */

static int kr_lpw_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  int step, ret;

  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  step = atomic_inc_return(&step_counter);
  ret = regs_return_value(regs);

  pr_info("#%d.Return [link_path_walk]. Ret=%d (%s).\n", step, ret,
          ret ? "ERROR" : "OK");
  return 0;
}

/* ===================================================================== */
/* 2.  walk_component  — ENTRY                                           */
/*     Signature: const char *walk_component(struct nameidata *nd,        */
/*                                           int flags)                   */
/*     Registers: %rdi = nd,  %rsi = flags                               */
/* ===================================================================== */

static int kp_wc_entry(struct kprobe *p, struct pt_regs *regs) {
  int step;
  struct my_nameidata *nd;
  int flags;

  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  step = atomic_inc_return(&step_counter);
  nd = (struct my_nameidata *)regs->di;
  flags = (int)regs->si;

  pr_info("#%d.Call [walk_component SYMBOL]. "
          "Values [nd=%px, flags=0x%x]. "
          "Data [LookingUp=%s, InDir=%s, depth=%u]. "
          "Work [lookup_fast → handle_mounts → step_into].\n",
          step, nd, flags, nd->last.name ? safe_kstr(nd->last.name) : "(none)",
          get_dname(nd->path.dentry), nd->depth);
  return 0;
}

/* ----- walk_component  — RETURN --------------------------------------- */

static int kr_wc_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  void *ret_val;
  int step;

  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  step = atomic_inc_return(&step_counter);
  ret_val = (void *)regs_return_value(regs);

  pr_info("#%d.Return [walk_component SYMBOL]. "
          "Values [ret=%px]. "
          "Data [%s].\n",
          step, ret_val,
          ret_val == NULL   ? "Normal (NULL → not symlink)"
          : IS_ERR(ret_val) ? "Error"
                            : "Symlink pointer returned");
  return 0;
}

/* ===================================================================== */
/* 3.  lookup_fast  — ENTRY                                              */
/*     Signature: static struct dentry *lookup_fast(                     */
/*                    struct nameidata *nd)                               */
/*     Registers: %rdi = nd                                              */
/*                                                                       */
/*     Internally calls:                                                 */
/*       __d_lookup_rcu(parent, &nd->last, &nd->next_seq)  [RCU path]    */
/*       __d_lookup(parent, &nd->last)                     [ref path]    */
/*       d_revalidate(...)                  [INLINED, see header note]   */
/* ===================================================================== */

static int kp_lf_entry(struct kprobe *p, struct pt_regs *regs) {
  int step;
  struct my_nameidata *nd;

  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  step = atomic_inc_return(&step_counter);
  nd = (struct my_nameidata *)regs->di;

  pr_info("#%d.Call [lookup_fast SYMBOL]. "
          "Values [nd=%px, flags=0x%x]. "
          "Data [Parent=%s, Seeking=%s]. "
          "Work [dcache probe via __d_lookup_rcu, then d_revalidate].\n",
          step, nd, nd->flags, get_dname(nd->path.dentry),
          nd->last.name ? safe_kstr(nd->last.name) : "(none)");
  return 0;
}

/* ----- lookup_fast  — RETURN ------------------------------------------ */

static int kr_lf_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct dentry *ret_val;
  int step;

  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  step = atomic_inc_return(&step_counter);
  ret_val = (struct dentry *)regs_return_value(regs);

  pr_info("#%d.Return [lookup_fast SYMBOL]. "
          "Values [ret=%px]. "
          "Data [%s].\n",
          step, ret_val,
          (ret_val && !IS_ERR(ret_val)) ? get_dname(ret_val)
          : (ret_val == NULL)           ? "Cache MISS (NULL)"
                                        : "Error/ECHILD");
  return 0;
}

/* ===================================================================== */
/* 4.  __d_lookup_rcu  — ENTRY                                           */
/*     Signature: struct dentry *__d_lookup_rcu(                         */
/*                    const struct dentry *parent,                       */
/*                    const struct qstr   *name,                         */
/*                    unsigned            *seqp)                         */
/*     Registers: %rdi = parent,  %rsi = name,  %rdx = seqp             */
/*     Defined:   fs/dcache.c:2253                                       */
/* ===================================================================== */

static int kp_dlr_entry(struct kprobe *p, struct pt_regs *regs) {
  int step;
  struct dentry *parent;
  struct qstr *name;

  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  step = atomic_inc_return(&step_counter);
  parent = (struct dentry *)regs->di;
  name = (struct qstr *)regs->si;

  pr_info("#%d.Call [__d_lookup_rcu SYMBOL]. "
          "Values [parent=%px, name=%px]. "
          "Data [Dir=%s, Seeking=%s]. "
          "Work [Hash-bucket walk under RCU read-lock].\n",
          step, parent, name, get_dname(parent),
          (name && name->name) ? safe_kstr(name->name) : "(null)");
  return 0;
}

/* ----- __d_lookup_rcu  — RETURN --------------------------------------- */

static int kr_dlr_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  struct dentry *ret_val;
  int step;

  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  step = atomic_inc_return(&step_counter);
  ret_val = (struct dentry *)regs_return_value(regs);

  pr_info("#%d.Return [__d_lookup_rcu SYMBOL]. "
          "Values [ret=%px]. "
          "Data [%s].\n",
          step, ret_val, ret_val ? get_dname(ret_val) : "Not in dcache (NULL)");
  return 0;
}

/* ===================================================================== */
/* probe struct definitions                                               */
/* ===================================================================== */

static struct kprobe kp_lpw = {
    .symbol_name = "link_path_walk",
    .pre_handler = kp_lpw_entry,
};
static struct kprobe kp_wc = {
    .symbol_name = "walk_component",
    .pre_handler = kp_wc_entry,
};
static struct kprobe kp_lf = {
    .symbol_name = "lookup_fast",
    .pre_handler = kp_lf_entry,
};
static struct kprobe kp_dlr = {
    .symbol_name = "__d_lookup_rcu",
    .pre_handler = kp_dlr_entry,
};

static struct kretprobe kr_lpw = {
    .kp = {.symbol_name = "link_path_walk"},
    .handler = kr_lpw_ret,
};
static struct kretprobe kr_wc = {
    .kp = {.symbol_name = "walk_component"},
    .handler = kr_wc_ret,
};
static struct kretprobe kr_lf = {
    .kp = {.symbol_name = "lookup_fast"},
    .handler = kr_lf_ret,
};
static struct kretprobe kr_dlr = {
    .kp = {.symbol_name = "__d_lookup_rcu"},
    .handler = kr_dlr_ret,
};

/* ===================================================================== */
/* init / exit                                                            */
/* ===================================================================== */

static int __init trace_safe_init(void) {
  int ret;

  ret = register_kprobe(&kp_lpw);
  if (ret < 0) {
    pr_err("kp_lpw: %d\n", ret);
    return ret;
  }

  ret = register_kprobe(&kp_wc);
  if (ret < 0)
    goto fail_wc;

  ret = register_kprobe(&kp_lf);
  if (ret < 0)
    goto fail_lf;

  ret = register_kprobe(&kp_dlr);
  if (ret < 0)
    goto fail_dlr;

  ret = register_kretprobe(&kr_lpw);
  if (ret < 0)
    goto fail_kr_lpw;

  ret = register_kretprobe(&kr_wc);
  if (ret < 0)
    goto fail_kr_wc;

  ret = register_kretprobe(&kr_lf);
  if (ret < 0)
    goto fail_kr_lf;

  ret = register_kretprobe(&kr_dlr);
  if (ret < 0)
    goto fail_kr_dlr;

  pr_info("trace_lpw_safe: loaded (8 probes). "
          "Targets: link_path_walk, walk_component, "
          "lookup_fast, __d_lookup_rcu.  target_comm=%s\n",
          target_comm);
  return 0;

fail_kr_dlr:
  unregister_kretprobe(&kr_lf);
fail_kr_lf:
  unregister_kretprobe(&kr_wc);
fail_kr_wc:
  unregister_kretprobe(&kr_lpw);
fail_kr_lpw:
  unregister_kprobe(&kp_dlr);
fail_dlr:
  unregister_kprobe(&kp_lf);
fail_lf:
  unregister_kprobe(&kp_wc);
fail_wc:
  unregister_kprobe(&kp_lpw);
  pr_err("trace_lpw_safe: registration failed: %d\n", ret);
  return ret;
}

static void __exit trace_safe_exit(void) {
  unregister_kretprobe(&kr_dlr);
  unregister_kretprobe(&kr_lf);
  unregister_kretprobe(&kr_wc);
  unregister_kretprobe(&kr_lpw);
  unregister_kprobe(&kp_dlr);
  unregister_kprobe(&kp_lf);
  unregister_kprobe(&kp_wc);
  unregister_kprobe(&kp_lpw);
  pr_info("trace_lpw_safe: unloaded.\n");
}

module_init(trace_safe_init);
module_exit(trace_safe_exit);
