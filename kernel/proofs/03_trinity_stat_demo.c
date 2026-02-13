#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static void report_stat(const char *label, int rc, struct stat *st) {
    if (rc == 0)
        printf("%s -> inode %lu\n", label, (unsigned long)st->st_ino);
    else
        printf("%s -> fail %s\n", label, strerror(errno));
}

int main() {
  struct stat st;
  const char *path = "/etc/passwd";

  printf("--- stat(path)\n");
  if (stat(path, &st) == 0)
    printf("stat('%s') inode %lu\n", path, (unsigned long)st.st_ino);

  printf("--- open('')\n");
  int bad_fd = open("", O_RDONLY);
  printf("open('') returned %d (%s)\n", bad_fd, bad_fd < 0 ? strerror(errno) : "ok");

  printf("--- fstat(fd)\n");
  int fd = open(path, O_RDONLY);
  report_stat("fstat(fd)", fd >= 0 ? fstat(fd, &st) : -1, &st);

  printf("--- fstatat(dirfd, '', AT_EMPTY_PATH)\n");
  int dirfd = open("/etc", O_RDONLY | O_DIRECTORY);
  report_stat("fstatat(AT_EMPTY_PATH)", dirfd >= 0 ? fstatat(dirfd, "", &st, AT_EMPTY_PATH) : -1, &st);

  printf("--- fstatat(dirfd, '', 0)\n");
  report_stat("fstatat('',0)", dirfd >= 0 ? fstatat(dirfd, "", &st, 0) : -1, &st);

  printf("--- fstatat(dirfd, 'passwd', 0)\n");
  report_stat("fstatat('passwd')", dirfd >= 0 ? fstatat(dirfd, "passwd", &st, 0) : -1, &st);

  if (fd >= 0) close(fd);
  if (bad_fd >= 0) close(bad_fd);
  if (dirfd >= 0) close(dirfd);
  return 0;
}
