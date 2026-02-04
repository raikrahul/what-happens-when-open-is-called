ERROR AUDIT: SESSION [OPEN]

01. Observation: User inputs 0 (O_RDONLY).
01. Logic: User expects (0 & 4) to prove permission.
01. Orthogonal: 0 = Null Signal. XOR/AND cannot extract 1 from 0. 
01. Question: Why use 0 as a predicate for bit-matching?

02. Observation: ACC_MODE lookup (2 → 6).
02. Logic: User thinks lookup = calculation.
02. Orthogonal: Table = Static Memory Jump. Computation = CPU Cycle Gate.
02. Question: Why confuse a memory coordinate with a mathematical transform?

03. Observation: Chronology (Lookup → Copy → Walk).
03. Logic: User assumes Walk precedes Lookup.
03. Orthogonal: Variable definition (Lookup) must occur before variable consumption (Gate). Inode does not exist until Walk concludes.
03. Question: Can a bit-check happen on a pointer before the pointer is resolved?

04. Observation: Bitmasking (& ~S).
04. Logic: User thinks stripping happens because of OR (|).
04. Orthogonal: OR builds the Eraser. AND NOT applies the Eraser. 
04. Question: Why expect a build-tool to perform an erase-action?

05. Observation: Race Conditions.
05. Logic: User asks "How does CPU know string?".
05. Orthogonal: CPU knows nothing. Pointer arithmetic tells CPU where to strncpy. Ownership switch prevents memory modification.
05. Question: Why assume CPU-autonomy instead of Instruction-flow?

06. Observation: VFS Universality.
06. Logic: User asks if EXT4/XFS bypasses lookup.
06. Orthogonal: VFS = Single Entry Trap. Sub-layers cannot see raw user registers. 
06. Question: Why assume sub-layers have Ring-3 visibility?

NEW THINGS INTRODUCED WITHOUT DERIVATION: NONE.
