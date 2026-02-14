#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/sched.h>
#include <linux/fs.h>
#include <linux/string.h>

static char target_comm[TASK_COMM_LEN] = "user_bulk_renam";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);
MODULE_PARM_DESC(target_comm, "Only trace this task comm; empty means trace all");

/* TODO(user): add your per-case math/logic checks here using captured pointers. */

static __always_inline bool trace_target_comm_matches(void)
{
    if (!target_comm[0])
        return true;
    return strcmp(current->comm, target_comm) == 0;
}

static int probe_entry_do_filp_open(struct kprobe *p, struct pt_regs *regs)
{
    if (!trace_target_comm_matches())
        return 0;

    pr_info("[trace_user_bulk_rename] do_filp_open.entry pid=%d comm=%s dfd=%lld pathname=%px op=%px\n",
            current->pid, current->comm,
            (long long)regs->di, (void *)regs->si, (void *)regs->dx);
    return 0;
}

static int probe_ret_do_filp_open(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    void *retp = (void *)regs_return_value(regs);

    if (!trace_target_comm_matches())
        return 0;

    pr_info("[trace_user_bulk_rename] do_filp_open.ret pid=%d comm=%s ret=%px\n",
            current->pid, current->comm, retp);
    return 0;
}

static int probe_entry___d_alloc(struct kprobe *p, struct pt_regs *regs)
{
    if (!trace_target_comm_matches())
        return 0;

    pr_info("[trace_user_bulk_rename] __d_alloc.entry pid=%d comm=%s sb=%px name_qstr=%px\n",
            current->pid, current->comm, (void *)regs->di, (void *)regs->si);
    return 0;
}

static int probe_ret___d_alloc(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    void *dentry = (void *)regs_return_value(regs);

    if (!trace_target_comm_matches())
        return 0;

    pr_info("[trace_user_bulk_rename] __d_alloc.ret pid=%d comm=%s dentry=%px\n",
            current->pid, current->comm, dentry);
    return 0;
}

static struct kprobe kp_do_filp_open = {
    .symbol_name = "do_filp_open",
    .pre_handler = probe_entry_do_filp_open,
};

static struct kretprobe krp_do_filp_open = {
    .kp.symbol_name = "do_filp_open",
    .handler = probe_ret_do_filp_open,
    .maxactive = 64,
};

static struct kprobe kp___d_alloc = {
    .symbol_name = "__d_alloc",
    .pre_handler = probe_entry___d_alloc,
};

static struct kretprobe krp___d_alloc = {
    .kp.symbol_name = "__d_alloc",
    .handler = probe_ret___d_alloc,
    .maxactive = 64,
};

static int __init trace_user_bulk_rename_init(void)
{
    int rc;

    rc = register_kprobe(&kp_do_filp_open);
    if (rc)
        return rc;

    rc = register_kretprobe(&krp_do_filp_open);
    if (rc)
        goto err_do_filp_open_ret;

    rc = register_kprobe(&kp___d_alloc);
    if (rc)
        goto err_d_alloc_entry;

    rc = register_kretprobe(&krp___d_alloc);
    if (rc)
        goto err_d_alloc_ret;

    pr_info("[trace_user_bulk_rename] loaded target_comm=%s user=kernel/user/stage3/case11_bulk_rename/user_bulk_rename.c\n",
            target_comm[0] ? target_comm : "<all>");
    return 0;

err_d_alloc_ret:
    unregister_kprobe(&kp___d_alloc);
err_d_alloc_entry:
    unregister_kretprobe(&krp_do_filp_open);
err_do_filp_open_ret:
    unregister_kprobe(&kp_do_filp_open);
    return rc;
}

static void __exit trace_user_bulk_rename_exit(void)
{
    unregister_kretprobe(&krp___d_alloc);
    unregister_kprobe(&kp___d_alloc);
    unregister_kretprobe(&krp_do_filp_open);
    unregister_kprobe(&kp_do_filp_open);
    pr_info("[trace_user_bulk_rename] unloaded\n");
}

module_init(trace_user_bulk_rename_init);
module_exit(trace_user_bulk_rename_exit);
MODULE_LICENSE("GPL");
MODULE_AUTHOR("stage3-automation");
MODULE_DESCRIPTION("Dedicated Stage3 trace driver for kernel/user/stage3/case11_bulk_rename/user_bulk_rename.c");
