1. n=7,k=3,arr=[8,-3,4,2,-10,5,1] → mid=7/2=3 → window(3)={3,4,5} → 2+(-10)+5=-3 → write -3.
2. 1→start₂=2 → window(2)={2,3,4} → 4+2+(-10)=-4 → compare -4 vs -3 → max=-3,start=3,end=5.
3. 2→start₃=4 → window(4)={4,5,6} → -10+5+1=-4 → compare -4 vs -3 → max=-3 unchanged.
4. 3→start₄=1 → window(1)={1,2,3} → -3+4+2=3 → compare 3 vs -3 → max=3,start=1,end=3.
5. 4→start₅=5 → window(5)={5,6,0} → 5+1+8=14 → compare 14 vs 3 → max=14,start=5,end=0.
6. 5→start₆=0 → window(0)={0,1,2} → 8+(-3)+4=9 → compare 9 vs 14 → max=14 unchanged.
7. 6→start₇=6 → window(6)={6,0,1} → 1+8+(-3)=6 → compare 6 vs 14 → max=14 unchanged.
8. ∴ T0 expected=(ok=1,sum=14,start=5,end=0).
9. n=5,k=5,arr=[1,2,3,4,5] → only start set={0,1,2,3,4} but each length=5 hits all elements → each sum=15 → tie rule=min start=0 → end=(0+5-1)%5=4.
10. ∴ T1 expected=(1,15,0,4).
11. n=4,k=2,arr=[-5,-2,-9,-1] → s0=-7,s1=-11,s2=-10,s3=-6 → max=-6 at s3 → end=(3+1)%4=0.
12. ∴ T2 expected=(1,-6,3,0).
13. n=4,k=2,arr=[1073741824,1073741824,-2,7] → s0=2147483648,s1=1073741822,s2=5,s3=1073741831 → max=2147483648 at s0.
14. int32 max=2147483647 < 2147483648 ✗ → int64 ✓.
15. ∴ T3 expected=(1,2147483648,0,1).
16. n=3,k=4 → k>n ✓ → return (0,0,0,0,"k_out_of_range").
17. n=3,k=0 → k==0 ✓ → return (0,0,0,0,"k_out_of_range").
18. doubled method check: n=7 → doubled length=14 → prefix length=15 → prefix[0]=0, prefix[1]=8, prefix[2]=5, prefix[3]=9, prefix[4]=11, prefix[5]=1, prefix[6]=6, prefix[7]=7, prefix[8]=15, prefix[9]=12, prefix[10]=16, prefix[11]=18, prefix[12]=8, prefix[13]=13, prefix[14]=14.
19. window formula check: win(5)=prefix[8]-prefix[5]=15-1=14 ✓; win(0)=prefix[3]-prefix[0]=9-0=9 ✓.
20. tie rule job: if sum_new==sum_best ∧ start_new<start_best → replace; else keep.
21. index bounds job: start set={0..n-1}; end=(start+k-1)%n; k>=1; n>=1.
22. edge job A: n=1,k=1,arr=[9] → sum=9,start=0,end=0.
23. edge job B: n=1,k=0 → invalid.
24. edge job C: n=0,k=0 → invalid.
25. failure F1: loop start<=n ✗ gives n+1 windows → out-of-set start=n.
26. failure F2: end=start+k%n-1 ✗ precedence bug → use (start+k-1)%n.
27. failure F3: int sum overflow with 100000 values*1000000000=100000000000000 > int32 max.
28. failure F4: tie forgotten → unstable outputs across runs.
29. failure F5: modulo on negative index if signed math used ✗.
30. failure F6: prefix sized 2*n not 2*n+1 ✗ causes pref[i+k] overread when i=n-1,k=n.
31. manual exercise 1: compute all 7 windows for arr=[3,1,-4,9,2,-6,5],k=4; write set and max.
32. manual exercise 2: compute overflow boundary: x=9223372036854775800,y=20 → x+y=9223372036854775820 > int64 max=9223372036854775807 ✗.
33. manual exercise 3: compute tie case arr=[2,2,2,2],k=2 → all sums=4 → expected start=0 by rule.
34. implement order in code: precheck → build doubled/prefix or sliding init → iterate starts 0..n-1 → compare/update → return.
