#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

int main() {
  char filename[64];
  time_t now = time(NULL);
  
  // Create unique filename to force new dentry allocation
  snprintf(filename, sizeof(filename), "test_file_%ld", now);
  
  printf("PID: %d\n", getpid());
  printf("Process name: minimal_open\n");
  printf("Creating unique file: %s\n", filename);
  printf("This forces __d_alloc to be called (no cache hit)\n\n");
  
  // Use O_CREAT to force dentry allocation
  int fd = open(filename, O_RDWR | O_CREAT, 0644);
  if (fd < 0) {
    perror("open failed");
    return 1;
  }
  
  printf("Successfully opened fd=%d\n", fd);
  printf("Sleeping for 5 seconds to allow trace capture...\n");
  sleep(5);
  
  close(fd);
  return 0;
}
