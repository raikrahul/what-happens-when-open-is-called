#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>

#define ITERATIONS 1000000

int main() {
  struct stat st;
  struct timespec start, end;
  long long total_ns;
  int fd = open("/etc/passwd", O_RDONLY);

  printf("Starting shadow path benchmark (%d iterations)...\n\n", ITERATIONS);

  // 1. fstatat with "" (The Standard Extended Path)
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < ITERATIONS; i++) {
    fstatat(fd, "", &st, AT_EMPTY_PATH);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
  total_ns =
      (end.tv_sec - start.tv_sec) * 1000000000L + (end.tv_nsec - start.tv_nsec);
  printf("fstatat(fd, \"\", AT_EMPTY_PATH):   %lld ns per call (Taxed)\n",
         total_ns / ITERATIONS);

  // 2. fstatat with NULL (The shadow optimal path)
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < ITERATIONS; i++) {
    fstatat(fd, NULL, &st, AT_EMPTY_PATH);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
  total_ns =
      (end.tv_sec - start.tv_sec) * 1000000000L + (end.tv_nsec - start.tv_nsec);
  printf("fstatat(fd, NULL, AT_EMPTY_PATH): %lld ns per call (OPTIMIZED)\n",
         total_ns / ITERATIONS);

  // 3. Raw fstat (Reference Baseline)
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < ITERATIONS; i++) {
    fstat(fd, &st);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
  total_ns =
      (end.tv_sec - start.tv_sec) * 1000000000L + (end.tv_nsec - start.tv_nsec);
  printf("fstat(fd):                         %lld ns per call (BASELINE)\n",
         total_ns / ITERATIONS);

  close(fd);
  return 0;
}
