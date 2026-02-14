#include <linux/dcache.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/sched.h>

static struct kprobe kp_lookup = {.symbol_name = "__d_lookup_rcu"};
static struct kprobe kp_move = {.symbol_name = "d_move"};

static int handler_lookup(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *parent = (struct dentry *)regs->di;
  struct qstr *name = (struct qstr *)regs->si;
  if (name && name->name && strncmp(name->name, "puzzle_", 7) == 0) {
    printk(KERN_INFO
           "PUZZLE_LOOKUP: Comm=%s Name='%s' Hash=0x%08x Salt(Parent)=%px\n",
           current->comm, name->name, name->hash, parent);
  }
  return 0;
}

static int handler_move(struct kprobe *p, struct pt_regs *regs) {
  struct dentry *dentry = (struct dentry *)regs->di;
  struct dentry *target = (struct dentry *)regs->si;
  if (strncmp(dentry->d_name.name, "puzzle_", 7) == 0) {
    printk(KERN_INFO "PUZZLE_MOVE: Dentry=%px OldParent=%px NewParent=%px\n",
           dentry, dentry->d_parent, target->d_parent);
    printk(KERN_INFO "PUZZLE_MOVE: OldHash=0x%08x NewHash=0x%08x\n",
           dentry->d_name.hash, target->d_name.hash);
  }
  return 0;
}

static int __init puzzle_init(void) {
  kp_lookup.pre_handler = handler_lookup;
  kp_move.pre_handler = handler_move;
  register_kprobe(&kp_lookup);
  register_kprobe(&kp_move);
  return 0;
}

static void __exit puzzle_exit(void) {
  unregister_kprobe(&kp_lookup);
  unregister_kprobe(&kp_move);
}

module_init(puzzle_init) module_exit(puzzle_exit) MODULE_LICENSE("GPL");
