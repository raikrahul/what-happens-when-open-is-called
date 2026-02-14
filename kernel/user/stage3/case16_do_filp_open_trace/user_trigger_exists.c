#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main() {
  const char *filename = "existing_case16.txt";

  // Preparation: Create the file if it doesn't exist
  int prep_fd = open(filename, O_CREAT | O_WRONLY, 0644);
  if (prep_fd >= 0)
    close(prep_fd);

  printf("TRIGGER_START: pid=%d filename=%s\n", getpid(), filename);

  int fd = open(filename, O_RDONLY);
  if (fd >= 0) {
    printf("TRIGGER_SUCCESS: result=fd(%d)\n", fd);
    close(fd);
  } else {
    printf("TRIGGER_ERROR: open failed with errno=%d (%s)\n", errno,
           strerror(errno));
  }

  return 0;
}
