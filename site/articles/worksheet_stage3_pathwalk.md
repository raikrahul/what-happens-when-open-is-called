**Stage 3 Worksheet: Filename Walk (Components)**

Flow recap: Stage 1 traced user space → syscall entry. Stage 2 traced `getname()` and the kernel filename buffer. Stage 2b traced dcache insert and return pointer reuse. This worksheet captures the missing middle: pathname component walk and `qstr` creation.

Path used in this stage:

`/tmp/alpha/beta/gamma/delta.txt`

You are recording the component walk. You only write numbers printed by your probes.

**Run**

```
cd kernel/drivers/trace_do_filp_open && make
sudo insmod trace_do_filp_open.ko target_comm=multi_path_open
cd kernel/user/stage3 && gcc -o multi_path_open multi_path_open.c && ./multi_path_open
sudo dmesg | rg -n "link_path_walk|walk_component|lookup_fast|qstr|alpha|beta|gamma|delta"
sudo rmmod trace_do_filp_open
```

**Record (one block per component)**

Component: tmp
```
ptr = 0x________
len = ________
hash = ________
```

Component: alpha
```
ptr = 0x________
len = ________
hash = ________
```

Component: beta
```
ptr = 0x________
len = ________
hash = ________
```

Component: gamma
```
ptr = 0x________
len = ________
hash = ________
```

Component: delta.txt
```
ptr = 0x________
len = ________
hash = ________
```

**Pointer progression checks**

Compute each difference using your recorded pointers:

```
ptr(alpha) - ptr(tmp) = 0x________
ptr(beta)  - ptr(alpha) = 0x________
ptr(gamma) - ptr(beta) = 0x________
ptr(delta) - ptr(gamma) = 0x________
```

Each difference should equal the length of the previous component plus one slash.

**Output location**

Print ../articles/worksheet_stage3_pathwalk.html
