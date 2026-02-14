#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  const char *old_dir = "dir_old";
  const char *new_dir = "dir_new";

  if (mkdir(old_dir, 0777) < 0) {
    perror("mkdir");
    return 1;
  }

  printf("Renaming directory %s to %s...\n", old_dir, new_dir);
  if (rename(old_dir, new_dir) < 0) {
    perror("rename");
    return 1;
  }

  printf("Directory rename successful.\n");
  return 0;
}
