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
MODULE_DESCRIPTION("Axiomatic trace of link_path_walk");

static char target_comm[32] = "";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);

/*
 * link_path_walk disassembly offsets (vmlinux ffffffff817fe220):
 * +0: Entry
 * +0x60 (96): Loop start (for(;;))
 * +0x9f (159): After hash_name (name updated)
 * +0x147 (327): After walk_component
 */

#define REL_LOOP_START 96
#define REL_AFTER_HASH 159
#define REL_AFTER_WALK 327

/* Variables in registers:
 * %rbx : struct nameidata *nd
 * %r12 : current char *name
 * %r13d: int depth
 */

static int kprobe_lpw_entry(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  // name is in %rdi, nd is in %rsi
  pr_info("[LPW] ENTRY: name=%px (%s), nd=%px, depth=0\n", (void *)regs->di,
          (char *)regs->di, (void *)regs->si);
  return 0;
}

static int kprobe_lpw_loop(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  // nd is in %rbx, depth in %r13d, current name in %rdi (initially) or %r12
  // We'll rely on register values at this offset.
  pr_info("[LPW] LOOP_START: name=%px (%s), depth=%d\n", (void *)regs->r12,
          (char *)regs->r12, (int)regs->r13);
  return 0;
}

static int kprobe_lpw_after_hash(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  /* lastword is at -0x38(%rbp) according to disassembly */
  unsigned long lastword;
  unsigned long *stack_ptr = (unsigned long *)(regs->bp - 0x38);

  // Safety check for pointer (simple) - in kernel we should use
  // probe_kernel_read or copy_from_kernel_nofault
  if (copy_from_kernel_nofault(&lastword, stack_ptr, sizeof(lastword)) != 0)
    lastword = 0xdeadbeef;

  pr_info("[LPW] AFTER_HASH: new_name=%px, lastword=%lx (0x2e=. 0x2e2e=..)\n",
          (void *)regs->ax, lastword);
  return 0;
}

static int kprobe_lpw_after_walk(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  // After walk_component, RAX holds 'link'.
  pr_info("[LPW] AFTER_WALK: link=%px, depth=%d, err=%d\n", (void *)regs->ax,
          (int)regs->r13, (int)regs->ax);
  return 0;
}

static struct kprobe kp_entry = {.symbol_name = "link_path_walk",
                                 .pre_handler = kprobe_lpw_entry};
static struct kprobe kp_loop = {.symbol_name = "link_path_walk",
                                .offset = REL_LOOP_START,
                                .pre_handler = kprobe_lpw_loop};
static struct kprobe kp_hash = {.symbol_name = "link_path_walk",
                                .offset = REL_AFTER_HASH,
                                .pre_handler = kprobe_lpw_after_hash};
static struct kprobe kp_walk = {.symbol_name = "link_path_walk",
                                .offset = REL_AFTER_WALK,
                                .pre_handler = kprobe_lpw_after_walk};

static int __init trace_lpw_init(void) {
  register_kprobe(&kp_entry);
  register_kprobe(&kp_loop);
  register_kprobe(&kp_hash);
  register_kprobe(&kp_walk);
  pr_info("trace_lpw: loaded\n");
  return 0;
}

static void __exit trace_lpw_exit(void) {
  unregister_kprobe(&kp_entry);
  unregister_kprobe(&kp_loop);
  unregister_kprobe(&kp_hash);
  unregister_kprobe(&kp_walk);
  pr_info("trace_lpw: unloaded\n");
}

module_init(trace_lpw_init);
module_exit(trace_lpw_exit);
