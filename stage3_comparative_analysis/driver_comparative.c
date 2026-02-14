/*
 * driver_comparative.c
 * 
 * Comprehensive VFS probe driver to capture and compare:
 * - File creation path (O_CREAT)
 * - File lookup path (open existing)
 * 
 * Probes key functions to show differences in kernel path
 */

#include <linux/dcache.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/namei.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <linux/types.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("VFS Analysis");
MODULE_DESCRIPTION("Comparative VFS path analysis: create vs open");
MODULE_VERSION("1.0");

static char target_comm[64] = "";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);
MODULE_PARM_DESC(target_comm, "Filter: only trace this process name");

static atomic_t probe_count = ATOMIC_INIT(0);

/* List of functions to probe - organized by VFS layer */
static const char *probe_list[] = {
    /* Entry points */
    "do_sys_openat2",
    "do_filp_open", 
    
    /* Path resolution */
    "path_openat",
    "path_init",
    "link_path_walk",
    
    /* Lookup stage */
    "open_last_lookups",
    "lookup_open",
    "lookup_fast",
    
    /* Dentry operations - KEY DIFFERENCE AREA */
    "__d_lookup_rcu",
    "d_lookup",
    "d_alloc",
    "d_alloc_parallel",
    "d_instantiate", 
    "d_revalidate",
    
    /* Filesystem operations */
    "vfs_create",
    "vfs_open",
    "do_dentry_open",
    
    /* File allocation */
    "alloc_empty_file",
    "init_file",
    
    /* Hash operations */
    "full_name_hash",
};

#define MAX_PROBES 21
static struct kprobe probes[MAX_PROBES];
static int num_probes_registered = 0;

/* Generic entry handler */
static int probe_entry(struct kprobe *p, struct pt_regs *regs)
{
    const char *func_name;
    int count;
    
    /* Filter by process name if specified */
    if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
        return 0;
    
    func_name = p->symbol_name;
    count = atomic_inc_return(&probe_count);
    
    /* Log the probe hit */
    pr_info("[PROBE:%03d] ENTRY: %s pid=%d comm=%s\n", 
            count, func_name, current->pid, current->comm);
    
    /* Function-specific logging */
    if (strcmp(func_name, "do_sys_openat2") == 0) {
        /* args: dfd, filename, struct open_how */
        const char __user *filename = (const char __user *)regs->si;
        pr_info("[PROBE:%03d]   filename=%pS\n", count, filename);
    }
    else if (strcmp(func_name, "link_path_walk") == 0) {
        /* arg: const char *name */
        const char *name = (const char *)regs->di;
        if (name && !IS_ERR(name))
            pr_info("[PROBE:%03d]   path=%s\n", count, name);
    }
    else if (strcmp(func_name, "lookup_fast") == 0) {
        /* This is critical - shows cache hit or miss */
        pr_info("[PROBE:%03d]   [LOOKUP_FAST] Attempting cache lookup\n", count);
    }
    else if (strcmp(func_name, "__d_lookup_rcu") == 0) {
        /* Fast lookup - only for existing files */
        pr_info("[PROBE:%03d]   [D_LOOKUP_RCU] Fast RCU lookup (CACHE HIT PATH)\n", count);
    }
    else if (strcmp(func_name, "d_alloc") == 0) {
        /* New dentry allocation - only for file creation */
        pr_info("[PROBE:%03d]   [D_ALLOC] Allocating NEW dentry (CREATION PATH)\n", count);
    }
    else if (strcmp(func_name, "d_instantiate") == 0) {
        /* Linking dentry to inode - only for creation */
        pr_info("[PROBE:%03d]   [D_INSTANTIATE] Linking dentry to inode (CREATION PATH)\n", count);
    }
    else if (strcmp(func_name, "vfs_create") == 0) {
        /* Filesystem create operation - only for O_CREAT */
        pr_info("[PROBE:%03d]   [VFS_CREATE] Calling filesystem create (CREATION PATH)\n", count);
    }
    else if (strcmp(func_name, "d_revalidate") == 0) {
        /* Validating existing dentry - only for lookup */
        pr_info("[PROBE:%03d]   [D_REVALIDATE] Validating dentry (LOOKUP PATH)\n", count);
    }
    
    return 0;
}

/* Module init */
static int __init comparative_probe_init(void)
{
    int i, ret;
    
    num_probes_registered = 0;
    atomic_set(&probe_count, 0);
    
    pr_info("Comparative VFS Probe: Initializing %d probes\n", MAX_PROBES);
    
    for (i = 0; i < MAX_PROBES; i++) {
        probes[i].symbol_name = probe_list[i];
        probes[i].pre_handler = probe_entry;
        
        ret = register_kprobe(&probes[i]);
        if (ret < 0) {
            pr_warn("Failed to register probe on %s (err=%d)\n", 
                    probe_list[i], ret);
            probes[i].symbol_name = NULL; /* Mark as failed */
        } else {
            num_probes_registered++;
            pr_info("  + Registered: %s\n", probe_list[i]);
        }
    }
    
    pr_info("Comparative VFS Probe: %d/%d probes registered\n", 
            num_probes_registered, MAX_PROBES);
    
    if (target_comm[0]) {
        pr_info("Filtering for process: %s\n", target_comm);
    } else {
        pr_info("No process filter (tracing all)\n");
    }
    
    return 0;
}

/* Module exit */
static void __exit comparative_probe_exit(void)
{
    int i;
    int unregistered = 0;
    
    for (i = 0; i < MAX_PROBES; i++) {
        if (probes[i].symbol_name != NULL) {
            unregister_kprobe(&probes[i]);
            unregistered++;
        }
    }
    
    pr_info("Comparative VFS Probe: Unregistered %d probes\n", unregistered);
    pr_info("Total probe hits: %d\n", atomic_read(&probe_count));
}

module_init(comparative_probe_init);
module_exit(comparative_probe_exit);
