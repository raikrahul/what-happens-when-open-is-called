#include <errno.h>
#include <fcntl.h>
#include <linux/fs.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

// Mock definitions based on kernel source logic
#define MAY_EXEC 1
#define MAY_WRITE 2
#define MAY_READ 4

// Kernel simulation structs
struct inode_mock {
  int i_mode;
  int i_uid;
  int i_gid;
};

// SIMULATION STEP 1: getname()
// Axiom: Kernel must copy string from user space to kernel space
void step1_getname(const char *filename) {
  printf("STEP 1: getname()\n");
  printf("  Action: Copying '%s' from User Space to Kernel Space.\n", filename);
  printf("  Destination: 'struct filename' object.\n\n");
}

// SIMULATION STEP 2: path_init()
// Axiom: Path walk starts at either CWD or Root
void step2_path_init(int dfd) {
  printf("STEP 2: path_init()\n");
  if (dfd == -100) {
    printf("  Start: AT_FDCWD (Current Working Directory).\n");
  } else {
    printf("  Start: Specific FD or Root.\n");
  }
  printf("  State: 'struct nameidata' initialized.\n\n");
}

// SIMULATION STEP 3: security_file_open() (LSM Hook)
// Axiom: Security modules (AppArmor, SELinux) get first say
void step3_lsm_hook() {
  printf("STEP 3: security_file_open() [LSM Hook]\n");
  printf("  Action: Checking with AppArmor/SELinux.\n");
  printf("  Logic: Does current task's security context allow this?\n");
  printf("  Result: PASS (Assuming default context).\n\n");
}

// SIMULATION STEP 4: mnt_want_write()
// Axiom: Cannot write to a read-only filesystem
int step4_ro_fs_check(int input_flags) {
  printf("STEP 4: mnt_want_write()\n");
  if (input_flags & O_RDWR || input_flags & O_WRONLY) {
    printf("  Check: Is Filesystem Read-Only?\n");
    printf("  Intent: WRITE access requested.\n");
    // Simulated check
    int fs_is_ro = 0;
    if (fs_is_ro)
      return -EROFS;
  }
  printf("  Result: PASS.\n\n");
  return 0;
}

// SIMULATION STEP 5: acl_permission_check()
// Axiom: ACLs can override standard bits
void step5_acl_check() {
  printf("STEP 5: check_acl() [Posix ACLs]\n");
  printf("  Check: Are there extended attributes (xattrs) for ACLs?\n");
  printf("  Result: No ACLs found (Standard fallback).\n\n");
}

// SIMULATION STEP 6: generic_permission()
// Axiom: The standard bitwise check
int step6_standard_check(struct inode_mock *inode, int mask) {
  printf("STEP 6: generic_permission()\n");
  printf("  Input Mask: %d (Binary: %d%d%d)\n", mask, (mask & 4) ? 1 : 0,
         (mask & 2) ? 1 : 0, (mask & 1) ? 1 : 0);

  int mode = inode->i_mode;

  // Logic: Shift bits based on user
  // Assume we are OWNER for this test
  int granted = (mode >> 6) & 7;

  printf("  Inode Owner Bits: %d (disk)\n", granted);

  if ((mask & ~granted) == 0) {
    printf("  Logic: (Request & ~Granted) == 0\n");
    printf("  Result: PASS.\n");
    return 0;
  } else {
    printf("  Result: FAIL.\n");
    return -EACCES;
  }
}

int main() {
  printf("KERNEL PERMISSION FLOW SIMULATION\n");
  printf("=================================\n\n");

  const char *file = "somefile";
  int flags = O_RDWR;
  int acc_mode = flags & O_ACCMODE;

  // 0. Decode O_RDWR to MAY_XXX
  int mask = 0;
  if (acc_mode == O_RDONLY)
    mask = MAY_READ;
  else if (acc_mode == O_WRONLY)
    mask = MAY_WRITE;
  else if (acc_mode == O_RDWR)
    mask = MAY_READ | MAY_WRITE;

  step1_getname(file);
  step2_path_init(-100); // AT_FDCWD
  step3_lsm_hook();
  step4_ro_fs_check(flags);
  step5_acl_check();

  struct inode_mock inode;
  inode.i_mode = 0644; // rw-r--r--
  step6_standard_check(&inode, mask);

  return 0;
}
