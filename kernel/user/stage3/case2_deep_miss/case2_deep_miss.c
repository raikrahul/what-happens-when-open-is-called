#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

int main(void) {
  const char *path = "/tmp/alpha/beta/gamma/nonexistent.txt";

  // Ensure the parents do NOT exist to force a middle-of-path miss
  // (Actual cleanup is in the driver/script logic)

  printf("Case 2: Opening deep path with missing components '%s'\n", path);
  int fd = open(path, O_RDONLY);

  if (fd < 0) {
    if (errno == ENOENT) {
      printf("Success: Received expected ENOENT\n");
    } else {
      perror("open");
    }
  } else {
    printf("Error: File opened unexpectedly (fd=%d)\n", fd);
    close(fd);
  }

  return 0;
}
