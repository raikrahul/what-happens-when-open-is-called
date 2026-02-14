#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main() {
  int fd = open("creation_proof.txt", O_RDONLY);
  if (fd < 0) {
    perror("open(O_RDONLY)");
    return 1;
  }
  printf("Successfully opened creation_proof.txt\n");
  close(fd);
  return 0;
}
