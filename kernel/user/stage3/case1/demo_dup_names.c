#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

int main() {
  // Create hierarchy
  mkdir("dirA", 0755);
  mkdir("dirA/common", 0755);
  mkdir("dirB", 0755);
  mkdir("dirB/common", 0755);

  // Case 1: Open in dirA/common
  printf("Changing to dirA/common and opening file.txt...\n");
  if (chdir("dirA/common") < 0) {
    perror("chdir dirA/common");
    return 1;
  }
  int fd1 = open("file.txt", O_CREAT | O_RDWR, 0644);
  if (fd1 >= 0)
    close(fd1);
  else
    perror("open dirA");

  // Case 2: Open in dirB/common
  // Note: We need to go up first, or use absolute path.
  // Let's use relative path to prove relative lookup.
  printf("Changing to ../../dirB/common and opening file.txt...\n");
  if (chdir("../../dirB/common") < 0) {
    perror("chdir dirB/common");
    return 1;
  }
  int fd2 = open("file.txt", O_CREAT | O_RDWR, 0644);
  if (fd2 >= 0)
    close(fd2);
  else
    perror("open dirB");

  return 0;
}
