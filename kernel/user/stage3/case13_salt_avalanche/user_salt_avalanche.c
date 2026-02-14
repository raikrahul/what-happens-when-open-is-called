#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

int main() {
  mkdir("dir_X", 0777);
  mkdir("dir_Z", 0777);

  int fd1 = open("dir_X/avalanche_hit.txt", O_CREAT | O_RDWR, 0666);
  close(fd1);

  int fd2 = open("dir_Z/avalanche_hit.txt", O_CREAT | O_RDWR, 0666);
  close(fd2);

  return 0;
}
