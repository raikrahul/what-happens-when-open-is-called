#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>

void log_case(int num, const char *desc) {
  printf("\n--- CASE %d: %s ---\n", num, desc);
}

int main() {
  int fds[10];
  char local_file[] = "local_exists.txt";
  char tmp_file[] = "/tmp/tmp_exists.txt";
  char tmp_missing[] = "/tmp/tmp_missing_case3.txt";
  char local_missing[] = "local_missing_case5.txt";

  printf("PID: %d\n", getpid());

  // Setup: Create files
  close(creat(local_file, 0644));
  close(creat(tmp_file, 0644));

  // CASE 1: Open file in same folder (First time) -> Should trigger __d_alloc
  log_case(1, "Open local existing file (First time)");
  fds[0] = open(local_file, O_RDONLY);

  // CASE 2: Open file in another folder (/tmp) -> Should trigger __d_alloc for
  // component
  log_case(2, "Open /tmp existing file");
  fds[1] = open(tmp_file, O_RDONLY);

  // CASE 3: Open file which does NOT exist in /tmp -> Should trigger __d_alloc
  // for negative dentry
  log_case(3, "Open /tmp non-existent file");
  fds[2] = open(tmp_missing, O_RDONLY);

  // CASE 4: Open file which is ALREADY OPEN -> Should be a DCACHE HIT (No
  // __d_alloc)
  log_case(4, "Open local existing file (ALREADY OPEN)");
  fds[3] = open(local_file, O_RDONLY);

  // CASE 5: Open file which is NOT there in local folder -> Negative __d_alloc
  log_case(5, "Open local non-existent file");
  fds[4] = open(local_missing, O_RDONLY);

  printf("\nAll FDs held open. Checking cache hit on closed file...\n");

  // Cleanup setup
  close(fds[0]);
  printf("Closed FD 0 (local_exists.txt)\n");

  // FINAL CASE: Open the closed file again -> Should be a CACHE HIT
  log_case(6, "Opening the closed file again (Cache test)");
  fds[5] = open(local_file, O_RDONLY);

  printf("\nTest sequence complete. Sleeping for capture...\n");
  sleep(2);

  // Final Cleanup
  unlink(local_file);
  unlink(tmp_file);
  return 0;
}
