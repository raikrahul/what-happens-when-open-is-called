/*
 * demo_toctou.c
 *
 * Case 3: TOCTOU race — openat with pinned fd vs directory rename attack
 *
 * Setup:
 *   /tmp/demo_toctou/real_dir/secret.txt    contains "CORRECT: real_dir"
 *   /tmp/demo_toctou/evil_dir/secret.txt    contains "EVIL: attacker data"
 *
 * Scenario A (VULNERABLE — using path strings):
 *   1. Check: access("/tmp/demo_toctou/real_dir/secret.txt") → OK
 *   2. Attack: rename real_dir → old_dir, symlink evil_dir → real_dir
 *   3. Open: open("/tmp/demo_toctou/real_dir/secret.txt") → reads EVIL data
 *
 * Scenario B (SAFE — using openat with pinned fd):
 *   1. Pin: dir_fd = open("/tmp/demo_toctou/real_dir", O_DIRECTORY)
 *   2. Attack: rename real_dir → old_dir, symlink evil_dir → real_dir
 *   3. Open: openat(dir_fd, "secret.txt") → reads CORRECT data
 *
 * The rename changes the NAME but not the INODE that dir_fd points to.
 *
 * Run:  gcc demo_toctou.c -o demo_toctou.out && ./demo_toctou.out
 */

#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static void read_and_print(int fd, const char *label) {
  char buf[64] = {0};
  if (fd < 0) {
    printf("[%s] open failed: fd=%d\n", label, fd);
    return;
  }
  read(fd, buf, sizeof(buf) - 1);
  close(fd);
  printf("[%s] content: %s", label, buf);
}

static void setup(void) {
  system("rm -rf /tmp/demo_toctou");
  mkdir("/tmp/demo_toctou", 0755);
  mkdir("/tmp/demo_toctou/real_dir", 0755);
  mkdir("/tmp/demo_toctou/evil_dir", 0755);

  int f1 = open("/tmp/demo_toctou/real_dir/secret.txt",
                O_CREAT | O_WRONLY | O_TRUNC, 0644);
  write(f1, "CORRECT: real_dir\n", 18);
  close(f1);

  int f2 = open("/tmp/demo_toctou/evil_dir/secret.txt",
                O_CREAT | O_WRONLY | O_TRUNC, 0644);
  write(f2, "EVIL: attacker data\n", 20);
  close(f2);
}

static void simulate_attack(void) {
  rename("/tmp/demo_toctou/real_dir", "/tmp/demo_toctou/old_dir");
  symlink("/tmp/demo_toctou/evil_dir", "/tmp/demo_toctou/real_dir");
  printf("[ATTACK] renamed real_dir → old_dir\n");
  printf("[ATTACK] symlinked evil_dir → real_dir\n\n");
}

static void restore(void) {
  unlink("/tmp/demo_toctou/real_dir"); /* remove symlink */
  rename("/tmp/demo_toctou/old_dir", "/tmp/demo_toctou/real_dir");
}

int main(void) {
  printf("═══════════════════════════════════════════\n");
  printf("  TOCTOU Demo: path strings vs pinned fd\n");
  printf("═══════════════════════════════════════════\n\n");

  /* ── Scenario A: VULNERABLE (path strings) ── */
  setup();

  printf("─── Scenario A: using path strings (VULNERABLE) ───\n\n");

  /* Step 1: check */
  int ok = access("/tmp/demo_toctou/real_dir/secret.txt", R_OK);
  printf("[CHECK] access(\"/tmp/demo_toctou/real_dir/secret.txt\") = %d (OK)\n",
         ok);

  /* Step 2: attacker renames directory between check and open */
  simulate_attack();

  /* Step 3: open the "same" path — but it now points to evil_dir */
  int fd_a = open("/tmp/demo_toctou/real_dir/secret.txt", O_RDONLY);
  printf("[OPEN]  open(\"/tmp/demo_toctou/real_dir/secret.txt\") → fd=%d\n",
         fd_a);
  read_and_print(fd_a, "Scenario A");
  printf("[RESULT] GOT EVIL DATA ← path was re-resolved through symlink ✗\n\n");

  restore();

  /* ── Scenario B: SAFE (pinned fd) ── */
  setup();

  printf("─── Scenario B: using openat + pinned fd (SAFE) ───\n\n");

  /* Step 1: pin the directory via fd */
  int dir_fd = open("/tmp/demo_toctou/real_dir", O_RDONLY | O_DIRECTORY);
  printf("[PIN]   dir_fd = %d (pinned to real_dir inode)\n", dir_fd);

  /* Step 2: same attack */
  simulate_attack();

  /* Step 3: openat uses the PINNED inode, not the path */
  int fd_b = openat(dir_fd, "secret.txt", O_RDONLY);
  printf("[OPENAT] openat(dir_fd, \"secret.txt\") → fd=%d\n", fd_b);
  read_and_print(fd_b, "Scenario B");
  printf("[RESULT] GOT CORRECT DATA ← dir_fd still points to original inode "
         "✓\n\n");

  printf("═══════════════════════════════════════════\n");
  printf("  Scenario A (open):   read attacker's data ✗\n");
  printf("  Scenario B (openat): read correct data    ✓\n");
  printf("═══════════════════════════════════════════\n");
  printf("  openat + pinned fd defeats TOCTOU rename attacks.\n");

  close(dir_fd);
  system("rm -rf /tmp/demo_toctou");
  return 0;
}
