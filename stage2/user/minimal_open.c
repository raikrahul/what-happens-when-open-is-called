#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

int main() {
  char filename[128];
  time_t now = time(NULL);

  // Create very long filename (> 40 chars) to force external allocation
  snprintf(filename, sizeof(filename),
           "test_file_very_long_name_to_force_external_allocation_%ld", now);

  printf("PID: %d\n", getpid());
  printf("Process name: minimal_open\n");
  printf("Creating unique file: %s\n", filename);
  printf("This forces __d_alloc to use external allocation (Long Name "
         "Puzzle)\n\n");

  int fd = open(filename, O_RDWR | O_CREAT, 0644);
  if (fd < 0) {
    perror("open failed");
    return 1;
  }

  printf("Successfully opened fd=%d\n", fd);
  printf("Sleeping for 5 seconds to allow trace capture...\n");
  sleep(5);

  close(fd);
  unlink(filename); // Cleanup
  return 0;
}
