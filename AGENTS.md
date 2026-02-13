# AGENTS.md

## BUILD AND TEST COMMANDS

### 1. Single Test Compilation
```bash
# Build specific demo (e.g., case1_relative)
make kernel/user/stage3/case1/case1_relative/case1_relative.out

# Build with debug
make kernel/user/stage3/case1/case1_relative/case1_relative.out CFLAGS="-g -DDEBUG"

# Clean single demo
make clean-$(DEMO_NAME)
```

### 2. Module Compilation and Loading
```bash
# Build trace_path_init driver
make kernel/drivers/stage3/case1/trace_path_init/trace_path_init.ko

# Load with target filter
sudo insmod kernel/drivers/stage3/case1/trace_path_init/trace_path_init.ko target_comm="case1_relativ"

# Unload
sudo rmmod trace_path_init

# Reload (for testing changes)
sudo rmmod trace_path_init && sudo insmod kernel/drivers/stage3/case1/trace_path_init/trace_path_init.ko

# Check loaded modules
lsmod | grep trace_path_init

# Verify module loaded
dmesg | tail -5 | grep "trace_path_init"
```

### 3. Running Single Test with Tracing
```bash
# Run test with dmesg capture
sudo dmesg -C
sudo insmod .../trace_path_init.ko target_comm="demo_name"
./demo_name.out
sudo dmesg | grep -E "PATH_INIT|PATH_WALK" > trace_$(date +%s).txt
sudo rmmod trace_path_init

# Run test with real-time monitoring
sudo dmesg -C
sudo insmod .../trace_path_init.ko target_comm="demo_name"
./demo_name.out &
PID=$!
sleep 0.5
sudo dmesg | tail -20 | grep -E "PATH_INIT|PATH_WALK"
kill $PID 2>/dev/null
sudo rmmod trace_path_init

# Run test without dmesg clear (keeps prior output)
sudo insmod .../trace_path_init.ko target_comm="demo_name"
./demo_name.out
sudo dmesg | grep -E "PATH_INIT|PATH_WALK" | tail -20
sudo rmmod trace_path_init

# Run all 7 case1 tests
make test-case1  # Runs case1_relative, demo_at_fdcwd, demo_o_path, etc.
```

### 4. Site Building and Publishing
```bash
# Generate HTML from Markdown
make build-site

# Build site without publishing
make site

# Publish to gh-pages (pushes commits)
make publish MSG="Stage 3 Case 1: link_path_walk integration"

# Preview site locally
make serve-site &

# Clean generated files
make clean-site
```

## CODE STYLE GUIDELINES

### 5. Kernel Module Style
```c
/*
 * Comment style: Kernel standard
 * Each function: purpose, parameters, return
 */

#include <linux/module.h>     // Core headers first
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/uaccess.h>

static char target_comm[TASK_COMM_LEN] = "";
module_param_string(target_comm, target_comm, sizeof(target_comm), 0644);

#define MODULE_NAME "trace_path_init"
#define MODULE_VERSION "1.0"

static int probe_handler(struct kprobe *p, struct pt_regs *regs)
{
    if (target_comm[0] && strcmp(current->comm, target_comm) != 0)
        return 0;

    // ALWAYS validate kernel pointers before dereferencing
    // Use IS_ERR() for error checking
    // Use probe_kernel_read() for memory access
    // Use %px for pointers, %s for strings in atomic context
    return 0;
}

static struct kprobe kp_function = {
    .symbol_name = "do_sys_openat2",
    .pre_handler = probe_handler,
};

module_init(trace_init_function);
module_exit(trace_cleanup_function);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Trace do_sys_openat2 with link_path_walk");
MODULE_AUTHOR("Open Project");

// Register all probes in init, cleanup in exit
// Return error codes properly
```

### 6. Userspace Program Style
```c
/*
 * Consistent naming: snake_case
 * Error checking always
 * Clear success/failure paths
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

#define MAX_PATH 256
#define DEMO_MAGIC 0xDEADBEEF

static void log_error(const char *op, int err)
{
    fprintf(stderr, "[ERROR] %s failed: %s (%d)\n", op, strerror(err));
}

static void log_success(const char *op, int result)
{
    fprintf(stdout, "[OK] %s: fd=%d\n", op, result);
}

static void check_return(int fd, const char *op)
{
    if (fd < 0) {
        log_error(op, -fd);
        return;
    }
    
    if (fd >= 0 && fd < 1024) {
        log_success(op, fd);
        close(fd);
    } else {
        log_error(op, EBADF);
    }
}

/* Function names: verb_noun pattern */
int main_open_file(const char *filename, int flags, mode_t mode)
{
    int fd = open(filename, flags, mode);
    check_return(fd, "open_file");
    return 0;
}
```

### 7. Error Handling Patterns
```c
// ALWAYS validate inputs
if (!filename || strlen(filename) >= MAX_PATH) {
    log_error("validate_input", EINVAL);
    return -1;
}

// ALWAYS check return values
if (ptr == NULL || IS_ERR(ptr)) {
    return PTR_ERR(ptr);
}

// NEVER dereference unchecked pointers
if (!ptr) return -EINVAL;
if (IS_ERR(ptr)) return PTR_ERR(ptr);

// Use proper cleanup paths
void cleanup_resources(void)
{
    if (fd >= 0) close(fd);
    if (buffer) free(buffer);
    if (mutex_locked) pthread_mutex_unlock(&mutex);
}

// Use consistent error propagation
int result = operation();
if (result != 0) {
    cleanup_resources();
    return result;
}
```

### 8. Import Organization
```c
// System headers first
#include <sys/types.h>
#include <sys/stat.h>

// Local headers next
#include "project_headers.h"

// Feature-specific headers last
#ifdef FEATURE_THREADING
#include <pthread.h>
#endif
```

### 9. Makefile Style
```makefile
# Variables
CC = gcc
CFLAGS = -Wall -Wextra -g -O2 -D_FORTIFY_SOURCE=2
LDFLAGS = -pthread

# Pattern rules
%.o: %.c
    $(CC) $(CFLAGS) -c $< -o $@

# PHONY targets
.PHONY: all clean test install

# Clean patterns
clean:
    rm -f *.o *.out *.so *.ko

# Debug build
debug: CFLAGS += -DDEBUG -O0
```

### 10. Testing Patterns
```c
// Test helper functions
#define ASSERT(cond, msg) \
    do { \
        if (!(cond)) { \
            fprintf(stderr, "ASSERTION FAILED: %s at %s:%d\n", msg, __FILE__, __LINE__); \
            exit(1); \
        } \
    } while(0)

#define EXPECT_EQ(a, b, msg) \
    do { \
        if ((a) != (b)) { \
            fprintf(stderr, "EXPECTED %s == %s: got %ld != %ld\n", #a, #b, (long)(a), (long)(b)); \
            exit(1); \
        } \
    } while(0)

// Test macros
#define TEST_SYSCALL(op, expected_errno) \
    do { \
        long result = op; \
        if ((result) == -expected_errno) { \
            printf("PASS: %s returned %ld (expected -%d)\n", #op, result, expected_errno); \
        } else { \
            printf("FAIL: %s returned %ld (expected -%d)\n", #op, result, expected_errno); \
        } \
    } while(0)
```

## NAMING CONVENTIONS

### 11. File Names
```bash
# Source files
case1_relative.c          # Clear, descriptive
demo_o_path_dir.c        # Verb_purpose_object
demo_thread_safety.c     # Feature_implementation
error_demo_enoent.c      # error_type_demo
```

### 12. Variable Names
```c
int fd;                    # File descriptor
char path_buffer[MAX_PATH];  # Clear, size-specified
const char *filename;        # Input parameter
static int error_count = 0;   # Module-level counters
```

### 13. Function Names
```c
static int setup_test_env(void);                    # Verb_infinitive
static int run_single_test(void);                     # Verb_infinitive  
static int validate_permissions(int fd);               # Verb_infinitive
static void cleanup_test_resources(int fd, void *ptr);  # Verb_infinitive

int main(int argc, char *argv[]);                # Standard entry point
```

### 14. Constants and Macros
```c
#define MODULE_NAME "trace_path_init"           # Descriptive
#define MODULE_VERSION "1.0"                    # Semantic versioning
#define MAX_RETRIES 3                           # Magic numbers avoided
#define DEFAULT_TIMEOUT_MS 5000                  # Descriptive
#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))  # Safe array sizing
```

## SECURITY GUIDELINES

### 15. Kernel Memory Safety
```c
// NEVER use user pointers without validation
if (copy_from_user(kernel_buf, user_ptr, size) != 0) {
    return -EFAULT;
}

// ALWAYS check pointer ranges before dereferencing
if (ptr < TASK_SIZE || ptr >= VIRTUAL_END) {
    return -EINVAL;
}

// Use kernel string functions, not raw memory ops
strncpy(kernel_buf, user_ptr, size);  // ✗
strscpy_from_user(kernel_buf, user_ptr, size);  // ✓

// Allocate kernel memory properly
buf = kmalloc(size, GFP_KERNEL);
if (!buf) {
    return -ENOMEM;
}
kfree(buf);  // Always free allocated memory
```

### 16. Userspace Input Validation
```c
// Validate ALL inputs
static int validate_open_params(const char *path, int flags, mode_t mode)
{
    if (!path || strlen(path) >= PATH_MAX) {
        errno = EINVAL;
        return -1;
    }
    
    if (flags & ~VALID_OPEN_FLAGS) {
        errno = EINVAL;
        return -1;
    }
    
    if (mode & ~VALID_MODE_MASK) {
        errno = EINVAL;
        return -1;
    }
    
    return 0;
}

// NEVER trust user input
if (geteuid() != 0 && (flags & O_CREAT)) {
    // User might create files in privileged locations
    log_warning("security: unprivileged create attempt");
    return -EPERM;
}
```

### 17. Concurrency and Thread Safety
```c
// Use proper synchronization
pthread_mutex_t global_mutex = PTHREAD_MUTEX_INITIALIZER;
static atomic_t ref_count = ATOMIC_INIT(0);

// Thread-safe increment
int increment_ref(void)
{
    return atomic_inc_return(&ref_count);
}

int decrement_ref(void)
{
    return atomic_dec_return(&ref_count);
}

// NEVER use global state without protection
// ✗ static int counter = 0;
// ✓ static atomic_t counter = ATOMIC_INIT(0);
```

## DEBUGGING GUIDELINES

### 18. Kernel Module Debug Output
```c
// Use appropriate log levels
pr_debug("Low-level detail: ptr=%px, len=%d\n", ptr, len);     // Development only
pr_info("Important events: fd=%d\n", fd);                    // Normal operation
pr_warn("Warning condition: timeout=%dms\n", timeout);            // Recoverable issues
pr_err("Error condition: err=%d\n", err);                       // Critical failures

// Use structured logging
pr_debug("%s:%d: [PROBE] entry: dfd=%d, flags=0x%x\n", 
         __func__, __LINE__, dfd, flags);

// Conditional debug output
#ifdef DEBUG
#define DBG_PRINT(fmt, ...) pr_debug(fmt, ##__VA_ARGS__)
#else
#define DBG_PRINT(fmt, ...)
#endif
```

### 19. Userspace Debug Output
```c
// Enable debug with compile flag
#ifdef DEBUG
    fprintf(stderr, "[DEBUG] %s:%d: Opening %s\n", __func__, __LINE__, filename);
#endif

// Structured debug information
void debug_print_state(const char *stage, const char *action, int fd)
{
    fprintf(stderr, "[STATE] %s/%s: fd=%d, errno=%d\n", 
            stage, action, fd, errno);
}

// Trace execution flow
#define TRACE_ENTER(func) fprintf(stderr, "[ENTER] %s\n", func)
#define TRACE_EXIT(func, result) fprintf(stderr, "[EXIT] %s: %d\n", func, result)
```

## PERFORMANCE GUIDELINES

### 20. Memory Allocation
```c
// Use appropriate allocators
void *buf = kmalloc(size, GFP_KERNEL);    // Kernel memory
void *buf = malloc(size);                 // Userspace memory

// Always check allocation results
if (!buf) {
    return -ENOMEM;
}

// Free consistently
kfree(kernel_buf);
free(userspace_buf);
```

### 21. Efficient String Handling
```c
// Use kernel string functions
len = strnlen_user(ptr, MAX_LEN);     // Safe bounded length
copy_from_user(kernel_buf, ptr, len); // Safe copy
```

### 22. Avoid Common Pitfalls
```c
// ✗ Bad: unchecked sprintf
sprintf(buf, user_string, sizeof(buf));

// ✓ Good: bounded copy
snprintf(buf, sizeof(buf), "%s", user_string);

// ✗ Bad: infinite loop assumptions
while (ptr && *ptr) { ptr++; }  // May crash on corrupted pointer

// ✓ Good: bounded iteration
for (i = 0; i < MAX_LEN && ptr[i]; i++) { /* safe */ }
```

---

**AI AGENT USAGE:**
This file provides comprehensive build, test, and development guidelines. Follow these patterns to maintain code quality, security, and performance standards.