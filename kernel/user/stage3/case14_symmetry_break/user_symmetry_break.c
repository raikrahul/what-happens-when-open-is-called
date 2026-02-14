#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

int main() {
  // We cannot control absolute parent pointers, but we can use two different
  // dirs. We will capture the actual salts and show why they don't collide.
  mkdir("dir_1", 0777);
  mkdir("dir_2", 0777);

  int fd1 = open("dir_1/break_A", O_CREAT | O_RDWR, 0666);
  close(fd1);

  int fd2 = open("dir_2/break_@", O_CREAT | O_RDWR, 0666);
  close(fd2);

  return 0;
}
