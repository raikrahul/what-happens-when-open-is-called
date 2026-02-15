# LRU (Least Recently Used): Numerical Explanation

## What
**Definition**: A Queue ordered by Time ($t$).
**Structure**: $Head \rightarrow [Object_{New}] \rightarrow \dots \rightarrow [Object_{Old}] \rightarrow Tail$.
**Operations**:
1.  **Access ($A$)**: $Object \rightarrow Head$. ($t = t_{now}$).
2.  **Evict ($E$)**: $Object \leftarrow Tail$. ($t = t_{min}$).
**Numerical Example**:
*   **Capacity**: 3 items.
*   **Input Stream**: 1, 2, 3, 1, 4.
*   **State Changes**:
    1.  Add 1: `[1]`
    2.  Add 2: `[2, 1]`
    3.  Add 3: `[3, 2, 1]` (Full)
    4.  Access 1: `[1, 3, 2]` (1 moves to Head).
    5.  Add 4: Evict Tail (2). State: `[4, 1, 3]`.

## Why
**Focus**: Probability of Reuse ($P$).
**Axiom**: $P(Recent) > P(Old)$. (Temporal Locality).
**Numerical Comparison**:
*   **Scenario**: 100 memory pages. 10 accessed frequently (Hot), 90 accessed once (Cold).
*   **Random Eviction**:
    *   Pick any page: $P(Evict\_Hot) = 10/100 = 10\%$.
    *   Risk: High.
*   **LRU Eviction**:
    *   Hot pages move to Head. Cold pages stay at Tail.
    *   Tail = Cold.
    *   $P(Evict\_Hot) \approx 0\%$.
    *   Efficiency = 100%.

## Where
**Location**: `struct list_lru` (Kernel Memory).
**Address Map**:
*   `Head`: `0xffff88810010` (Most Recent).
*   `Mid`: `0xffff88810020`
*   `Tail`: `0xffff88810030` (Least Recent).
*   Reclaim Scanner looks **only** at `0xffff88810030`.

## Who
**Actors**:
1.  **User (Restorer)**: Calls `dget()` or `find_inode()`.
    *   Action: Relinks Object to Head.
2.  **Kernel (Cleaner)**: Calls `list_lru_walk()`.
    *   Action: Unlinks Object from Tail.

## When
**Trigger**:
1.  **Promotion**: Every time object is touched ($t_{access} > t_{stored}$).
2.  **Demotion**: Never explicit. Happens implicitly as *other* objects are promoted.
3.  **Eviction**: When $Free\_Memory < Threshold$.

## Without
**Algorithm**: FIFO (First-In, First-Out).
**Scenario**: "Login Screen" image loaded at Boot ($t=0$).
*   User works for 8 hours. Memory fills up.
*   **FIFO**: Evicts "Login Screen" because $t=0$ is oldest.
*   **User Logs Out**: System must reload image from disk. Latency spike.
*   **With LRU**: "Login Screen" might be old, but if touched effectively, it survives? (Actually, pure LRU *would* evict it if not touched. *Scan Resistance* is needed for specialized cases, but basic LRU is better than Random).

## Which
**Variant**: `list_lru` (Kernel implementation).
**Mechanism**:
*   `list_add`: $O(1)$.
*   `list_del`: $O(1)$.
*   `list_move`: $O(1)$.
**Constraint**: Must be $O(1)$. Searching a list of 1,000,000 items is forbidden.
**Puzzle**:
*   You are a bartender. You have space for 3 bottles on the front counter (fast access).
*   Requests: Vodka, Gin, Rum, Vodka, Tequila.
*   **Step 1**: V, G, R on counter.
*   **Step 2**: Vodka requested. V moves to front. Order: V, G, R.
*   **Step 3**: Tequila requested. No space.
*   **Action**: Remove R (Tail). Put T at front. Order: T, V, G.
*   **Result**: Gin is now at risk.
