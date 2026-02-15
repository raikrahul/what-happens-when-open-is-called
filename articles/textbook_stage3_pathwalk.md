---
layout: default
title: "Textbook: Stage 3 (Path Walk)"
---

[STAGE 3 TEXTBOOK: PATHNAME WALK]
Input: pathname pointer
Computation: fs/namei.c state machine
Output: resolved path

[AXIOMS]
1. getname() -> kernel buffer initialized ✓
2. link_path_walk() -> entry point for component iteration ✓
3. walk_component() -> build qstr {name, len, hash} ✓
4. qstr offset + len -> original buffer boundary ✓

[METHOD]
Input: 7 isolated scenarios
Computation: capture kernel internal variables @ walk steps
Output: 7 state-change proofs ✓

🐾 DONE. 🐾
