#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main() {
  // "loop_link" must point to itself or create a cycle
  int fd = open("loop_link", O_RDONLY);
  if (fd < 0) {
    if (errno == ELOOP) {
      printf("Success: Caught ELOOP as expected.\n");
    } else {
      perror("open");
    }
    return 1;
  }
  close(fd);
  return 0;
}
