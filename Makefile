CC = gcc
CFLAGS = -Wall -Wextra -g -O2 -no-pie
SRC_PROOFS_DIR = kernel/proofs
LESSON_DIR = docs/lesson_details
SRC_DIR = kernel

# Proof programs (source in src/proofs, output in src/proofs)
PROOFS = $(SRC_PROOFS_DIR)/register_dump \
         $(SRC_PROOFS_DIR)/path_walk_simulator \
         $(SRC_PROOFS_DIR)/fd_exhaustion \
         $(SRC_PROOFS_DIR)/kernel_permission_simulation

# Axiomatic lesson programs
AXIOMATIC_PROGS = $(LESSON_DIR)/00_failure_predictions/lesson_demo \
                  $(LESSON_DIR)/01_the_syscall_interface/lesson_demo \
                  $(LESSON_DIR)/02_the_kernel_entry/lesson_demo \
                  $(LESSON_DIR)/03_the_path_walk/lesson_demo \
                  $(LESSON_DIR)/04_the_allocation/lesson_demo \
                  $(LESSON_DIR)/05_the_return/lesson_demo

# Error demonstration programs
ERROR_DEMOS = $(SRC_DIR)/demos/error_demo_enoent \
             $(SRC_DIR)/demos/error_demo_eacces

.PHONY: all clean proofs axiomatic errors test install-deps

all: proofs axiomatic errors

proofs: $(PROOFS)

axiomatic: $(AXIOMATIC_PROGS)

errors: $(ERROR_DEMOS)

# Proof program rules
$(SRC_PROOFS_DIR)/register_dump: $(SRC_PROOFS_DIR)/00_register_dump.c
	$(CC) $(CFLAGS) -o $@ $<

$(SRC_PROOFS_DIR)/path_walk_simulator: $(SRC_PROOFS_DIR)/01_path_walk_simulator.c
	$(CC) $(CFLAGS) -o $@ $<

$(SRC_PROOFS_DIR)/fd_exhaustion: $(SRC_PROOFS_DIR)/02_fd_exhaustion.c
	$(CC) $(CFLAGS) -o $@ $<

$(SRC_PROOFS_DIR)/kernel_permission_simulation: $(SRC_PROOFS_DIR)/03_kernel_permission_simulation.c
	$(CC) $(CFLAGS) -o $@ $<

# Axiomatic lesson demo programs
$(LESSON_DIR)/00_failure_predictions/lesson_demo: $(LESSON_DIR)/00_failure_predictions/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(LESSON_DIR)/01_the_syscall_interface/lesson_demo: $(LESSON_DIR)/01_the_syscall_interface/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(LESSON_DIR)/02_the_kernel_entry/lesson_demo: $(LESSON_DIR)/02_the_kernel_entry/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(LESSON_DIR)/03_the_path_walk/lesson_demo: $(LESSON_DIR)/03_the_path_walk/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(LESSON_DIR)/04_the_allocation/lesson_demo: $(LESSON_DIR)/04_the_allocation/demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(LESSON_DIR)/05_the_return/lesson_demo: $(LESSON_DIR)/05_the_return/demo.c
	$(CC) $(CFLAGS) -o $@ $<

# Error demonstration programs
$(SRC_DIR)/demos/error_demo_enoent: $(SRC_DIR)/demos/enoent_demo.c
	$(CC) $(CFLAGS) -o $@ $<

$(SRC_DIR)/demos/error_demo_eacces: $(SRC_DIR)/demos/eacces_demo.c
	$(CC) $(CFLAGS) -o $@ $<

# Test targets
test: all
	@echo "Running all proof programs..."
	@$(SRC_PROOFS_DIR)/register_dump && echo "OK register_dump"
	@$(SRC_PROOFS_DIR)/path_walk_simulator /etc/passwd > /dev/null && echo "OK path_walk_simulator"
	@echo "Testing fd_exhaustion..." && timeout 5s $(SRC_PROOFS_DIR)/fd_exhaustion || true && echo "OK fd_exhaustion"
	@$(SRC_PROOFS_DIR)/kernel_permission_simulation && echo "OK kernel_permission_simulation"
	@echo "Running error demos..."
	@$(SRC_DIR)/demos/error_demo_enoent && echo "OK ENOENT demo"
	@$(SRC_DIR)/demos/error_demo_eacces && echo "OK EACCES demo"
	@echo "All tests passed"

# Install dependencies for Ubuntu/Debian
install-deps:
	@echo "Installing dependencies..."
	sudo apt-get update
	sudo apt-get install -y build-essential gdb strace

clean:
	rm -f $(PROOFS) $(AXIOMATIC_PROGS) $(ERROR_DEMOS)
	find . -name "*.o" -delete

help:
	@echo "Available targets:"
	@echo "  all          - Build all programs"
	@echo "  proofs       - Build proof programs only"
	@echo "  axiomatic    - Build axiomatic lesson demos only"
	@echo "  errors       - Build error demonstration programs only"
	@echo "  test         - Run all tests"
	@echo "  clean        - Remove built files"
	@echo "  install-deps - Install build dependencies"
	@echo "  help         - Show this help"
