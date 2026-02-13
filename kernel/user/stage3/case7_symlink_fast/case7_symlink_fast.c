#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

/*
 * SETUP:
 * touch /tmp/target.txt
 * ln -s /tmp/target.txt /tmp/good_link
 */

int main(void) {
  const char *path = "/tmp/good_link";

  printf("Case 7: Opening valid symlink '%s'\n", path);
  int fd = open(path, O_RDONLY);
  if (fd >= 0) {
    printf("Success: fd=%d\n", fd);
    close(fd);
  } else {
    perror("open");
  }

  return 0;
}
