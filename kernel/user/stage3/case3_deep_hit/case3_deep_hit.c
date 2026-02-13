#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

int main(void) {
  const char *path = "/tmp/alpha/beta/gamma/hit.txt";

  // The setup script will handle mkdir -p and touch
  // This program just triggers the walk

  printf("Case 3: Opening deep path with cached components '%s'\n", path);

  // Open twice to ensure dcache hits on the second pass
  for (int i = 0; i < 2; i++) {
    printf("Attempt %d...\n", i + 1);
    int fd = open(path, O_RDONLY);
    if (fd >= 0) {
      printf("Success: fd=%d\n", fd);
      close(fd);
    } else {
      perror("open");
    }
  }

  return 0;
}
