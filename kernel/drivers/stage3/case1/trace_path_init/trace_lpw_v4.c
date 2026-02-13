
#include <linux/dcache.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/namei.h>
#include <linux/path.h>
#include <linux/ptrace.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/string.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Antigravity");
MODULE_DESCRIPTION("Tracing link_path_walk for Stage 3");

#include <linux/mnt_idmapping.h>

/* From fs/namei.c */
#define EMBEDDED_LEVELS 2
struct nameidata {
  struct path path;
  struct qstr last;
  struct path root;
  struct inode *inode; /* path.dentry.d_inode */
  unsigned int flags, state;
  unsigned seq, next_seq, m_seq, r_seq;
  int last_type;
  unsigned depth;
  int total_link_count;
  struct {
    struct path link;
    struct delayed_call done;
    const char *name;
    unsigned seq;
  } *stack, internal[EMBEDDED_LEVELS];
  struct filename *name;
  const char *pathname;
  struct nameidata *saved;
  unsigned root_seq;
  int dfd;
  vfsuid_t dir_vfsuid;
  umode_t dir_mode;
};

static char target_comm[32] = "demo_dup_names";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);

/*
 * We use kprobes on function entry points to be safe from randomization shifts.
 * link_path_walk(const char *name, struct nameidata *nd)
 * walk_component(struct nameidata *nd, int flags)
 */

static const char *get_dname(struct dentry *d) {
  if (!d)
    return "NULL";
  return (const char *)d->d_name.name;
}

static int kp_lpw_entry(struct kprobe *p, struct pt_regs *regs) {
  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  const char *name = (const char *)regs->di;
  pr_info("[LPW] link_path_walk entry: name='%s'\n", name ? name : "NULL");
  return 0;
}

static int kp_walk_entry(struct kprobe *p, struct pt_regs *regs) {
  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  /* walk_component(nd, flags). nd is in %rdi */
  struct nameidata *nd = (struct nameidata *)regs->di;

  /* Use len to avoid printing the whole string if not null-terminated */
  pr_info("[LPW] walk_component: component='%.*s' (len=%d, hash=0x%08x) | "
          "parent='%s' (addr=%px)\n",
          nd->last.len, nd->last.name ? (char *)nd->last.name : "???",
          nd->last.len, nd->last.hash, get_dname(nd->path.dentry),
          nd->path.dentry);
  return 0;
}

static int kp_walk_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  const char *ret_link = (const char *)regs_return_value(regs);
  pr_info("[LPW] walk_component returned: %px (NULL means success/normal)\n",
          ret_link);
  return 0;
}

static struct kprobe kp_lpw = {
    .symbol_name = "link_path_walk",
    .pre_handler = kp_lpw_entry,
};

static struct kprobe kp_walk = {
    .symbol_name = "walk_component",
    .pre_handler = kp_walk_entry,
};

static struct kretprobe kr_walk = {
    .kp = {.symbol_name = "walk_component"},
    .handler = kp_walk_ret,
};

static int __init trace_lpw_init(void) {
  register_kprobe(&kp_lpw);
  register_kprobe(&kp_walk);
  register_kretprobe(&kr_walk);
  pr_info("trace_lpw_stage3: loaded. Targeting %s\n", target_comm);
  return 0;
}

static void __exit trace_lpw_exit(void) {
  unregister_kprobe(&kp_lpw);
  unregister_kprobe(&kp_walk);
  unregister_kretprobe(&kr_walk);
  pr_info("trace_lpw_stage3: unloaded\n");
}

module_init(trace_lpw_init);
module_exit(trace_lpw_exit);
