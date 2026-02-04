01. O_RDONLY = 0
02. O_WRONLY = 1
03. O_RDWR = 2
04. MAY_READ = 4
05. MAY_WRITE = 2
06. KERNEL_6 = 4 | 2
07. 0 & 4 = 0 ✗
08. 0 & 2 = 0 ✗
09. ∴ 0 → 4
10. ∴ 1 → 2
11. ∴ 2 → 6
12. O_ACCMODE = 3
13. MAP = [4, 2, 6, 6]
14. RSI = 2
15. RDI = 2
16. 2 & 3 = 2
17. MAP[2] = 6
18. ffffffff817c0650 → ffffffff817c0430
19. ffffffff817c0430 → MAP[2] → 6
20. op->acc_mode = 6
21. 6 & 4 = 4 ✓
22. 6 & 2 = 2 ✓
NEW THINGS INTRODUCED WITHOUT DERIVATION: NONE.
