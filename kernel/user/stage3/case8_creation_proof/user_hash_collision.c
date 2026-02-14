#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main() {
  const char *names[] = {"collision_alpha.txt", "collision_beta.txt",
                         "collision_gamma.txt"};

  for (int i = 0; i < 3; i++) {
    int fd = open(names[i], O_RDWR | O_CREAT | O_EXCL, 0644);
    if (fd >= 0) {
      printf("Created %s\n", names[i]);
      close(fd);
    }
  }
  return 0;
}
