#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main() {
  const char *filename = "missing_case16.txt";
  printf("TRIGGER_START: pid=%d filename=%s\n", getpid(), filename);

  int fd = open(filename, O_RDONLY);
  if (fd < 0) {
    printf("TRIGGER_SUCCESS: result=%d errno=%d (%s)\n", fd, errno,
           strerror(errno));
  } else {
    printf("TRIGGER_ERROR: file exists unexpectedly\n");
    close(fd);
  }

  return 0;
}
