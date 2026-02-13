#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

/*
 * vfs_trigger.c
 *
 * MISSION: Execute a path lookup that forces the kernel through
 * every "middle step" we want to watch.
 */

int main() {
  // 1. SETUP: Create a controlled environment
  mkdir("ALPHA", 0755);
  mkdir("ALPHA/BETA", 0755);
  int fd_dir = open("ALPHA", O_RDONLY | O_DIRECTORY);

  // 2. TRIGGER: The targeted lookup
  // We want to resolve "BETA/GAMMA" inside "ALPHA"
  printf("Triggering VFS lookup for 'BETA/GAMMA'...\n");
  int fd_file = openat(fd_dir, "BETA/GAMMA", O_CREAT | O_RDWR, 0644);

  if (fd_file >= 0) {
    printf("Success! Target detected.\n");
    close(fd_file);
  } else {
    perror("openat");
  }

  close(fd_dir);
  return 0;
}
