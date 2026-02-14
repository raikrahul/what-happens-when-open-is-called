#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  mkdir("subdir", 0755);
  int fd =
      open("subdir/creation_proof_deep.txt", O_RDWR | O_CREAT | O_EXCL, 0644);
  if (fd < 0) {
    perror("open(O_CREAT_DEEP)");
    return 1;
  }
  printf("Successfully created deep file in subdir\n");
  close(fd);
  return 0;
}
