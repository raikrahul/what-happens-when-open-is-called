/*******************************************************************************
 * DRIVER A: File Creation Path Tracer - CORRECTED VERSION
 * Timestamp: 2026-02-13 20:55:00
 * Fixed: Use correct kernel symbol names
 ******************************************************************************/

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/fs.h>
#include <linux/namei.h>
#include <linux/dcache.h>
#include <linux/slab.h>
#include <linux/time.h>
#include <linux/ktime.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <asm/current.h>

#define DRIVER_NAME "trace_create_path"
#define DRIVER_VERSION "1.0.0"

static atomic_t trace_seq = ATOMIC_INIT(0);
static char target_comm[TASK_COMM_LEN] = "create_test";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);
MODULE_PARM_DESC(target_comm, "Process name to trace (default: create_test)");

static inline int get_next_seq(void)
{
    return atomic_fetch_add(1, &trace_seq);
}

static int is_target_process(void)
{
    if (target_comm[0] == '\0')
        return 1;
    return (strcmp(current->comm, target_comm) == 0);
}

static void trace_record(int seq, const char *func, const char *action, const char *fmt, ...)
{
    va_list args;
    char buf[256];
    int len;
    u64 ts = ktime_get_ns();
    
    len = snprintf(buf, sizeof(buf), "[A.%08d] %020llu %s %s %s %d:%s ",
                   seq, ts, func, action, current->comm, current->pid, fmt);
    
    va_start(args, fmt);
    vsnprintf(buf + len, sizeof(buf) - len, fmt, args);
    va_end(args);
    
    pr_info("%s\n", buf);
}

/*******************************************************************************
 * ENTRY HANDLERS
 ******************************************************************************/

static int entry_do_sys_open(struct kprobe *p, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    
    trace_record(seq, "do_sys_open", "ENTRY", "dfd=%d flags=0x%x", 
                 (int)regs->di, (int)regs->dx);
    return 0;
}

static int entry_path_openat(struct kprobe *p, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "path_openat", "ENTRY", "");
    return 0;
}

static int entry_link_path_walk(struct kprobe *p, struct pt_regs *regs)
{
    int seq = get_next_seq();
    const char *name;
    
    if (!is_target_process()) return 0;
    
    name = (const char *)regs->di;
    trace_record(seq, "link_path_walk", "ENTRY", "path=0x%px", name);
    return 0;
}

static int entry_lookup_open(struct kprobe *p, struct pt_regs *regs)
{
    int seq = get_next_seq();
    struct dentry *dentry;
    
    if (!is_target_process()) return 0;
    
    dentry = (struct dentry *)regs->si;
    trace_record(seq, "lookup_open", "ENTRY", "dentry=0x%px inode=0x%px %s",
                 dentry, dentry ? dentry->d_inode : NULL,
                 (dentry && dentry->d_inode) ? "EXISTS" : "CREATE_NEEDED");
    return 0;
}

static int entry_vfs_create(struct kprobe *p, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "vfs_create", "ENTRY", "CREATING_FILE");
    return 0;
}

static int entry_d_alloc(struct kprobe *p, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "d_alloc", "ENTRY", "allocating_dentry");
    return 0;
}

static int entry_d_instantiate(struct kprobe *p, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "d_instantiate", "ENTRY", "linking_dentry_to_inode");
    return 0;
}

static int entry_fd_install(struct kprobe *p, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "fd_install", "ENTRY", "fd=%d", (int)regs->di);
    return 0;
}

/*******************************************************************************
 * RETURN HANDLERS
 ******************************************************************************/

static int ret_do_sys_open(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    
    trace_record(seq, "do_sys_open", "EXIT", "ret=%ld %s",
                 regs_return_value(regs),
                 regs_return_value(regs) >= 0 ? "SUCCESS" : "FAIL");
    return 0;
}

static int ret_path_openat(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "path_openat", "EXIT", "");
    return 0;
}

static int ret_link_path_walk(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "link_path_walk", "EXIT", "ret=%ld",
                 regs_return_value(regs));
    return 0;
}

static int ret_lookup_open(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "lookup_open", "EXIT", "ret=0x%px",
                 (void *)regs_return_value(regs));
    return 0;
}

static int ret_vfs_create(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "vfs_create", "EXIT", "ret=%ld %s",
                 regs_return_value(regs),
                 regs_return_value(regs) == 0 ? "CREATED" : "FAILED");
    return 0;
}

static int ret_d_alloc(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "d_alloc", "EXIT", "dentry=0x%px",
                 (void *)regs_return_value(regs));
    return 0;
}

static int ret_d_instantiate(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "d_instantiate", "EXIT", "LINKED");
    return 0;
}

/*******************************************************************************
 * PROBE REGISTRATION
 ******************************************************************************/

static struct kprobe kp_do_sys_open = {
    .symbol_name = "do_sys_open",
    .pre_handler = entry_do_sys_open,
};

static struct kprobe kp_path_openat = {
    .symbol_name = "path_openat",
    .pre_handler = entry_path_openat,
};

static struct kprobe kp_link_path_walk = {
    .symbol_name = "link_path_walk",
    .pre_handler = entry_link_path_walk,
};

static struct kprobe kp_lookup_open = {
    .symbol_name = "lookup_open.isra.0",
    .pre_handler = entry_lookup_open,
};

static struct kprobe kp_vfs_create = {
    .symbol_name = "vfs_create",
    .pre_handler = entry_vfs_create,
};

static struct kprobe kp_d_alloc = {
    .symbol_name = "d_alloc",
    .pre_handler = entry_d_alloc,
};

static struct kprobe kp_d_instantiate = {
    .symbol_name = "d_instantiate",
    .pre_handler = entry_d_instantiate,
};

static struct kprobe kp_fd_install = {
    .symbol_name = "fd_install",
    .pre_handler = entry_fd_install,
};

static struct kretprobe krp_do_sys_open = {
    .kp.symbol_name = "do_sys_open",
    .handler = ret_do_sys_open,
};

static struct kretprobe krp_path_openat = {
    .kp.symbol_name = "path_openat",
    .handler = ret_path_openat,
};

static struct kretprobe krp_link_path_walk = {
    .kp.symbol_name = "link_path_walk",
    .handler = ret_link_path_walk,
};

static struct kretprobe krp_lookup_open = {
    .kp.symbol_name = "lookup_open.isra.0",
    .handler = ret_lookup_open,
};

static struct kretprobe krp_vfs_create = {
    .kp.symbol_name = "vfs_create",
    .handler = ret_vfs_create,
};

static struct kretprobe krp_d_alloc = {
    .kp.symbol_name = "d_alloc",
    .handler = ret_d_alloc,
};

static struct kretprobe krp_d_instantiate = {
    .kp.symbol_name = "d_instantiate",
    .handler = ret_d_instantiate,
};

/*******************************************************************************
 * MODULE INIT
 ******************************************************************************/

static int __init trace_create_path_init(void)
{
    int ret;
    int count = 0;
    
    pr_info("%s: Loading driver (target=%s)\n", DRIVER_NAME, target_comm);
    
    ret = register_kprobe(&kp_do_sys_open);
    if (ret < 0) goto err1;
    count++;
    
    ret = register_kprobe(&kp_path_openat);
    if (ret < 0) goto err2;
    count++;
    
    ret = register_kprobe(&kp_link_path_walk);
    if (ret < 0) goto err3;
    count++;
    
    ret = register_kprobe(&kp_lookup_open);
    if (ret < 0) goto err4;
    count++;
    
    ret = register_kprobe(&kp_vfs_create);
    if (ret < 0) goto err5;
    count++;
    
    ret = register_kprobe(&kp_d_alloc);
    if (ret < 0) goto err6;
    count++;
    
    ret = register_kprobe(&kp_d_instantiate);
    if (ret < 0) goto err7;
    count++;
    
    ret = register_kprobe(&kp_fd_install);
    if (ret < 0) goto err8;
    count++;
    
    ret = register_kretprobe(&krp_do_sys_open);
    if (ret < 0) goto err9;
    count++;
    
    ret = register_kretprobe(&krp_path_openat);
    if (ret < 0) goto err10;
    count++;
    
    ret = register_kretprobe(&krp_link_path_walk);
    if (ret < 0) goto err11;
    count++;
    
    ret = register_kretprobe(&krp_lookup_open);
    if (ret < 0) goto err12;
    count++;
    
    ret = register_kretprobe(&krp_vfs_create);
    if (ret < 0) goto err13;
    count++;
    
    ret = register_kretprobe(&krp_d_alloc);
    if (ret < 0) goto err14;
    count++;
    
    ret = register_kretprobe(&krp_d_instantiate);
    if (ret < 0) goto err15;
    count++;
    
    pr_info("%s: Registered %d probes successfully\n", DRIVER_NAME, count);
    return 0;
    
err15: unregister_kretprobe(&krp_d_alloc);
err14: unregister_kretprobe(&krp_vfs_create);
err13: unregister_kretprobe(&krp_lookup_open);
err12: unregister_kretprobe(&krp_link_path_walk);
err11: unregister_kretprobe(&krp_path_openat);
err10: unregister_kretprobe(&krp_do_sys_open);
err9:  unregister_kprobe(&kp_fd_install);
err8:  unregister_kprobe(&kp_d_instantiate);
err7:  unregister_kprobe(&kp_d_alloc);
err6:  unregister_kprobe(&kp_vfs_create);
err5:  unregister_kprobe(&kp_lookup_open);
err4:  unregister_kprobe(&kp_link_path_walk);
err3:  unregister_kprobe(&kp_path_openat);
err2:  unregister_kprobe(&kp_do_sys_open);
err1:
    pr_err("%s: Failed to register probes: %d\n", DRIVER_NAME, ret);
    return ret;
}

static void __exit trace_create_path_exit(void)
{
    unregister_kretprobe(&krp_d_instantiate);
    unregister_kretprobe(&krp_d_alloc);
    unregister_kretprobe(&krp_vfs_create);
    unregister_kretprobe(&krp_lookup_open);
    unregister_kretprobe(&krp_link_path_walk);
    unregister_kretprobe(&krp_path_openat);
    unregister_kretprobe(&krp_do_sys_open);
    
    unregister_kprobe(&kp_fd_install);
    unregister_kprobe(&kp_d_instantiate);
    unregister_kprobe(&kp_d_alloc);
    unregister_kprobe(&kp_vfs_create);
    unregister_kprobe(&kp_lookup_open);
    unregister_kprobe(&kp_link_path_walk);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_do_sys_open);
    
    pr_info("%s: Unloaded driver\n", DRIVER_NAME);
}

module_init(trace_create_path_init);
module_exit(trace_create_path_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Trace Analysis");
MODULE_DESCRIPTION("Trace file creation path through VFS");
MODULE_VERSION(DRIVER_VERSION);
