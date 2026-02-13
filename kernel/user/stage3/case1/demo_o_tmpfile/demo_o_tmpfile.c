#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

int main() {
  printf("=== O_TMPFILE Demonstration ===\n");

  // 1. Create unnamed temp file in current directory
  // Note: Must specify a directory (like ".")
  int fd = open(".", O_TMPFILE | O_RDWR, 0600);
  if (fd < 0) {
    perror("open(O_TMPFILE)");
    // O_TMPFILE might not be supported on all filesystems (e.g. some tmpfs/ext4
    // older versions?) But usually supported.
    return 1;
  }
  printf("[*] Opened O_TMPFILE in '.' (fd=%d)\n", fd);

  // 2. Write something
  const char *msg = "This data will disappear!";
  if (write(fd, msg, strlen(msg)) < 0) {
    perror("write");
  }

  // 3. Verify it has no name (link count should be 1? No, 0? Or 1 if open?)
  // Actually, i_nlink is 0 for O_TMPFILE files until linked.
  struct stat sb;
  if (fstat(fd, &sb) == 0) {
    printf("[*] fstat: Inode=%lu, nlink=%lu (Expected: 1 or 0?)\n", sb.st_ino,
           sb.st_nlink);
    // Linux O_TMPFILE files have nlink=1 initially (as reference held by fs?)
    // No, typically nlink=0? Let's see.
    // wait, open() returns a file descriptor. The inode is allocated.
    // It is "unlinked".
    // "The file is created with an initial link count of 0"? Not necessarily?
    // Or 1 but hidden?
    // Let's verify output.
  }

  // 4. Prove it's not visible in ls
  printf("[*] Check 'ls -la' output (should NOT see any new weird file)...\n");
  system("ls -la | grep -v 'total' | grep -v '\\.'");

  // 5. Close checks
  close(fd);
  printf("[*] Closed fd. File should be gone.\n");
  return 0;
}
