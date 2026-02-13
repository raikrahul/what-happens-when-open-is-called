#include <fcntl.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main(void) {
  const char *path = "/tmp/new_creation_file.txt";

  printf("Case 4: O_CREAT metamorphosis flow '%s'\n", path);

  // 1. Create and Open
  int fd1 = open(path, O_RDWR | O_CREAT, 0644);
  if (fd1 >= 0) {
    printf("Created: fd=%d. Sleeping 5s...\n", fd1);
    sleep(5); // Hold reference so we can check fd state in /proc
    close(fd1);
  } else {
    perror("open(create)");
  }

  // 2. Open again (should be hit)
  int fd2 = open(path, O_RDONLY);
  if (fd2 >= 0) {
    printf("Re-opened: fd=%d\n", fd2);
    close(fd2);
  } else {
    perror("open(re-open)");
  }

  return 0;
}
