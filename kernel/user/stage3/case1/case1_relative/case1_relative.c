#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

static const char path[] = "some_relative_file.txt";

int main(void) {
  int fd = open(path, O_CREAT | O_WRONLY, 0644);
  printf("fd=%d path_addr=%p path=\"%s\"\n", fd, path, path);
  if (fd >= 0)
    close(fd);
  return 0;
}
