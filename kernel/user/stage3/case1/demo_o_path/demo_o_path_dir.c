#define _GNU_SOURCE
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  // 1. Setup: Create directory and a file inside
  mkdir("demo_dir", 0755);
  int temp_fd = open("demo_dir/secret_file.txt", O_CREAT | O_WRONLY, 0644);
  if (temp_fd >= 0)
    close(temp_fd);

  printf("=== O_PATH Demonstration ===\n");

  // 2. Open directory with O_PATH
  int dir_fd = open("demo_dir", O_PATH | O_DIRECTORY);
  if (dir_fd < 0) {
    perror("open O_PATH");
    return 1;
  }
  printf("[*] Opened 'demo_dir' with O_PATH (fd=%d)\n", dir_fd);

  // 3. Try to list files (getdents) -> SHOULD FAIL
  DIR *dir_stream = fdopendir(dir_fd);
  if (dir_stream == NULL) {
    printf("[!] fdopendir failed as expected: %s\n", strerror(errno));
  } else {
    printf("[?] fdopendir succeeded? That's unexpected for O_PATH.\n");
    closedir(dir_stream);
  }

  // 4. Use as anchor for openat (Accessing file INSIDE via O_PATH fd)
  int file_fd = openat(dir_fd, "secret_file.txt", O_RDONLY);
  if (file_fd >= 0) {
    printf("[*] Success! Used O_PATH fd to open 'secret_file.txt' via "
           "openat().\n");
    printf("    This proves O_PATH fds work as directory anchors.\n");
    close(file_fd);
  } else {
    perror("openat");
  }

  // 5. Use fstat on the O_PATH fd
  struct stat sb;
  if (fstat(dir_fd, &sb) == 0) {
    printf("[*] fstat(dir_fd) works! Inode: %lu\n", sb.st_ino);
  }

  // Cleanup
  close(dir_fd);
  unlink("demo_dir/secret_file.txt");
  rmdir("demo_dir");
  return 0;
}
