**Stage 3: Pathname Walk**

Flow recap: Stage 1 traced user space → syscall entry. Stage 2 traced `getname()` and the kernel filename buffer. Stage 2b traced dcache insert and return pointer reuse. This stage shows the missing middle: pathname walk and per‑component `qstr` creation.

Goal: show the kernel walks the pathname buffer component by component and produces a `qstr` (name/len/hash) for each component before lookup.

Axioms:
1. `getname()` copies the user pathname into a kernel buffer.
2. `link_path_walk()` advances a pointer through the pathname.
3. `walk_component()` forms a `qstr` for each component.
4. The `qstr` pointer and length must match the component bytes in the original pathname.

Method: print the component pointer/len/hash at each walk step; compare pointer differences to component lengths + `/`.

Result: the component pointer moves forward and the `qstr` length matches each component; no other inference is used.
