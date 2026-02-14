#include <linux/dcache.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/namei.h>
#include <linux/ptrace.h>
#include <linux/string.h>
#include <linux/types.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("rahultest");
MODULE_DESCRIPTION("Case17 training driver: do_filp_open + __d_alloc");

static char target_comm[TASK_COMM_LEN] = "openat_raw";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);
MODULE_PARM_DESC(target_comm, "Process comm filter");

static char target_name[128] = "missing_case17_raw_syscall";
module_param_string(target_name, target_name, sizeof(target_name), 0644);
MODULE_PARM_DESC(target_name, "Filename substring filter from qstr->name");

static bool trace_enabled;
static pid_t trace_tgid = -1;
static pid_t trace_pid = -1;

/*
 * Probe object names are intentionally explicit.
 */
static struct kprobe kprobe_do_filp_open_entry = {
    .symbol_name = "do_filp_open",
};

static struct kretprobe kretprobe_do_filp_open_return = {
    .kp = {
        .symbol_name = "do_filp_open",
    },
    .maxactive = 64,
};

static struct kprobe kprobe_d_alloc_parallel_entry = {
    .symbol_name = "d_alloc_parallel",
};

static struct kprobe kprobe_d_alloc_entry = {
    .symbol_name = "__d_alloc",
};

static struct kretprobe kretprobe_d_alloc_return = {
    .kp = {
        .symbol_name = "__d_alloc",
    },
    .maxactive = 64,
};

static bool should_trace_this_task(void)
{
    if (!trace_enabled)
        return false;

    if (trace_tgid > 0)
        return current->tgid == trace_tgid;

    if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
        return false;

    return true;
}

static int probe_do_filp_open_entry_capture_filename(struct kprobe *probe,
                                                     struct pt_regs *regs)
{
    struct filename *pathname = (struct filename *)regs->si;

    if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
        return 0;

    if (!pathname || !pathname->name)
        return 0;

    if (target_name[0] && !strstr(pathname->name, target_name))
        return 0;

    trace_enabled = true;
    trace_tgid = current->tgid;
    trace_pid = current->pid;

    printk(KERN_INFO
           "[C17][do_filp_open][ENTRY] pid=%d tgid=%d pathname_ptr=%px name=%s\n",
           current->pid, current->tgid, pathname, pathname->name);
    return 0;
}

static int probe_do_filp_open_return_capture_ret(struct kretprobe_instance *ri,
                                                 struct pt_regs *regs)
{
    long ret = regs_return_value(regs);

    if (!trace_enabled)
        return 0;

    if (trace_tgid > 0 && current->tgid != trace_tgid)
        return 0;

    printk(KERN_INFO
           "[C17][do_filp_open][RET] pid=%d tgid=%d ret_ptr=%px is_err=%d err=%ld\n",
           current->pid, current->tgid, (void *)ret, IS_ERR((void *)ret) ? 1 : 0,
           IS_ERR((void *)ret) ? -PTR_ERR((void *)ret) : 0L);
    return 0;
}

static int probe_d_alloc_entry_capture_qstr(struct kprobe *probe,
                                            struct pt_regs *regs)
{
    struct qstr *name = (struct qstr *)regs->si;
    int n = 0;

    if (!should_trace_this_task())
        return 0;

    if (!name || !name->name)
        return 0;

    if (target_name[0] && !strstr(name->name, target_name))
        return 0;

    n = (name->len > 96) ? 96 : (int)name->len;

    printk(KERN_INFO
           "[C17][__d_alloc][ENTRY] pid=%d tgid=%d qstr_ptr=%px name_ptr=%px len=%u hash=0x%x name=%.*s\n",
           current->pid, current->tgid, name, name->name, name->len, name->hash,
           n, name->name);

    /*
     * TODO(USER_FUN_01): hash arithmetic by hand from raw qstr bytes.
     * Axiom numbers first, then code:
     * 1) Take first 8 bytes of `name` and write decimal byte values.
     * 2) Write your per-byte combine rule explicitly.
     * 3) Compute intermediate hash after each byte: H0,H1,H2...H8.
     * 4) Compare your final H with printed qstr.hash.
     */

    return 0;
}

static int probe_d_alloc_parallel_entry_capture_parent(struct kprobe *probe,
                                                       struct pt_regs *regs)
{
    struct dentry *parent = (struct dentry *)regs->di;
    struct qstr *name = (struct qstr *)regs->si;
    const char *parent_name = NULL;
    unsigned int parent_name_len = 0;
    int child_n = 0;
    int parent_n = 0;

    if (!should_trace_this_task())
        return 0;

    if (!parent || !name || !name->name)
        return 0;

    if (target_name[0] && !strstr(name->name, target_name))
        return 0;

    parent_name = parent->d_name.name;
    parent_name_len = parent->d_name.len;
    child_n = (name->len > 96) ? 96 : (int)name->len;
    parent_n = (parent_name_len > 96) ? 96 : (int)parent_name_len;

    printk(KERN_INFO
           "[C17][d_alloc_parallel][ENTRY] pid=%d tgid=%d parent=%px parent_inode=%px parent_name=%.*s child_name=%.*s parent_sb=%px sb_magic=0x%lx sb_blocksize=%lu\n",
           current->pid, current->tgid, parent, parent->d_inode, parent_n,
           parent_name ? parent_name : "<null>", child_n, name->name,
           parent->d_sb,
           parent->d_sb ? parent->d_sb->s_magic : 0UL,
           parent->d_sb ? parent->d_sb->s_blocksize : 0UL);

    /*
     * TODO(USER_FUN_03): parent + superblock notebook.
     * 1) Write 3 pointers in one row: parent, parent->d_sb, parent->d_inode.
     * 2) Write sb_magic decimal + hex and map it to filesystem manually.
     * 3) Write parent_name.len and count actual bytes of parent_name by hand.
     * 4) Write why child_name goes to __d_alloc(parent->d_sb, name).
     */

    return 0;
}

static int probe_d_alloc_return_capture_dentry(struct kretprobe_instance *ri,
                                               struct pt_regs *regs)
{
    struct dentry *new_dentry = (struct dentry *)regs_return_value(regs);

    if (!trace_enabled)
        return 0;

    if (trace_tgid > 0 && current->tgid != trace_tgid)
        return 0;

    if (IS_ERR(new_dentry)) {
        printk(KERN_INFO
               "[C17][__d_alloc][RET] pid=%d tgid=%d err=%ld\n",
               current->pid, current->tgid, -PTR_ERR(new_dentry));
        return 0;
    }

    if (!new_dentry) {
        printk(KERN_INFO
               "[C17][__d_alloc][RET] pid=%d tgid=%d dentry=NULL\n",
               current->pid, current->tgid);
        return 0;
    }

    printk(KERN_INFO
           "[C17][__d_alloc][RET] pid=%d tgid=%d dentry=%px inode=%px unhashed=%d in_lookup=%d name.hash=0x%x name.len=%u name_ptr=%px\n",
           current->pid, current->tgid, new_dentry, new_dentry->d_inode,
           d_unhashed(new_dentry) ? 1 : 0, d_in_lookup(new_dentry) ? 1 : 0,
           new_dentry->d_name.hash, new_dentry->d_name.len,
           new_dentry->d_name.name);

    /*
     * TODO(USER_FUN_02): dentry memory-state notebook.
     * Axiom numbers first, then code:
     * 1) Track three addresses exactly: dentry, d_name.name, d_inode.
     * 2) Write numeric state vector S = [inode_is_null, unhashed, in_lookup].
     * 3) For 5 runs, build table: run_id -> S and hash.
     * 4) Add your own derived invariant in code comments after the table.
     */

    return 0;
}

static int __init case17_filp_open_plus_dalloc_init(void)
{
    int ret;

    kprobe_do_filp_open_entry.pre_handler = probe_do_filp_open_entry_capture_filename;
    ret = register_kprobe(&kprobe_do_filp_open_entry);
    if (ret) {
        printk(KERN_ERR "[C17] register kprobe(do_filp_open) failed: %d\n", ret);
        return ret;
    }

    kretprobe_do_filp_open_return.handler = probe_do_filp_open_return_capture_ret;
    ret = register_kretprobe(&kretprobe_do_filp_open_return);
    if (ret) {
        printk(KERN_ERR "[C17] register kretprobe(do_filp_open) failed: %d\n",
               ret);
        unregister_kprobe(&kprobe_do_filp_open_entry);
        return ret;
    }

    kprobe_d_alloc_parallel_entry.pre_handler =
        probe_d_alloc_parallel_entry_capture_parent;
    ret = register_kprobe(&kprobe_d_alloc_parallel_entry);
    if (ret) {
        printk(KERN_ERR "[C17] register kprobe(d_alloc_parallel) failed: %d\n",
               ret);
        unregister_kretprobe(&kretprobe_do_filp_open_return);
        unregister_kprobe(&kprobe_do_filp_open_entry);
        return ret;
    }

    kprobe_d_alloc_entry.pre_handler = probe_d_alloc_entry_capture_qstr;
    ret = register_kprobe(&kprobe_d_alloc_entry);
    if (ret) {
        printk(KERN_ERR "[C17] register kprobe(__d_alloc) failed: %d\n", ret);
        unregister_kprobe(&kprobe_d_alloc_parallel_entry);
        unregister_kretprobe(&kretprobe_do_filp_open_return);
        unregister_kprobe(&kprobe_do_filp_open_entry);
        return ret;
    }

    kretprobe_d_alloc_return.handler = probe_d_alloc_return_capture_dentry;
    ret = register_kretprobe(&kretprobe_d_alloc_return);
    if (ret) {
        printk(KERN_ERR "[C17] register kretprobe(__d_alloc) failed: %d\n",
               ret);
        unregister_kprobe(&kprobe_d_alloc_entry);
        unregister_kprobe(&kprobe_d_alloc_parallel_entry);
        unregister_kretprobe(&kretprobe_do_filp_open_return);
        unregister_kprobe(&kprobe_do_filp_open_entry);
        return ret;
    }

    printk(KERN_INFO
           "[C17] Loaded: do_filp_open + d_alloc_parallel + __d_alloc | target_comm=%s target_name=%s\n",
           target_comm, target_name);
    return 0;
}

static void __exit case17_filp_open_plus_dalloc_exit(void)
{
    unregister_kretprobe(&kretprobe_d_alloc_return);
    unregister_kprobe(&kprobe_d_alloc_entry);
    unregister_kprobe(&kprobe_d_alloc_parallel_entry);
    unregister_kretprobe(&kretprobe_do_filp_open_return);
    unregister_kprobe(&kprobe_do_filp_open_entry);
    printk(KERN_INFO "[C17] Unloaded: do_filp_open + d_alloc_parallel + __d_alloc\n");
}

module_init(case17_filp_open_plus_dalloc_init);
module_exit(case17_filp_open_plus_dalloc_exit);
