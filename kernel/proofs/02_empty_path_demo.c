#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

/*
 * DEMO: The "Empty Path" Loophole
 *
 * 1. open("") -> Always fails (No LOOKUP_EMPTY in kernel)
 * 2. fstatat(fd, "", ..., AT_EMPTY_PATH) -> Succeeds (LOOKUP_EMPTY enabled)
 */

int main() {
  struct stat st;
  int fd;

  // First, get a valid file descriptor to work with
  fd = open("/etc/passwd", O_RDONLY);
  if (fd < 0) {
    perror("Failed to open /etc/passwd");
    return 1;
  }

  printf("--- BASE CASE ---\n");
  printf("Successfully opened /etc/passwd (FD: %d)\n\n", fd);

  printf("--- THE 'BAD' CASE: open(\"\") ---\n");
  int bad_fd = open("", O_RDONLY);
  if (bad_fd < 0) {
    printf("RESULT: open(\"\") failed as expected.\n");
    printf("ERROR:  %s (Error Code: %d)\n\n", strerror(errno), errno);
  } else {
    printf(
        "RESULT: Surprisingly succeeded? (This shouldn't happen on Linux)\n\n");
    close(bad_fd);
  }

  printf("--- THE 'GOOD' CASE: fstatat(fd, \"\", ..., AT_EMPTY_PATH) ---\n");
  // AT_EMPTY_PATH maps to LOOKUP_EMPTY in kernel
  if (fstatat(fd, "", &st, AT_EMPTY_PATH) == 0) {
    printf("RESULT: fstatat(\"\") SUCCEEDED!\n");
    printf("PROOF:  Inode number is %lu\n", (unsigned long)st.st_ino);
  } else {
    printf("RESULT: fstatat failed.\n");
    printf("ERROR:  %s\n", strerror(errno));
  }

  close(fd);
  return 0;
}
