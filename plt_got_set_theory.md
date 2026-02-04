# PLT-GOT Relationship in Set Theory Terms

## Fundamental Sets

Let:
- **F** = {f₀, f₁, f₂, ..., fₙ} = Set of external functions
- **P** = {p₀, p₁, p₂, ..., pₙ} = Set of PLT entries  
- **G** = {g₀, g₁, g₂, ..., gₙ} = Set of GOT entries
- **R** = {r₀, r₁, r₂, ..., rₙ} = Set of runtime addresses

## Set-Theoretic Relations

### 1. Domain and Codomain Relations

**Compilation Mapping**:
```
C: F → P
C(fᵢ) = pᵢ
```
**Domain(C) = F**, **Codomain(C) = P**

**Linker Mapping**:
```
L: P → G  
L(pᵢ) = gᵢ
```
**Domain(L) = P**, **Codomain(L) = G**

**Runtime Mapping**:
```
T: G → R
T(gᵢ) = rᵢ
```
**Domain(T) = G**, **Codomain(T) = R**

### 2. Function Properties

**Injective (One-to-One)**:
```
∀fᵢ, fⱼ ∈ F: fᵢ ≠ fⱼ ⇒ C(fᵢ) ≠ C(fⱼ)
∀pᵢ, pⱼ ∈ P: pᵢ ≠ pⱼ ⇒ L(pᵢ) ≠ L(pⱼ)
∀gᵢ, gⱼ ∈ G: gᵢ ≠ gⱼ ⇒ T(gᵢ) ≠ T(gⱼ)
```

**Surjective (Onto)**:
```
∀pᵢ ∈ P, ∃fᵢ ∈ F: C(fᵢ) = pᵢ
∀gᵢ ∈ G, ∃pᵢ ∈ P: L(pᵢ) = gᵢ  
∀rᵢ ∈ R, ∃gᵢ ∈ G: T(gᵢ) = rᵢ
```

**Bijective**:
Since all functions are both injective and surjective:
```
C, L, T are bijections
```

### 3. Cartesian Product Relations

**PLT-GOT Relation as Subset**:
```
R_plt_got ⊆ P × G
R_plt_got = {(pᵢ, gᵢ) | i ∈ ℕ₀, i ≤ n}
```

**Function-PLT Relation**:
```
R_func_plt ⊆ F × P  
R_func_plt = {(fᵢ, pᵢ) | i ∈ ℕ₀, i ≤ n}
```

**Complete Composition Relation**:
```
R_complete = {(fᵢ, rᵢ) | i ∈ ℕ₀, i ≤ n} ⊆ F × R
```

### 4. Equivalence Relations

**Partition the Universal Set**:
Let **U** = F ∪ P ∪ G ∪ R

**Equivalence Classes**:
```
[fᵢ] = {fᵢ, pᵢ, gᵢ, rᵢ}  for i ∈ {0, 1, 2, ..., n}

The set of equivalence classes = {[f₀], [f₁], [f₂], ..., [fₙ]}
```

**Properties**:
```
1. Reflexive: ∀x ∈ U, x ~ x
2. Symmetric: ∀x, y ∈ U, x ~ y ⇒ y ~ x  
3. Transitive: ∀x, y, z ∈ U, x ~ y ∧ y ~ z ⇒ x ~ z
```

### 5. Power Set and Subsets

**All Possible Mappings**:
```
P(F × P) = Power set of all possible F to P relations
P(P × G) = Power set of all possible P to G relations
```

**Actual Mappings Used**:
```
R_func_plt ∈ P(F × P)
R_plt_got ∈ P(P × G)
```

**Size Comparison**:
```
|R_func_plt| = |R_plt_got| = n + 1
|P(F × P)| = 2^((n+1)²)  (much larger!)
```

### 6. Function Composition in Set Theory

**Composition Operation**:
```
T ∘ L ∘ C: F → R
(T ∘ L ∘ C)(fᵢ) = T(L(C(fᵢ))) = rᵢ
```

**Image and Preimage**:

**Image of Function C**:
```
Im(C) = {pᵢ | ∃fᵢ ∈ F: C(fᵢ) = pᵢ} = P
```

**Preimage of GOT Entry**:
```
L⁻¹({gᵢ}) = {pᵢ | L(pᵢ) = gᵢ} = {pᵢ}
```

### 7. Set Operations

**Union of All Relations**:
```
R_total = R_func_plt ∪ R_plt_got ∪ R_got_runtime
```

**Intersection Properties**:
```
R_func_plt ∩ R_plt_got = ∅ (disjoint domains)
```

**Partition Property**:
```
R_func_plt ∪ R_plt_got ∪ R_got_runtime partitions F ∪ P ∪ G ∪ R
```

### 8. Cardinality and Cardinal Numbers

**Set Cardinalities**:
```
|F| = |P| = |G| = |R| = ℵ₀ (countably infinite for unlimited functions)
|F ∪ P ∪ G ∪ R| = 4 × |F| = ℵ₀
```

**Number of Bijections**:
```
|Bijections(F, G)| = |F|!  (factorial of cardinality)
```

### 9. Ordered Pairs and Tuples

**Mapping as Ordered Pairs**:
```
C = {(fᵢ, pᵢ) | i ∈ ℕ₀, i ≤ n} ⊆ F × P
L = {(pᵢ, gᵢ) | i ∈ ℕ₀, i ≤ n} ⊆ P × G  
T = {(gᵢ, rᵢ) | i ∈ ℕ₀, i ≤ n} ⊆ G × R
```

**Complete Path as 4-tuples**:
```
Path_i = (fᵢ, pᵢ, gᵢ, rᵢ) ∈ F × P × G × R
```

### 10. Axiom of Choice Application

**Choice Function**:
```
∃ choice: P(F \ {∅}) → F
choice(S) = some element of set S
```

The linker uses a deterministic choice function based on symbol ordering to select which PLT/GOT pair corresponds to each function.

## The Complete Set-Theoretic Model

**The PLT-GOT system forms**:
1. **Four disjoint sets**: F, P, G, R
2. **Three bijective functions**: C, L, T  
3. **A partition of U = F ∪ P ∪ G ∪ R** into equivalence classes
4. **A composition of functions** from external functions to runtime addresses

**In set-builder notation**:
```
∀fᵢ ∈ F: ∃!pᵢ ∈ P, ∃!gᵢ ∈ G, ∃!rᵢ ∈ R:
(fᵢ, pᵢ) ∈ C ∧ (pᵢ, gᵢ) ∈ L ∧ (gᵢ, rᵢ) ∈ T
```

This is the complete set-theoretic foundation of the PLT-GOT relationship.