#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main() {
  int fd = open("fast_link", O_RDONLY);
  if (fd < 0) {
    perror("open");
    return 1;
  }
  printf("Opened fast_link fd: %d\n", fd);
  close(fd);
  return 0;
}
