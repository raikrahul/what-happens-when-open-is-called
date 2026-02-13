/*
 * demo_at_fdcwd.c
 *
 * Case 1: AT_FDCWD — open() with relative path
 *
 * Proof: open("file.txt") is identical to openat(AT_FDCWD, "file.txt")
 *        Both resolve from the process's current working directory.
 *
 * Run:  gcc demo_at_fdcwd.c -o demo_at_fdcwd.out && ./demo_at_fdcwd.out
 */

#define _GNU_SOURCE
#include <fcntl.h>
#include <linux/limits.h>
#include <stdio.h>
#include <sys/syscall.h>
#include <unistd.h>

int main(void) {
  char cwd[PATH_MAX];
  getcwd(cwd, sizeof(cwd));
  printf("cwd = %s\n\n", cwd);

  /* Method 1: old open() — glibc converts to openat(AT_FDCWD, ...) */
  int fd1 = open("test_fdcwd.txt", O_CREAT | O_WRONLY, 0644);
  printf("[open]   fd=%d  → created test_fdcwd.txt in cwd\n", fd1);

  /* Method 2: explicit openat with AT_FDCWD */
  int fd2 = openat(AT_FDCWD, "test_fdcwd_2.txt", O_CREAT | O_WRONLY, 0644);
  printf("[openat] fd=%d  → created test_fdcwd_2.txt in cwd\n", fd2);

  /* Method 3: raw syscall with -100 */
  int fd3 =
      syscall(SYS_openat, -100, "test_fdcwd_3.txt", O_CREAT | O_WRONLY, 0644);
  printf("[syscall] fd=%d → created test_fdcwd_3.txt in cwd\n", fd3);

  printf("\nAll three are identical. AT_FDCWD = %d\n", AT_FDCWD);
  printf("Proof: ls -la test_fdcwd*.txt\n");

  if (fd1 >= 0)
    close(fd1);
  if (fd2 >= 0)
    close(fd2);
  if (fd3 >= 0)
    close(fd3);

  /* cleanup */
  unlink("test_fdcwd.txt");
  unlink("test_fdcwd_2.txt");
  unlink("test_fdcwd_3.txt");

  return 0;
}
