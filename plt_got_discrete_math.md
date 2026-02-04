# PLT-GOT Relationship in Discrete Mathematics

## Set Theory Foundation

Let:
- **P** = Set of PLT entries = {p₀, p₁, p₂, ..., pₙ}
- **G** = Set of GOT entries = {g₀, g₁, g₂, ..., gₙ}
- **F** = Set of external functions = {f₀, f₁, f₂, ..., fₙ}

## Function Definitions

### 1. Index Mapping Function
```
idx: F → ℕ
idx(fᵢ) = i
```
Maps each function to its processing order index.

### 2. PLT Address Function
```
plt_addr: ℕ → ℕ
plt_addr(i) = plt_base + (i × plt_entry_size)
```
Where `plt_base = 0x1050`, `plt_entry_size = 16`.

### 3. GOT Address Function
```
got_addr: ℕ → ℕ  
got_addr(i) = got_base + (i × got_entry_size)
```
Where `got_base = 0x3fb8`, `got_entry_size = 8`.

### 4. Displacement Function
```
disp: ℕ × ℕ → ℤ
disp(i, j) = got_addr(j) - (plt_addr(i) + instruction_length)
```
Where `instruction_length = 6`.

## Core Mathematical Relationships

### Relation 1: Bijection Between Functions and Entries
```
fᵢ ↔ pᵢ ↔ gᵢ  for all i ∈ ℕ
```
This is a **bijective relation** - one-to-one correspondence.

### Relation 2: PLT-to-GOT Mapping
```
R_plt_got = {(pᵢ, gᵢ) | i ∈ ℕ}
```
This is the **identity relation** under index mapping.

### Relation 3: Call-to-PLT Mapping
```
call_address = function_code_location
call_target = plt_addr(idx(function))
```

## Mathematical Proof of Address Calculations

### Theorem 1: GOT Address Determination
**Given**: `got_base = 0x3fb8`, function `open` has index 3

**Proof**:
```
got_addr(open) = got_base + (idx(open) × 8)
                = 0x3fb8 + (3 × 8) 
                = 0x3fb8 + 0x18
                = 0x3fd0
∎
```

### Theorem 2: PLT Address Determination  
**Given**: `plt_base = 0x1050`, function `open` has index 3

**Proof**:
```
plt_addr(open) = plt_base + (idx(open) × 16)
                = 0x1050 + (3 × 16)
                = 0x1050 + 0x30  
                = 0x1080
```
*Note: Actual shows 0x1050 due to different base calculation*

### Theorem 3: Displacement Calculation
**Given**: PLT instruction at 0x1054, GOT target at 0x3fd0

**Proof**:
```
disp = got_addr - (plt_instr + instr_len)
     = 0x3fd0 - (0x1054 + 6)
     = 0x3fd0 - 0x105a  
     = 0x2f76
∎
```

## Algebraic Relations

### Composition of Functions
```
Function → PLT → GOT → Real Address
fᵢ → plt_addr(i) → got_addr(i) → runtime_addr
```

### Functional Composition
```
runtime_addr = patch ○ got_addr ○ idx ○ identify_function
```
Where:
- `identify_function`: Maps call site to function name
- `idx`: Maps function to index  
- `got_addr`: Maps index to GOT address
- `patch`: Maps GOT address to runtime address

## Graph Theory Representation

### Directed Graph
```
Nodes: {functions, PLT entries, GOT entries, runtime addresses}
Edges: 
  fᵢ → pᵢ (compilation mapping)
  pᵢ → gᵢ (linker mapping)  
  gᵢ → rᵢ (runtime mapping)
```

This forms a **disjoint union of paths**:
```
f₀ → p₀ → g₀ → r₀
f₁ → p₁ → g₁ → r₁
f₂ → p₂ → g₂ → r₂
...
```

## Properties of the PLT-GOT Relation

### 1. Reflexivity
```
∀fᵢ ∈ F: fᵢ R fᵢ (trivial - function maps to itself)
```

### 2. Symmetry (Partial)
```
(pᵢ, gᵢ) ∈ R_plt_got ⇒ (gᵢ, pᵢ) ∈ R_got_plt (inverse mapping exists)
```

### 3. Transitivity
```
(fᵢ, pᵢ) ∈ R AND (pᵢ, gᵢ) ∈ R ⇒ (fᵢ, gᵢ) ∈ R
```

### 4. Equivalence Classes
Each function belongs to exactly one equivalence class:
```
[fᵢ] = {fᵢ, pᵢ, gᵢ, runtime_addrᵢ}
```

## Counting and Cardinality

### Cardinality Relations
```
|F| = |P| = |G| = n  (where n = number of external functions)
```

### Number of Possible Mappings
```
Number of bijections from F to G = n!
```
But linker uses **deterministic mapping** based on symbol order.

## Recurrence Relations

### GOT Address Recurrence
```
got_addr(0) = got_base
got_addr(n+1) = got_addr(n) + 8
```

### PLT Address Recurrence  
```
plt_addr(0) = plt_base
plt_addr(n+1) = plt_addr(n) + 16
```

## Formal Specification

### Using Set-Builder Notation
```
R_plt_got = {(x, y) | x ∈ P ∧ y ∈ G ∧ index(x) = index(y)}
```

### Using Predicate Logic
```
∀fᵢ ∈ F: ∃!pᵢ ∈ P, ∃!gᵢ ∈ G: 
  (fᵢ, pᵢ) ∈ R_func_plt ∧ (pᵢ, gᵢ) ∈ R_plt_got
```

This discrete mathematics formulation shows that PLT-GOT relationship is fundamentally a **bijective mapping** enforced through **arithmetic sequences** with deterministic index-based addressing.