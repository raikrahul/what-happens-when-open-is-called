# Open() Axiomatic Derivation

## Live Blog
**URL**: https://raikrahul.github.io/what-happens-when-open-is-called/

## Repository Structure

```
.
├── docs/                          # Documentation
│   ├── core_concepts/             # Linking, metamorphosis, error audits
│   ├── kernel_tracing/            # Kernel traces, GDB analysis
│   ├── lesson_details/            # Step-by-step axiomatic lessons
│   │   ├── 00_failure_predictions/
│   │   ├── 01_the_syscall_interface/
│   │   ├── 02_the_kernel_entry/
│   │   ├── 03_the_path_walk/
│   │   ├── 04_the_allocation/
│   │   └── 05_the_return/
│   ├── plt_got/                   # PLT/GOT mathematical derivations
│   ├── proofs_md/                 # Written proofs (markdown)
│   └── worksheets/                # Interactive worksheets
├── src/                           # Source code
│   ├── error_demos/               # ENOENT, EACCES demo programs
│   ├── minimal_open/              # Minimal open() implementations
│   └── proofs/                    # Proof simulator source (.c)
├── wiki-content/                  # GitHub Wiki content (pending sync)
├── Makefile                       # Build system
└── AXIOMATIC_CURRICULUM.md        # Curriculum overview
```

## Build

```bash
make              # Build all programs
make test         # Run all proof simulators
make clean        # Remove compiled artifacts
```

## Proof Simulators

```bash
./src/proofs/register_dump                   # Register state dump
./src/proofs/path_walk_simulator /etc/passwd # Path resolution
./src/proofs/fd_exhaustion                   # File descriptor limits
./src/proofs/kernel_permission_simulation    # Permission checks
```

## Error Demos

```bash
./src/error_demos/error_demo_enoent   # ENOENT demonstration
./src/error_demos/error_demo_eacces   # EACCES demonstration
```

## License
MIT License