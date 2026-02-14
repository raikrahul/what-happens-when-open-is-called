#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main() {
  printf("PID: %d | MISSION: OPEN somefileNew.txt\n", getpid());
  int fd = open("somefileNew.txt", O_RDONLY);
  if (fd < 0) {
    perror("open read");
    return 1;
  }
  close(fd);
  return 0;
}
