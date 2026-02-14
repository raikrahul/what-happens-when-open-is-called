#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main() {
  const char *long_name =
      "creation_proof_long_name_that_exceeds_32_bytes_limit_for_sure.txt";
  int fd = open(long_name, O_RDWR | O_CREAT | O_EXCL, 0644);
  if (fd < 0) {
    perror("open(O_CREAT_LONG)");
    return 1;
  }
  printf("Successfully created long named file\n");
  close(fd);
  return 0;
}
