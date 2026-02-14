#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/fs.h>
#include <linux/namei.h>
#include <linux/dcache.h>
#include <linux/time.h>
#include <linux/ktime.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <asm/current.h>

#define DRIVER_NAME "trace_open_path"
static atomic_t trace_seq = ATOMIC_INIT(0);
static char target_comm[TASK_COMM_LEN] = "open_test";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);

static inline int get_next_seq(void) { return atomic_fetch_add(1, &trace_seq); }

static int is_target_process(void) {
    if (target_comm[0] == '\0') return 1;
    return (strcmp(current->comm, target_comm) == 0);
}

static void trace_record(int seq, const char *func, const char *action, const char *fmt, ...) {
    va_list args;
    char buf[256];
    int len;
    u64 ts = ktime_get_ns();
    len = snprintf(buf, sizeof(buf), "[B.%08d] %020llu %s %s %s %d:%s ", seq, ts, func, action, current->comm, current->pid, fmt);
    va_start(args, fmt);
    vsnprintf(buf + len, sizeof(buf) - len, fmt, args);
    va_end(args);
    pr_info("%s\n", buf);
}

static int entry_do_sys_open(struct kprobe *p, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "do_sys_open", "ENTRY", "dfd=%d flags=0x%x EXISTING", (int)regs->di, (int)regs->dx);
    return 0;
}

static int entry_path_openat(struct kprobe *p, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "path_openat", "ENTRY", "EXISTING_FILE");
    return 0;
}

static int entry_link_path_walk(struct kprobe *p, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "link_path_walk", "ENTRY", "path=0x%px EXISTING", (void*)regs->di);
    return 0;
}

static int entry_lookup_open(struct kprobe *p, struct pt_regs *regs) {
    int seq = get_next_seq();
    struct dentry *dentry;
    if (!is_target_process()) return 0;
    dentry = (struct dentry *)regs->si;
    trace_record(seq, "lookup_open", "ENTRY", "dentry=0x%px inode=0x%px %s", dentry, dentry ? dentry->d_inode : NULL, (dentry && dentry->d_inode) ? "FILE_EXISTS" : "NO_INODE");
    return 0;
}

static int entry_may_open(struct kprobe *p, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "may_open", "ENTRY", "EXISTING_FILE_PERMISSION_CHECK");
    return 0;
}

static int entry_finish_open(struct kprobe *p, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "finish_open", "ENTRY", "file=0x%px dentry=0x%px LINKING_EXISTING", (void*)regs->di, (void*)regs->si);
    return 0;
}

static int entry_fd_install(struct kprobe *p, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "fd_install", "ENTRY", "fd=%d EXISTING_FILE", (int)regs->di);
    return 0;
}

static int ret_do_sys_open(struct kretprobe_instance *ri, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "do_sys_open", "EXIT", "ret=%ld %s", regs_return_value(regs), regs_return_value(regs) >= 0 ? "SUCCESS" : "FAIL");
    return 0;
}

static int ret_path_openat(struct kretprobe_instance *ri, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "path_openat", "EXIT", "");
    return 0;
}

static int ret_link_path_walk(struct kretprobe_instance *ri, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "link_path_walk", "EXIT", "ret=%ld", regs_return_value(regs));
    return 0;
}

static int ret_lookup_open(struct kretprobe_instance *ri, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "lookup_open", "EXIT", "ret=0x%px - EXISTING FILE RETURN", (void *)regs_return_value(regs));
    return 0;
}

static int ret_may_open(struct kretprobe_instance *ri, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "may_open", "EXIT", "ret=%ld %s", regs_return_value(regs), regs_return_value(regs) == 0 ? "ALLOWED" : "DENIED");
    return 0;
}

static int ret_finish_open(struct kretprobe_instance *ri, struct pt_regs *regs) {
    int seq = get_next_seq();
    if (!is_target_process()) return 0;
    trace_record(seq, "finish_open", "EXIT", "ret=%ld %s", regs_return_value(regs), regs_return_value(regs) == 0 ? "LINKED" : "FAILED");
    return 0;
}

static struct kprobe kp_do_sys_open = { .symbol_name = "do_sys_open", .pre_handler = entry_do_sys_open };
static struct kprobe kp_path_openat = { .symbol_name = "path_openat", .pre_handler = entry_path_openat };
static struct kprobe kp_link_path_walk = { .symbol_name = "link_path_walk", .pre_handler = entry_link_path_walk };
static struct kprobe kp_lookup_open = { .symbol_name = "lookup_open.isra.0", .pre_handler = entry_lookup_open };
static struct kprobe kp_may_open = { .symbol_name = "may_open", .pre_handler = entry_may_open };
static struct kprobe kp_finish_open = { .symbol_name = "finish_open", .pre_handler = entry_finish_open };
static struct kprobe kp_fd_install = { .symbol_name = "fd_install", .pre_handler = entry_fd_install };

static struct kretprobe krp_do_sys_open = { .kp.symbol_name = "do_sys_open", .handler = ret_do_sys_open };
static struct kretprobe krp_path_openat = { .kp.symbol_name = "path_openat", .handler = ret_path_openat };
static struct kretprobe krp_link_path_walk = { .kp.symbol_name = "link_path_walk", .handler = ret_link_path_walk };
static struct kretprobe krp_lookup_open = { .kp.symbol_name = "lookup_open.isra.0", .handler = ret_lookup_open };
static struct kretprobe krp_may_open = { .kp.symbol_name = "may_open", .handler = ret_may_open };
static struct kretprobe krp_finish_open = { .kp.symbol_name = "finish_open", .handler = ret_finish_open };

static int __init trace_open_path_init(void) {
    int ret, count = 0;
    pr_info("%s: Loading driver (target=%s)\n", DRIVER_NAME, target_comm);
    ret = register_kprobe(&kp_do_sys_open); if (ret < 0) goto err1; count++;
    ret = register_kprobe(&kp_path_openat); if (ret < 0) goto err2; count++;
    ret = register_kprobe(&kp_link_path_walk); if (ret < 0) goto err3; count++;
    ret = register_kprobe(&kp_lookup_open); if (ret < 0) goto err4; count++;
    ret = register_kprobe(&kp_may_open); if (ret < 0) goto err5; count++;
    ret = register_kprobe(&kp_finish_open); if (ret < 0) goto err6; count++;
    ret = register_kprobe(&kp_fd_install); if (ret < 0) goto err7; count++;
    ret = register_kretprobe(&krp_do_sys_open); if (ret < 0) goto err8; count++;
    ret = register_kretprobe(&krp_path_openat); if (ret < 0) goto err9; count++;
    ret = register_kretprobe(&krp_link_path_walk); if (ret < 0) goto err10; count++;
    ret = register_kretprobe(&krp_lookup_open); if (ret < 0) goto err11; count++;
    ret = register_kretprobe(&krp_may_open); if (ret < 0) goto err12; count++;
    ret = register_kretprobe(&krp_finish_open); if (ret < 0) goto err13; count++;
    pr_info("%s: Registered %d probes successfully\n", DRIVER_NAME, count);
    return 0;
err13: unregister_kretprobe(&krp_may_open);
err12: unregister_kretprobe(&krp_lookup_open);
err11: unregister_kretprobe(&krp_link_path_walk);
err10: unregister_kretprobe(&krp_path_openat);
err9: unregister_kretprobe(&krp_do_sys_open);
err8:  unregister_kprobe(&kp_fd_install);
err7:  unregister_kprobe(&kp_finish_open);
err6:  unregister_kprobe(&kp_may_open);
err5:  unregister_kprobe(&kp_lookup_open);
err4:  unregister_kprobe(&kp_link_path_walk);
err3:  unregister_kprobe(&kp_path_openat);
err2:  unregister_kprobe(&kp_do_sys_open);
err1:  pr_err("%s: Failed to register probes: %d\n", DRIVER_NAME, ret); return ret;
}

static void __exit trace_open_path_exit(void) {
    unregister_kretprobe(&krp_finish_open);
    unregister_kretprobe(&krp_may_open);
    unregister_kretprobe(&krp_lookup_open);
    unregister_kretprobe(&krp_link_path_walk);
    unregister_kretprobe(&krp_path_openat);
    unregister_kretprobe(&krp_do_sys_open);
    unregister_kprobe(&kp_fd_install);
    unregister_kprobe(&kp_finish_open);
    unregister_kprobe(&kp_may_open);
    unregister_kprobe(&kp_lookup_open);
    unregister_kprobe(&kp_link_path_walk);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_do_sys_open);
    pr_info("%s: Unloaded driver\n", DRIVER_NAME);
}

module_init(trace_open_path_init);
module_exit(trace_open_path_exit);
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Trace Analysis");
MODULE_DESCRIPTION("Trace file open path for existing files");
MODULE_VERSION("1.0.0");
