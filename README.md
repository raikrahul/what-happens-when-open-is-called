# What Happens When Open Is Called
> An Axiomatic, From-Scratch Deconstruction of the `open()` System Call.

## The Philosophy
You are a primate who understands counting, symbols, and basic math. You do NOT understand "magic", "abstractions", or "hand-waving".
This repository explains the journey of a file path `open("file.txt")` becoming a file descriptor `3`.

## The Rules
1.  **Zero Magic**: No "it just works". We derive it.
2.  **Zero Inference**: We don't assume you know what an Inode is. We prove it exists.
3.  **Visual Proof**: Input → Computation → Output.

## How to Read This
Start at `AXIOMATIC_CURRICULUM.md`.
Go in order. Do not skip lines.

## Content Structure
- `axiomatic_lessons/`: The step-by-step breakdown.
- `proofs/`: C programs that prove the axioms (run these!).
- `machine_truth.json`: The constants we verified on this machine.

## Deploying
This site is hosted on GitHub Pages.
Run `gh pages build` (or equivalent) to see the rendered output.
