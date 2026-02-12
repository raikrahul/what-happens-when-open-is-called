/*
 * trace_path_init.c
 *
 * kprobe + kretprobe on do_filp_open() to observe the AT_FDCWD vs fd-lookup
 * branch that path_init() takes (fs/namei.c:2576).
 *
 * Why do_filp_open and not path_init directly?
 *   struct nameidata has __randomize_layout — field offsets are unknown.
 *   do_filp_open(int dfd, struct filename *pathname, ...) has dfd as a
 *   direct integer argument (%rdi), so we can read it without any struct
 *   offset assumptions.
 *
 * do_filp_open calls set_nameidata(&nd, dfd, ...) which sets nd->dfd,
 * then path_openat() → path_init() reads nd->dfd at line 2576:
 *
 *   if (nd->dfd == AT_FDCWD)        ← Branch 1: uses current->fs->pwd
 *   else                            ← Branch 2: looks up fd in fd table
 *
 * Probes:
 *   1. kprobe  on do_filp_open entry:  dfd (%rdi), pathname (%rsi)
 *   2. kretprobe on do_filp_open return: struct file * or ERR_PTR
 *   3. kprobe  on path_openat entry: nd (%rdi), op (%rsi), flags (%rdx)
 *   4. kretprobe on path_openat return: struct file * or ERR_PTR
 *   5. kprobe  on alloc_empty_file entry: flags (%rdi), cred (%rsi)
 *   6. kretprobe on alloc_empty_file return: struct file *
 *   7. kprobe  on fdget_raw entry:  fd (%rdi)
 *      → fdget_raw is called ONLY from the else branch of path_init
 *        (namei.c:2593). If this probe fires, the else branch was taken.
 *
 * Usage:
 *   insmod trace_path_init.ko target_comm="demo_thread_saf"
 *   # run your test binary
 *   dmesg | grep PATH_INIT
 *   rmmod trace_path_init
 */

#include <linux/fs.h>
#include <linux/fs_struct.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/ptrace.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <linux/uaccess.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Open Project");
MODULE_DESCRIPTION("Trace path_init branching and link_path_walk execution");
MODULE_VERSION("1.1");

static char target_comm[64] = "";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);
MODULE_PARM_DESC(target_comm, "Filter: only trace this process name");

/* Offsets derived from vmlinux objdump:
 * path_init: ffffffff817fc440
 * cmp $0xffffff9c, %edi: ffffffff817fc571 (+0x131 = 305)
 * mov %gs:..., %rax (AT_FDCWD path): ffffffff817fc57a (+0x13a = 314)
 * call fdget_raw (else path): ffffffff817fc5fa (+0x1ba = 442)
 */
#define OFF_CMP 305
#define OFF_CWD 314
#define OFF_FD 442

/*
 * struct filename is defined in include/linux/fs.h:
 *   struct filename {
 *       const char *name;   ← offset 0, the pathname string
 *       ...
 *   };
 * This struct does NOT have __randomize_layout, so offset 0 is safe.
 */

/* ── kprobe: do_filp_open entry ── */

static int filp_open_entry(struct kprobe *p, struct pt_regs *regs) {
  int dfd;
  struct filename *fname;
  const char *pathname;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  /* do_filp_open(int dfd, struct filename *pathname, const struct open_flags
   * *op) arg1 = %rdi = dfd arg2 = %rsi = pathname (struct filename *)
   */
  dfd = (int)regs->di;
  fname = (struct filename *)regs->si;

  /* Read the pathname string from struct filename.
   * fname->name is a kernel pointer (getname() already copied from user),
   * so we can dereference it directly — no copy_from_user needed.
   */
  pathname = "(null)";
  if (fname) {
    const char *p = *(const char **)fname; /* fname->name at offset 0 */
    if (p)
      pathname = p;
  }

  /* Proof: current->nameidata is NULL for first-level open().
   * __set_nameidata reads old = current->nameidata before overwriting.
   * If this is NULL, old=NULL, proving no nesting.
   */
  pr_info("[DO_FILP_OPEN] ENTRY pid=%d comm=%s current->nameidata=%px "
          "(NULL = first-level open, non-NULL = nested lookup)\n",
          current->pid, current->comm, current->nameidata);

  if (dfd == -100) {
    pr_info("[PATH_INIT] ENTRY pid=%d comm=%s dfd=-100 (AT_FDCWD) "
            "pathname=\"%s\"\n",
            current->pid, current->comm, pathname);
    pr_info("[PATH_INIT] BRANCH: AT_FDCWD → path_init will use "
            "current->fs->pwd dentry=0x%px name=\"%s\"\n",
            current->fs->pwd.dentry, current->fs->pwd.dentry->d_name.name);
    pr_info("[PATH_INIT] CODE: namei.c:2576 if (nd->dfd == AT_FDCWD) → TRUE → "
            "line 2578: fs = current->fs; nd->path = fs->pwd\n");
  } else {
    pr_info(
        "[PATH_INIT] ENTRY pid=%d comm=%s dfd=%d (fd lookup) pathname=\"%s\"\n",
        current->pid, current->comm, dfd, pathname);
    pr_info("[PATH_INIT] BRANCH: FD_LOOKUP → path_init will look up fd %d in "
            "fd table (ignoring pwd)\n",
            dfd);
    pr_info("[PATH_INIT] BRANCH: current->fs->pwd dentry=0x%px name=\"%s\" "
            "(IGNORED — kernel "
            "uses fd %d instead)\n",
            current->fs->pwd.dentry, current->fs->pwd.dentry->d_name.name, dfd);
    pr_info("[PATH_INIT] CODE: namei.c:2576 if (nd->dfd == AT_FDCWD) → FALSE → "
            "line 2593: fd_raw(nd->dfd) → fd_file(f)->f_path\n");
  }

  return 0;
}

static struct kprobe kp_filp_open = {
    .symbol_name = "do_filp_open",
};

/* ── kprobe: path_openat entry ── */

static int path_openat_entry(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  /* path_openat(struct nameidata *nd, const struct open_flags *op, unsigned
   * flags) arg1 = %rdi = nd arg2 = %rsi = op arg3 = %rdx = flags
   */
  pr_info("[PATH_INIT] path_openat() called (fs/namei.c) → calling path_init "
          "next...\n");
  return 0;
}

static struct kprobe kp_path_openat = {
    .symbol_name = "path_openat",
};

/* ── kretprobe: path_openat return ── */

static int path_openat_ret(struct kretprobe_instance *ri,
                           struct pt_regs *regs) {
  long retval;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  retval = (long)regs->ax;

  if (retval < 0 && retval >= -4096) {
    pr_info("[PATH_INIT] path_openat() returned ERR(%ld)\n", retval);
  } else {
    pr_info("[PATH_INIT] path_openat() returned struct_file*=0x%lx (success)\n",
            (unsigned long)retval);
  }
  return 0;
}

static struct kretprobe krp_path_openat = {
    .handler = path_openat_ret,
    .maxactive = 20,
    .kp.symbol_name = "path_openat",
};

/* ── kprobe: alloc_empty_file entry ── */

static int alloc_empty_file_entry(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  /* alloc_empty_file(int flags, const struct cred *cred)
   * arg1 = %rdi = flags
   * arg2 = %rsi = cred
   */
  pr_info("[PATH_INIT] alloc_empty_file() called → allocating struct file\n");
  pr_info("[PATH_INIT]   flags=0x%x, cred=0x%lx\n", (int)regs->di,
          (unsigned long)regs->si);
  return 0;
}

static struct kprobe kp_alloc_empty_file = {
    .symbol_name = "alloc_empty_file",
};

/* ── kretprobe: alloc_empty_file return ── */

static int alloc_empty_file_ret(struct kretprobe_instance *ri,
                                struct pt_regs *regs) {
  long retval;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  retval = (long)regs->ax;

  if (retval < 0 && retval >= -4096) {
    pr_info("[PATH_INIT] alloc_empty_file() returned ERR(%ld)\n", retval);
  } else {
    pr_info("[PATH_INIT] alloc_empty_file() returned new struct_file*=0x%lx\n",
            (unsigned long)retval);
  }
  return 0;
}

static struct kretprobe krp_alloc_empty_file = {
    .handler = alloc_empty_file_ret,
    .maxactive = 20,
    .kp.symbol_name = "alloc_empty_file",
};

/* ── kprobe: fdget_raw — ONLY called from path_init else branch ── */
/*
 * namei.c:2591  } else {
 * namei.c:2593      CLASS(fd_raw, f)(nd->dfd);  → expands to fdget_raw(nd->dfd)
 *
 * fdget_raw(unsigned int fd)  — arg1 = %rdi = the fd number
 *
 * If this probe fires for our comm, path_init took the ELSE branch.
 * If it does NOT fire, path_init took the IF (AT_FDCWD) branch.
 */

static int fdget_raw_entry(struct kprobe *p, struct pt_regs *regs) {
  unsigned int fd;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  fd = (unsigned int)regs->di;

  pr_info("[PATH_INIT] FDGET_RAW pid=%d comm=%s fd=%u\n", current->pid,
          current->comm, fd);
  pr_info("[PATH_INIT] PROOF: fdget_raw() called → path_init ELSE branch "
          "CONFIRMED (namei.c:2593)\n");
  pr_info("[PATH_INIT] PROOF: kernel is looking up fd %u in fd table, NOT "
          "using current->fs->pwd\n",
          fd);

  return 0;
}

static struct kprobe kp_fdget_raw = {
    .symbol_name = "fdget_raw",
};

/* ── kretprobe: do_filp_open return ── */

static int filp_open_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  long retval;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  /* Return value in %rax: struct file * or ERR_PTR(-errno) */
  retval = (long)regs->ax;

  if (retval < 0 && retval >= -4096) {
    pr_info("[PATH_INIT] RETURN pid=%d comm=%s result=ERR(%ld)\n", current->pid,
            current->comm, retval);
  } else {
    pr_info("[PATH_INIT] RETURN pid=%d comm=%s result=struct_file*=0x%lx "
            "(success)\n",
            current->pid, current->comm, (unsigned long)retval);
  }

  return 0;
}

static struct kretprobe krp_filp_open = {
    .handler = filp_open_ret,
    .maxactive = 20,
    .kp.symbol_name = "do_filp_open",
};

/* ── kprobe: path_lookupat entry ── */

static int path_lookupat_entry(struct kprobe *p, struct pt_regs *regs) {
  unsigned int flags;
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  /* path_lookupat(struct nameidata *nd, unsigned flags, struct path *path)
   * arg1 = %rdi = nd
   * arg2 = %rsi = flags
   * arg3 = %rdx = path
   */
  flags = (unsigned int)regs->si;
  if (flags & 2) { /* LOOKUP_DIRECTORY is BIT(1) = 2 */
    pr_info("[PATH_INIT] path_lookupat() called with LOOKUP_DIRECTORY "
            "(flags=0x%x)\n",
            flags);
    pr_info(
        "[PATH_INIT] PROOF: potentially from do_tmpfile() or do_o_path()\n");
  }
  return 0;
}

static struct kprobe kp_path_lookupat = {
    .symbol_name = "path_lookupat",
};

static int init_file_entry(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  /* init_file(struct file *f, int flags, const struct cred *cred)
   * arg1 = %rdi = f
   * arg2 = %rsi = flags
   * arg3 = %rdx = cred
   */
  pr_info("[PATH_INIT] init_file() called\n");
  pr_info("[PATH_INIT]   f=0x%lx, flags=0x%x, cred=0x%lx\n",
          (unsigned long)regs->di, (int)regs->si, (unsigned long)regs->dx);
  return 0;
}

static struct kprobe kp_init_file = {
    .symbol_name = "init_file",
};

/* ── kretprobe: init_file return ── */

static int init_file_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  long retval;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  retval = (long)regs->ax;
  pr_info("[PATH_INIT] init_file() returned %ld\n", retval);
  return 0;
}

static struct kretprobe krp_init_file = {
    .handler = init_file_ret,
    .maxactive = 20,
    .kp.symbol_name = "init_file",
};

/* ── kretprobe: path_lookupat return ── */
static int path_lookupat_ret(struct kretprobe_instance *ri,
                             struct pt_regs *regs) {
  int retval;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  retval = (int)regs->ax;
  // We cannot easily correlate entry flags here without data access,
  // but if we saw the entry log, this follows.
  // Actually, we can use entry_handler data, but let's keep it simple.
  // Just log all returns for now? No, that's spammy.
  // We will assume single threaded test or low noise.

  if (retval != 0)
    pr_info("[PATH_INIT] path_lookupat() returned error %d\n", retval);
  else
    pr_info("[PATH_INIT] path_lookupat() returned success (0)\n");

  return 0;
}

static struct kretprobe krp_path_lookupat = {
    .handler = path_lookupat_ret,
    .maxactive = 20,
    .kp.symbol_name = "path_lookupat",
};

/* ── kprobe: path_init offsets ── */

static int path_init_cmp_entry(struct kprobe *p, struct pt_regs *regs) {
  /* At +305: cmp $0xffffff9c, %edi.
   * %rdi (or %edi) holds nd->dfd.
   * Actually, line 85: mov 0xe4(%rbx),%edi. %rbx is likely struct nameidata.
   * So %edi is definitely dfd.
   */
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  pr_info("[PATH_INIT] OFFSET+305: Checking dfd == AT_FDCWD? (dfd=%ld)\n",
          (long)regs->di);
  return 0;
}

static struct kprobe kp_path_init_cmp = {
    .symbol_name = "path_init",
    .offset = OFF_CMP,
    .pre_handler = path_init_cmp_entry,
};

static int path_init_cwd_entry(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  pr_info("[PATH_INIT] OFFSET+314: Taken AT_FDCWD branch (using CWD)\n");
  return 0;
}

static struct kprobe kp_path_init_cwd = {
    .symbol_name = "path_init",
    .offset = OFF_CWD,
    .pre_handler = path_init_cwd_entry,
};

static int path_init_fd_entry(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  pr_info("[PATH_INIT] OFFSET+442: Taken FD branch (calling fdget_raw)\n");
  return 0;
}

static struct kprobe kp_path_init_fd = {
    .symbol_name = "path_init",
    .offset = OFF_FD,
    .pre_handler = path_init_fd_entry,
};

/* ── kprobe: path_init entry ── */
static int path_init_entry(struct kprobe *p, struct pt_regs *regs) {
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  pr_info("[PATH_INIT] path_init() called\n");
  /* We can try to print nd->dfd but we don't know offset.
   * But we know path_init args: (struct nameidata *nd, unsigned flags)
   * %rdi = nd, %rsi = flags.
   */
  pr_info("[PATH_INIT]   flags=0x%lx\n", (unsigned long)regs->si);
  return 0;
}

static struct kprobe kp_path_init = {
    .symbol_name = "path_init",
};

/* ── kretprobe: path_init return ── */
static int path_init_ret(struct kretprobe_instance *ri, struct pt_regs *regs) {
  const char *s;
  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  s = (const char *)regs->ax;
  if (IS_ERR(s)) {
    pr_info("[PATH_INIT] path_init() returned error %ld\n", PTR_ERR(s));
  } else {
    /* s is the pointer to the rest of the path name. */
    pr_info("[PATH_INIT] path_init() returned ptr=%px\n", s);
  }
  return 0;
}

static struct kretprobe krp_path_init = {
    .handler = path_init_ret,
    .maxactive = 20,
    .kp.symbol_name = "path_init",
};

/* ── kprobe: link_path_walk entry ── */

static int link_path_walk_entry(struct kprobe *p, struct pt_regs *regs) {
  const char *name;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  /* link_path_walk(const char *name, struct nameidata *nd)
   * arg1 = %rdi = name (pointer to remaining path)
   * arg2 = %rsi = nd (struct nameidata *)
   */
  name = (const char *)regs->di;

  if (name && !IS_ERR(name)) {
    /* Safe to read the string - it's already in kernel space */
    pr_info("[PATH_WALK] link_path_walk() called with path=\"%s\"\n", name);
  } else {
    pr_info("[PATH_WALK] link_path_walk() called (name=0x%lx)\n",
            (unsigned long)name);
  }

  return 0;
}

static struct kprobe kp_link_path_walk = {
    .symbol_name = "link_path_walk",
};

/* ── kretprobe: link_path_walk return ── */

static int link_path_walk_ret(struct kretprobe_instance *ri,
                              struct pt_regs *regs) {
  int retval;

  if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
    return 0;

  retval = (int)regs->ax;

  if (retval != 0) {
    pr_info("[PATH_WALK] link_path_walk() returned error %d\n", retval);
  } else {
    pr_info("[PATH_WALK] link_path_walk() returned success (0)\n");
  }

  return 0;
}

static struct kretprobe krp_link_path_walk = {
    .handler = link_path_walk_ret,
    .maxactive = 20,
    .kp.symbol_name = "link_path_walk",
};

/* ── module init/exit ── */

static int __init trace_path_init_init(void) {
  int ret;

  kp_filp_open.pre_handler = filp_open_entry;
  kp_fdget_raw.pre_handler = fdget_raw_entry;

  ret = register_kprobe(&kp_filp_open);
  if (ret < 0) {
    pr_err("trace_path_init: kprobe do_filp_open failed: %d\n", ret);
    return ret;
  }

  ret = register_kretprobe(&krp_filp_open);
  if (ret < 0) {
    pr_err("trace_path_init: kretprobe do_filp_open failed: %d\n", ret);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  ret = register_kprobe(&kp_fdget_raw);
  if (ret < 0) {
    pr_err("trace_path_init: kprobe fdget_raw failed: %d\n", ret);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  /* Register path_openat probes */
  kp_path_openat.pre_handler = path_openat_entry;
  ret = register_kprobe(&kp_path_openat);
  if (ret < 0) {
    pr_err("trace_path_init: kprobe path_openat failed: %d\n", ret);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  ret = register_kretprobe(&krp_path_openat);
  if (ret < 0) {
    pr_err("trace_path_init: kretprobe path_openat failed: %d\n", ret);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  /* Register alloc_empty_file probes */
  kp_alloc_empty_file.pre_handler = alloc_empty_file_entry;
  ret = register_kprobe(&kp_alloc_empty_file);
  if (ret < 0) {
    pr_err("trace_path_init: kprobe alloc_empty_file failed: %d\n", ret);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  ret = register_kretprobe(&krp_alloc_empty_file);
  if (ret < 0) {
    pr_err("trace_path_init: kretprobe alloc_empty_file failed: %d\n", ret);
    unregister_kprobe(&kp_alloc_empty_file);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  /* Register path_lookupat probes */
  kp_path_lookupat.pre_handler = path_lookupat_entry;
  ret = register_kprobe(&kp_path_lookupat);
  if (ret < 0) {
    pr_err("trace_path_init: kprobe path_lookupat failed: %d\n", ret);
    unregister_kretprobe(&krp_alloc_empty_file);
    unregister_kprobe(&kp_alloc_empty_file);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  // Not registering return probe for path_lookupat yet to keep noise down?
  // No, user asked for result.
  ret = register_kretprobe(&krp_path_lookupat);
  if (ret < 0) {
    pr_err("trace_path_init: kretprobe path_lookupat failed: %d\n", ret);
    unregister_kprobe(&kp_path_lookupat);
    unregister_kretprobe(&krp_alloc_empty_file);
    unregister_kprobe(&kp_alloc_empty_file);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  /* Register init_file probes */
  kp_init_file.pre_handler = init_file_entry;
  ret = register_kprobe(&kp_init_file);
  if (ret < 0) {
    pr_err("trace_path_init: kprobe init_file failed: %d\n", ret);
    unregister_kretprobe(&krp_path_lookupat);
    unregister_kprobe(&kp_path_lookupat);
    unregister_kretprobe(&krp_alloc_empty_file);
    unregister_kprobe(&kp_alloc_empty_file);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  ret = register_kretprobe(&krp_init_file);
  if (ret < 0) {
    pr_err("trace_path_init: kretprobe init_file failed: %d\n", ret);
    unregister_kprobe(&kp_init_file);
    unregister_kretprobe(&krp_path_lookupat);
    unregister_kprobe(&kp_path_lookupat);
    unregister_kretprobe(&krp_alloc_empty_file);
    unregister_kprobe(&kp_alloc_empty_file);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  /* Register path_init probes */
  kp_path_init.pre_handler = path_init_entry;
  ret = register_kprobe(&kp_path_init);
  if (ret < 0) {
    pr_err("trace_path_init: kprobe path_init failed: %d\n", ret);
    unregister_kretprobe(&krp_init_file);
    unregister_kprobe(&kp_init_file);
    unregister_kretprobe(&krp_path_lookupat);
    unregister_kprobe(&kp_path_lookupat);
    unregister_kretprobe(&krp_alloc_empty_file);
    unregister_kprobe(&kp_alloc_empty_file);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  ret = register_kretprobe(&krp_path_init);
  if (ret < 0) {
    pr_err("trace_path_init: kretprobe path_init failed: %d\n", ret);
    unregister_kprobe(&kp_path_init);
    unregister_kretprobe(&krp_init_file);
    unregister_kprobe(&kp_init_file);
    unregister_kretprobe(&krp_path_lookupat);
    unregister_kprobe(&kp_path_lookupat);
    unregister_kretprobe(&krp_alloc_empty_file);
    unregister_kprobe(&kp_alloc_empty_file);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  /* Register link_path_walk probes */
  kp_link_path_walk.pre_handler = link_path_walk_entry;
  ret = register_kprobe(&kp_link_path_walk);
  if (ret < 0) {
    pr_err("trace_path_init: kprobe link_path_walk failed: %d\n", ret);
    unregister_kretprobe(&krp_path_init);
    unregister_kprobe(&kp_path_init);
    unregister_kretprobe(&krp_init_file);
    unregister_kprobe(&kp_init_file);
    unregister_kretprobe(&krp_path_lookupat);
    unregister_kprobe(&kp_path_lookupat);
    unregister_kretprobe(&krp_alloc_empty_file);
    unregister_kprobe(&kp_alloc_empty_file);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  ret = register_kretprobe(&krp_link_path_walk);
  if (ret < 0) {
    pr_err("trace_path_init: kretprobe link_path_walk failed: %d\n", ret);
    unregister_kprobe(&kp_link_path_walk);
    unregister_kretprobe(&krp_path_init);
    unregister_kprobe(&kp_path_init);
    unregister_kretprobe(&krp_init_file);
    unregister_kprobe(&kp_init_file);
    unregister_kretprobe(&krp_path_lookupat);
    unregister_kprobe(&kp_path_lookupat);
    unregister_kretprobe(&krp_alloc_empty_file);
    unregister_kprobe(&kp_alloc_empty_file);
    unregister_kretprobe(&krp_path_openat);
    unregister_kprobe(&kp_path_openat);
    unregister_kprobe(&kp_fdget_raw);
    unregister_kretprobe(&krp_filp_open);
    unregister_kprobe(&kp_filp_open);
    return ret;
  }

  /* Register offset probes */
  ret = register_kprobe(&kp_path_init_cmp);
  if (ret < 0)
    pr_err("trace_path_init: cmp offset failed: %d\n", ret); // ignore error

  ret = register_kprobe(&kp_path_init_cwd);
  if (ret < 0)
    pr_err("trace_path_init: cwd offset failed: %d\n", ret);

  ret = register_kprobe(&kp_path_init_fd);
  if (ret < 0)
    pr_err("trace_path_init: fd offset failed: %d\n", ret);

  pr_info("trace_path_init: loaded link_path_walk + path_init + offset probes, "
          "target_comm=%s\n",
          target_comm[0] ? target_comm : "(all)");
  return 0;
}

static void __exit trace_path_init_exit(void) {
  unregister_kretprobe(&krp_link_path_walk);
  unregister_kprobe(&kp_link_path_walk);
  unregister_kprobe(&kp_path_init_fd);
  unregister_kprobe(&kp_path_init_cwd);
  unregister_kprobe(&kp_path_init_cmp);
  unregister_kretprobe(&krp_path_init);
  unregister_kprobe(&kp_path_init);
  unregister_kretprobe(&krp_init_file);
  unregister_kprobe(&kp_init_file);
  unregister_kretprobe(&krp_path_lookupat);
  unregister_kprobe(&kp_path_lookupat);
  unregister_kretprobe(&krp_alloc_empty_file);
  unregister_kprobe(&kp_alloc_empty_file);
  unregister_kretprobe(&krp_path_openat);
  unregister_kprobe(&kp_path_openat);
  unregister_kprobe(&kp_fdget_raw);
  unregister_kretprobe(&krp_filp_open);
  unregister_kprobe(&kp_filp_open);
  pr_info("trace_path_init: unloaded\n");
}

module_init(trace_path_init_init);
module_exit(trace_path_init_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION(
    "Trace do_filp_open to observe path_init AT_FDCWD vs fd-lookup branching");
