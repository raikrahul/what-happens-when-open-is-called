#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/sched.h>

static struct kprobe kp = {
    .symbol_name = "d_alloc_parallel",
};

/*
 * This driver specifically looks for names that might collide or
 * demonstrate bucket placement logic.
 */
static int handler_pre(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *parent = (struct dentry *)regs->di;
  struct qstr *name = (struct qstr *)regs->si;

  if (name && name->name) {
    // Filter for "collision_case"
    const unsigned char *n = name->name;
    if (n[0] == 'c' && n[1] == 'o' && n[2] == 'l' && n[3] == 'l' &&
        n[4] == 'i' && n[5] == 's' && n[6] == 'i' && n[7] == 'o') {

      printk(KERN_INFO "PROBE_COLLISION: Comm=%s Name='%s' Hash=0x%08x\n",
             current->comm, name->name, name->hash);

      // Log bucket index if we can derive it from hash
      // This usually depends on d_hash_mask which is internal,
      // but we can log the raw hash for post-processing.
    }
  }

  return 0;
}

static int __init kprobe_init(void) {
  kp.pre_handler = handler_pre;
  return register_kprobe(&kp);
}

static void __exit kprobe_exit(void) { unregister_kprobe(&kp); }

module_init(kprobe_init) module_exit(kprobe_exit) MODULE_LICENSE("GPL");
