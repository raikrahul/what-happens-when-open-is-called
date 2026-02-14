#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

int main() {
  const char *old_dir = "bulk_old";
  const char *new_dir = "bulk_new";
  char path[256];

  mkdir(old_dir, 0777);

  // Create 100 files
  for (int i = 0; i < 100; i++) {
    snprintf(path, sizeof(path), "%s/child_%d.txt", old_dir, i);
    int fd = open(path, O_CREAT | O_RDWR, 0666);
    close(fd);
  }

  printf("--- Initial Access ---\n");
  int fd = open("bulk_old/child_50.txt", O_RDONLY);
  close(fd);

  printf("Renaming directory %s to %s...\n", old_dir, new_dir);
  rename(old_dir, new_dir);

  printf("--- Final Access ---\n");
  fd = open("bulk_new/child_50.txt", O_RDONLY);
  close(fd);

  printf("Done.\n");
  return 0;
}
