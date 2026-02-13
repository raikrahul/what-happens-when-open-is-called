/*
 * trace_do_sys_openat2.c
 *
 * kprobe + kretprobe on do_sys_openat2
 *
 * Entry:  logs dfd, filename pointer (user-space), filename string
 * Return: logs fd (returned file descriptor)
 *
 * Proof target:
 *   dfd == AT_FDCWD (-100)          → glibc inserted it
 *   filename == user .rodata addr   → same buffer from user-space
 *   fd == user-space open() return  → end-to-end match
 *
 * fs/open.c line 1420:
 *   static int do_sys_openat2(int dfd,
 *                             const char __user *filename,
 *                             struct open_how *how)
 *
 * x86_64 ABI:
 *   regs->di = dfd  (sign-extended int)
 *   regs->si = filename (__user pointer)
 *   regs->dx = how  (kernel pointer)
 *   return in regs->ax = fd (int)
 */

#include <linux/fs_struct.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/ptrace.h>
#include <linux/sched.h>
#include <linux/uaccess.h>

MODULE_LICENSE("GPL");

static char *target_comm = "case1_relativ";
module_param(target_comm, charp, 0644);

static struct kprobe kp_openat2;
static struct kretprobe rp_openat2;

static inline int is_target(void) {
  return (strcmp(current->comm, target_comm) == 0);
}

/* ── kprobe entry: do_sys_openat2 ── */
static int openat2_entry(struct kprobe *p, struct pt_regs *regs) {
  char buf[256];
  long copied;
  int dfd;
  const char __user *ufilename;

  if (!is_target())
    return 0;

  dfd = (int)regs->di;
  ufilename = (const char __user *)regs->si;

  /* Copy the filename from user-space into kernel buffer */
  copied = strncpy_from_user(buf, ufilename, sizeof(buf) - 1);
  if (copied < 0) {
    pr_info("[OPENAT2] ENTRY pid=%d comm=%s dfd=%d filename_uptr=0x%px (copy "
            "failed)\n",
            current->pid, current->comm, dfd, ufilename);
    return 0;
  }
  buf[copied] = '\0';

  pr_info("[OPENAT2] ENTRY pid=%d comm=%s dfd=%d filename_uptr=0x%px "
          "filename=\"%s\"\n",
          current->pid, current->comm, dfd, ufilename, buf);

  /* Axiomatic check: AT_FDCWD = -100 */
  if (dfd == -100) {
    pr_info("[OPENAT2] PROOF: dfd == AT_FDCWD (-100) CONFIRMED\n");
    pr_info(
        "[OPENAT2] PROOF: dfd==-100 → kernel uses current->fs->pwd = \"%s\"\n",
        current->fs->pwd.dentry->d_name.name);
  } else {
    pr_info("[OPENAT2] PROOF: dfd == %d (NOT AT_FDCWD)\n", dfd);
    pr_info("[OPENAT2] PROOF: dfd!=-100 → kernel ignores pwd, but "
            "current->fs->pwd = \"%s\"\n",
            current->fs->pwd.dentry->d_name.name);
  }

  return 0;
}

/* ── kretprobe return: do_sys_openat2 ── */
static int openat2_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  int fd;

  if (!is_target())
    return 0;

  fd = (int)regs->ax;

  pr_info("[OPENAT2] RETURN pid=%d comm=%s fd=%d\n", current->pid,
          current->comm, fd);

  if (fd >= 0)
    pr_info("[OPENAT2] PROOF: fd=%d (success, valid descriptor)\n", fd);
  else
    pr_info("[OPENAT2] PROOF: fd=%d (error: %d)\n", fd, fd);

  return 0;
}

static int __init trace_openat2_init(void) {
  int r;

  kp_openat2.symbol_name = "do_sys_openat2";
  kp_openat2.pre_handler = openat2_entry;
  r = register_kprobe(&kp_openat2);
  if (r < 0) {
    pr_err("trace_do_sys_openat2: kprobe register failed: %d\n", r);
    return r;
  }

  rp_openat2.kp.symbol_name = "do_sys_openat2";
  rp_openat2.handler = openat2_ret;
  rp_openat2.maxactive = 20;
  r = register_kretprobe(&rp_openat2);
  if (r < 0) {
    pr_err("trace_do_sys_openat2: kretprobe register failed: %d\n", r);
    unregister_kprobe(&kp_openat2);
    return r;
  }

  pr_info("trace_do_sys_openat2: loaded, target_comm=%s\n", target_comm);
  return 0;
}

static void __exit trace_openat2_exit(void) {
  unregister_kretprobe(&rp_openat2);
  unregister_kprobe(&kp_openat2);
  pr_info("trace_do_sys_openat2: unloaded\n");
}

module_init(trace_openat2_init);
module_exit(trace_openat2_exit);
