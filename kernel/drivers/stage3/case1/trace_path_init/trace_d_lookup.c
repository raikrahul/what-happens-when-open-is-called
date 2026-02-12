
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
MODULE_DESCRIPTION("Tracing d_lookup for Hash/Parent Verification");

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

/* We will trace d_lookup directly:
 * struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
 */

static const char *get_dname(struct dentry *d) {
  if (!d)
    return "NULL";
  return (const char *)d->d_name.name;
}

static int kp_d_lookup_entry(struct kprobe *p, struct pt_regs *regs) {
  /* TRACING: We removed the target_comm check to trace ALL processes.
   * This allows us to see the full path resolution for demo_dup_names
   * and any other user-space programs we run.
   */

  struct dentry *parent = (struct dentry *)regs->di;
  struct qstr *name = (struct qstr *)regs->si;

  /* Axiomatic Bucket Calculation:
   * bucket_id = hash >> (32 - d_hash_shift)
   * This PROVES why we look in this exact bucket.
   */
  unsigned int *shift_ptr = (unsigned int *)0xffffffff8ca3b650;
  unsigned int shift = *shift_ptr;
  unsigned int bucket_id = name->hash >> (32 - shift);

  pr_info("[D_LOOKUP] Searching in parent: '%s' (addr=%px)\n",
          get_dname(parent), parent);
  pr_info("           Target: '%.*s' (len=%d, hash=0x%08x)\n", name->len,
          name->name, name->len, name->hash);
  pr_info("           AXIOM: 0x%08x >> (32-%u) = Bucket #%u\n", name->hash,
          shift, bucket_id);
  return 0;
}

static int kp_d_lookup_ret(struct kretprobe_instance *ri,
                           struct pt_regs *regs) {
  if (strcmp(current->comm, target_comm) != 0)
    return 0;

  struct dentry *ret = (struct dentry *)regs_return_value(regs);
  if (ret) {
    pr_info("[D_LOOKUP] MATCH FOUND! Dentry=%px Name='%s' Parent=%px\n", ret,
            get_dname(ret), ret->d_parent);
  } else {
    pr_info("[D_LOOKUP] No Match Found (NULL)\n");
  }
  return 0;
}

static struct kprobe kp_lookup = {
    .symbol_name = "d_lookup",
    .pre_handler = kp_d_lookup_entry,
};

static struct kretprobe kr_lookup = {
    .kp = {.symbol_name = "d_lookup"},
    .handler = kp_d_lookup_ret,
};

static int __init trace_d_lookup_init(void) {
  register_kprobe(&kp_lookup);
  register_kretprobe(&kr_lookup);

  /* Axiomatic Proof: Read d_hash_shift from known address */
  unsigned int *shift_ptr = (unsigned int *)0xffffffff8ca3b650;
  unsigned int shift = *shift_ptr;
  unsigned long size = 1UL << (32 - shift);

  pr_info("trace_lpw_stage3: loaded. Targeting %s\n", target_comm);
  pr_info("AXIOM: d_hash_shift in memory is %u\n", shift);
  pr_info("AXIOM: Total Hash Buckets = 2^(32-%u) = %lu buckets\n", shift, size);
  return 0;
}

static void __exit trace_d_lookup_exit(void) {
  unregister_kprobe(&kp_lookup);
  unregister_kretprobe(&kr_lookup);
  pr_info("trace_d_lookup: unloaded\n");
}

module_init(trace_d_lookup_init);
module_exit(trace_d_lookup_exit);
