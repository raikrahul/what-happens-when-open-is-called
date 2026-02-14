#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

int main() {
  printf("PID: %d | MISSION: CREATE somefileNew.txt\n", getpid());
  unlink("somefileNew.txt"); // Ensure it doesn't exist
  int fd = open("somefileNew.txt", O_CREAT | O_EXCL | O_RDWR, 0666);
  if (fd < 0) {
    perror("open create");
    return 1;
  }
  close(fd);
  return 0;
}
