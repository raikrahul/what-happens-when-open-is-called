#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main() {
  char filename[512];
  int pid = getpid();
  int fd;

  snprintf(filename, sizeof(filename),
           "/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/"
           "case17_do_filp_open_deep_trace/missing_case17_filp_%d.txt",
           pid);

  printf("[USER] My PID: %d\n", pid);
  printf("[USER] Starting Case 17 Trigger\n");
  printf("[USER] Target: %s\n", filename);

  fd = open(filename, O_RDONLY);
  if (fd < 0) {
    printf("[USER] open() failed as expected. Result: %d, Errno: %d (%s)\n", fd,
           errno, strerror(errno));
  } else {
    printf("[USER] open() unexpectedly succeeded! fd: %d\n", fd);
    close(fd);
  }

  return 0;
}
