#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

/*
 * NOTE: This requires Case 5 Setup Script (setup.sh) to:
 * 1. dd if=/dev/zero of=ext2.img bs=1M count=10
 * 2. mkfs.ext2 ext2.img
 * 3. mkdir /tmp/mnt_stage3
 * 4. mount -o loop ext2.img /tmp/mnt_stage3
 * 5. touch /tmp/mnt_stage3/loop_file.txt
 */

int main(void) {
  const char *path = "/tmp/mnt_stage3/loop_file.txt";

  printf("Case 5: Opening file across mount boundary '%s'\n", path);
  int fd = open(path, O_RDONLY);
  if (fd >= 0) {
    printf("Success: fd=%d\n", fd);
    close(fd);
  } else {
    perror("open");
  }

  return 0;
}
