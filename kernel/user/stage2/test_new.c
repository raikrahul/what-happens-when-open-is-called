#include <fcntl.h>
#include <unistd.h>

#include <stdio.h>

int main() {
  printf("PID: %d\n", getpid());
  printf("Opening files...\n");
  open("newtestfile", O_RDWR);
  printf("Done opening. Sleeping...\n");
  sleep(10);
  return 0;
}
