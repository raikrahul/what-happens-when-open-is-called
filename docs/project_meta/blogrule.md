# Blog Format Rules

## Color Palette

| Element | Dark Theme | Light Theme |
|---------|-----------|-------------|
| Background | `#111` | `#ffffff` |
| Text | `#ccc` | `#000000` |
| Headings | `#fff` | `#000000` |
| Code/Mono | `#88ff88` | inherit |
| Borders | `#333` → `#555` (hover) | N/A |

**Usage:**
- **Dark**: Index pages, navigation, stage wrappers
- **Light**: Explanation content, worksheets

---

## Page Types

### 1. Index Page (`index.html`)
Dark theme. Stage cards in `.stage` divs wrapped in `<a>` tags.

```html
<a href="articles/stage1.html">
  <div class="stage">
    <h2>STAGE N: Title</h2>
    <p>Description with <code>inline code</code></p>
    <p><strong>Topics:</strong> Topic1, Topic2.</p>
  </div>
</a>

<!-- Future stages: -->
<div class="stage" style="opacity: 0.5;">
  <h2>STAGE N: Title</h2>
  <p>Coming soon...</p>
</div>
```

### 2. Stage Wrapper (`stageN.html`)
Split-pane layout with header bar.

```html
<div class="header">
  <span>EXPLANATION</span>
  <span>Scroll each panel independently</span>
  <span>WORKSHEET</span>
</div>
<div class="container">
  <div class="panel"><iframe src="explanation.html"></iframe></div>
  <div class="panel"><iframe src="worksheet.html"></iframe></div>
</div>
```

### 3. Content Pages (`explanation.html`, `worksheet.html`)
Light theme, `<pre>` wrapped, print button.

```html
<body>
  <div style="text-align: right; padding-bottom: 20px;">
    <button onclick="window.print()">Print Page</button>
  </div>
  <pre>
CONTENT HERE
  </pre>
</body>
```

---

## Content Structure

### Headers
ALL CAPS + underline:
```
SECTION NAME
------------
```

### Commands
```
$ command args
  output line 1
  output line 2
```

### Worksheet Sections (in order):
1. `DO:` - Action to take
2. `RUN:` - Command with `$` prefix
3. `OUTPUT:` - Expected output
4. `OBSERVE:` - What to notice
5. `INQUIRY:` - Q&A format
6. `MATH (Type):` - Step-by-step calculations
7. `CONCLUSION:` - Summary
8. `AXIOM:` - Fundamental truth

### Separator
```
================================================================================
```

---

## Typography

- **Font**: `'Courier New', monospace`
- **Explanation size**: 13px
- **Worksheet size**: 14px
- **Line height**: 1.6-1.7
- **Max width**: 800px

### Code Formatting
- Inline HTML: `<code>...</code>`
- Function names: `open()`, `main()`
- Addresses: `0x3fd0`, `0x1050`
- Registers: `%rip`, `%rax`
- Constants: `O_RDWR`, `AT_FDCWD`

---

## Required CSS

```css
/* Print styles */
@media print {
  button, div[style*="text-align: right"] { 
    display: none !important; 
  }
  body { padding: 0; }
}

/* Text wrapping */
pre {
  white-space: pre-wrap;
  word-wrap: break-word;
}
```

---

## Content Rules

### Every Value Must Be:
1. From actual system headers (`/usr/include/...`)
2. Verified by running commands
3. Derived step-by-step (no magic)

### Required Sections:
- Machine configuration block
- Definitions from man pages
- Troubleshooting for platform differences

### File Paths to Reference:
- `/usr/include/asm-generic/fcntl.h`
- `/usr/include/asm/unistd_64.h`
- `/usr/include/elf.h`
- `/lib/x86_64-linux-gnu/libc.so.6`

### Tools to Use:
- `objdump -d` - disassembly
- `readelf -S` - sections
- `readelf -r` - relocations
- `readelf -s` - symbols
- `gdb -batch -ex` - runtime inspection
- `grep` - header searches

---

## Formatting Patterns

### Tables
```
+--------+-------+------------------+
| Name   | Value | Meaning          |
+--------+-------+------------------+
| ENOENT | 2     | No such file     |
| EACCES | 13    | Permission denied|
+--------+-------+------------------+
```

### Flow Diagrams
```
SOURCE: open("file", O_RDWR)
    |
    v
PREPROCESS: Replace O_RDWR
    |
    v
COMPILE: Object file
```

### Math Blocks
```
MATH (Two's Complement):
    Value: 286 = 0x0000011e
    Invert bits: 0xfffffee1
    Add 1: 0xfffffee2
    Little-endian: e2 fe ff ff
```

---

## Naming

### Files:
- `index.html` - main navigation
- `stageN.html` - stage wrappers
- `explanation.html` - technical content
- `worksheet.html` - interactive exercises
- `explanation_stageN.html` - specific stages
- `worksheet_stageN.html` - specific worksheets

### Directories:
- `articles/` - stage wrappers
- Root - index + assets

---

## Quality Checklist

Before publishing:
- [ ] All commands tested on actual system
- [ ] Hex addresses match between tools
- [ ] Math verified manually
- [ ] Dark theme for nav, light for content
- [ ] Print button works
- [ ] Every section has AXIOM
- [ ] No undefined terms
- [ ] Machine config included
- [ ] Troubleshooting section present
