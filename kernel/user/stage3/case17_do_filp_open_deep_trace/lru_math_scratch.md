[Time] = t

Recency Function R(x):
R(x) = t_now - t_last_access(x)

Goal: Find x where R(x) is MAX (Oldest).
Eviction Policy: argmax_x(R(x))

Constraint: N = 1,000,000.
Checking all x is O(N). Too slow.
Requirement: O(1).

Solution: Map Space <-> Time.
List Head (H) represents t_now.
List Tail (T) represents t_oldest.

Data Structure: Double Linked List.
Nodes: L (List Head), A (Obj), B (Obj).

State 0: Empty
L.next = L
L.prev = L

State 1: Add A (t=1)
Operation: Insert A at Tail.
A.next = L
A.prev = L
L.next = A
L.prev = A
Visualization: [L <-> A]

State 2: Add B (t=2)
Operation: Insert B at Tail.
B.next = L
B.prev = A
A.next = B
L.prev = B
Visualization: [L <-> A <-> B]
Order: Head(L) -> Oldest(A) -> Newest(B)

State 3: Access A (t=3) -> Promotion
Condition: t_new(A) > t_old(B).
Action: Move A to Tail.
Step 3.1: Unlink A.
   L.next = B
   B.prev = L
Step 3.2: Link A at Tail.
   A.prev = B
   A.next = L
   B.next = A
   L.prev = A
Visualization: [L <-> B <-> A]
Order: Head(L) -> Oldest(B) -> Newest(A)

Addresses (64-bit):
L (Head) : 0xffff888000001000
A (Obj)  : 0xffff888000002000
B (Obj)  : 0xffff888000003000

Pointer State at t=2 (A is Oldest):
L.next -> 0x...2000 (A)
L.prev -> 0x...3000 (B)

A.next -> 0x...3000 (B)
A.prev -> 0x...1000 (L)

B.next -> 0x...1000 (L)
B.prev -> 0x...2000 (A)

Efficiency Calculation:
Scenario: N = 100,000 items. Target Reclaim = 50.

Method 1 (Sort timestamps):
   Cost: N * log(N)
   Operations: 1,600,000+ comparisons.

Method 2 (Scan timestamps):
   Cost: N
   Operations: 100,000 reads.

Method 3 (Kernel LRU List):
   Cost: 1 (dereference Head.next).
   For 50 items: 50 dereferences.
   Improvement: 2000x faster than linear scan.

Eviction Logic:
M_free  = Free Memory
M_limit = Low Watermark

IF (M_free < M_limit):
   1. Lock List L.
   2. Victim = L.next (Oldest).
   3. Unlink Victim.
   4. Free Victim.
   5. M_free = M_free + Size(Victim).
   6. Repeat.
