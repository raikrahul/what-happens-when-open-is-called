#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
  char filename[64];
  snprintf(filename, sizeof(filename), "creation_proof_%d.txt", getpid());
  int fd = open(filename, O_RDWR | O_CREAT | O_EXCL, 0644);
  if (fd < 0) {
    perror("open(O_CREAT)");
    return 1;
  }
  printf("Successfully created %s\n", filename);
  close(fd);
  return 0;
}
