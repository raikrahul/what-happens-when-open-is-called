# Makefile for userspace programs
# Compiles create_test_file and open_existing_file

# Compiler settings
CC = gcc
CFLAGS = -Wall -Wextra -g -O2 -D_GNU_SOURCE
LDFLAGS = 

# Programs
PROGRAMS = create_test_file open_existing_file

# Default target
all: $(PROGRAMS)

# Compile create_test_file
create_test_file: create_test_file.c
	@echo "========================================"
	@echo "Compiling: create_test_file"
	@echo "========================================"
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
	@echo "Output: $@"
	@ls -lh $@
	@echo ""

# Compile open_existing_file
open_existing_file: open_existing_file.c
	@echo "========================================"
	@echo "Compiling: open_existing_file"
	@echo "========================================"
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
	@echo "Output: $@"
	@ls -lh $@
	@echo ""

# Clean
clean:
	rm -f $(PROGRAMS)
	rm -f *.o
	rm -f /tmp/test_create_*.txt
	@echo "Cleaned userspace programs"

# Test compilation
test: all
	@echo "========================================"
	@echo "Testing programs..."
	@echo "========================================"
	@echo ""
	@echo "1. Testing create_test_file:"
	./create_test_file --help
	@echo ""
	@echo "2. Testing open_existing_file:"
	./open_existing_file --help

# Full test sequence
run-test: all
	@echo "========================================"
	@echo "RUNNING FULL TEST SEQUENCE"
	@echo "========================================"
	@echo ""
	@echo "STEP 1: Create file (triggers creation path)"
	./create_test_file
	@echo ""
	@echo "STEP 2: Open existing file (triggers open path)"
	@echo "   (Run with filename from STEP 1)"

.PHONY: all clean test run-test
