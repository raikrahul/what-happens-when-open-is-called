# Open() Pre-Syscall Worksheet

## 📱 Live Blog
**URL**: https://raikrahul.github.io/what-happens-when-open-is-called/
**Design**: Black/White/Green with red memory addresses
**Format**: Interactive worksheet - 11 steps + VMA mappings

## 🐙 GitHub Wiki
**Wiki URL**: https://github.com/raikrahul/what-happens-when-open-is-called/wiki
**Setup**: Run `gh repo edit --enable-wiki=true` to enable

## 📦 Repository
**Source**: https://github.com/raikrahul/what-happens-when-open-is-called
**Branch**: `gh-pages` (deployed to GitHub Pages)

## About
This worksheet walks through the complete journey of `open()` system call from source code to kernel boundary, covering:

- Static linking and relocations
- Dynamic linking with PLT/GOT  
- ASLR and address randomization
- Register transformations
- VMA memory mappings
- Pre-syscall preparation steps

## Usage
Clone and explore the source code:
```bash
git clone https://github.com/raikrahul/what-happens-when-open-is-called.git
cd what-happens-when-open-is-called
```

Run the proof programs:
```bash
cd proofs
./register_dump
./path_walk_simulator /etc/passwd
./fd_exhaustion
```

## License
MIT License