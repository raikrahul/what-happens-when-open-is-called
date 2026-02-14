/*******************************************************************************
 * USER PROGRAM A: Create Test File
 * Filename: create_test_file.c
 * Purpose: Create a file that doesn't exist to trigger creation path
 * Process Name: create_test (for driver filtering)
 * 
 * Memory Layout on Execution:
 * Stack (high address):
 *   0x7fff...f000: argv[0] pointer = 0x7fff...e000
 *   0x7fff...f008: argv[1] pointer = NULL (argc=1)
 *   0x7fff...f010: envp[0] pointer...
 *   0x7fff...e000: "./create_test_file\0" (19 bytes including null)
 *   
 * BSS Section:
 *   0x601000: test_data[256] = {0} (zero-initialized)
 *   
 * Data Section:
 *   0x602000: filename[] = "/tmp/test_create_YYYYmmdd_HHMMSS.txt\0"
 *             Size: 42 bytes at compile time, 44 bytes with timestamp
 *             
 * Heap (dynamic):
 *   malloc(256) returns address like 0x55a3b2c1d000
 *   Free'd before exit
 ******************************************************************************/

#define _GNU_SOURCE
#include <stdio.h>      // printf, fprintf, perror
#include <stdlib.h>     // exit, malloc, free
#include <string.h>     // strcpy, strcat, strerror
#include <time.h>       // time, localtime, strftime
#include <unistd.h>     // getpid, close
#include <fcntl.h>      // open, O_CREAT, O_WRONLY, O_TRUNC
#include <errno.h>      // errno, EEXIST, ENOENT
#include <sys/stat.h>   // stat, struct stat
#include <sys/types.h>  // mode_t, off_t

/* 
 * Buffer size calculation:
 * N = 256 bytes
 * Purpose: Hold data to write to file
 * Memory: 256 bytes in BSS section (uninitialized data)
 * Address: 0x601000 (example linker address)
 * Cache lines: 256 / 64 = 4 cache lines (L1 cache line = 64 bytes)
 */
static char test_data[256];

/*
 * Filename buffer:
 * Base: "/tmp/test_create_"
 * Timestamp: 15 chars (YYYYMMDDHHMMSS)
 * Extension: ".txt\0"
 * Total: 17 + 15 + 5 = 37 bytes
 * Allocated: 128 bytes for safety
 * Memory: 128 bytes in DATA section (initialized)
 * Address: 0x602000 (example)
 */
static char filename[128];

/*
 * Function: generate_timestamp_filename
 * Purpose: Create unique filename based on current time
 * Parameters: None
 * Returns: void
 * Side effects: Modifies global 'filename' buffer
 * 
 * Calculation:
 * time(NULL) returns seconds since 1970-01-01 00:00:00 UTC
 * Example: t = 1739464321 (Feb 13, 2026 19:12:01 UTC)
 * localtime(&t) converts to: tm_year=126 (2026-1900)
 *                              tm_mon=1 (February, 0-indexed)
 *                              tm_mday=13
 *                              tm_hour=19
 *                              tm_min=12
 *                              tm_sec=1
 * strftime format: "%Y%m%d_%H%M%S" = "20260213_191201"
 */
static void generate_timestamp_filename(void)
{
    time_t t;                   // sizeof(time_t) = 8 bytes (64-bit), holds seconds
    struct tm tm_info;          // sizeof(struct tm) = 56 bytes (glibc)
    char timestamp[16];         // 15 chars + null = 16 bytes on stack
    
    /* Get current time:
     * System call: clock_gettime(CLOCK_REALTIME, ...)
     * Returns: seconds since epoch (1739464321)
     */
    t = time(NULL);
    
    /* Convert to local time:
     * tzset() parses /etc/localtime
     * tm_info.tm_gmtoff = 19800 (IST = +5:30 = 5.5 * 3600 seconds)
     */
    localtime_r(&t, &tm_info);
    
    /* Format timestamp:
     * "%Y" = 2026 (4 bytes)
     * "%m" = 02 (2 bytes)
     * "%d" = 13 (2 bytes)
     * "_" = 1 byte
     * "%H" = 19 (2 bytes)
     * "%M" = 12 (2 bytes)
     * "%S" = 01 (2 bytes)
     * Total: 15 bytes written to timestamp[0..14]
     * timestamp[15] = '\0' (null terminator)
     */
    strftime(timestamp, sizeof(timestamp), "%Y%m%d_%H%M%S", &tm_info);
    
    /* Construct full path:
     * strcpy: copies "/tmp/test_create_" (17 bytes including \0)
     * strcat: appends timestamp (15 bytes)
     * strcat: appends ".txt" (5 bytes including \0)
     * Total: 36 bytes written
     */
    strcpy(filename, "/tmp/test_create_");
    strcat(filename, timestamp);
    strcat(filename, ".txt");
    
    /* Result example:
     * filename = "/tmp/test_create_20260213_191201.txt"
     * Stored at: 0x602000 (example)
     * strlen = 35 characters
     * sizeof(filename) = 128 bytes allocated
     * Utilization: 35/128 = 27.3%
     */
}

/*
 * Function: verify_file_not_exists
 * Purpose: Ensure file doesn't exist before creation
 * Parameters: pathname - const char * (4 or 8 bytes pointer)
 * Returns: 0 if doesn't exist, 1 if exists
 * 
 * System call: stat(pathname, &st)
 * st structure: 144 bytes (struct stat on x86_64)
 * st.st_ino: inode number (8 bytes) - 0 if doesn't exist
 * st.st_mode: file mode (4 bytes) - 0 if doesn't exist
 */
static int verify_file_not_exists(const char *pathname)
{
    struct stat st;     // 144 bytes on stack at 0x7fff...d000
    int ret;            // 4 bytes on stack
    
    /* stat() system call:
     * vfs_statx(AT_FDCWD, pathname, ...)
     * Returns: 0 on success, -1 on error
     * errno: ENOENT (2) if file doesn't exist
     */
    ret = stat(pathname, &st);
    
    if (ret == 0) {
        /* File exists:
         * st.st_ino = actual inode number (e.g., 12345678)
         * st.st_size = current file size in bytes
         */
        fprintf(stderr, "ERROR: File already exists: %s\n", pathname);
        fprintf(stderr, "       inode=%lu size=%ld bytes\n", 
                (unsigned long)st.st_ino, (long)st.st_size);
        return 1;   // File exists - fail
    }
    
    /* File doesn't exist:
     * errno = ENOENT (2)
     * This is EXPECTED - we want to create it
     */
    if (errno == ENOENT) {
        printf("VERIFIED: File does not exist (errno=%d ENOENT)\n", ENOENT);
        return 0;   // File doesn't exist - good
    }
    
    /* Other error:
     * errno could be EACCES (13) - permission denied
     *              ENOTDIR (20) - path component not directory
     *              ELOOP (40) - too many symbolic links
     */
    fprintf(stderr, "ERROR: stat() failed: %s (errno=%d)\n", 
            strerror(errno), errno);
    return 1;
}

/*
 * Function: create_file
 * Purpose: Create new file with O_CREAT flag
 * Parameters: pathname - const char *
 * Returns: file descriptor or -1 on error
 * 
 * Open flags calculation:
 * O_CREAT = 0x40 = 64 decimal - create file if doesn't exist
 * O_WRONLY = 0x01 = 1 decimal - write-only access
 * O_TRUNC = 0x200 = 512 decimal - truncate if exists
 * Combined: 64 | 1 | 512 = 577 = 0x241
 * Mode: 0644 = S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH = owner rw, group r, other r
 */
static int create_file(const char *pathname)
{
    int fd;         // File descriptor: 0,1,2,3...1024 typically
    int flags;      // 4 bytes on stack
    mode_t mode;    // 4 bytes on stack
    
    flags = O_CREAT | O_WRONLY | O_TRUNC;
    /* Binary: 0x241
     * Bit 0: O_WRONLY = 1
     * Bit 6: O_CREAT = 64
     * Bit 9: O_TRUNC = 512
     */
    
    mode = 0644;
    /* Binary: 000 110 100 100
     * Owner: 110 = rw-
     * Group: 100 = r--
     * Other: 100 = r--
     */
    
    printf("OPEN FLAGS: 0x%x (%d) = O_CREAT|O_WRONLY|O_TRUNC\n", flags, flags);
    printf("OPEN MODE: 0%o (%d) = rw-r--r--\n", mode, mode);
    
    /* open() system call entry:
     * do_sys_openat2(AT_FDCWD=-100, pathname, flags=0x241, mode=0x1a4)
     * 
     * Kernel path for O_CREAT:
     * 1. do_sys_openat2()
     * 2. do_filp_open()
     * 3. path_openat()
     * 4. path_init()
     * 5. alloc_empty_file()
     * 6. init_file()
     * 7. link_path_walk()
     * 8. lookup_fast() -> returns NULL (file doesn't exist)
     * 9. lookup_open() -> dentry->d_inode = NULL
     * 10. vfs_create() -> actual file creation
     * 11. d_alloc() -> allocate new dentry
     * 12. d_instantiate() -> link dentry to new inode
     * 13. fd_install() -> install fd in fd table
     * 14. return fd (e.g., 3)
     */
    
    fd = open(pathname, flags, mode);
    
    if (fd < 0) {
        /* Creation failed:
         * fd = -1
         * errno = ENOSPC (28) - no space left
         *      or EACCES (13) - permission denied
         *      or EROFS (30) - read-only filesystem
         */
        fprintf(stderr, "ERROR: open() failed: %s (errno=%d)\n", 
                strerror(errno), errno);
        return -1;
    }
    
    /* Success:
     * fd = 3 (first available fd after stdin=0, stdout=1, stderr=2)
     * current->files->fd_array[3] = struct file pointer
     */
    printf("SUCCESS: File created, fd=%d\n", fd);
    printf("        Pathname: %s\n", pathname);
    
    return fd;
}

/*
 * Function: write_test_data
 * Purpose: Write identifiable data to file
 * Parameters: fd - file descriptor
 * Returns: 0 on success, -1 on error
 * 
 * Data format:
 * "CREATE_TEST_PID=<pid> TIMESTAMP=<seconds> DATA=<pattern>\n"
 * Length: ~80 bytes
 */
static int write_test_data(int fd)
{
    pid_t pid;          // 4 bytes, process ID
    time_t t;          // 8 bytes, timestamp
    ssize_t written;   // 8 bytes, bytes written
    int data_len;      // 4 bytes, length of formatted string
    
    /* Get process ID:
     * current->pid (kernel)
     * getpid() = syscall(SYS_getpid)
     * Returns: 4 bytes process identifier (e.g., 12345)
     */
    pid = getpid();
    
    /* Get current time:
     * Returns: seconds since epoch (e.g., 1739464321)
     */
    t = time(NULL);
    
    /* Format data:
     * snprintf returns: number of bytes written (not including null)
     * test_data buffer: 256 bytes at 0x601000
     * 
     * Format string components:
     * "CREATE_TEST_" = 12 bytes
     * "PID=" = 4 bytes
     * pid (e.g., 12345) = 5 bytes
     * " TIMESTAMP=" = 11 bytes
     * t (e.g., 1739464321) = 10 bytes
     * " DATA=AAAAAAAA..." = 200 bytes of 'A'
     * "\n" = 1 byte
     * Total: ~243 bytes (fits in 256)
     */
    data_len = snprintf(test_data, sizeof(test_data),
                        "CREATE_TEST_PID=%d TIMESTAMP=%ld DATA=", pid, t);
    
    /* Fill remaining with pattern:
     * 256 - data_len = ~13 bytes remaining
     * Fill with 'A' characters
     * Then add newline
     */
    memset(test_data + data_len, 'A', sizeof(test_data) - data_len - 2);
    test_data[sizeof(test_data) - 2] = '\n';
    test_data[sizeof(test_data) - 1] = '\0';
    
    /* Write to file:
     * vfs_write(fd, test_data, 256, &pos)
     * pos starts at 0 (file is new)
     * Returns: bytes written (should be 256)
     */
    written = write(fd, test_data, strlen(test_data));
    
    if (written < 0) {
        fprintf(stderr, "ERROR: write() failed: %s\n", strerror(errno));
        return -1;
    }
    
    printf("WRITTEN: %zd bytes to fd=%d\n", written, fd);
    printf("DATA: %.60s...\n", test_data);
    
    return 0;
}

/*
 * Function: verify_creation
 * Purpose: Verify file was created with correct attributes
 * Parameters: pathname - const char *
 * Returns: 0 on success, 1 on error
 */
static int verify_creation(const char *pathname)
{
    struct stat st;     // 144 bytes on stack
    int ret;
    
    /* Stat the file to verify creation:
     * Should exist now
     * Should have inode number
     * Should have size > 0
     */
    ret = stat(pathname, &st);
    
    if (ret < 0) {
        fprintf(stderr, "ERROR: File creation verification failed: %s\n", 
                strerror(errno));
        return 1;
    }
    
    /* Verify inode exists:
     * st.st_ino != 0 (inode number assigned by filesystem)
     * Example: st.st_ino = 12345678
     */
    if (st.st_ino == 0) {
        fprintf(stderr, "ERROR: File has no inode!\n");
        return 1;
    }
    
    /* Verify size:
     * Should be ~256 bytes (what we wrote)
     */
    if (st.st_size == 0) {
        fprintf(stderr, "ERROR: File has zero size!\n");
        return 1;
    }
    
    printf("VERIFIED CREATION:\n");
    printf("  inode: %lu\n", (unsigned long)st.st_ino);
    printf("  size: %ld bytes\n", (long)st.st_size);
    printf("  mode: 0%o\n", st.st_mode & 0777);
    printf("  uid: %d\n", st.st_uid);
    printf("  gid: %d\n", st.st_gid);
    
    return 0;
}

/*
 * Function: print_usage
 * Purpose: Print command line usage
 */
static void print_usage(const char *progname)
{
    printf("Usage: %s [OPTIONS]\n", progname);
    printf("\n");
    printf("Create a test file to trigger kernel file creation path tracing.\n");
    printf("\n");
    printf("OPTIONS:\n");
    printf("  -h, --help     Show this help message\n");
    printf("  -p PATH        Use specific path instead of timestamp\n");
    printf("\n");
    printf("EXAMPLES:\n");
    printf("  %s                    Create /tmp/test_create_YYYYMMDD_HHMMSS.txt\n", progname);
    printf("  %s -p /tmp/myfile.txt Create specific file\n", progname);
}

/*******************************************************************************
 * MAIN FUNCTION
 ******************************************************************************/

/*
 * argc = argument count (1 if no args, >=1 always)
 * argv = argument vector array
 * argv[0] = program name pointer
 * 
 * Stack frame on entry:
 * 0x7fff...f000: return address to libc
 * 0x7fff...eff8: saved rbp
 * 0x7fff...eff0: argc (4 or 8 bytes)
 * 0x7fff...efe8: argv pointer
 * 0x7fff...efe0: envp pointer
 */
int main(int argc, char *argv[])
{
    int fd;             // File descriptor (4 bytes on stack)
    int ret;            // Return value (4 bytes on stack)
    int i;              // Loop counter (4 bytes on stack)
    
    /* Parse command line:
     * If -p provided, use that path
     * Otherwise generate timestamp-based path
     */
    if (argc > 1) {
        if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
            print_usage(argv[0]);
            return 0;
        }
        if (strcmp(argv[1], "-p") == 0 && argc > 2) {
            strncpy(filename, argv[2], sizeof(filename) - 1);
            filename[sizeof(filename) - 1] = '\0';
        } else {
            fprintf(stderr, "Unknown option: %s\n", argv[1]);
            print_usage(argv[0]);
            return 1;
        }
    } else {
        /* Generate timestamp filename:
         * filename = "/tmp/test_create_20260213_191201.txt"
         */
        generate_timestamp_filename();
    }
    
    printf("========================================\n");
    printf("CREATE TEST FILE - TRIGGER CREATION PATH\n");
    printf("========================================\n");
    printf("Process: PID=%d COMM=%s\n", getpid(), argv[0]);
    printf("Target file: %s\n", filename);
    printf("========================================\n\n");
    
    /* Step 1: Verify file doesn't exist
     * Expected: File should NOT exist (errno=ENOENT)
     */
    printf("STEP 1: Verify file doesn't exist\n");
    if (verify_file_not_exists(filename) != 0) {
        fprintf(stderr, "FAIL: File already exists or error\n");
        return 1;
    }
    printf("\n");
    
    /* Step 2: Create file
     * This triggers the full creation path in kernel:
     * vfs_create -> d_alloc -> d_instantiate
     */
    printf("STEP 2: Create file with O_CREAT|O_WRONLY|O_TRUNC\n");
    fd = create_file(filename);
    if (fd < 0) {
        fprintf(stderr, "FAIL: File creation failed\n");
        return 1;
    }
    printf("\n");
    
    /* Step 3: Write test data
     * Write identifiable data for verification
     */
    printf("STEP 3: Write test data\n");
    if (write_test_data(fd) != 0) {
        close(fd);
        unlink(filename);
        return 1;
    }
    printf("\n");
    
    /* Step 4: Close file
     * fput() called in kernel
     * If refcount reaches 0, file is released
     */
    printf("STEP 4: Close file (fd=%d)\n", fd);
    ret = close(fd);
    if (ret < 0) {
        fprintf(stderr, "ERROR: close() failed: %s\n", strerror(errno));
        return 1;
    }
    printf("File closed successfully\n\n");
    
    /* Step 5: Verify creation
     * Ensure file exists with correct attributes
     */
    printf("STEP 5: Verify file creation\n");
    if (verify_creation(filename) != 0) {
        return 1;
    }
    printf("\n");
    
    /* Success - print filename for next program */
    printf("========================================\n");
    printf("SUCCESS: File created at:\n");
    printf("  %s\n", filename);
    printf("\n");
    printf("Use this path with open_existing_file program:\n");
    printf("  ./open_existing_file %s\n", filename);
    printf("========================================\n");
    
    return 0;
}
