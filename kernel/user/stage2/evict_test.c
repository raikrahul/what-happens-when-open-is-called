#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main(void) {
  const char *name = "/tmp/evict_test.txt";

  // Create and immediately close
  close(creat(name, 0644));

  printf("Created %s\n", name);
  sleep(1);

  // Drop caches
  if (geteuid() == 0) {
    sync();
    int fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
    if (fd >= 0) {
      write(fd, "2\n", 2);
      close(fd);
    }
    printf("Dropped caches\n");
  }

  sleep(1);

  // Open again - should allocate new dentry
  int fd = open(name, O_RDONLY);
  printf("Opened fd=%d\n", fd);
  if (fd >= 0)
    close(fd);

  return 0;
}
