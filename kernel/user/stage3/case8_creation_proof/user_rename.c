#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
  const char *old_name = "rename_proof_old.txt";
  const char *new_name = "rename_proof_new.txt";

  int fd = open(old_name, O_CREAT | O_RDWR, 0666);
  if (fd < 0) {
    perror("open");
    return 1;
  }
  close(fd);

  printf("Renaming %s to %s...\n", old_name, new_name);
  if (rename(old_name, new_name) < 0) {
    perror("rename");
    return 1;
  }

  printf("Rename successful.\n");
  return 0;
}
