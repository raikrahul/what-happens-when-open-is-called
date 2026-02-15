#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/sched.h>
#include <linux/string.h>

static char target_comm[TASK_COMM_LEN] = "case3_intensity";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);

static __always_inline bool hit(void)
{
    if (!target_comm[0]) return true;
    return strcmp(current->comm, target_comm) == 0;
}

static int kp_filp_pre(struct kprobe *p, struct pt_regs *regs)
{ if (!hit()) return 0; pr_info("[case3_addon] do_filp_open.entry pid=%d comm=%s\n", current->pid, current->comm); return 0; }
static int kr_filp_ret(struct kretprobe_instance *ri, struct pt_regs *regs)
{ if (!hit()) return 0; pr_info("[case3_addon] do_filp_open.ret ret=%px\n", (void *)regs_return_value(regs)); return 0; }

static struct kprobe kp_filp = { .symbol_name = "do_filp_open", .pre_handler = kp_filp_pre };
static struct kretprobe kr_filp = { .kp.symbol_name = "do_filp_open", .handler = kr_filp_ret, .maxactive = 64 };

static int __init init_mod(void)
{ int rc=register_kprobe(&kp_filp); if (rc) return rc; rc=register_kretprobe(&kr_filp); if (rc) { unregister_kprobe(&kp_filp); return rc; } pr_info("[case3_addon] loaded\n"); return 0; }
static void __exit exit_mod(void)
{ unregister_kretprobe(&kr_filp); unregister_kprobe(&kp_filp); pr_info("[case3_addon] unloaded\n"); }

module_init(init_mod); module_exit(exit_mod);
MODULE_LICENSE("GPL");
