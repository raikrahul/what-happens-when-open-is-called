#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

int main() {
  mkdir("dir_A", 0777);
  mkdir("dir_B", 0777);

  int fd = open("dir_A/puzzle_target.txt", O_CREAT | O_RDWR, 0666);
  close(fd);

  printf("Initial access (dir_A)...\n");
  fd = open("dir_A/puzzle_target.txt", O_RDONLY);
  close(fd);

  printf("Moving across parents: dir_A -> dir_B...\n");
  rename("dir_A/puzzle_target.txt", "dir_B/puzzle_target.txt");

  printf("Final access (dir_B)...\n");
  fd = open("dir_B/puzzle_target.txt", O_RDONLY);
  close(fd);

  return 0;
}
