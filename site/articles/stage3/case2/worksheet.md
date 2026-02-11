---
layout: default
title: "Stage 3 Case 2: Worksheet (Deep Miss)"
---

This worksheet derives the path walk for: Deep Miss.

### [TRACE MAP]
**Target:** `link_path_walk` / `walk_component`
**Process:** link_path_walk on parent, walk_component on leaf (return NULL)

1.  **[entry]** link_path_walk
2.  **[step]** component lookup
3.  **[exit]** result verification

---

### [WORKSHEET: RECORD DATA]

1.  **Syscall Filename Pointer:** 0x________________
2.  **Component 1 (Entry):** 0x________________ | name: "________"
3.  **Component 2 (Step):** 0x________________ | name: "________"
4.  **Final dentry/inode Ptr:** 0x________________

---

### [VERIFICATION]
- **Axiom:** (Child ptr) - (Parent ptr) matches directory entry offset? [YES / NO]
- **Status:** 🐾 IN PROGRESS. 🐾
