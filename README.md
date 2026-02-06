# Open() Axiomatic Derivation

## Live Blog
**URL**: https://raikrahul.github.io/what-happens-when-open-is-called/

## Branches

- `main`: source code, docs, and site source
- `gh-pages`: published site output

## Repository Structure

```
.
├── docs/                          # Documentation and lesson material
│   ├── core_concepts/             # Linking, metamorphosis, error audits
│   ├── kernel_tracing/            # Kernel traces, GDB analysis
│   ├── lesson_details/            # Step-by-step axiomatic lessons
│   ├── plt_got/                   # PLT/GOT mathematical derivations
│   ├── proofs_md/                 # Written proofs (markdown)
│   ├── worksheets/                # Interactive worksheets
│   └── project_meta/              # Curriculum and blog rules
├── kernel/                        # Tracing code and drivers
│   ├── drivers/                   # Kernel modules and probes
│   ├── user/                      # User-space test programs
│   ├── proofs/                    # Proof simulators
│   ├── demos/                     # Error demos
│   ├── minimal_open/              # Minimal open() variants
│   └── traces/                    # Raw traces and outputs
├── site/                          # Website source (published to gh-pages)
├── wiki/                          # GitHub Wiki content
├── notes/                         # Sessions, scratch, backups
├── tools/                         # Helpers and scripts
└── Makefile                       # Build system
```

## Build

```bash
make              # Build all programs
make test         # Run all proof simulators
make clean        # Remove compiled artifacts
```

## Proof Simulators

```bash
./kernel/proofs/register_dump                   # Register state dump
./kernel/proofs/path_walk_simulator /etc/passwd # Path resolution
./kernel/proofs/fd_exhaustion                   # File descriptor limits
./kernel/proofs/kernel_permission_simulation    # Permission checks
```

## Error Demos

```bash
./kernel/demos/error_demo_enoent   # ENOENT demonstration
./kernel/demos/error_demo_eacces   # EACCES demonstration
```

## Publish

```bash
make publish MSG="Update stage2 return"
```

## License
MIT License
