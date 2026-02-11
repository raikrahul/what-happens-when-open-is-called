#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
  int fd;

  printf("Opening 'demo_o_path_target' with O_PATH...\n");

  // Create target first
  int temp_fd = open("demo_o_path_target", O_CREAT | O_RDWR, 0644);
  if (temp_fd >= 0)
    close(temp_fd);

  // Open with O_PATH
  fd = open("demo_o_path_target", O_PATH);
  if (fd < 0) {
    perror("open(O_PATH)");
    return 1;
  }

  printf("Success! fd=%d. This fd cannot be read/written, only used for "
         "operations like fstat or *at calls.\n",
         fd);

  // Cleanup
  close(fd);
  unlink("demo_o_path_target");
  return 0;
}
