#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

/*
 * SETUP:
 * ln -s /tmp/link_a /tmp/link_b
 * ln -s /tmp/link_b /tmp/link_a
 */

int main(void) {
  const char *path = "/tmp/link_a";

  printf("Case 6: Opening self-looping symlink '%s'\n", path);
  int fd = open(path, O_RDONLY);

  if (fd < 0) {
    if (errno == ELOOP) {
      printf("Success: Received expected ELOOP\n");
    } else {
      perror("open");
    }
  } else {
    printf("Error: Loop opened successfully? (fd=%d)\n", fd);
    close(fd);
  }

  return 0;
}
