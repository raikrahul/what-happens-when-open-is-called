#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>

#define ITERATIONS 500000

int main() {
  struct stat st;
  struct timespec start, end;
  long long total_ns;

  // Preparation: Prime the dentry cache
  int fd = open("/etc/passwd", O_RDONLY);
  int dir_fd = open("/etc", O_RDONLY | O_DIRECTORY);
  stat("/etc/passwd", &st);

  printf("Starting benchmark (%d iterations)...\n\n", ITERATIONS);

  // 1. stat
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < ITERATIONS; i++) {
    stat("/etc/passwd", &st);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
  total_ns =
      (end.tv_sec - start.tv_sec) * 1000000000L + (end.tv_nsec - start.tv_nsec);
  printf("stat(\"/etc/passwd\"): %lld ns per call\n", total_ns / ITERATIONS);

  // 2. fstatat
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < ITERATIONS; i++) {
    fstatat(dir_fd, "passwd", &st, 0);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
  total_ns =
      (end.tv_sec - start.tv_sec) * 1000000000L + (end.tv_nsec - start.tv_nsec);
  printf("fstatat(dirfd, \"passwd\"): %lld ns per call\n",
         total_ns / ITERATIONS);

  // 3. fstat
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < ITERATIONS; i++) {
    fstat(fd, &st);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
  total_ns =
      (end.tv_sec - start.tv_sec) * 1000000000L + (end.tv_nsec - start.tv_nsec);
  printf("fstat(fd): %lld ns per call\n", total_ns / ITERATIONS);

  close(fd);
  close(dir_fd);
  return 0;
}
