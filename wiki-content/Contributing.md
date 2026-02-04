# Contributing Guidelines

This guide covers how to contribute to the "What Happens When Open Is Called" project while maintaining its axiomatic principles.

## 🎯 Contribution Philosophy

This project follows strict axiomatic principles. Every contribution must:

1. **Define Before Use**: No undefined terms or concepts
2. **Prove Everything**: Every claim must be verifiable
3. **Derive Logically**: Each step follows from previous steps
4. **Stay Minimal**: Demonstrate exactly one concept per program

## 📋 Types of Contributions

### 🐛 Bug Reports

#### What to Include
- System information: `uname -a`
- GCC version: `gcc --version`
- Full error message with stack trace
- Steps to reproduce
- Expected vs actual behavior

#### Example Bug Report
```
System: Linux 5.15.0-52-generic x86_64
GCC: 11.2.0
Command: ./proofs/register_dump
Error: Segmentation fault
Steps: Run command on clean build
Expected: Success message
Actual: Crash with SIGSEGV
```

### ✨ New Features

#### Acceptable Additions
- Additional proof programs for existing axioms
- New axiomatic lessons following the same methodology
- Enhanced error demonstrations
- Better verification tools

#### Process for New Features
1. **Open Issue**: Describe the proposed addition
2. **Get Approval**: Maintain team reviews for axiomatic compliance
3. **Implement**: Following all coding standards
4. **Test**: Include integration tests
5. **Document**: Update relevant wiki pages

### 📚 Documentation

#### Types of Documentation
- Axiom explanations with derivations
- Program usage examples
- System-specific troubleshooting
- Educational methodology explanations

#### Documentation Standards
- Define all technical terms before use
- Provide concrete examples for abstract concepts
- Include verification methods
- Link to related concepts

## 🛠 Development Workflow

### 1. Setup Development Environment

```bash
# Clone repository
git clone https://github.com/raikrahul/what-happens-when-open-is-called.git
cd what-happens-when-open-is-called

# Install dependencies
make install-deps

# Test everything works
make all
./integration_test.sh
```

### 2. Create Feature Branch

```bash
# Create descriptive branch name
git checkout -b feature/new-proof-program
# or
git checkout -b fix/errno-handling-issue
```

### 3. Make Changes

#### Coding Standards

```c
// Good: Minimal, focused program
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
    int fd = open("/tmp/test", O_RDONLY);
    if (fd == -1) {
        printf("Error: %s\n", strerror(errno));
        return 1;
    }
    close(fd);
    return 0;
}
```

#### What to Avoid
```c
// Bad: Complex program with mixed concerns
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <string.h>
#include <stdlib.h>

int main() {
    // Multiple unrelated operations
    struct stat st;
    char *buf = malloc(1024);
    int fd = open("/etc/passwd", O_RDONLY);
    read(fd, buf, 1024);
    stat("/etc/passwd", &st);
    printf("Size: %ld\n", st.st_size);
    free(buf);
    close(fd);
    return 0;
}
```

### 4. Test Your Changes

#### Build Test
```bash
make clean && make all
```

#### Integration Test
```bash
./integration_test.sh
```

#### Manual Test
```bash
# Test your specific changes
./your_new_program
./proofs/register_dump  # Ensure no regression
```

### 5. Create Pull Request

#### PR Template
```markdown
## Description
Brief description of changes made.

## Axiomatic Compliance
- [ ] All concepts are defined before use
- [ ] Every claim is verifiable
- [ ] Logical derivation is maintained
- [ ] Programs demonstrate single concepts

## Testing
- [ ] Integration tests pass
- [ ] Manual testing completed
- [ ] No regression in existing functionality

## Documentation
- [ ] README updated if needed
- [ ] Wiki updated if applicable
- [ ] Inline comments added
```

## 📝 Code Review Criteria

### Axiomatic Compliance
1. **No Magic**: Every concept must be explained
2. **No Inference**: No assumed prior knowledge
3. **No Fluff**: Remove unnecessary code/text
4. **Derivation**: Each step must follow from previous

### Code Quality
1. **Compilation**: Must compile without warnings
2. **Functionality**: Must work as intended
3. **Testing**: Must pass integration tests
4. **Documentation**: Must be well-documented

### Educational Value
1. **Clarity**: Easy to understand and follow
2. **Accuracy**: Technically correct
3. **Completeness**: Covers the concept fully
4. **Verifiability**: Claims can be independently verified

## 🏷 Naming Conventions

### Programs
- Proof programs: `number_descriptive_name.c` (e.g., `00_register_dump.c`)
- Lesson demos: `demo.c` in lesson directory
- Error demos: `errno_demo.c` (e.g., `enoent_demo.c`)

### Variables
- Descriptive but concise
- Use underscores for multi-word names
- Avoid single-letter variables except for counters

### Functions
- Action-oriented names
- Include error handling
- Single responsibility principle

## 📚 Adding New Lessons

### Lesson Structure
```
axiomatic_lessons/XX_lesson_name/
├── lesson.md          # Axiom definitions and theory
├── demo.c             # Practical demonstration
├── Makefile           # Build instructions (if needed)
└── README.md          # Additional context
```

### Lesson Content Requirements
1. **Clear Goal**: What will be learned
2. **Axioms**: List of assumptions
3. **Tools**: How to verify understanding
4. **Derivation**: Step-by-step logic
5. **Proof**: Verifiable demonstration

### Lesson Numbering
- Two-digit format: `00`, `01`, `02`, etc.
- Maintain logical progression
- Update curriculum index in main README

## 🔄 Maintaining Standards

### Regular Reviews
- Quarterly review of all content
- Update for kernel changes
- Improve based on user feedback
- Ensure cross-platform compatibility

### Quality Assurance
- Automated testing via GitHub Actions
- Documentation review process
- Code review for all changes
- User feedback integration

## 🚫 What Not to Contribute

### Inappropriate Contributions
- Magic explanations without derivation
- Assumed knowledge without definition
- Complex programs mixing multiple concepts
- Platform-specific code without alternatives

### Examples of What to Avoid
```c
// Bad: Magic without explanation
// "This works because the kernel does magic" - NO!

// Bad: Assumed knowledge
// "Obviously, everyone knows what a file descriptor is" - NO!

// Bad: Mixed concerns
int open_and_read_and_close_and_error_check() { /* ... */ } - NO!
```

## 📞 Getting Help

### For Contributors
- Create GitHub issue with `contribution` label
- Ask in discussions for clarification
- Review existing PRs for examples
- Read methodology documentation

### For Users
- Use GitHub issues for bug reports
- Check troubleshooting guide first
- Provide system information
- Include reproduction steps

## 🎉 Recognition

Contributors will be:
- Listed in project README
- Mentioned in relevant documentation
- Recognized in release notes
- Invited to collaborate on future improvements

---

Remember: The goal is not just to add code, but to enhance understanding through axiomatic, verifiable knowledge. Every contribution should make complex concepts more accessible through first-principles thinking.