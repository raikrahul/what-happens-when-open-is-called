/*
* worksheet_dentry.md
*
* -----------------------------------------------------------------------------
* DENTRY LOOKUP: MANUAL CALCULATION WORKSHEET
* -----------------------------------------------------------------------------
*
* TASK: Perform the kernel's dentry lookup algorithm by hand.
*
* DATA SOURCE (Captured from Kernel Trace):
* - PWD (case1) Address: 0xffff8b41a44eeb40
* - Target Name:         "dirA"
* - Target Hash:         0x03e4bb97
* - Global Hash Shift:   11
*
* -----------------------------------------------------------------------------
* STEP 1: CALCULATE THE BUCKET ID
* -----------------------------------------------------------------------------
* The Kernel uses the formula: hash >> (32 - shift)
*
* 1. Write the Hash in Binary:
*    0x03e4bb97 = 0000 0011 1110 0100 1011 1011 1001 0111
*
* 2. Calculate the Shift Amount:
*    32 - 11 = _______
*
* 3. Shift the Hash Right by _______ bits:
*    0x03e4bb97 >> _______ = _______ (Decimal: _______)
*
*    This is your Bucket ID.
*
* -----------------------------------------------------------------------------
* STEP 2: CHECK CANDIDATE A (The "Stranger")
* -----------------------------------------------------------------------------
* Candidate A Data:
* - Name:   "dirA"
* - Hash:   0x03e4bb97
* - Parent: 0xffff8b410b51a480 (This is actually 'dirB' address)
*
* 1. Compare Parent Pointers:
*    Is (Candidate.Parent == PWD.Address)?
*    Is (0xffff8b410b51a480 == 0xffff8b41a44eeb40)?
*    Result: _______ (MATCH / NO MATCH)
*
* 2. Conclusion:
*    Do we proceed to check the name? _______ (YES / NO)
*
* -----------------------------------------------------------------------------
* STEP 3: CHECK CANDIDATE B (The "Target")
* -----------------------------------------------------------------------------
* Candidate B Data:
* - Name:   "dirA"
* - Hash:   0x03e4bb97
* - Parent: 0xffff8b41a44eeb40 (This is 'case1' address)
*
* 1. Compare Parent Pointers:
*    Is (Candidate.Parent == PWD.Address)?
*    Is (0xffff8b41a44eeb40 == 0xffff8b41a44eeb40)?
*    Result: _______ (MATCH / NO MATCH)
*
* 2. Compare Hashes:
*    Is (Candidate.Hash == Target.Hash)?
*    Is (0x03e4bb97 == 0x03e4bb97)?
*    Result: _______ (MATCH / NO MATCH)
*
* 3. Compare Names (String Comparison):
*    Is ("dirA" == "dirA")?
*    Result: _______ (MATCH / NO MATCH)
*
* 4. Conclusion:
*    Is this the file we want? _______ (YES / NO)
*
* -----------------------------------------------------------------------------
* STEP 4: CHECK CANDIDATE C (The "Imposter")
* -----------------------------------------------------------------------------
* Candidate C Data:
* - Name:   "diRA" (Capital 'R', hash collision)
* - Hash:   0x03e4bb97
* - Parent: 0xffff8b41a44eeb40 (This is 'case1' address)
*
* 1. Compare Parent Pointers:
*    Is (Candidate.Parent == PWD.Address)?
*    Is (0xffff8b41a44eeb40 == 0xffff8b41a44eeb40)?
*    Result: _______ (MATCH / NO MATCH)
*
* 2. Compare Hashes:
*    Is (Candidate.Hash == Target.Hash)?
*    Result: _______ (MATCH / NO MATCH)
*
* 3. Compare Names:
*    Is ("diRA" == "dirA")?
*    Result: _______ (MATCH / NO MATCH)
*
* 4. Conclusion:
*    Is this the file we want? _______
*
* -----------------------------------------------------------------------------
* STEP 5: THE SALTED HASH (The "Harder Puzzle" Twist)
* -----------------------------------------------------------------------------
* Scenario: Resolving "common" inside "dirA" vs "common" inside "dirB".
*
* 1. Data from Trace:
*    - "common" + Parent(dirA) Hash: 0x0c0d6fc1
*    - "common" + Parent(dirB) Hash: 0xe5443054
*
* 2. Question:
*    The name strings are IDENTICAL ("common" == "common").
*    Why are the hash values DIFFERENT?
*    Answer: _________________________________________________________________
*            (Hint: Look at fs/namei.c hash_name() implementation)
*
* 3. Implication:
*    Does d_lookup even NEED to check the parent if the hashes are different?
*    Answer: _______ (YES / NO / SOMETIMES)
*
* 4. The Safety Net:
*    If "common" + Parent(dirB) accidentally hashed to 0x0c0d6fc1 (Collision),
*    which check saves us from opening the wrong directory?
*    Answer: Step _______ check.
*/
