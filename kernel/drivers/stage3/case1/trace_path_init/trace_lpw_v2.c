
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
#include <linux/uaccess.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Antigravity");
MODULE_DESCRIPTION("Pseudo-Debugger for link_path_walk V3");

static char target_comm[32] = "demo_short";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);

static atomic_t step_counter = ATOMIC_INIT(0);

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
  struct path path;
  struct qstr last;
  struct path root;
  struct inode *inode;
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

static const char *get_dname(struct dentry *d) {
  if (!d)
    return "NULL";
  return (const char *)d->d_name.name;
}

/* Offsets from link_path_walk start (0xffffffff817fe220) */
#define OFF_MAY_LOOKUP 0x7d
#define OFF_HASH_NAME 0x9a
#define OFF_WALK_COMPONENT_1 0x100
#define OFF_WALK_COMPONENT_2 0x142

static int kp_lpw_entry(struct kprobe *p, struct pt_regs *regs) {
  if (strcmp(current->comm, target_comm) != 0)
    return 0;
  int step = atomic_inc_return(&step_counter);
  const char *name = (const char *)regs->di;
  struct my_nameidata *nd = (struct my_nameidata *)regs->si;
  pr_info("#%d.Call [link_path_walk]. Values [name=%px, nd=%px]. Data "
          "[PathBase=%s, flags=%x]. Work [Initialize resolution loop]. Errors "
          "[0]. Real value [%px]. Real data [%s]. Caller [path_lookupat:2652], "
          "Current [2429].\n",
          step, name, nd, get_dname(nd->path.dentry), nd->flags, (void *)name,
          name ? name : "NULL");
  return 0;
}

static int kp_may_lookup_call(struct kprobe *p, struct pt_regs *regs) {
  if (strcmp(current->comm, target_comm) != 0)
    return 0;
  int step = atomic_inc_return(&step_counter);
  /* In link_path_walk: may_lookup(idmap, nd). idmap is in %rdi, nd is in %rsi
   */
  struct my_nameidata *nd = (struct my_nameidata *)regs->si;
  pr_info(
      "#%d.Call [may_lookup]. Values [idmap=%px, nd=%px]. Data [Dir=%s, "
      "Inode=%px]. Work [Check MAY_EXEC perms]. Errors [0]. Real value [%px]. "
      "Real data [Mode:%o]. Caller [link_path_walk:2453], Current [2453].\n",
      step, (void *)regs->di, nd, get_dname(nd->path.dentry), nd->inode, nd,
      nd->inode ? nd->inode->i_mode : 0);
  return 0;
}

static int kp_hash_name_call(struct kprobe *p, struct pt_regs *regs) {
  if (strcmp(current->comm, target_comm) != 0)
    return 0;
  int step = atomic_inc_return(&step_counter);
  /* hash_name(nd, name, &lastword). nd is in %rdi, name in %rsi */
  struct my_nameidata *nd = (struct my_nameidata *)regs->di;
  const char *name = (const char *)regs->si;
  pr_info(
      "#%d.Call [hash_name]. Values [nd=%px, name=%px]. Data [TokenStart=%s]. "
      "Work [Identify component]. Errors [0]. Real value [%px]. Real data "
      "[%s]. Caller [link_path_walk:2458], Current [2458].\n",
      step, nd, name, name, (void *)name, name);
  return 0;
}

static int kp_walk_component_call(struct kprobe *p, struct pt_regs *regs) {
  if (strcmp(current->comm, target_comm) != 0)
    return 0;
  int step = atomic_inc_return(&step_counter);
  /* walk_component(nd, flags). nd is in %rdi, flags in %rsi */
  struct my_nameidata *nd = (struct my_nameidata *)regs->di;
  int flags = (int)regs->si;
  pr_info(
      "#%d.Call [walk_component]. Values [nd=%px, flags=%x]. Data "
      "[LookingUp=%s, Dir=%s]. Work [Resolve component name]. Errors [0]. Real "
      "value [%px]. Real data [Parent=%s]. Caller [link_path_walk:2502], "
      "Current [2502]. Resumed [link_path_walk:2429].\n",
      step, nd, flags, (char *)nd->last.name, get_dname(nd->path.dentry),
      (void *)nd->path.dentry, get_dname(nd->path.dentry));
  return 0;
}

static int kp_lpw_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  if (strcmp(current->comm, target_comm) != 0)
    return 0;
  int step = atomic_inc_return(&step_counter);
  int ret = (int)regs_return_value(regs);
  pr_info("#%d.Resumed [path_lookupat:2652]. Values [ret=%d]. Data "
          "[FinalResState=%s]. Work [Resolution done]. Errors [%d]. Real value "
          "[%d]. Real data [Traversal Result]. Caller [path_lookupat:2652], "
          "Current [2523].\n",
          step, ret, (ret == 0) ? "SUCCESS" : "ERROR", ret, ret);
  return 0;
}

static struct kprobe kp_lpw = {.symbol_name = "link_path_walk",
                               .pre_handler = kp_lpw_entry};
static struct kprobe kp_may = {.symbol_name = "link_path_walk",
                               .offset = OFF_MAY_LOOKUP,
                               .pre_handler = kp_may_lookup_call};
static struct kprobe kp_hash = {.symbol_name = "link_path_walk",
                                .offset = OFF_HASH_NAME,
                                .pre_handler = kp_hash_name_call};
static struct kprobe kp_walk1 = {.symbol_name = "link_path_walk",
                                 .offset = OFF_WALK_COMPONENT_1,
                                 .pre_handler = kp_walk_component_call};
static struct kprobe kp_walk2 = {.symbol_name = "link_path_walk",
                                 .offset = OFF_WALK_COMPONENT_2,
                                 .pre_handler = kp_walk_component_call};
static struct kretprobe kr_lpw = {.kp = {.symbol_name = "link_path_walk"},
                                  .handler = kp_lpw_ret};

static int __init trace_debugger_init(void) {
  register_kprobe(&kp_lpw);
  register_kprobe(&kp_may);
  register_kprobe(&kp_hash);
  register_kprobe(&kp_walk1);
  register_kprobe(&kp_walk2);
  register_kretprobe(&kr_lpw);
  pr_info("trace_lpw_debugger_v3: loaded. Targeting %s\n", target_comm);
  return 0;
}

static void __exit trace_debugger_exit(void) {
  unregister_kprobe(&kp_lpw);
  unregister_kprobe(&kp_may);
  unregister_kprobe(&kp_hash);
  unregister_kprobe(&kp_walk1);
  unregister_kprobe(&kp_walk2);
  unregister_kretprobe(&kr_lpw);
  pr_info("trace_lpw_debugger_v3: unloaded\n");
}

module_init(trace_debugger_init);
module_exit(trace_debugger_exit);
