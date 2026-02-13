
/usr/src/linux-hwe-6.17-6.17.0/fs/namei.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <__pfx_full_name_hash>:
       0:	90                   	nop
       1:	90                   	nop
       2:	90                   	nop
       3:	90                   	nop
       4:	90                   	nop
       5:	90                   	nop
       6:	90                   	nop
       7:	90                   	nop
       8:	90                   	nop
       9:	90                   	nop
       a:	90                   	nop
       b:	90                   	nop
       c:	90                   	nop
       d:	90                   	nop
       e:	90                   	nop
       f:	90                   	nop

0000000000000010 <full_name_hash>:
      10:	e8 00 00 00 00       	call   15 <full_name_hash+0x5>
      15:	55                   	push   %rbp
      16:	48 89 f8             	mov    %rdi,%rax
      19:	48 89 e5             	mov    %rsp,%rbp
      1c:	85 d2                	test   %edx,%edx
      1e:	74 45                	je     65 <full_name_hash+0x55>
      20:	48 8b 3e             	mov    (%rsi),%rdi
      23:	45 31 c0             	xor    %r8d,%r8d
      26:	83 fa 07             	cmp    $0x7,%edx
      29:	77 0a                	ja     35 <full_name_hash+0x25>
      2b:	eb 5b                	jmp    88 <full_name_hash+0x78>
      2d:	48 8b 3e             	mov    (%rsi),%rdi
      30:	83 fa 07             	cmp    $0x7,%edx
      33:	76 53                	jbe    88 <full_name_hash+0x78>
      35:	4c 31 c7             	xor    %r8,%rdi
      38:	48 83 c6 08          	add    $0x8,%rsi
      3c:	48 31 f8             	xor    %rdi,%rax
      3f:	48 c1 c7 0c          	rol    $0xc,%rdi
      43:	4c 8d 04 38          	lea    (%rax,%rdi,1),%r8
      47:	48 c1 c8 13          	ror    $0x13,%rax
      4b:	48 8d 04 c0          	lea    (%rax,%rax,8),%rax
      4f:	83 ea 08             	sub    $0x8,%edx
      52:	75 d9                	jne    2d <full_name_hash+0x1d>
      54:	48 ba eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rdx
      5b:	86 c8 61 
      5e:	49 0f af d0          	imul   %r8,%rdx
      62:	48 31 d0             	xor    %rdx,%rax
      65:	48 ba eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rdx
      6c:	86 c8 61 
      6f:	5d                   	pop    %rbp
      70:	48 0f af c2          	imul   %rdx,%rax
      74:	48 c1 e8 20          	shr    $0x20,%rax
      78:	31 d2                	xor    %edx,%edx
      7a:	31 c9                	xor    %ecx,%ecx
      7c:	31 f6                	xor    %esi,%esi
      7e:	31 ff                	xor    %edi,%edi
      80:	45 31 c0             	xor    %r8d,%r8d
      83:	e9 00 00 00 00       	jmp    88 <full_name_hash+0x78>
      88:	8d 0c d5 00 00 00 00 	lea    0x0(,%rdx,8),%ecx
      8f:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
      96:	48 d3 e2             	shl    %cl,%rdx
      99:	48 b9 eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rcx
      a0:	86 c8 61 
      a3:	48 f7 d2             	not    %rdx
      a6:	48 21 fa             	and    %rdi,%rdx
      a9:	4c 31 c2             	xor    %r8,%rdx
      ac:	48 0f af d1          	imul   %rcx,%rdx
      b0:	48 31 d0             	xor    %rdx,%rax
      b3:	eb b0                	jmp    65 <full_name_hash+0x55>
      b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
      bc:	00 00 00 00 

00000000000000c0 <__pfx_lookup_noperm_common>:
      c0:	90                   	nop
      c1:	90                   	nop
      c2:	90                   	nop
      c3:	90                   	nop
      c4:	90                   	nop
      c5:	90                   	nop
      c6:	90                   	nop
      c7:	90                   	nop
      c8:	90                   	nop
      c9:	90                   	nop
      ca:	90                   	nop
      cb:	90                   	nop
      cc:	90                   	nop
      cd:	90                   	nop
      ce:	90                   	nop
      cf:	90                   	nop

00000000000000d0 <lookup_noperm_common>:
      d0:	e8 00 00 00 00       	call   d5 <lookup_noperm_common+0x5>
      d5:	55                   	push   %rbp
      d6:	48 89 e5             	mov    %rsp,%rbp
      d9:	41 56                	push   %r14
      db:	49 89 f6             	mov    %rsi,%r14
      de:	41 55                	push   %r13
      e0:	49 89 fd             	mov    %rdi,%r13
      e3:	41 54                	push   %r12
      e5:	53                   	push   %rbx
      e6:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
      ea:	44 8b 67 04          	mov    0x4(%rdi),%r12d
      ee:	4c 89 f7             	mov    %r14,%rdi
      f1:	48 89 de             	mov    %rbx,%rsi
      f4:	44 89 e2             	mov    %r12d,%edx
      f7:	e8 00 00 00 00       	call   fc <lookup_noperm_common+0x2c>
      fc:	41 89 45 00          	mov    %eax,0x0(%r13)
     100:	45 85 e4             	test   %r12d,%r12d
     103:	74 57                	je     15c <lookup_noperm_common+0x8c>
     105:	80 3b 2e             	cmpb   $0x2e,(%rbx)
     108:	44 89 e2             	mov    %r12d,%edx
     10b:	74 67                	je     174 <lookup_noperm_common+0xa4>
     10d:	48 01 da             	add    %rbx,%rdx
     110:	eb 10                	jmp    122 <lookup_noperm_common+0x52>
     112:	0f b6 03             	movzbl (%rbx),%eax
     115:	48 83 c3 01          	add    $0x1,%rbx
     119:	83 f8 2f             	cmp    $0x2f,%eax
     11c:	74 3e                	je     15c <lookup_noperm_common+0x8c>
     11e:	85 c0                	test   %eax,%eax
     120:	74 3a                	je     15c <lookup_noperm_common+0x8c>
     122:	48 39 d3             	cmp    %rdx,%rbx
     125:	75 eb                	jne    112 <lookup_noperm_common+0x42>
     127:	31 c0                	xor    %eax,%eax
     129:	41 f6 06 01          	testb  $0x1,(%r14)
     12d:	74 1a                	je     149 <lookup_noperm_common+0x79>
     12f:	49 8b 46 60          	mov    0x60(%r14),%rax
     133:	4c 89 ee             	mov    %r13,%rsi
     136:	4c 89 f7             	mov    %r14,%rdi
     139:	48 8b 40 10          	mov    0x10(%rax),%rax
     13d:	e8 00 00 00 00       	call   142 <lookup_noperm_common+0x72>
     142:	31 d2                	xor    %edx,%edx
     144:	85 c0                	test   %eax,%eax
     146:	0f 4f c2             	cmovg  %edx,%eax
     149:	5b                   	pop    %rbx
     14a:	41 5c                	pop    %r12
     14c:	41 5d                	pop    %r13
     14e:	41 5e                	pop    %r14
     150:	5d                   	pop    %rbp
     151:	31 d2                	xor    %edx,%edx
     153:	31 f6                	xor    %esi,%esi
     155:	31 ff                	xor    %edi,%edi
     157:	e9 00 00 00 00       	jmp    15c <lookup_noperm_common+0x8c>
     15c:	5b                   	pop    %rbx
     15d:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
     162:	41 5c                	pop    %r12
     164:	41 5d                	pop    %r13
     166:	41 5e                	pop    %r14
     168:	5d                   	pop    %rbp
     169:	31 d2                	xor    %edx,%edx
     16b:	31 f6                	xor    %esi,%esi
     16d:	31 ff                	xor    %edi,%edi
     16f:	e9 00 00 00 00       	jmp    174 <lookup_noperm_common+0xa4>
     174:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
     179:	48 83 fa 01          	cmp    $0x1,%rdx
     17d:	74 ca                	je     149 <lookup_noperm_common+0x79>
     17f:	48 83 fa 02          	cmp    $0x2,%rdx
     183:	75 88                	jne    10d <lookup_noperm_common+0x3d>
     185:	80 7b 01 2e          	cmpb   $0x2e,0x1(%rbx)
     189:	75 82                	jne    10d <lookup_noperm_common+0x3d>
     18b:	eb bc                	jmp    149 <lookup_noperm_common+0x79>
     18d:	0f 1f 00             	nopl   (%rax)

0000000000000190 <__pfx___check_sticky>:
     190:	90                   	nop
     191:	90                   	nop
     192:	90                   	nop
     193:	90                   	nop
     194:	90                   	nop
     195:	90                   	nop
     196:	90                   	nop
     197:	90                   	nop
     198:	90                   	nop
     199:	90                   	nop
     19a:	90                   	nop
     19b:	90                   	nop
     19c:	90                   	nop
     19d:	90                   	nop
     19e:	90                   	nop
     19f:	90                   	nop

00000000000001a0 <__check_sticky>:
     1a0:	e8 00 00 00 00       	call   1a5 <__check_sticky+0x5>
     1a5:	55                   	push   %rbp
     1a6:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 1ae <__check_sticky+0xe>
     1ad:	00 
     1ae:	48 89 e5             	mov    %rsp,%rbp
     1b1:	41 56                	push   %r14
     1b3:	49 89 f6             	mov    %rsi,%r14
     1b6:	41 55                	push   %r13
     1b8:	41 54                	push   %r12
     1ba:	49 89 fc             	mov    %rdi,%r12
     1bd:	53                   	push   %rbx
     1be:	48 8b 80 a0 0c 00 00 	mov    0xca0(%rax),%rax
     1c5:	48 89 d3             	mov    %rdx,%rbx
     1c8:	8b 52 04             	mov    0x4(%rdx),%edx
     1cb:	44 8b 68 20          	mov    0x20(%rax),%r13d
     1cf:	48 8b 43 28          	mov    0x28(%rbx),%rax
     1d3:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
     1da:	e8 00 00 00 00       	call   1df <__check_sticky+0x3f>
     1df:	44 39 e8             	cmp    %r13d,%eax
     1e2:	75 05                	jne    1e9 <__check_sticky+0x49>
     1e4:	83 f8 ff             	cmp    $0xffffffff,%eax
     1e7:	75 4a                	jne    233 <__check_sticky+0x93>
     1e9:	49 8b 46 28          	mov    0x28(%r14),%rax
     1ed:	41 8b 56 04          	mov    0x4(%r14),%edx
     1f1:	4c 89 e7             	mov    %r12,%rdi
     1f4:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
     1fb:	e8 00 00 00 00       	call   200 <__check_sticky+0x60>
     200:	44 39 e8             	cmp    %r13d,%eax
     203:	75 05                	jne    20a <__check_sticky+0x6a>
     205:	83 f8 ff             	cmp    $0xffffffff,%eax
     208:	75 29                	jne    233 <__check_sticky+0x93>
     20a:	48 89 de             	mov    %rbx,%rsi
     20d:	4c 89 e7             	mov    %r12,%rdi
     210:	ba 03 00 00 00       	mov    $0x3,%edx
     215:	e8 00 00 00 00       	call   21a <__check_sticky+0x7a>
     21a:	5b                   	pop    %rbx
     21b:	41 5c                	pop    %r12
     21d:	83 f0 01             	xor    $0x1,%eax
     220:	41 5d                	pop    %r13
     222:	41 5e                	pop    %r14
     224:	0f b6 c0             	movzbl %al,%eax
     227:	5d                   	pop    %rbp
     228:	31 d2                	xor    %edx,%edx
     22a:	31 f6                	xor    %esi,%esi
     22c:	31 ff                	xor    %edi,%edi
     22e:	e9 00 00 00 00       	jmp    233 <__check_sticky+0x93>
     233:	5b                   	pop    %rbx
     234:	31 c0                	xor    %eax,%eax
     236:	41 5c                	pop    %r12
     238:	41 5d                	pop    %r13
     23a:	41 5e                	pop    %r14
     23c:	5d                   	pop    %rbp
     23d:	31 d2                	xor    %edx,%edx
     23f:	31 f6                	xor    %esi,%esi
     241:	31 ff                	xor    %edi,%edi
     243:	e9 00 00 00 00       	jmp    248 <__check_sticky+0xa8>
     248:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
     24f:	00 

0000000000000250 <__pfx_path_get>:
     250:	90                   	nop
     251:	90                   	nop
     252:	90                   	nop
     253:	90                   	nop
     254:	90                   	nop
     255:	90                   	nop
     256:	90                   	nop
     257:	90                   	nop
     258:	90                   	nop
     259:	90                   	nop
     25a:	90                   	nop
     25b:	90                   	nop
     25c:	90                   	nop
     25d:	90                   	nop
     25e:	90                   	nop
     25f:	90                   	nop

0000000000000260 <path_get>:
     260:	e8 00 00 00 00       	call   265 <path_get+0x5>
     265:	55                   	push   %rbp
     266:	48 89 e5             	mov    %rsp,%rbp
     269:	53                   	push   %rbx
     26a:	48 89 fb             	mov    %rdi,%rbx
     26d:	48 8b 3f             	mov    (%rdi),%rdi
     270:	e8 00 00 00 00       	call   275 <path_get+0x15>
     275:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
     279:	48 85 ff             	test   %rdi,%rdi
     27c:	74 09                	je     287 <path_get+0x27>
     27e:	48 83 ef 80          	sub    $0xffffffffffffff80,%rdi
     282:	e8 00 00 00 00       	call   287 <path_get+0x27>
     287:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     28b:	c9                   	leave
     28c:	31 c0                	xor    %eax,%eax
     28e:	31 ff                	xor    %edi,%edi
     290:	e9 00 00 00 00       	jmp    295 <path_get+0x35>
     295:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     29c:	00 00 00 00 

00000000000002a0 <__pfx_path_put>:
     2a0:	90                   	nop
     2a1:	90                   	nop
     2a2:	90                   	nop
     2a3:	90                   	nop
     2a4:	90                   	nop
     2a5:	90                   	nop
     2a6:	90                   	nop
     2a7:	90                   	nop
     2a8:	90                   	nop
     2a9:	90                   	nop
     2aa:	90                   	nop
     2ab:	90                   	nop
     2ac:	90                   	nop
     2ad:	90                   	nop
     2ae:	90                   	nop
     2af:	90                   	nop

00000000000002b0 <path_put>:
     2b0:	e8 00 00 00 00       	call   2b5 <path_put+0x5>
     2b5:	55                   	push   %rbp
     2b6:	48 89 e5             	mov    %rsp,%rbp
     2b9:	53                   	push   %rbx
     2ba:	48 89 fb             	mov    %rdi,%rbx
     2bd:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
     2c1:	e8 00 00 00 00       	call   2c6 <path_put+0x16>
     2c6:	48 8b 3b             	mov    (%rbx),%rdi
     2c9:	e8 00 00 00 00       	call   2ce <path_put+0x1e>
     2ce:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     2d2:	c9                   	leave
     2d3:	31 ff                	xor    %edi,%edi
     2d5:	e9 00 00 00 00       	jmp    2da <path_put+0x2a>
     2da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000002e0 <__pfx_follow_up>:
     2e0:	90                   	nop
     2e1:	90                   	nop
     2e2:	90                   	nop
     2e3:	90                   	nop
     2e4:	90                   	nop
     2e5:	90                   	nop
     2e6:	90                   	nop
     2e7:	90                   	nop
     2e8:	90                   	nop
     2e9:	90                   	nop
     2ea:	90                   	nop
     2eb:	90                   	nop
     2ec:	90                   	nop
     2ed:	90                   	nop
     2ee:	90                   	nop
     2ef:	90                   	nop

00000000000002f0 <follow_up>:
     2f0:	e8 00 00 00 00       	call   2f5 <follow_up+0x5>
     2f5:	55                   	push   %rbp
     2f6:	48 89 e5             	mov    %rsp,%rbp
     2f9:	41 55                	push   %r13
     2fb:	41 54                	push   %r12
     2fd:	53                   	push   %rbx
     2fe:	4c 8b 2f             	mov    (%rdi),%r13
     301:	48 89 fb             	mov    %rdi,%rbx
     304:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     30b:	e8 00 00 00 00       	call   310 <follow_up+0x20>
     310:	49 8b 45 f0          	mov    -0x10(%r13),%rax
     314:	49 8d 55 e0          	lea    -0x20(%r13),%rdx
     318:	48 39 d0             	cmp    %rdx,%rax
     31b:	74 59                	je     376 <follow_up+0x86>
     31d:	4c 8d 60 20          	lea    0x20(%rax),%r12
     321:	4c 89 e7             	mov    %r12,%rdi
     324:	e8 00 00 00 00       	call   329 <follow_up+0x39>
     329:	4d 8b 6d f8          	mov    -0x8(%r13),%r13
     32d:	4d 85 ed             	test   %r13,%r13
     330:	74 0c                	je     33e <follow_up+0x4e>
     332:	49 8d bd 80 00 00 00 	lea    0x80(%r13),%rdi
     339:	e8 00 00 00 00       	call   33e <follow_up+0x4e>
     33e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     345:	e8 00 00 00 00       	call   34a <follow_up+0x5a>
     34a:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
     34e:	e8 00 00 00 00       	call   353 <follow_up+0x63>
     353:	4c 89 6b 08          	mov    %r13,0x8(%rbx)
     357:	48 8b 3b             	mov    (%rbx),%rdi
     35a:	e8 00 00 00 00       	call   35f <follow_up+0x6f>
     35f:	4c 89 23             	mov    %r12,(%rbx)
     362:	b8 01 00 00 00       	mov    $0x1,%eax
     367:	5b                   	pop    %rbx
     368:	41 5c                	pop    %r12
     36a:	41 5d                	pop    %r13
     36c:	5d                   	pop    %rbp
     36d:	31 d2                	xor    %edx,%edx
     36f:	31 ff                	xor    %edi,%edi
     371:	e9 00 00 00 00       	jmp    376 <follow_up+0x86>
     376:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     37d:	e8 00 00 00 00       	call   382 <follow_up+0x92>
     382:	31 c0                	xor    %eax,%eax
     384:	5b                   	pop    %rbx
     385:	41 5c                	pop    %r12
     387:	41 5d                	pop    %r13
     389:	5d                   	pop    %rbp
     38a:	31 d2                	xor    %edx,%edx
     38c:	31 ff                	xor    %edi,%edi
     38e:	e9 00 00 00 00       	jmp    393 <follow_up+0xa3>
     393:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     39a:	00 00 00 00 
     39e:	66 90                	xchg   %ax,%ax

00000000000003a0 <__pfx_follow_down_one>:
     3a0:	90                   	nop
     3a1:	90                   	nop
     3a2:	90                   	nop
     3a3:	90                   	nop
     3a4:	90                   	nop
     3a5:	90                   	nop
     3a6:	90                   	nop
     3a7:	90                   	nop
     3a8:	90                   	nop
     3a9:	90                   	nop
     3aa:	90                   	nop
     3ab:	90                   	nop
     3ac:	90                   	nop
     3ad:	90                   	nop
     3ae:	90                   	nop
     3af:	90                   	nop

00000000000003b0 <follow_down_one>:
     3b0:	e8 00 00 00 00       	call   3b5 <follow_down_one+0x5>
     3b5:	55                   	push   %rbp
     3b6:	48 89 e5             	mov    %rsp,%rbp
     3b9:	41 54                	push   %r12
     3bb:	53                   	push   %rbx
     3bc:	48 89 fb             	mov    %rdi,%rbx
     3bf:	e8 00 00 00 00       	call   3c4 <follow_down_one+0x14>
     3c4:	49 89 c4             	mov    %rax,%r12
     3c7:	31 c0                	xor    %eax,%eax
     3c9:	4d 85 e4             	test   %r12,%r12
     3cc:	75 0b                	jne    3d9 <follow_down_one+0x29>
     3ce:	5b                   	pop    %rbx
     3cf:	41 5c                	pop    %r12
     3d1:	5d                   	pop    %rbp
     3d2:	31 ff                	xor    %edi,%edi
     3d4:	e9 00 00 00 00       	jmp    3d9 <follow_down_one+0x29>
     3d9:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
     3dd:	e8 00 00 00 00       	call   3e2 <follow_down_one+0x32>
     3e2:	48 8b 3b             	mov    (%rbx),%rdi
     3e5:	e8 00 00 00 00       	call   3ea <follow_down_one+0x3a>
     3ea:	4c 89 23             	mov    %r12,(%rbx)
     3ed:	4d 8b 24 24          	mov    (%r12),%r12
     3f1:	4d 85 e4             	test   %r12,%r12
     3f4:	74 0d                	je     403 <follow_down_one+0x53>
     3f6:	49 8d bc 24 80 00 00 	lea    0x80(%r12),%rdi
     3fd:	00 
     3fe:	e8 00 00 00 00       	call   403 <follow_down_one+0x53>
     403:	4c 89 63 08          	mov    %r12,0x8(%rbx)
     407:	b8 01 00 00 00       	mov    $0x1,%eax
     40c:	5b                   	pop    %rbx
     40d:	41 5c                	pop    %r12
     40f:	5d                   	pop    %rbp
     410:	31 ff                	xor    %edi,%edi
     412:	e9 00 00 00 00       	jmp    417 <follow_down_one+0x67>
     417:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     41e:	00 00 

0000000000000420 <__pfx___traverse_mounts>:
     420:	90                   	nop
     421:	90                   	nop
     422:	90                   	nop
     423:	90                   	nop
     424:	90                   	nop
     425:	90                   	nop
     426:	90                   	nop
     427:	90                   	nop
     428:	90                   	nop
     429:	90                   	nop
     42a:	90                   	nop
     42b:	90                   	nop
     42c:	90                   	nop
     42d:	90                   	nop
     42e:	90                   	nop
     42f:	90                   	nop

0000000000000430 <__traverse_mounts>:
     430:	e8 00 00 00 00       	call   435 <__traverse_mounts+0x5>
     435:	55                   	push   %rbp
     436:	48 89 e5             	mov    %rsp,%rbp
     439:	41 57                	push   %r15
     43b:	41 56                	push   %r14
     43d:	41 89 f6             	mov    %esi,%r14d
     440:	41 55                	push   %r13
     442:	41 54                	push   %r12
     444:	53                   	push   %rbx
     445:	48 83 ec 28          	sub    $0x28,%rsp
     449:	48 8b 07             	mov    (%rdi),%rax
     44c:	81 e6 00 80 03 00    	and    $0x38000,%esi
     452:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
     456:	44 89 45 d4          	mov    %r8d,-0x2c(%rbp)
     45a:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
     45e:	0f 84 34 02 00 00    	je     698 <__traverse_mounts+0x268>
     464:	41 81 e0 00 00 00 04 	and    $0x4000000,%r8d
     46b:	49 89 fd             	mov    %rdi,%r13
     46e:	48 89 cb             	mov    %rcx,%rbx
     471:	45 31 ff             	xor    %r15d,%r15d
     474:	c6 45 c8 00          	movb   $0x0,-0x38(%rbp)
     478:	45 89 c4             	mov    %r8d,%r12d
     47b:	eb 7e                	jmp    4fb <__traverse_mounts+0xcb>
     47d:	41 f7 c6 00 00 01 00 	test   $0x10000,%r14d
     484:	0f 84 11 01 00 00    	je     59b <__traverse_mounts+0x16b>
     48a:	49 8b 45 08          	mov    0x8(%r13),%rax
     48e:	f7 45 d4 06 04 03 00 	testl  $0x30406,-0x2c(%rbp)
     495:	75 0b                	jne    4a2 <__traverse_mounts+0x72>
     497:	48 83 78 30 00       	cmpq   $0x0,0x30(%rax)
     49c:	0f 85 68 01 00 00    	jne    60a <__traverse_mounts+0x1da>
     4a2:	45 85 e4             	test   %r12d,%r12d
     4a5:	0f 85 a7 01 00 00    	jne    652 <__traverse_mounts+0x222>
     4ab:	48 85 db             	test   %rbx,%rbx
     4ae:	74 10                	je     4c0 <__traverse_mounts+0x90>
     4b0:	8b 13                	mov    (%rbx),%edx
     4b2:	8d 4a 01             	lea    0x1(%rdx),%ecx
     4b5:	89 0b                	mov    %ecx,(%rbx)
     4b7:	83 fa 27             	cmp    $0x27,%edx
     4ba:	0f 8f b3 01 00 00    	jg     673 <__traverse_mounts+0x243>
     4c0:	48 8b 40 60          	mov    0x60(%rax),%rax
     4c4:	4c 89 ef             	mov    %r13,%rdi
     4c7:	48 8b 40 50          	mov    0x50(%rax),%rax
     4cb:	e8 00 00 00 00       	call   4d0 <__traverse_mounts+0xa0>
     4d0:	4c 89 ee             	mov    %r13,%rsi
     4d3:	48 89 c7             	mov    %rax,%rdi
     4d6:	e8 00 00 00 00       	call   4db <__traverse_mounts+0xab>
     4db:	41 89 c7             	mov    %eax,%r15d
     4de:	49 8b 45 08          	mov    0x8(%r13),%rax
     4e2:	44 8b 30             	mov    (%rax),%r14d
     4e5:	45 85 ff             	test   %r15d,%r15d
     4e8:	0f 88 ad 00 00 00    	js     59b <__traverse_mounts+0x16b>
     4ee:	41 f7 c6 00 80 03 00 	test   $0x38000,%r14d
     4f5:	0f 84 a0 00 00 00    	je     59b <__traverse_mounts+0x16b>
     4fb:	41 f7 c6 00 00 02 00 	test   $0x20000,%r14d
     502:	74 2e                	je     532 <__traverse_mounts+0x102>
     504:	45 85 e4             	test   %r12d,%r12d
     507:	0f 85 30 01 00 00    	jne    63d <__traverse_mounts+0x20d>
     50d:	49 8b 45 08          	mov    0x8(%r13),%rax
     511:	31 f6                	xor    %esi,%esi
     513:	4c 89 ef             	mov    %r13,%rdi
     516:	48 8b 40 60          	mov    0x60(%rax),%rax
     51a:	48 8b 40 58          	mov    0x58(%rax),%rax
     51e:	e8 00 00 00 00       	call   523 <__traverse_mounts+0xf3>
     523:	41 89 c7             	mov    %eax,%r15d
     526:	49 8b 45 08          	mov    0x8(%r13),%rax
     52a:	44 8b 30             	mov    (%rax),%r14d
     52d:	45 85 ff             	test   %r15d,%r15d
     530:	78 69                	js     59b <__traverse_mounts+0x16b>
     532:	41 f7 c6 00 80 00 00 	test   $0x8000,%r14d
     539:	0f 84 3e ff ff ff    	je     47d <__traverse_mounts+0x4d>
     53f:	4c 89 ef             	mov    %r13,%rdi
     542:	e8 00 00 00 00       	call   547 <__traverse_mounts+0x117>
     547:	48 85 c0             	test   %rax,%rax
     54a:	0f 84 2d ff ff ff    	je     47d <__traverse_mounts+0x4d>
     550:	49 8b 7d 08          	mov    0x8(%r13),%rdi
     554:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
     558:	e8 00 00 00 00       	call   55d <__traverse_mounts+0x12d>
     55d:	80 7d c8 00          	cmpb   $0x0,-0x38(%rbp)
     561:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
     565:	0f 85 bc 00 00 00    	jne    627 <__traverse_mounts+0x1f7>
     56b:	49 89 45 00          	mov    %rax,0x0(%r13)
     56f:	4c 8b 30             	mov    (%rax),%r14
     572:	4d 85 f6             	test   %r14,%r14
     575:	74 0c                	je     583 <__traverse_mounts+0x153>
     577:	49 8d be 80 00 00 00 	lea    0x80(%r14),%rdi
     57e:	e8 00 00 00 00       	call   583 <__traverse_mounts+0x153>
     583:	4d 89 75 08          	mov    %r14,0x8(%r13)
     587:	45 8b 36             	mov    (%r14),%r14d
     58a:	c6 45 c8 01          	movb   $0x1,-0x38(%rbp)
     58e:	41 f7 c6 00 80 03 00 	test   $0x38000,%r14d
     595:	0f 85 60 ff ff ff    	jne    4fb <__traverse_mounts+0xcb>
     59b:	41 83 ff eb          	cmp    $0xffffffeb,%r15d
     59f:	74 6c                	je     60d <__traverse_mounts+0x1dd>
     5a1:	80 7d c8 00          	cmpb   $0x0,-0x38(%rbp)
     5a5:	75 37                	jne    5de <__traverse_mounts+0x1ae>
     5a7:	45 85 ff             	test   %r15d,%r15d
     5aa:	74 49                	je     5f5 <__traverse_mounts+0x1c5>
     5ac:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
     5b0:	0f b6 75 c8          	movzbl -0x38(%rbp),%esi
     5b4:	40 88 30             	mov    %sil,(%rax)
     5b7:	48 83 c4 28          	add    $0x28,%rsp
     5bb:	44 89 f8             	mov    %r15d,%eax
     5be:	5b                   	pop    %rbx
     5bf:	41 5c                	pop    %r12
     5c1:	41 5d                	pop    %r13
     5c3:	41 5e                	pop    %r14
     5c5:	41 5f                	pop    %r15
     5c7:	5d                   	pop    %rbp
     5c8:	31 d2                	xor    %edx,%edx
     5ca:	31 c9                	xor    %ecx,%ecx
     5cc:	31 f6                	xor    %esi,%esi
     5ce:	31 ff                	xor    %edi,%edi
     5d0:	45 31 c0             	xor    %r8d,%r8d
     5d3:	e9 00 00 00 00       	jmp    5d8 <__traverse_mounts+0x1a8>
     5d8:	41 bf ee ff ff ff    	mov    $0xffffffee,%r15d
     5de:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
     5e2:	49 39 45 00          	cmp    %rax,0x0(%r13)
     5e6:	0f 84 9e 00 00 00    	je     68a <__traverse_mounts+0x25a>
     5ec:	c6 45 c8 01          	movb   $0x1,-0x38(%rbp)
     5f0:	45 85 ff             	test   %r15d,%r15d
     5f3:	75 b7                	jne    5ac <__traverse_mounts+0x17c>
     5f5:	44 89 f6             	mov    %r14d,%esi
     5f8:	81 e6 00 00 38 00    	and    $0x380000,%esi
     5fe:	83 fe 01             	cmp    $0x1,%esi
     601:	45 19 ff             	sbb    %r15d,%r15d
     604:	41 83 e7 fe          	and    $0xfffffffe,%r15d
     608:	eb a2                	jmp    5ac <__traverse_mounts+0x17c>
     60a:	44 8b 30             	mov    (%rax),%r14d
     60d:	80 7d c8 00          	cmpb   $0x0,-0x38(%rbp)
     611:	74 e2                	je     5f5 <__traverse_mounts+0x1c5>
     613:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
     617:	49 3b 45 00          	cmp    0x0(%r13),%rax
     61b:	75 d8                	jne    5f5 <__traverse_mounts+0x1c5>
     61d:	48 89 c7             	mov    %rax,%rdi
     620:	e8 00 00 00 00       	call   625 <__traverse_mounts+0x1f5>
     625:	eb ce                	jmp    5f5 <__traverse_mounts+0x1c5>
     627:	49 8b 7d 00          	mov    0x0(%r13),%rdi
     62b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
     62f:	e8 00 00 00 00       	call   634 <__traverse_mounts+0x204>
     634:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     638:	e9 2e ff ff ff       	jmp    56b <__traverse_mounts+0x13b>
     63d:	80 7d c8 00          	cmpb   $0x0,-0x38(%rbp)
     641:	75 95                	jne    5d8 <__traverse_mounts+0x1a8>
     643:	c6 45 c8 00          	movb   $0x0,-0x38(%rbp)
     647:	41 bf ee ff ff ff    	mov    $0xffffffee,%r15d
     64d:	e9 5a ff ff ff       	jmp    5ac <__traverse_mounts+0x17c>
     652:	8b 00                	mov    (%rax),%eax
     654:	80 7d c8 00          	cmpb   $0x0,-0x38(%rbp)
     658:	74 e9                	je     643 <__traverse_mounts+0x213>
     65a:	41 bf ee ff ff ff    	mov    $0xffffffee,%r15d
     660:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
     664:	49 39 45 00          	cmp    %rax,0x0(%r13)
     668:	74 37                	je     6a1 <__traverse_mounts+0x271>
     66a:	c6 45 c8 01          	movb   $0x1,-0x38(%rbp)
     66e:	e9 39 ff ff ff       	jmp    5ac <__traverse_mounts+0x17c>
     673:	49 8b 45 08          	mov    0x8(%r13),%rax
     677:	8b 00                	mov    (%rax),%eax
     679:	80 7d c8 00          	cmpb   $0x0,-0x38(%rbp)
     67d:	41 bf d8 ff ff ff    	mov    $0xffffffd8,%r15d
     683:	75 db                	jne    660 <__traverse_mounts+0x230>
     685:	e9 22 ff ff ff       	jmp    5ac <__traverse_mounts+0x17c>
     68a:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
     68e:	e8 00 00 00 00       	call   693 <__traverse_mounts+0x263>
     693:	e9 54 ff ff ff       	jmp    5ec <__traverse_mounts+0x1bc>
     698:	c6 45 c8 00          	movb   $0x0,-0x38(%rbp)
     69c:	e9 54 ff ff ff       	jmp    5f5 <__traverse_mounts+0x1c5>
     6a1:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
     6a5:	e8 00 00 00 00       	call   6aa <__traverse_mounts+0x27a>
     6aa:	eb be                	jmp    66a <__traverse_mounts+0x23a>
     6ac:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000006b0 <__pfx_try_lookup_noperm>:
     6b0:	90                   	nop
     6b1:	90                   	nop
     6b2:	90                   	nop
     6b3:	90                   	nop
     6b4:	90                   	nop
     6b5:	90                   	nop
     6b6:	90                   	nop
     6b7:	90                   	nop
     6b8:	90                   	nop
     6b9:	90                   	nop
     6ba:	90                   	nop
     6bb:	90                   	nop
     6bc:	90                   	nop
     6bd:	90                   	nop
     6be:	90                   	nop
     6bf:	90                   	nop

00000000000006c0 <try_lookup_noperm>:
     6c0:	e8 00 00 00 00       	call   6c5 <try_lookup_noperm+0x5>
     6c5:	55                   	push   %rbp
     6c6:	48 89 e5             	mov    %rsp,%rbp
     6c9:	41 54                	push   %r12
     6cb:	49 89 fc             	mov    %rdi,%r12
     6ce:	53                   	push   %rbx
     6cf:	48 89 f3             	mov    %rsi,%rbx
     6d2:	e8 f9 f9 ff ff       	call   d0 <lookup_noperm_common>
     6d7:	85 c0                	test   %eax,%eax
     6d9:	74 0f                	je     6ea <try_lookup_noperm+0x2a>
     6db:	5b                   	pop    %rbx
     6dc:	48 98                	cltq
     6de:	41 5c                	pop    %r12
     6e0:	5d                   	pop    %rbp
     6e1:	31 f6                	xor    %esi,%esi
     6e3:	31 ff                	xor    %edi,%edi
     6e5:	e9 00 00 00 00       	jmp    6ea <try_lookup_noperm+0x2a>
     6ea:	4c 89 e6             	mov    %r12,%rsi
     6ed:	48 89 df             	mov    %rbx,%rdi
     6f0:	e8 00 00 00 00       	call   6f5 <try_lookup_noperm+0x35>
     6f5:	5b                   	pop    %rbx
     6f6:	41 5c                	pop    %r12
     6f8:	5d                   	pop    %rbp
     6f9:	31 f6                	xor    %esi,%esi
     6fb:	31 ff                	xor    %edi,%edi
     6fd:	e9 00 00 00 00       	jmp    702 <try_lookup_noperm+0x42>
     702:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     709:	00 00 00 00 
     70d:	0f 1f 00             	nopl   (%rax)

0000000000000710 <__pfx_hashlen_string>:
     710:	90                   	nop
     711:	90                   	nop
     712:	90                   	nop
     713:	90                   	nop
     714:	90                   	nop
     715:	90                   	nop
     716:	90                   	nop
     717:	90                   	nop
     718:	90                   	nop
     719:	90                   	nop
     71a:	90                   	nop
     71b:	90                   	nop
     71c:	90                   	nop
     71d:	90                   	nop
     71e:	90                   	nop
     71f:	90                   	nop

0000000000000720 <hashlen_string>:
     720:	e8 00 00 00 00       	call   725 <hashlen_string+0x5>
     725:	55                   	push   %rbp
     726:	48 89 f9             	mov    %rdi,%rcx
     729:	48 89 e5             	mov    %rsp,%rbp
     72c:	48 8b 06             	mov    (%rsi),%rax
     72f:	49 ba ff fe fe fe fe 	movabs $0xfefefefefefefeff,%r10
     736:	fe fe fe 
     739:	48 89 c7             	mov    %rax,%rdi
     73c:	49 b8 80 80 80 80 80 	movabs $0x8080808080808080,%r8
     743:	80 80 80 
     746:	48 f7 d7             	not    %rdi
     749:	4a 8d 14 10          	lea    (%rax,%r10,1),%rdx
     74d:	48 21 d7             	and    %rdx,%rdi
     750:	4c 21 c7             	and    %r8,%rdi
     753:	0f 85 8f 00 00 00    	jne    7e8 <hashlen_string+0xc8>
     759:	49 89 f1             	mov    %rsi,%r9
     75c:	31 f6                	xor    %esi,%esi
     75e:	48 31 f8             	xor    %rdi,%rax
     761:	48 83 c6 08          	add    $0x8,%rsi
     765:	48 31 c1             	xor    %rax,%rcx
     768:	48 c1 c0 0c          	rol    $0xc,%rax
     76c:	48 89 ca             	mov    %rcx,%rdx
     76f:	48 8d 3c 01          	lea    (%rcx,%rax,1),%rdi
     773:	48 c1 ca 13          	ror    $0x13,%rdx
     777:	48 8d 0c d2          	lea    (%rdx,%rdx,8),%rcx
     77b:	49 8b 04 31          	mov    (%r9,%rsi,1),%rax
     77f:	49 89 c3             	mov    %rax,%r11
     782:	4a 8d 14 10          	lea    (%rax,%r10,1),%rdx
     786:	49 f7 d3             	not    %r11
     789:	4c 21 da             	and    %r11,%rdx
     78c:	4c 21 c2             	and    %r8,%rdx
     78f:	74 cd                	je     75e <hashlen_string+0x3e>
     791:	4c 8d 42 ff          	lea    -0x1(%rdx),%r8
     795:	5d                   	pop    %rbp
     796:	f3 4c 0f bc ca       	tzcnt  %rdx,%r9
     79b:	48 f7 d2             	not    %rdx
     79e:	4c 21 c2             	and    %r8,%rdx
     7a1:	48 c1 ea 07          	shr    $0x7,%rdx
     7a5:	48 21 d0             	and    %rdx,%rax
     7a8:	4c 89 ca             	mov    %r9,%rdx
     7ab:	48 31 f8             	xor    %rdi,%rax
     7ae:	48 c1 ea 03          	shr    $0x3,%rdx
     7b2:	48 bf eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rdi
     7b9:	86 c8 61 
     7bc:	48 0f af c7          	imul   %rdi,%rax
     7c0:	48 01 f2             	add    %rsi,%rdx
     7c3:	48 31 c8             	xor    %rcx,%rax
     7c6:	48 0f af c7          	imul   %rdi,%rax
     7ca:	48 0f ac d0 20       	shrd   $0x20,%rdx,%rax
     7cf:	31 d2                	xor    %edx,%edx
     7d1:	31 c9                	xor    %ecx,%ecx
     7d3:	31 f6                	xor    %esi,%esi
     7d5:	31 ff                	xor    %edi,%edi
     7d7:	45 31 c0             	xor    %r8d,%r8d
     7da:	45 31 c9             	xor    %r9d,%r9d
     7dd:	45 31 d2             	xor    %r10d,%r10d
     7e0:	45 31 db             	xor    %r11d,%r11d
     7e3:	e9 00 00 00 00       	jmp    7e8 <hashlen_string+0xc8>
     7e8:	48 89 fa             	mov    %rdi,%rdx
     7eb:	31 f6                	xor    %esi,%esi
     7ed:	31 ff                	xor    %edi,%edi
     7ef:	eb a0                	jmp    791 <hashlen_string+0x71>
     7f1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     7f8:	00 00 00 00 
     7fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000800 <__pfx___legitimize_path>:
     800:	90                   	nop
     801:	90                   	nop
     802:	90                   	nop
     803:	90                   	nop
     804:	90                   	nop
     805:	90                   	nop
     806:	90                   	nop
     807:	90                   	nop
     808:	90                   	nop
     809:	90                   	nop
     80a:	90                   	nop
     80b:	90                   	nop
     80c:	90                   	nop
     80d:	90                   	nop
     80e:	90                   	nop
     80f:	90                   	nop

0000000000000810 <__legitimize_path>:
     810:	e8 00 00 00 00       	call   815 <__legitimize_path+0x5>
     815:	55                   	push   %rbp
     816:	48 89 e5             	mov    %rsp,%rbp
     819:	41 54                	push   %r12
     81b:	41 89 f4             	mov    %esi,%r12d
     81e:	89 d6                	mov    %edx,%esi
     820:	53                   	push   %rbx
     821:	48 89 fb             	mov    %rdi,%rbx
     824:	48 8b 3f             	mov    (%rdi),%rdi
     827:	e8 00 00 00 00       	call   82c <__legitimize_path+0x1c>
     82c:	85 c0                	test   %eax,%eax
     82e:	75 30                	jne    860 <__legitimize_path+0x50>
     830:	48 8b 43 08          	mov    0x8(%rbx),%rax
     834:	48 8d b8 80 00 00 00 	lea    0x80(%rax),%rdi
     83b:	e8 00 00 00 00       	call   840 <__legitimize_path+0x30>
     840:	84 c0                	test   %al,%al
     842:	74 25                	je     869 <__legitimize_path+0x59>
     844:	48 8b 43 08          	mov    0x8(%rbx),%rax
     848:	8b 40 04             	mov    0x4(%rax),%eax
     84b:	5b                   	pop    %rbx
     84c:	41 39 c4             	cmp    %eax,%r12d
     84f:	41 5c                	pop    %r12
     851:	5d                   	pop    %rbp
     852:	0f 94 c0             	sete   %al
     855:	31 d2                	xor    %edx,%edx
     857:	31 f6                	xor    %esi,%esi
     859:	31 ff                	xor    %edi,%edi
     85b:	e9 00 00 00 00       	jmp    860 <__legitimize_path+0x50>
     860:	7e 07                	jle    869 <__legitimize_path+0x59>
     862:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
     869:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
     870:	00 
     871:	31 c0                	xor    %eax,%eax
     873:	5b                   	pop    %rbx
     874:	41 5c                	pop    %r12
     876:	5d                   	pop    %rbp
     877:	31 d2                	xor    %edx,%edx
     879:	31 f6                	xor    %esi,%esi
     87b:	31 ff                	xor    %edi,%edi
     87d:	e9 00 00 00 00       	jmp    882 <__legitimize_path+0x72>
     882:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     889:	00 00 00 00 
     88d:	0f 1f 00             	nopl   (%rax)

0000000000000890 <__pfx_lock_two_directories>:
     890:	90                   	nop
     891:	90                   	nop
     892:	90                   	nop
     893:	90                   	nop
     894:	90                   	nop
     895:	90                   	nop
     896:	90                   	nop
     897:	90                   	nop
     898:	90                   	nop
     899:	90                   	nop
     89a:	90                   	nop
     89b:	90                   	nop
     89c:	90                   	nop
     89d:	90                   	nop
     89e:	90                   	nop
     89f:	90                   	nop

00000000000008a0 <lock_two_directories>:
     8a0:	e8 00 00 00 00       	call   8a5 <lock_two_directories+0x5>
     8a5:	55                   	push   %rbp
     8a6:	48 89 fa             	mov    %rdi,%rdx
     8a9:	48 89 e5             	mov    %rsp,%rbp
     8ac:	41 56                	push   %r14
     8ae:	49 89 fe             	mov    %rdi,%r14
     8b1:	41 55                	push   %r13
     8b3:	49 89 f5             	mov    %rsi,%r13
     8b6:	41 54                	push   %r12
     8b8:	53                   	push   %rbx
     8b9:	eb 05                	jmp    8c0 <lock_two_directories+0x20>
     8bb:	49 39 d5             	cmp    %rdx,%r13
     8be:	74 0c                	je     8cc <lock_two_directories+0x2c>
     8c0:	48 89 d3             	mov    %rdx,%rbx
     8c3:	48 8b 52 18          	mov    0x18(%rdx),%rdx
     8c7:	48 39 d3             	cmp    %rdx,%rbx
     8ca:	75 ef                	jne    8bb <lock_two_directories+0x1b>
     8cc:	4c 89 e8             	mov    %r13,%rax
     8cf:	49 39 d5             	cmp    %rdx,%r13
     8d2:	75 0f                	jne    8e3 <lock_two_directories+0x43>
     8d4:	e9 91 00 00 00       	jmp    96a <lock_two_directories+0xca>
     8d9:	48 39 c3             	cmp    %rax,%rbx
     8dc:	74 3b                	je     919 <lock_two_directories+0x79>
     8de:	49 39 c4             	cmp    %rax,%r12
     8e1:	74 31                	je     914 <lock_two_directories+0x74>
     8e3:	49 89 c4             	mov    %rax,%r12
     8e6:	48 8b 40 18          	mov    0x18(%rax),%rax
     8ea:	49 39 c6             	cmp    %rax,%r14
     8ed:	75 ea                	jne    8d9 <lock_two_directories+0x39>
     8ef:	49 8b 7e 30          	mov    0x30(%r14),%rdi
     8f3:	4c 89 e3             	mov    %r12,%rbx
     8f6:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
     8fd:	e8 00 00 00 00       	call   902 <lock_two_directories+0x62>
     902:	49 8b 7d 30          	mov    0x30(%r13),%rdi
     906:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
     90d:	e8 00 00 00 00       	call   912 <lock_two_directories+0x72>
     912:	eb 27                	jmp    93b <lock_two_directories+0x9b>
     914:	48 39 c3             	cmp    %rax,%rbx
     917:	75 38                	jne    951 <lock_two_directories+0xb1>
     919:	49 8b 7e 30          	mov    0x30(%r14),%rdi
     91d:	31 db                	xor    %ebx,%ebx
     91f:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
     926:	e8 00 00 00 00       	call   92b <lock_two_directories+0x8b>
     92b:	49 8b 7d 30          	mov    0x30(%r13),%rdi
     92f:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
     936:	e8 00 00 00 00       	call   93b <lock_two_directories+0x9b>
     93b:	48 89 d8             	mov    %rbx,%rax
     93e:	5b                   	pop    %rbx
     93f:	41 5c                	pop    %r12
     941:	41 5d                	pop    %r13
     943:	41 5e                	pop    %r14
     945:	5d                   	pop    %rbp
     946:	31 d2                	xor    %edx,%edx
     948:	31 f6                	xor    %esi,%esi
     94a:	31 ff                	xor    %edi,%edi
     94c:	e9 00 00 00 00       	jmp    951 <lock_two_directories+0xb1>
     951:	49 8b 7e 68          	mov    0x68(%r14),%rdi
     955:	48 c7 c3 ee ff ff ff 	mov    $0xffffffffffffffee,%rbx
     95c:	48 81 c7 28 04 00 00 	add    $0x428,%rdi
     963:	e8 00 00 00 00       	call   968 <lock_two_directories+0xc8>
     968:	eb d1                	jmp    93b <lock_two_directories+0x9b>
     96a:	49 8b 7d 30          	mov    0x30(%r13),%rdi
     96e:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
     975:	e8 00 00 00 00       	call   97a <lock_two_directories+0xda>
     97a:	49 8b 7e 30          	mov    0x30(%r14),%rdi
     97e:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
     985:	e8 00 00 00 00       	call   98a <lock_two_directories+0xea>
     98a:	eb af                	jmp    93b <lock_two_directories+0x9b>
     98c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000990 <__pfx_lock_rename>:
     990:	90                   	nop
     991:	90                   	nop
     992:	90                   	nop
     993:	90                   	nop
     994:	90                   	nop
     995:	90                   	nop
     996:	90                   	nop
     997:	90                   	nop
     998:	90                   	nop
     999:	90                   	nop
     99a:	90                   	nop
     99b:	90                   	nop
     99c:	90                   	nop
     99d:	90                   	nop
     99e:	90                   	nop
     99f:	90                   	nop

00000000000009a0 <lock_rename>:
     9a0:	e8 00 00 00 00       	call   9a5 <lock_rename+0x5>
     9a5:	55                   	push   %rbp
     9a6:	48 89 e5             	mov    %rsp,%rbp
     9a9:	41 54                	push   %r12
     9ab:	53                   	push   %rbx
     9ac:	48 89 fb             	mov    %rdi,%rbx
     9af:	48 39 f7             	cmp    %rsi,%rdi
     9b2:	74 2b                	je     9df <lock_rename+0x3f>
     9b4:	48 8b 47 68          	mov    0x68(%rdi),%rax
     9b8:	49 89 f4             	mov    %rsi,%r12
     9bb:	48 8d b8 28 04 00 00 	lea    0x428(%rax),%rdi
     9c2:	e8 00 00 00 00       	call   9c7 <lock_rename+0x27>
     9c7:	4c 89 e6             	mov    %r12,%rsi
     9ca:	48 89 df             	mov    %rbx,%rdi
     9cd:	e8 ce fe ff ff       	call   8a0 <lock_two_directories>
     9d2:	5b                   	pop    %rbx
     9d3:	41 5c                	pop    %r12
     9d5:	5d                   	pop    %rbp
     9d6:	31 f6                	xor    %esi,%esi
     9d8:	31 ff                	xor    %edi,%edi
     9da:	e9 00 00 00 00       	jmp    9df <lock_rename+0x3f>
     9df:	48 8b 7f 30          	mov    0x30(%rdi),%rdi
     9e3:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
     9ea:	e8 00 00 00 00       	call   9ef <lock_rename+0x4f>
     9ef:	31 c0                	xor    %eax,%eax
     9f1:	eb df                	jmp    9d2 <lock_rename+0x32>
     9f3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     9fa:	00 00 00 00 
     9fe:	66 90                	xchg   %ax,%ax

0000000000000a00 <__pfx_lock_rename_child>:
     a00:	90                   	nop
     a01:	90                   	nop
     a02:	90                   	nop
     a03:	90                   	nop
     a04:	90                   	nop
     a05:	90                   	nop
     a06:	90                   	nop
     a07:	90                   	nop
     a08:	90                   	nop
     a09:	90                   	nop
     a0a:	90                   	nop
     a0b:	90                   	nop
     a0c:	90                   	nop
     a0d:	90                   	nop
     a0e:	90                   	nop
     a0f:	90                   	nop

0000000000000a10 <lock_rename_child>:
     a10:	e8 00 00 00 00       	call   a15 <lock_rename_child+0x5>
     a15:	55                   	push   %rbp
     a16:	48 89 e5             	mov    %rsp,%rbp
     a19:	41 54                	push   %r12
     a1b:	49 89 fc             	mov    %rdi,%r12
     a1e:	53                   	push   %rbx
     a1f:	48 8b 47 18          	mov    0x18(%rdi),%rax
     a23:	48 89 f3             	mov    %rsi,%rbx
     a26:	48 39 f0             	cmp    %rsi,%rax
     a29:	74 30                	je     a5b <lock_rename_child+0x4b>
     a2b:	49 8b 44 24 68       	mov    0x68(%r12),%rax
     a30:	48 8d b8 28 04 00 00 	lea    0x428(%rax),%rdi
     a37:	e8 00 00 00 00       	call   a3c <lock_rename_child+0x2c>
     a3c:	49 8b 7c 24 18       	mov    0x18(%r12),%rdi
     a41:	48 39 df             	cmp    %rbx,%rdi
     a44:	74 30                	je     a76 <lock_rename_child+0x66>
     a46:	48 89 de             	mov    %rbx,%rsi
     a49:	e8 52 fe ff ff       	call   8a0 <lock_two_directories>
     a4e:	5b                   	pop    %rbx
     a4f:	41 5c                	pop    %r12
     a51:	5d                   	pop    %rbp
     a52:	31 f6                	xor    %esi,%esi
     a54:	31 ff                	xor    %edi,%edi
     a56:	e9 00 00 00 00       	jmp    a5b <lock_rename_child+0x4b>
     a5b:	48 8b 46 30          	mov    0x30(%rsi),%rax
     a5f:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
     a66:	e8 00 00 00 00       	call   a6b <lock_rename_child+0x5b>
     a6b:	49 39 5c 24 18       	cmp    %rbx,0x18(%r12)
     a70:	75 29                	jne    a9b <lock_rename_child+0x8b>
     a72:	31 c0                	xor    %eax,%eax
     a74:	eb d8                	jmp    a4e <lock_rename_child+0x3e>
     a76:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
     a7a:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
     a81:	e8 00 00 00 00       	call   a86 <lock_rename_child+0x76>
     a86:	49 8b 7c 24 68       	mov    0x68(%r12),%rdi
     a8b:	48 81 c7 28 04 00 00 	add    $0x428,%rdi
     a92:	e8 00 00 00 00       	call   a97 <lock_rename_child+0x87>
     a97:	31 c0                	xor    %eax,%eax
     a99:	eb b3                	jmp    a4e <lock_rename_child+0x3e>
     a9b:	48 8b 43 30          	mov    0x30(%rbx),%rax
     a9f:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
     aa6:	e8 00 00 00 00       	call   aab <lock_rename_child+0x9b>
     aab:	e9 7b ff ff ff       	jmp    a2b <lock_rename_child+0x1b>

0000000000000ab0 <__pfx_vfs_get_link>:
     ab0:	90                   	nop
     ab1:	90                   	nop
     ab2:	90                   	nop
     ab3:	90                   	nop
     ab4:	90                   	nop
     ab5:	90                   	nop
     ab6:	90                   	nop
     ab7:	90                   	nop
     ab8:	90                   	nop
     ab9:	90                   	nop
     aba:	90                   	nop
     abb:	90                   	nop
     abc:	90                   	nop
     abd:	90                   	nop
     abe:	90                   	nop
     abf:	90                   	nop

0000000000000ac0 <vfs_get_link>:
     ac0:	e8 00 00 00 00       	call   ac5 <vfs_get_link+0x5>
     ac5:	8b 0f                	mov    (%rdi),%ecx
     ac7:	48 c7 c0 ea ff ff ff 	mov    $0xffffffffffffffea,%rax
     ace:	81 e1 00 00 38 00    	and    $0x380000,%ecx
     ad4:	81 f9 00 00 30 00    	cmp    $0x300000,%ecx
     ada:	74 0d                	je     ae9 <vfs_get_link+0x29>
     adc:	31 d2                	xor    %edx,%edx
     ade:	31 c9                	xor    %ecx,%ecx
     ae0:	31 f6                	xor    %esi,%esi
     ae2:	31 ff                	xor    %edi,%edi
     ae4:	e9 00 00 00 00       	jmp    ae9 <vfs_get_link+0x29>
     ae9:	55                   	push   %rbp
     aea:	48 89 e5             	mov    %rsp,%rbp
     aed:	41 55                	push   %r13
     aef:	49 89 f5             	mov    %rsi,%r13
     af2:	41 54                	push   %r12
     af4:	53                   	push   %rbx
     af5:	48 89 fb             	mov    %rdi,%rbx
     af8:	4c 8b 67 30          	mov    0x30(%rdi),%r12
     afc:	e8 00 00 00 00       	call   b01 <vfs_get_link+0x41>
     b01:	85 c0                	test   %eax,%eax
     b03:	74 15                	je     b1a <vfs_get_link+0x5a>
     b05:	5b                   	pop    %rbx
     b06:	48 98                	cltq
     b08:	41 5c                	pop    %r12
     b0a:	41 5d                	pop    %r13
     b0c:	5d                   	pop    %rbp
     b0d:	31 d2                	xor    %edx,%edx
     b0f:	31 c9                	xor    %ecx,%ecx
     b11:	31 f6                	xor    %esi,%esi
     b13:	31 ff                	xor    %edi,%edi
     b15:	e9 00 00 00 00       	jmp    b1a <vfs_get_link+0x5a>
     b1a:	49 8b 44 24 20       	mov    0x20(%r12),%rax
     b1f:	4c 89 ea             	mov    %r13,%rdx
     b22:	4c 89 e6             	mov    %r12,%rsi
     b25:	48 89 df             	mov    %rbx,%rdi
     b28:	48 8b 40 08          	mov    0x8(%rax),%rax
     b2c:	e8 00 00 00 00       	call   b31 <vfs_get_link+0x71>
     b31:	5b                   	pop    %rbx
     b32:	41 5c                	pop    %r12
     b34:	41 5d                	pop    %r13
     b36:	5d                   	pop    %rbp
     b37:	31 d2                	xor    %edx,%edx
     b39:	31 c9                	xor    %ecx,%ecx
     b3b:	31 f6                	xor    %esi,%esi
     b3d:	31 ff                	xor    %edi,%edi
     b3f:	e9 00 00 00 00       	jmp    b44 <vfs_get_link+0x84>
     b44:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     b4b:	00 00 00 00 
     b4f:	90                   	nop

0000000000000b50 <__pfx_page_put_link>:
     b50:	90                   	nop
     b51:	90                   	nop
     b52:	90                   	nop
     b53:	90                   	nop
     b54:	90                   	nop
     b55:	90                   	nop
     b56:	90                   	nop
     b57:	90                   	nop
     b58:	90                   	nop
     b59:	90                   	nop
     b5a:	90                   	nop
     b5b:	90                   	nop
     b5c:	90                   	nop
     b5d:	90                   	nop
     b5e:	90                   	nop
     b5f:	90                   	nop

0000000000000b60 <page_put_link>:
     b60:	e8 00 00 00 00       	call   b65 <page_put_link+0x5>
     b65:	f0 ff 4f 34          	lock decl 0x34(%rdi)
     b69:	74 07                	je     b72 <page_put_link+0x12>
     b6b:	31 ff                	xor    %edi,%edi
     b6d:	e9 00 00 00 00       	jmp    b72 <page_put_link+0x12>
     b72:	55                   	push   %rbp
     b73:	48 89 e5             	mov    %rsp,%rbp
     b76:	e8 00 00 00 00       	call   b7b <page_put_link+0x1b>
     b7b:	5d                   	pop    %rbp
     b7c:	31 ff                	xor    %edi,%edi
     b7e:	e9 00 00 00 00       	jmp    b83 <page_put_link+0x23>
     b83:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     b8a:	00 00 00 00 
     b8e:	66 90                	xchg   %ax,%ax

0000000000000b90 <__pfx_page_symlink>:
     b90:	90                   	nop
     b91:	90                   	nop
     b92:	90                   	nop
     b93:	90                   	nop
     b94:	90                   	nop
     b95:	90                   	nop
     b96:	90                   	nop
     b97:	90                   	nop
     b98:	90                   	nop
     b99:	90                   	nop
     b9a:	90                   	nop
     b9b:	90                   	nop
     b9c:	90                   	nop
     b9d:	90                   	nop
     b9e:	90                   	nop
     b9f:	90                   	nop

0000000000000ba0 <page_symlink>:
     ba0:	e8 00 00 00 00       	call   ba5 <page_symlink+0x5>
     ba5:	55                   	push   %rbp
     ba6:	48 89 e5             	mov    %rsp,%rbp
     ba9:	41 57                	push   %r15
     bab:	41 56                	push   %r14
     bad:	41 89 d6             	mov    %edx,%r14d
     bb0:	41 55                	push   %r13
     bb2:	41 83 ee 01          	sub    $0x1,%r14d
     bb6:	41 54                	push   %r12
     bb8:	53                   	push   %rbx
     bb9:	48 83 ec 30          	sub    $0x30,%rsp
     bbd:	48 8b 5f 30          	mov    0x30(%rdi),%rbx
     bc1:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # bc9 <page_symlink+0x29>
     bc8:	00 
     bc9:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
     bcd:	31 c0                	xor    %eax,%eax
     bcf:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
     bd6:	00 
     bd7:	8b 43 40             	mov    0x40(%rbx),%eax
     bda:	4c 8b 6b 68          	mov    0x68(%rbx),%r13
     bde:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
     be5:	00 
     be6:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
     bea:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
     bee:	25 80 00 00 00       	and    $0x80,%eax
     bf3:	89 45 bc             	mov    %eax,-0x44(%rbp)
     bf6:	49 63 c6             	movslq %r14d,%rax
     bf9:	49 89 c4             	mov    %rax,%r12
     bfc:	8b 4d bc             	mov    -0x44(%rbp),%ecx
     bff:	85 c9                	test   %ecx,%ecx
     c01:	0f 85 ed 00 00 00    	jne    cf4 <page_symlink+0x154>
     c07:	65 4c 8b 15 00 00 00 	mov    %gs:0x0(%rip),%r10        # c0f <page_symlink+0x6f>
     c0e:	00 
     c0f:	4c 8d 4d c8          	lea    -0x38(%rbp),%r9
     c13:	31 d2                	xor    %edx,%edx
     c15:	31 ff                	xor    %edi,%edi
     c17:	4c 8d 45 c0          	lea    -0x40(%rbp),%r8
     c1b:	44 89 f1             	mov    %r14d,%ecx
     c1e:	48 89 de             	mov    %rbx,%rsi
     c21:	45 8b 5a 2c          	mov    0x2c(%r10),%r11d
     c25:	44 89 d8             	mov    %r11d,%eax
     c28:	44 89 5d b8          	mov    %r11d,-0x48(%rbp)
     c2c:	0d 00 00 04 00       	or     $0x40000,%eax
     c31:	41 89 42 2c          	mov    %eax,0x2c(%r10)
     c35:	49 8b 45 20          	mov    0x20(%r13),%rax
     c39:	e8 00 00 00 00       	call   c3e <page_symlink+0x9e>
     c3e:	44 8b 5d b8          	mov    -0x48(%rbp),%r11d
     c42:	65 4c 8b 15 00 00 00 	mov    %gs:0x0(%rip),%r10        # c4a <page_symlink+0xaa>
     c49:	00 
     c4a:	41 89 c7             	mov    %eax,%r15d
     c4d:	41 81 cb ff ff fb ff 	or     $0xfffbffff,%r11d
     c54:	45 21 5a 2c          	and    %r11d,0x2c(%r10)
     c58:	45 85 ff             	test   %r15d,%r15d
     c5b:	75 5f                	jne    cbc <page_symlink+0x11c>
     c5d:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
     c61:	48 2b 3d 00 00 00 00 	sub    0x0(%rip),%rdi        # c68 <page_symlink+0xc8>
     c68:	4c 89 e2             	mov    %r12,%rdx
     c6b:	48 8b 75 b0          	mov    -0x50(%rbp),%rsi
     c6f:	48 c1 ff 06          	sar    $0x6,%rdi
     c73:	48 c1 e7 0c          	shl    $0xc,%rdi
     c77:	48 03 3d 00 00 00 00 	add    0x0(%rip),%rdi        # c7e <page_symlink+0xde>
     c7e:	e8 00 00 00 00       	call   c83 <page_symlink+0xe3>
     c83:	31 d2                	xor    %edx,%edx
     c85:	ff 75 c8             	push   -0x38(%rbp)
     c88:	45 89 f0             	mov    %r14d,%r8d
     c8b:	49 8b 45 28          	mov    0x28(%r13),%rax
     c8f:	44 89 f1             	mov    %r14d,%ecx
     c92:	48 89 de             	mov    %rbx,%rsi
     c95:	31 ff                	xor    %edi,%edi
     c97:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
     c9b:	e8 00 00 00 00       	call   ca0 <page_symlink+0x100>
     ca0:	5a                   	pop    %rdx
     ca1:	85 c0                	test   %eax,%eax
     ca3:	78 72                	js     d17 <page_symlink+0x177>
     ca5:	41 39 c6             	cmp    %eax,%r14d
     ca8:	0f 8f 4e ff ff ff    	jg     bfc <page_symlink+0x5c>
     cae:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
     cb2:	be 38 00 00 00       	mov    $0x38,%esi
     cb7:	e8 00 00 00 00       	call   cbc <page_symlink+0x11c>
     cbc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     cc0:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # cc8 <page_symlink+0x128>
     cc7:	00 
     cc8:	75 52                	jne    d1c <page_symlink+0x17c>
     cca:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     cce:	44 89 f8             	mov    %r15d,%eax
     cd1:	5b                   	pop    %rbx
     cd2:	41 5c                	pop    %r12
     cd4:	41 5d                	pop    %r13
     cd6:	41 5e                	pop    %r14
     cd8:	41 5f                	pop    %r15
     cda:	5d                   	pop    %rbp
     cdb:	31 d2                	xor    %edx,%edx
     cdd:	31 c9                	xor    %ecx,%ecx
     cdf:	31 f6                	xor    %esi,%esi
     ce1:	31 ff                	xor    %edi,%edi
     ce3:	45 31 c0             	xor    %r8d,%r8d
     ce6:	45 31 c9             	xor    %r9d,%r9d
     ce9:	45 31 d2             	xor    %r10d,%r10d
     cec:	45 31 db             	xor    %r11d,%r11d
     cef:	e9 00 00 00 00       	jmp    cf4 <page_symlink+0x154>
     cf4:	49 8b 45 20          	mov    0x20(%r13),%rax
     cf8:	4c 8d 4d c8          	lea    -0x38(%rbp),%r9
     cfc:	4c 8d 45 c0          	lea    -0x40(%rbp),%r8
     d00:	44 89 f1             	mov    %r14d,%ecx
     d03:	31 d2                	xor    %edx,%edx
     d05:	48 89 de             	mov    %rbx,%rsi
     d08:	31 ff                	xor    %edi,%edi
     d0a:	e8 00 00 00 00       	call   d0f <page_symlink+0x16f>
     d0f:	41 89 c7             	mov    %eax,%r15d
     d12:	e9 41 ff ff ff       	jmp    c58 <page_symlink+0xb8>
     d17:	41 89 c7             	mov    %eax,%r15d
     d1a:	eb a0                	jmp    cbc <page_symlink+0x11c>
     d1c:	e8 00 00 00 00       	call   d21 <page_symlink+0x181>
     d21:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     d28:	00 00 00 00 
     d2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000d30 <__pfx_getname_kernel>:
     d30:	90                   	nop
     d31:	90                   	nop
     d32:	90                   	nop
     d33:	90                   	nop
     d34:	90                   	nop
     d35:	90                   	nop
     d36:	90                   	nop
     d37:	90                   	nop
     d38:	90                   	nop
     d39:	90                   	nop
     d3a:	90                   	nop
     d3b:	90                   	nop
     d3c:	90                   	nop
     d3d:	90                   	nop
     d3e:	90                   	nop
     d3f:	90                   	nop

0000000000000d40 <getname_kernel>:
     d40:	e8 00 00 00 00       	call   d45 <getname_kernel+0x5>
     d45:	55                   	push   %rbp
     d46:	48 89 e5             	mov    %rsp,%rbp
     d49:	41 55                	push   %r13
     d4b:	49 89 fd             	mov    %rdi,%r13
     d4e:	41 54                	push   %r12
     d50:	53                   	push   %rbx
     d51:	e8 00 00 00 00       	call   d56 <getname_kernel+0x16>
     d56:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # d5d <getname_kernel+0x1d>
     d5d:	be c0 0c 00 00       	mov    $0xcc0,%esi
     d62:	8d 58 01             	lea    0x1(%rax),%ebx
     d65:	e8 00 00 00 00       	call   d6a <getname_kernel+0x2a>
     d6a:	48 85 c0             	test   %rax,%rax
     d6d:	0f 84 12 01 00 00    	je     e85 <getname_kernel+0x145>
     d73:	49 89 c4             	mov    %rax,%r12
     d76:	81 fb e0 0f 00 00    	cmp    $0xfe0,%ebx
     d7c:	0f 86 b7 00 00 00    	jbe    e39 <getname_kernel+0xf9>
     d82:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
     d88:	0f 8f be 00 00 00    	jg     e4c <getname_kernel+0x10c>
     d8e:	48 ba eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rdx
     d95:	86 c8 61 
     d98:	48 8b 45 08          	mov    0x8(%rbp),%rax
     d9c:	48 33 05 00 00 00 00 	xor    0x0(%rip),%rax        # da3 <getname_kernel+0x63>
     da3:	be c0 0c 00 00       	mov    $0xcc0,%esi
     da8:	48 0f af c2          	imul   %rdx,%rax
     dac:	48 c1 e8 3c          	shr    $0x3c,%rax
     db0:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
     db7:	00 
     db8:	48 29 c2             	sub    %rax,%rdx
     dbb:	48 89 d0             	mov    %rdx,%rax
     dbe:	ba 21 00 00 00       	mov    $0x21,%edx
     dc3:	48 c1 e0 04          	shl    $0x4,%rax
     dc7:	48 8b b8 00 00 00 00 	mov    0x0(%rax),%rdi
     dce:	e8 00 00 00 00       	call   dd3 <getname_kernel+0x93>
     dd3:	48 85 c0             	test   %rax,%rax
     dd6:	0f 84 9a 00 00 00    	je     e76 <getname_kernel+0x136>
     ddc:	4c 89 20             	mov    %r12,(%rax)
     ddf:	4c 89 e7             	mov    %r12,%rdi
     de2:	49 89 c4             	mov    %rax,%r12
     de5:	4c 89 ee             	mov    %r13,%rsi
     de8:	48 63 d3             	movslq %ebx,%rdx
     deb:	e8 00 00 00 00       	call   df0 <getname_kernel+0xb0>
     df0:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # df8 <getname_kernel+0xb8>
     df7:	00 
     df8:	49 c7 44 24 08 00 00 	movq   $0x0,0x8(%r12)
     dff:	00 00 
     e01:	49 c7 44 24 18 00 00 	movq   $0x0,0x18(%r12)
     e08:	00 00 
     e0a:	41 c7 44 24 10 01 00 	movl   $0x1,0x10(%r12)
     e11:	00 00 
     e13:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
     e1a:	48 85 c0             	test   %rax,%rax
     e1d:	74 06                	je     e25 <getname_kernel+0xe5>
     e1f:	8b 00                	mov    (%rax),%eax
     e21:	85 c0                	test   %eax,%eax
     e23:	74 1d                	je     e42 <getname_kernel+0x102>
     e25:	5b                   	pop    %rbx
     e26:	4c 89 e0             	mov    %r12,%rax
     e29:	41 5c                	pop    %r12
     e2b:	41 5d                	pop    %r13
     e2d:	5d                   	pop    %rbp
     e2e:	31 d2                	xor    %edx,%edx
     e30:	31 f6                	xor    %esi,%esi
     e32:	31 ff                	xor    %edi,%edi
     e34:	e9 00 00 00 00       	jmp    e39 <getname_kernel+0xf9>
     e39:	48 8d 78 20          	lea    0x20(%rax),%rdi
     e3d:	48 89 38             	mov    %rdi,(%rax)
     e40:	eb a3                	jmp    de5 <getname_kernel+0xa5>
     e42:	4c 89 e7             	mov    %r12,%rdi
     e45:	e8 00 00 00 00       	call   e4a <getname_kernel+0x10a>
     e4a:	eb d9                	jmp    e25 <getname_kernel+0xe5>
     e4c:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # e53 <getname_kernel+0x113>
     e53:	48 89 c6             	mov    %rax,%rsi
     e56:	49 c7 c4 dc ff ff ff 	mov    $0xffffffffffffffdc,%r12
     e5d:	e8 00 00 00 00       	call   e62 <getname_kernel+0x122>
     e62:	4c 89 e0             	mov    %r12,%rax
     e65:	5b                   	pop    %rbx
     e66:	41 5c                	pop    %r12
     e68:	41 5d                	pop    %r13
     e6a:	5d                   	pop    %rbp
     e6b:	31 d2                	xor    %edx,%edx
     e6d:	31 f6                	xor    %esi,%esi
     e6f:	31 ff                	xor    %edi,%edi
     e71:	e9 00 00 00 00       	jmp    e76 <getname_kernel+0x136>
     e76:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # e7d <getname_kernel+0x13d>
     e7d:	4c 89 e6             	mov    %r12,%rsi
     e80:	e8 00 00 00 00       	call   e85 <getname_kernel+0x145>
     e85:	49 c7 c4 f4 ff ff ff 	mov    $0xfffffffffffffff4,%r12
     e8c:	eb 97                	jmp    e25 <getname_kernel+0xe5>
     e8e:	66 90                	xchg   %ax,%ax

0000000000000e90 <__pfx_putname>:
     e90:	90                   	nop
     e91:	90                   	nop
     e92:	90                   	nop
     e93:	90                   	nop
     e94:	90                   	nop
     e95:	90                   	nop
     e96:	90                   	nop
     e97:	90                   	nop
     e98:	90                   	nop
     e99:	90                   	nop
     e9a:	90                   	nop
     e9b:	90                   	nop
     e9c:	90                   	nop
     e9d:	90                   	nop
     e9e:	90                   	nop
     e9f:	90                   	nop

0000000000000ea0 <putname>:
     ea0:	e8 00 00 00 00       	call   ea5 <putname+0x5>
     ea5:	48 85 ff             	test   %rdi,%rdi
     ea8:	74 6f                	je     f19 <putname+0x79>
     eaa:	55                   	push   %rbp
     eab:	48 89 e5             	mov    %rsp,%rbp
     eae:	53                   	push   %rbx
     eaf:	48 89 fb             	mov    %rdi,%rbx
     eb2:	48 81 ff 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rdi
     eb9:	77 32                	ja     eed <putname+0x4d>
     ebb:	8b 47 10             	mov    0x10(%rdi),%eax
     ebe:	83 f8 01             	cmp    $0x1,%eax
     ec1:	74 0a                	je     ecd <putname+0x2d>
     ec3:	85 c0                	test   %eax,%eax
     ec5:	74 4e                	je     f15 <putname+0x75>
     ec7:	f0 ff 4f 10          	lock decl 0x10(%rdi)
     ecb:	75 20                	jne    eed <putname+0x4d>
     ecd:	48 8b 33             	mov    (%rbx),%rsi
     ed0:	48 8d 43 20          	lea    0x20(%rbx),%rax
     ed4:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # edb <putname+0x3b>
     edb:	48 39 c6             	cmp    %rax,%rsi
     ede:	74 1d                	je     efd <putname+0x5d>
     ee0:	e8 00 00 00 00       	call   ee5 <putname+0x45>
     ee5:	48 89 df             	mov    %rbx,%rdi
     ee8:	e8 00 00 00 00       	call   eed <putname+0x4d>
     eed:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     ef1:	c9                   	leave
     ef2:	31 c0                	xor    %eax,%eax
     ef4:	31 f6                	xor    %esi,%esi
     ef6:	31 ff                	xor    %edi,%edi
     ef8:	e9 00 00 00 00       	jmp    efd <putname+0x5d>
     efd:	48 89 de             	mov    %rbx,%rsi
     f00:	e8 00 00 00 00       	call   f05 <putname+0x65>
     f05:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     f09:	c9                   	leave
     f0a:	31 c0                	xor    %eax,%eax
     f0c:	31 f6                	xor    %esi,%esi
     f0e:	31 ff                	xor    %edi,%edi
     f10:	e9 00 00 00 00       	jmp    f15 <putname+0x75>
     f15:	0f 0b                	ud2
     f17:	eb d4                	jmp    eed <putname+0x4d>
     f19:	31 c0                	xor    %eax,%eax
     f1b:	31 f6                	xor    %esi,%esi
     f1d:	31 ff                	xor    %edi,%edi
     f1f:	e9 00 00 00 00       	jmp    f24 <putname+0x84>
     f24:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     f2b:	00 00 00 00 
     f2f:	90                   	nop

0000000000000f30 <__pfx_nd_alloc_stack>:
     f30:	90                   	nop
     f31:	90                   	nop
     f32:	90                   	nop
     f33:	90                   	nop
     f34:	90                   	nop
     f35:	90                   	nop
     f36:	90                   	nop
     f37:	90                   	nop
     f38:	90                   	nop
     f39:	90                   	nop
     f3a:	90                   	nop
     f3b:	90                   	nop
     f3c:	90                   	nop
     f3d:	90                   	nop
     f3e:	90                   	nop
     f3f:	90                   	nop

0000000000000f40 <nd_alloc_stack>:
     f40:	e8 00 00 00 00       	call   f45 <nd_alloc_stack+0x5>
     f45:	48 ba eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rdx
     f4c:	86 c8 61 
     f4f:	55                   	push   %rbp
     f50:	48 89 e5             	mov    %rsp,%rbp
     f53:	53                   	push   %rbx
     f54:	8b 47 38             	mov    0x38(%rdi),%eax
     f57:	48 89 fb             	mov    %rdi,%rbx
     f5a:	25 00 01 00 00       	and    $0x100,%eax
     f5f:	83 f8 01             	cmp    $0x1,%eax
     f62:	48 8b 45 08          	mov    0x8(%rbp),%rax
     f66:	19 f6                	sbb    %esi,%esi
     f68:	48 33 05 00 00 00 00 	xor    0x0(%rip),%rax        # f6f <nd_alloc_stack+0x2f>
     f6f:	48 0f af c2          	imul   %rdx,%rax
     f73:	81 e6 a0 04 00 00    	and    $0x4a0,%esi
     f79:	81 c6 20 08 00 00    	add    $0x820,%esi
     f7f:	48 c1 e8 3c          	shr    $0x3c,%rax
     f83:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
     f8a:	00 
     f8b:	48 29 c2             	sub    %rax,%rdx
     f8e:	48 89 d0             	mov    %rdx,%rax
     f91:	ba 80 07 00 00       	mov    $0x780,%edx
     f96:	48 c1 e0 04          	shl    $0x4,%rax
     f9a:	48 8b b8 00 00 00 00 	mov    0x0(%rax),%rdi
     fa1:	e8 00 00 00 00       	call   fa6 <nd_alloc_stack+0x66>
     fa6:	48 85 c0             	test   %rax,%rax
     fa9:	0f 84 95 00 00 00    	je     1044 <nd_alloc_stack+0x104>
     faf:	48 8b 4b 68          	mov    0x68(%rbx),%rcx
     fb3:	48 8b 93 c0 00 00 00 	mov    0xc0(%rbx),%rdx
     fba:	48 89 43 60          	mov    %rax,0x60(%rbx)
     fbe:	48 89 08             	mov    %rcx,(%rax)
     fc1:	48 8b 4b 70          	mov    0x70(%rbx),%rcx
     fc5:	48 89 50 58          	mov    %rdx,0x58(%rax)
     fc9:	48 89 48 08          	mov    %rcx,0x8(%rax)
     fcd:	48 8b 4b 78          	mov    0x78(%rbx),%rcx
     fd1:	48 89 48 10          	mov    %rcx,0x10(%rax)
     fd5:	48 8b 8b 80 00 00 00 	mov    0x80(%rbx),%rcx
     fdc:	48 89 48 18          	mov    %rcx,0x18(%rax)
     fe0:	48 8b 8b 88 00 00 00 	mov    0x88(%rbx),%rcx
     fe7:	48 89 48 20          	mov    %rcx,0x20(%rax)
     feb:	48 8b 8b 90 00 00 00 	mov    0x90(%rbx),%rcx
     ff2:	48 89 48 28          	mov    %rcx,0x28(%rax)
     ff6:	48 8b 8b 98 00 00 00 	mov    0x98(%rbx),%rcx
     ffd:	48 89 48 30          	mov    %rcx,0x30(%rax)
    1001:	48 8b 8b a0 00 00 00 	mov    0xa0(%rbx),%rcx
    1008:	48 89 48 38          	mov    %rcx,0x38(%rax)
    100c:	48 8b 8b a8 00 00 00 	mov    0xa8(%rbx),%rcx
    1013:	48 89 48 40          	mov    %rcx,0x40(%rax)
    1017:	48 8b 8b b0 00 00 00 	mov    0xb0(%rbx),%rcx
    101e:	48 89 48 48          	mov    %rcx,0x48(%rax)
    1022:	48 8b 8b b8 00 00 00 	mov    0xb8(%rbx),%rcx
    1029:	48 89 48 50          	mov    %rcx,0x50(%rax)
    102d:	b8 01 00 00 00       	mov    $0x1,%eax
    1032:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    1036:	c9                   	leave
    1037:	31 d2                	xor    %edx,%edx
    1039:	31 c9                	xor    %ecx,%ecx
    103b:	31 f6                	xor    %esi,%esi
    103d:	31 ff                	xor    %edi,%edi
    103f:	e9 00 00 00 00       	jmp    1044 <nd_alloc_stack+0x104>
    1044:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    1048:	31 c0                	xor    %eax,%eax
    104a:	c9                   	leave
    104b:	31 d2                	xor    %edx,%edx
    104d:	31 c9                	xor    %ecx,%ecx
    104f:	31 f6                	xor    %esi,%esi
    1051:	31 ff                	xor    %edi,%edi
    1053:	e9 00 00 00 00       	jmp    1058 <nd_alloc_stack+0x118>
    1058:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    105f:	00 

0000000000001060 <__pfx_generic_permission>:
    1060:	90                   	nop
    1061:	90                   	nop
    1062:	90                   	nop
    1063:	90                   	nop
    1064:	90                   	nop
    1065:	90                   	nop
    1066:	90                   	nop
    1067:	90                   	nop
    1068:	90                   	nop
    1069:	90                   	nop
    106a:	90                   	nop
    106b:	90                   	nop
    106c:	90                   	nop
    106d:	90                   	nop
    106e:	90                   	nop
    106f:	90                   	nop

0000000000001070 <generic_permission>:
    1070:	e8 00 00 00 00       	call   1075 <generic_permission+0x5>
    1075:	55                   	push   %rbp
    1076:	48 89 e5             	mov    %rsp,%rbp
    1079:	41 57                	push   %r15
    107b:	41 56                	push   %r14
    107d:	49 89 fe             	mov    %rdi,%r14
    1080:	41 55                	push   %r13
    1082:	41 89 d5             	mov    %edx,%r13d
    1085:	41 54                	push   %r12
    1087:	41 89 d4             	mov    %edx,%r12d
    108a:	53                   	push   %rbx
    108b:	41 83 e4 07          	and    $0x7,%r12d
    108f:	48 89 f3             	mov    %rsi,%rbx
    1092:	43 8d 04 e4          	lea    (%r12,%r12,8),%eax
    1096:	41 8d 04 c4          	lea    (%r12,%rax,8),%eax
    109a:	48 83 ec 10          	sub    $0x10,%rsp
    109e:	44 0f b7 3e          	movzwl (%rsi),%r15d
    10a2:	45 89 f8             	mov    %r15d,%r8d
    10a5:	44 89 f9             	mov    %r15d,%ecx
    10a8:	41 f7 d0             	not    %r8d
    10ab:	44 85 c0             	test   %r8d,%eax
    10ae:	75 2d                	jne    10dd <generic_permission+0x6d>
    10b0:	48 8b 46 10          	mov    0x10(%rsi),%rax
    10b4:	48 85 c0             	test   %rax,%rax
    10b7:	0f 85 20 01 00 00    	jne    11dd <generic_permission+0x16d>
    10bd:	31 c0                	xor    %eax,%eax
    10bf:	48 83 c4 10          	add    $0x10,%rsp
    10c3:	5b                   	pop    %rbx
    10c4:	41 5c                	pop    %r12
    10c6:	41 5d                	pop    %r13
    10c8:	41 5e                	pop    %r14
    10ca:	41 5f                	pop    %r15
    10cc:	5d                   	pop    %rbp
    10cd:	31 d2                	xor    %edx,%edx
    10cf:	31 c9                	xor    %ecx,%ecx
    10d1:	31 f6                	xor    %esi,%esi
    10d3:	31 ff                	xor    %edi,%edi
    10d5:	45 31 c0             	xor    %r8d,%r8d
    10d8:	e9 00 00 00 00       	jmp    10dd <generic_permission+0x6d>
    10dd:	48 8b 46 28          	mov    0x28(%rsi),%rax
    10e1:	8b 53 04             	mov    0x4(%rbx),%edx
    10e4:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    10eb:	4c 89 f7             	mov    %r14,%rdi
    10ee:	89 4d d0             	mov    %ecx,-0x30(%rbp)
    10f1:	44 89 45 cc          	mov    %r8d,-0x34(%rbp)
    10f5:	e8 00 00 00 00       	call   10fa <generic_permission+0x8a>
    10fa:	65 48 8b 15 00 00 00 	mov    %gs:0x0(%rip),%rdx        # 1102 <generic_permission+0x92>
    1101:	00 
    1102:	8b 4d d0             	mov    -0x30(%rbp),%ecx
    1105:	44 8b 45 cc          	mov    -0x34(%rbp),%r8d
    1109:	48 8b 92 a0 0c 00 00 	mov    0xca0(%rdx),%rdx
    1110:	39 42 20             	cmp    %eax,0x20(%rdx)
    1113:	75 09                	jne    111e <generic_permission+0xae>
    1115:	83 f8 ff             	cmp    $0xffffffff,%eax
    1118:	0f 85 aa 00 00 00    	jne    11c8 <generic_permission+0x158>
    111e:	48 8b 43 28          	mov    0x28(%rbx),%rax
    1122:	f6 40 52 01          	testb  $0x1,0x52(%rax)
    1126:	74 09                	je     1131 <generic_permission+0xc1>
    1128:	83 e1 38             	and    $0x38,%ecx
    112b:	0f 85 03 01 00 00    	jne    1234 <generic_permission+0x1c4>
    1131:	44 89 f9             	mov    %r15d,%ecx
    1134:	c1 e9 03             	shr    $0x3,%ecx
    1137:	41 31 cf             	xor    %ecx,%r15d
    113a:	45 85 e7             	test   %r12d,%r15d
    113d:	75 51                	jne    1190 <generic_permission+0x120>
    113f:	45 85 c4             	test   %r8d,%r12d
    1142:	0f 84 75 ff ff ff    	je     10bd <generic_permission+0x4d>
    1148:	0f b7 03             	movzwl (%rbx),%eax
    114b:	66 25 00 f0          	and    $0xf000,%ax
    114f:	66 3d 00 40          	cmp    $0x4000,%ax
    1153:	0f 84 97 00 00 00    	je     11f0 <generic_permission+0x180>
    1159:	41 83 fc 04          	cmp    $0x4,%r12d
    115d:	0f 84 b4 00 00 00    	je     1217 <generic_permission+0x1a7>
    1163:	41 83 e5 01          	and    $0x1,%r13d
    1167:	74 05                	je     116e <generic_permission+0xfe>
    1169:	f6 03 49             	testb  $0x49,(%rbx)
    116c:	74 18                	je     1186 <generic_permission+0x116>
    116e:	ba 01 00 00 00       	mov    $0x1,%edx
    1173:	48 89 de             	mov    %rbx,%rsi
    1176:	4c 89 f7             	mov    %r14,%rdi
    1179:	e8 00 00 00 00       	call   117e <generic_permission+0x10e>
    117e:	84 c0                	test   %al,%al
    1180:	0f 85 37 ff ff ff    	jne    10bd <generic_permission+0x4d>
    1186:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
    118b:	e9 2f ff ff ff       	jmp    10bf <generic_permission+0x4f>
    1190:	48 8b 43 28          	mov    0x28(%rbx),%rax
    1194:	8b 53 08             	mov    0x8(%rbx),%edx
    1197:	4c 89 f7             	mov    %r14,%rdi
    119a:	89 4d cc             	mov    %ecx,-0x34(%rbp)
    119d:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
    11a1:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    11a8:	e8 00 00 00 00       	call   11ad <generic_permission+0x13d>
    11ad:	89 c7                	mov    %eax,%edi
    11af:	e8 00 00 00 00       	call   11b4 <generic_permission+0x144>
    11b4:	8b 4d cc             	mov    -0x34(%rbp),%ecx
    11b7:	44 8b 45 d0          	mov    -0x30(%rbp),%r8d
    11bb:	85 c0                	test   %eax,%eax
    11bd:	f7 d1                	not    %ecx
    11bf:	44 0f 45 c1          	cmovne %ecx,%r8d
    11c3:	e9 77 ff ff ff       	jmp    113f <generic_permission+0xcf>
    11c8:	41 c1 ef 06          	shr    $0x6,%r15d
    11cc:	41 f7 d7             	not    %r15d
    11cf:	45 85 e7             	test   %r12d,%r15d
    11d2:	0f 84 e5 fe ff ff    	je     10bd <generic_permission+0x4d>
    11d8:	e9 6b ff ff ff       	jmp    1148 <generic_permission+0xd8>
    11dd:	48 8b 46 28          	mov    0x28(%rsi),%rax
    11e1:	f6 40 52 01          	testb  $0x1,0x52(%rax)
    11e5:	0f 85 f6 fe ff ff    	jne    10e1 <generic_permission+0x71>
    11eb:	e9 cd fe ff ff       	jmp    10bd <generic_permission+0x4d>
    11f0:	41 83 e5 02          	and    $0x2,%r13d
    11f4:	0f 85 74 ff ff ff    	jne    116e <generic_permission+0xfe>
    11fa:	ba 02 00 00 00       	mov    $0x2,%edx
    11ff:	48 89 de             	mov    %rbx,%rsi
    1202:	4c 89 f7             	mov    %r14,%rdi
    1205:	e8 00 00 00 00       	call   120a <generic_permission+0x19a>
    120a:	84 c0                	test   %al,%al
    120c:	0f 84 5c ff ff ff    	je     116e <generic_permission+0xfe>
    1212:	e9 a6 fe ff ff       	jmp    10bd <generic_permission+0x4d>
    1217:	ba 02 00 00 00       	mov    $0x2,%edx
    121c:	48 89 de             	mov    %rbx,%rsi
    121f:	4c 89 f7             	mov    %r14,%rdi
    1222:	e8 00 00 00 00       	call   1227 <generic_permission+0x1b7>
    1227:	84 c0                	test   %al,%al
    1229:	0f 84 34 ff ff ff    	je     1163 <generic_permission+0xf3>
    122f:	e9 89 fe ff ff       	jmp    10bd <generic_permission+0x4d>
    1234:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
    1238:	be 00 80 00 00       	mov    $0x8000,%esi
    123d:	48 89 df             	mov    %rbx,%rdi
    1240:	41 f6 c5 80          	test   $0x80,%r13b
    1244:	74 46                	je     128c <generic_permission+0x21c>
    1246:	e8 00 00 00 00       	call   124b <generic_permission+0x1db>
    124b:	44 8b 45 d0          	mov    -0x30(%rbp),%r8d
    124f:	48 85 c0             	test   %rax,%rax
    1252:	48 89 c2             	mov    %rax,%rdx
    1255:	0f 84 d6 fe ff ff    	je     1131 <generic_permission+0xc1>
    125b:	a8 01                	test   $0x1,%al
    125d:	0f 85 b5 00 00 00    	jne    1318 <generic_permission+0x2a8>
    1263:	44 89 e9             	mov    %r13d,%ecx
    1266:	48 89 de             	mov    %rbx,%rsi
    1269:	4c 89 f7             	mov    %r14,%rdi
    126c:	e8 00 00 00 00       	call   1271 <generic_permission+0x201>
    1271:	44 8b 45 d0          	mov    -0x30(%rbp),%r8d
    1275:	83 f8 f5             	cmp    $0xfffffff5,%eax
    1278:	0f 84 b3 fe ff ff    	je     1131 <generic_permission+0xc1>
    127e:	83 f8 f3             	cmp    $0xfffffff3,%eax
    1281:	0f 84 c1 fe ff ff    	je     1148 <generic_permission+0xd8>
    1287:	e9 33 fe ff ff       	jmp    10bf <generic_permission+0x4f>
    128c:	e8 00 00 00 00       	call   1291 <generic_permission+0x221>
    1291:	44 8b 45 d0          	mov    -0x30(%rbp),%r8d
    1295:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    129b:	48 89 c2             	mov    %rax,%rdx
    129e:	77 d5                	ja     1275 <generic_permission+0x205>
    12a0:	48 85 c0             	test   %rax,%rax
    12a3:	0f 84 88 fe ff ff    	je     1131 <generic_permission+0xc1>
    12a9:	44 89 e9             	mov    %r13d,%ecx
    12ac:	48 89 de             	mov    %rbx,%rsi
    12af:	4c 89 f7             	mov    %r14,%rdi
    12b2:	44 89 45 cc          	mov    %r8d,-0x34(%rbp)
    12b6:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    12ba:	e8 00 00 00 00       	call   12bf <generic_permission+0x24f>
    12bf:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
    12c3:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    12c8:	f0 0f c1 0a          	lock xadd %ecx,(%rdx)
    12cc:	83 f9 01             	cmp    $0x1,%ecx
    12cf:	44 8b 45 cc          	mov    -0x34(%rbp),%r8d
    12d3:	74 24                	je     12f9 <generic_permission+0x289>
    12d5:	85 c9                	test   %ecx,%ecx
    12d7:	7f 9c                	jg     1275 <generic_permission+0x205>
    12d9:	be 03 00 00 00       	mov    $0x3,%esi
    12de:	48 89 d7             	mov    %rdx,%rdi
    12e1:	89 45 cc             	mov    %eax,-0x34(%rbp)
    12e4:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
    12e8:	e8 00 00 00 00       	call   12ed <generic_permission+0x27d>
    12ed:	8b 45 cc             	mov    -0x34(%rbp),%eax
    12f0:	44 8b 45 d0          	mov    -0x30(%rbp),%r8d
    12f4:	e9 7c ff ff ff       	jmp    1275 <generic_permission+0x205>
    12f9:	89 45 cc             	mov    %eax,-0x34(%rbp)
    12fc:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
    1300:	48 8d 7a 08          	lea    0x8(%rdx),%rdi
    1304:	48 89 d6             	mov    %rdx,%rsi
    1307:	e8 00 00 00 00       	call   130c <generic_permission+0x29c>
    130c:	44 8b 45 d0          	mov    -0x30(%rbp),%r8d
    1310:	8b 45 cc             	mov    -0x34(%rbp),%eax
    1313:	e9 5d ff ff ff       	jmp    1275 <generic_permission+0x205>
    1318:	b8 f6 ff ff ff       	mov    $0xfffffff6,%eax
    131d:	e9 9d fd ff ff       	jmp    10bf <generic_permission+0x4f>
    1322:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1329:	00 00 00 00 
    132d:	0f 1f 00             	nopl   (%rax)

0000000000001330 <__pfx_inode_permission>:
    1330:	90                   	nop
    1331:	90                   	nop
    1332:	90                   	nop
    1333:	90                   	nop
    1334:	90                   	nop
    1335:	90                   	nop
    1336:	90                   	nop
    1337:	90                   	nop
    1338:	90                   	nop
    1339:	90                   	nop
    133a:	90                   	nop
    133b:	90                   	nop
    133c:	90                   	nop
    133d:	90                   	nop
    133e:	90                   	nop
    133f:	90                   	nop

0000000000001340 <inode_permission>:
    1340:	e8 00 00 00 00       	call   1345 <inode_permission+0x5>
    1345:	55                   	push   %rbp
    1346:	48 89 e5             	mov    %rsp,%rbp
    1349:	41 57                	push   %r15
    134b:	41 56                	push   %r14
    134d:	49 89 fe             	mov    %rdi,%r14
    1350:	41 55                	push   %r13
    1352:	41 89 d5             	mov    %edx,%r13d
    1355:	41 54                	push   %r12
    1357:	41 89 d4             	mov    %edx,%r12d
    135a:	53                   	push   %rbx
    135b:	48 89 f3             	mov    %rsi,%rbx
    135e:	48 8b 46 28          	mov    0x28(%rsi),%rax
    1362:	41 83 e4 02          	and    $0x2,%r12d
    1366:	75 53                	jne    13bb <inode_permission+0x7b>
    1368:	f6 43 02 01          	testb  $0x1,0x2(%rbx)
    136c:	0f 84 9b 00 00 00    	je     140d <inode_permission+0xcd>
    1372:	44 89 ea             	mov    %r13d,%edx
    1375:	48 89 de             	mov    %rbx,%rsi
    1378:	4c 89 f7             	mov    %r14,%rdi
    137b:	e8 00 00 00 00       	call   1380 <inode_permission+0x40>
    1380:	85 c0                	test   %eax,%eax
    1382:	75 20                	jne    13a4 <inode_permission+0x64>
    1384:	0f b7 03             	movzwl (%rbx),%eax
    1387:	89 c2                	mov    %eax,%edx
    1389:	66 81 e2 00 b0       	and    $0xb000,%dx
    138e:	66 81 fa 00 20       	cmp    $0x2000,%dx
    1393:	0f 84 98 00 00 00    	je     1431 <inode_permission+0xf1>
    1399:	44 89 ee             	mov    %r13d,%esi
    139c:	48 89 df             	mov    %rbx,%rdi
    139f:	e8 00 00 00 00       	call   13a4 <inode_permission+0x64>
    13a4:	5b                   	pop    %rbx
    13a5:	41 5c                	pop    %r12
    13a7:	41 5d                	pop    %r13
    13a9:	41 5e                	pop    %r14
    13ab:	41 5f                	pop    %r15
    13ad:	5d                   	pop    %rbp
    13ae:	31 d2                	xor    %edx,%edx
    13b0:	31 c9                	xor    %ecx,%ecx
    13b2:	31 f6                	xor    %esi,%esi
    13b4:	31 ff                	xor    %edi,%edi
    13b6:	e9 00 00 00 00       	jmp    13bb <inode_permission+0x7b>
    13bb:	0f b7 16             	movzwl (%rsi),%edx
    13be:	f6 40 50 01          	testb  $0x1,0x50(%rax)
    13c2:	74 21                	je     13e5 <inode_permission+0xa5>
    13c4:	89 d1                	mov    %edx,%ecx
    13c6:	66 81 e1 00 d0       	and    $0xd000,%cx
    13cb:	66 81 f9 00 80       	cmp    $0x8000,%cx
    13d0:	74 0c                	je     13de <inode_permission+0x9e>
    13d2:	66 81 e2 00 f0       	and    $0xf000,%dx
    13d7:	66 81 fa 00 40       	cmp    $0x4000,%dx
    13dc:	75 07                	jne    13e5 <inode_permission+0xa5>
    13de:	b8 e2 ff ff ff       	mov    $0xffffffe2,%eax
    13e3:	eb bf                	jmp    13a4 <inode_permission+0x64>
    13e5:	f6 43 0c 08          	testb  $0x8,0xc(%rbx)
    13e9:	0f 85 b9 00 00 00    	jne    14a8 <inode_permission+0x168>
    13ef:	8b 53 04             	mov    0x4(%rbx),%edx
    13f2:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    13f9:	4c 89 f7             	mov    %r14,%rdi
    13fc:	e8 00 00 00 00       	call   1401 <inode_permission+0xc1>
    1401:	83 f8 ff             	cmp    $0xffffffff,%eax
    1404:	75 7e                	jne    1484 <inode_permission+0x144>
    1406:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
    140b:	eb 97                	jmp    13a4 <inode_permission+0x64>
    140d:	48 8b 43 20          	mov    0x20(%rbx),%rax
    1411:	48 8b 40 10          	mov    0x10(%rax),%rax
    1415:	48 85 c0             	test   %rax,%rax
    1418:	0f 84 94 00 00 00    	je     14b2 <inode_permission+0x172>
    141e:	44 89 ea             	mov    %r13d,%edx
    1421:	48 89 de             	mov    %rbx,%rsi
    1424:	4c 89 f7             	mov    %r14,%rdi
    1427:	e8 00 00 00 00       	call   142c <inode_permission+0xec>
    142c:	e9 4f ff ff ff       	jmp    1380 <inode_permission+0x40>
    1431:	8b 73 4c             	mov    0x4c(%rbx),%esi
    1434:	85 f6                	test   %esi,%esi
    1436:	0f 84 5d ff ff ff    	je     1399 <inode_permission+0x59>
    143c:	66 25 00 f0          	and    $0xf000,%ax
    1440:	31 ff                	xor    %edi,%edi
    1442:	66 3d 00 60          	cmp    $0x6000,%ax
    1446:	40 0f 95 c7          	setne  %dil
    144a:	31 c0                	xor    %eax,%eax
    144c:	83 c7 01             	add    $0x1,%edi
    144f:	45 85 e4             	test   %r12d,%r12d
    1452:	0f 95 c0             	setne  %al
    1455:	c1 e0 02             	shl    $0x2,%eax
    1458:	89 c2                	mov    %eax,%edx
    145a:	83 ca 02             	or     $0x2,%edx
    145d:	41 f6 c5 04          	test   $0x4,%r13b
    1461:	0f 45 c2             	cmovne %edx,%eax
    1464:	89 f2                	mov    %esi,%edx
    1466:	c1 ee 14             	shr    $0x14,%esi
    1469:	81 e2 ff ff 0f 00    	and    $0xfffff,%edx
    146f:	0f bf c8             	movswl %ax,%ecx
    1472:	e8 00 00 00 00       	call   1477 <inode_permission+0x137>
    1477:	85 c0                	test   %eax,%eax
    1479:	0f 85 25 ff ff ff    	jne    13a4 <inode_permission+0x64>
    147f:	e9 15 ff ff ff       	jmp    1399 <inode_permission+0x59>
    1484:	48 8b 43 28          	mov    0x28(%rbx),%rax
    1488:	8b 53 08             	mov    0x8(%rbx),%edx
    148b:	4c 89 f7             	mov    %r14,%rdi
    148e:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    1495:	e8 00 00 00 00       	call   149a <inode_permission+0x15a>
    149a:	83 f8 ff             	cmp    $0xffffffff,%eax
    149d:	0f 85 c5 fe ff ff    	jne    1368 <inode_permission+0x28>
    14a3:	e9 5e ff ff ff       	jmp    1406 <inode_permission+0xc6>
    14a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14ad:	e9 f2 fe ff ff       	jmp    13a4 <inode_permission+0x64>
    14b2:	4c 8d bb 80 00 00 00 	lea    0x80(%rbx),%r15
    14b9:	4c 89 ff             	mov    %r15,%rdi
    14bc:	e8 00 00 00 00       	call   14c1 <inode_permission+0x181>
    14c1:	66 83 4b 02 01       	orw    $0x1,0x2(%rbx)
    14c6:	4c 89 ff             	mov    %r15,%rdi
    14c9:	e8 00 00 00 00       	call   14ce <inode_permission+0x18e>
    14ce:	e9 9f fe ff ff       	jmp    1372 <inode_permission+0x32>
    14d3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    14da:	00 00 00 00 
    14de:	66 90                	xchg   %ax,%ax

00000000000014e0 <__pfx_unlock_rename>:
    14e0:	90                   	nop
    14e1:	90                   	nop
    14e2:	90                   	nop
    14e3:	90                   	nop
    14e4:	90                   	nop
    14e5:	90                   	nop
    14e6:	90                   	nop
    14e7:	90                   	nop
    14e8:	90                   	nop
    14e9:	90                   	nop
    14ea:	90                   	nop
    14eb:	90                   	nop
    14ec:	90                   	nop
    14ed:	90                   	nop
    14ee:	90                   	nop
    14ef:	90                   	nop

00000000000014f0 <unlock_rename>:
    14f0:	e8 00 00 00 00       	call   14f5 <unlock_rename+0x5>
    14f5:	55                   	push   %rbp
    14f6:	48 89 e5             	mov    %rsp,%rbp
    14f9:	41 54                	push   %r12
    14fb:	49 89 f4             	mov    %rsi,%r12
    14fe:	53                   	push   %rbx
    14ff:	48 8b 47 30          	mov    0x30(%rdi),%rax
    1503:	48 89 fb             	mov    %rdi,%rbx
    1506:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    150d:	e8 00 00 00 00       	call   1512 <unlock_rename+0x22>
    1512:	4c 39 e3             	cmp    %r12,%rbx
    1515:	74 21                	je     1538 <unlock_rename+0x48>
    1517:	49 8b 7c 24 30       	mov    0x30(%r12),%rdi
    151c:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    1523:	e8 00 00 00 00       	call   1528 <unlock_rename+0x38>
    1528:	48 8b 7b 68          	mov    0x68(%rbx),%rdi
    152c:	48 81 c7 28 04 00 00 	add    $0x428,%rdi
    1533:	e8 00 00 00 00       	call   1538 <unlock_rename+0x48>
    1538:	5b                   	pop    %rbx
    1539:	41 5c                	pop    %r12
    153b:	5d                   	pop    %rbp
    153c:	31 c0                	xor    %eax,%eax
    153e:	31 f6                	xor    %esi,%esi
    1540:	31 ff                	xor    %edi,%edi
    1542:	e9 00 00 00 00       	jmp    1547 <unlock_rename+0x57>
    1547:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    154e:	00 00 

0000000000001550 <__pfx___page_get_link.isra.0>:
    1550:	90                   	nop
    1551:	90                   	nop
    1552:	90                   	nop
    1553:	90                   	nop
    1554:	90                   	nop
    1555:	90                   	nop
    1556:	90                   	nop
    1557:	90                   	nop
    1558:	90                   	nop
    1559:	90                   	nop
    155a:	90                   	nop
    155b:	90                   	nop
    155c:	90                   	nop
    155d:	90                   	nop
    155e:	90                   	nop
    155f:	90                   	nop

0000000000001560 <__page_get_link.isra.0>:
    1560:	e8 00 00 00 00       	call   1565 <__page_get_link.isra.0+0x5>
    1565:	55                   	push   %rbp
    1566:	48 89 e5             	mov    %rsp,%rbp
    1569:	41 54                	push   %r12
    156b:	49 89 d4             	mov    %rdx,%r12
    156e:	53                   	push   %rbx
    156f:	48 89 f3             	mov    %rsi,%rbx
    1572:	48 85 ff             	test   %rdi,%rdi
    1575:	74 50                	je     15c7 <__page_get_link.isra.0+0x67>
    1577:	31 c9                	xor    %ecx,%ecx
    1579:	31 d2                	xor    %edx,%edx
    157b:	31 f6                	xor    %esi,%esi
    157d:	48 89 df             	mov    %rbx,%rdi
    1580:	e8 00 00 00 00       	call   1585 <__page_get_link.isra.0+0x25>
    1585:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    158b:	77 29                	ja     15b6 <__page_get_link.isra.0+0x56>
    158d:	49 c7 04 24 00 00 00 	movq   $0x0,(%r12)
    1594:	00 
    1595:	49 89 44 24 08       	mov    %rax,0x8(%r12)
    159a:	f6 43 40 02          	testb  $0x2,0x40(%rbx)
    159e:	75 56                	jne    15f6 <__page_get_link.isra.0+0x96>
    15a0:	48 2b 05 00 00 00 00 	sub    0x0(%rip),%rax        # 15a7 <__page_get_link.isra.0+0x47>
    15a7:	48 c1 f8 06          	sar    $0x6,%rax
    15ab:	48 c1 e0 0c          	shl    $0xc,%rax
    15af:	48 03 05 00 00 00 00 	add    0x0(%rip),%rax        # 15b6 <__page_get_link.isra.0+0x56>
    15b6:	5b                   	pop    %rbx
    15b7:	41 5c                	pop    %r12
    15b9:	5d                   	pop    %rbp
    15ba:	31 d2                	xor    %edx,%edx
    15bc:	31 c9                	xor    %ecx,%ecx
    15be:	31 f6                	xor    %esi,%esi
    15c0:	31 ff                	xor    %edi,%edi
    15c2:	e9 00 00 00 00       	jmp    15c7 <__page_get_link.isra.0+0x67>
    15c7:	31 c9                	xor    %ecx,%ecx
    15c9:	31 d2                	xor    %edx,%edx
    15cb:	31 f6                	xor    %esi,%esi
    15cd:	48 89 df             	mov    %rbx,%rdi
    15d0:	e8 00 00 00 00       	call   15d5 <__page_get_link.isra.0+0x75>
    15d5:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    15db:	77 0e                	ja     15eb <__page_get_link.isra.0+0x8b>
    15dd:	48 8b 10             	mov    (%rax),%rdx
    15e0:	83 e2 08             	and    $0x8,%edx
    15e3:	75 0f                	jne    15f4 <__page_get_link.isra.0+0x94>
    15e5:	f0 ff 48 34          	lock decl 0x34(%rax)
    15e9:	74 0d                	je     15f8 <__page_get_link.isra.0+0x98>
    15eb:	48 c7 c0 f6 ff ff ff 	mov    $0xfffffffffffffff6,%rax
    15f2:	eb c2                	jmp    15b6 <__page_get_link.isra.0+0x56>
    15f4:	eb 97                	jmp    158d <__page_get_link.isra.0+0x2d>
    15f6:	0f 0b                	ud2
    15f8:	48 89 c7             	mov    %rax,%rdi
    15fb:	e8 00 00 00 00       	call   1600 <__page_get_link.isra.0+0xa0>
    1600:	eb e9                	jmp    15eb <__page_get_link.isra.0+0x8b>
    1602:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1609:	00 00 00 00 
    160d:	0f 1f 00             	nopl   (%rax)

0000000000001610 <__pfx_page_get_link>:
    1610:	90                   	nop
    1611:	90                   	nop
    1612:	90                   	nop
    1613:	90                   	nop
    1614:	90                   	nop
    1615:	90                   	nop
    1616:	90                   	nop
    1617:	90                   	nop
    1618:	90                   	nop
    1619:	90                   	nop
    161a:	90                   	nop
    161b:	90                   	nop
    161c:	90                   	nop
    161d:	90                   	nop
    161e:	90                   	nop
    161f:	90                   	nop

0000000000001620 <page_get_link>:
    1620:	e8 00 00 00 00       	call   1625 <page_get_link+0x5>
    1625:	55                   	push   %rbp
    1626:	48 89 e5             	mov    %rsp,%rbp
    1629:	53                   	push   %rbx
    162a:	48 89 f3             	mov    %rsi,%rbx
    162d:	48 8b 76 30          	mov    0x30(%rsi),%rsi
    1631:	e8 2a ff ff ff       	call   1560 <__page_get_link.isra.0>
    1636:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    163c:	77 14                	ja     1652 <page_get_link+0x32>
    163e:	48 8b 53 50          	mov    0x50(%rbx),%rdx
    1642:	b9 ff 0f 00 00       	mov    $0xfff,%ecx
    1647:	48 39 ca             	cmp    %rcx,%rdx
    164a:	48 0f 47 d1          	cmova  %rcx,%rdx
    164e:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    1652:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    1656:	c9                   	leave
    1657:	31 d2                	xor    %edx,%edx
    1659:	31 c9                	xor    %ecx,%ecx
    165b:	31 f6                	xor    %esi,%esi
    165d:	31 ff                	xor    %edi,%edi
    165f:	e9 00 00 00 00       	jmp    1664 <page_get_link+0x44>
    1664:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    166b:	00 00 00 00 
    166f:	90                   	nop

0000000000001670 <__pfx_page_get_link_raw>:
    1670:	90                   	nop
    1671:	90                   	nop
    1672:	90                   	nop
    1673:	90                   	nop
    1674:	90                   	nop
    1675:	90                   	nop
    1676:	90                   	nop
    1677:	90                   	nop
    1678:	90                   	nop
    1679:	90                   	nop
    167a:	90                   	nop
    167b:	90                   	nop
    167c:	90                   	nop
    167d:	90                   	nop
    167e:	90                   	nop
    167f:	90                   	nop

0000000000001680 <page_get_link_raw>:
    1680:	e8 00 00 00 00       	call   1685 <page_get_link_raw+0x5>
    1685:	55                   	push   %rbp
    1686:	48 8b 76 30          	mov    0x30(%rsi),%rsi
    168a:	48 89 e5             	mov    %rsp,%rbp
    168d:	e8 ce fe ff ff       	call   1560 <__page_get_link.isra.0>
    1692:	5d                   	pop    %rbp
    1693:	31 d2                	xor    %edx,%edx
    1695:	31 f6                	xor    %esi,%esi
    1697:	31 ff                	xor    %edi,%edi
    1699:	e9 00 00 00 00       	jmp    169e <page_get_link_raw+0x1e>
    169e:	66 90                	xchg   %ax,%ax

00000000000016a0 <__pfx_follow_down>:
    16a0:	90                   	nop
    16a1:	90                   	nop
    16a2:	90                   	nop
    16a3:	90                   	nop
    16a4:	90                   	nop
    16a5:	90                   	nop
    16a6:	90                   	nop
    16a7:	90                   	nop
    16a8:	90                   	nop
    16a9:	90                   	nop
    16aa:	90                   	nop
    16ab:	90                   	nop
    16ac:	90                   	nop
    16ad:	90                   	nop
    16ae:	90                   	nop
    16af:	90                   	nop

00000000000016b0 <follow_down>:
    16b0:	e8 00 00 00 00       	call   16b5 <follow_down+0x5>
    16b5:	55                   	push   %rbp
    16b6:	48 89 e5             	mov    %rsp,%rbp
    16b9:	41 55                	push   %r13
    16bb:	41 54                	push   %r12
    16bd:	48 83 ec 18          	sub    $0x18,%rsp
    16c1:	4c 8b 2f             	mov    (%rdi),%r13
    16c4:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 16cc <follow_down+0x1c>
    16cb:	00 
    16cc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    16d0:	31 c0                	xor    %eax,%eax
    16d2:	48 8b 47 08          	mov    0x8(%rdi),%rax
    16d6:	8b 00                	mov    (%rax),%eax
    16d8:	a9 00 80 03 00       	test   $0x38000,%eax
    16dd:	75 46                	jne    1725 <follow_down+0x75>
    16df:	25 00 00 38 00       	and    $0x380000,%eax
    16e4:	83 f8 01             	cmp    $0x1,%eax
    16e7:	45 19 e4             	sbb    %r12d,%r12d
    16ea:	41 83 e4 fe          	and    $0xfffffffe,%r12d
    16ee:	4c 39 2f             	cmp    %r13,(%rdi)
    16f1:	74 08                	je     16fb <follow_down+0x4b>
    16f3:	4c 89 ef             	mov    %r13,%rdi
    16f6:	e8 00 00 00 00       	call   16fb <follow_down+0x4b>
    16fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    16ff:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 1707 <follow_down+0x57>
    1706:	00 
    1707:	75 39                	jne    1742 <follow_down+0x92>
    1709:	48 83 c4 18          	add    $0x18,%rsp
    170d:	44 89 e0             	mov    %r12d,%eax
    1710:	41 5c                	pop    %r12
    1712:	41 5d                	pop    %r13
    1714:	5d                   	pop    %rbp
    1715:	31 d2                	xor    %edx,%edx
    1717:	31 c9                	xor    %ecx,%ecx
    1719:	31 f6                	xor    %esi,%esi
    171b:	31 ff                	xor    %edi,%edi
    171d:	45 31 c0             	xor    %r8d,%r8d
    1720:	e9 00 00 00 00       	jmp    1725 <follow_down+0x75>
    1725:	41 89 f0             	mov    %esi,%r8d
    1728:	31 c9                	xor    %ecx,%ecx
    172a:	48 8d 55 e7          	lea    -0x19(%rbp),%rdx
    172e:	89 c6                	mov    %eax,%esi
    1730:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
    1734:	e8 f7 ec ff ff       	call   430 <__traverse_mounts>
    1739:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
    173d:	41 89 c4             	mov    %eax,%r12d
    1740:	eb ac                	jmp    16ee <follow_down+0x3e>
    1742:	e8 00 00 00 00       	call   1747 <follow_down+0x97>
    1747:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    174e:	00 00 

0000000000001750 <__pfx_getname_flags.part.0>:
    1750:	90                   	nop
    1751:	90                   	nop
    1752:	90                   	nop
    1753:	90                   	nop
    1754:	90                   	nop
    1755:	90                   	nop
    1756:	90                   	nop
    1757:	90                   	nop
    1758:	90                   	nop
    1759:	90                   	nop
    175a:	90                   	nop
    175b:	90                   	nop
    175c:	90                   	nop
    175d:	90                   	nop
    175e:	90                   	nop
    175f:	90                   	nop

0000000000001760 <getname_flags.part.0>:
    1760:	e8 00 00 00 00       	call   1765 <getname_flags.part.0+0x5>
    1765:	55                   	push   %rbp
    1766:	48 89 e5             	mov    %rsp,%rbp
    1769:	41 56                	push   %r14
    176b:	41 55                	push   %r13
    176d:	41 89 f5             	mov    %esi,%r13d
    1770:	be c0 0c 00 00       	mov    $0xcc0,%esi
    1775:	41 54                	push   %r12
    1777:	49 89 fc             	mov    %rdi,%r12
    177a:	53                   	push   %rbx
    177b:	48 83 ec 08          	sub    $0x8,%rsp
    177f:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 1786 <getname_flags.part.0+0x26>
    1786:	e8 00 00 00 00       	call   178b <getname_flags.part.0+0x2b>
    178b:	48 85 c0             	test   %rax,%rax
    178e:	0f 84 5a 01 00 00    	je     18ee <getname_flags.part.0+0x18e>
    1794:	48 8d 78 20          	lea    0x20(%rax),%rdi
    1798:	ba e0 0f 00 00       	mov    $0xfe0,%edx
    179d:	4c 89 e6             	mov    %r12,%rsi
    17a0:	48 89 c3             	mov    %rax,%rbx
    17a3:	48 89 38             	mov    %rdi,(%rax)
    17a6:	e8 00 00 00 00       	call   17ab <getname_flags.part.0+0x4b>
    17ab:	85 c0                	test   %eax,%eax
    17ad:	7e 74                	jle    1823 <getname_flags.part.0+0xc3>
    17af:	3d e0 0f 00 00       	cmp    $0xfe0,%eax
    17b4:	0f 84 8d 00 00 00    	je     1847 <getname_flags.part.0+0xe7>
    17ba:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 17c2 <getname_flags.part.0+0x62>
    17c1:	00 
    17c2:	4c 89 63 08          	mov    %r12,0x8(%rbx)
    17c6:	48 c7 43 18 00 00 00 	movq   $0x0,0x18(%rbx)
    17cd:	00 
    17ce:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    17d5:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    17dc:	48 85 c0             	test   %rax,%rax
    17df:	74 06                	je     17e7 <getname_flags.part.0+0x87>
    17e1:	8b 00                	mov    (%rax),%eax
    17e3:	85 c0                	test   %eax,%eax
    17e5:	74 1a                	je     1801 <getname_flags.part.0+0xa1>
    17e7:	48 83 c4 08          	add    $0x8,%rsp
    17eb:	48 89 d8             	mov    %rbx,%rax
    17ee:	5b                   	pop    %rbx
    17ef:	41 5c                	pop    %r12
    17f1:	41 5d                	pop    %r13
    17f3:	41 5e                	pop    %r14
    17f5:	5d                   	pop    %rbp
    17f6:	31 d2                	xor    %edx,%edx
    17f8:	31 f6                	xor    %esi,%esi
    17fa:	31 ff                	xor    %edi,%edi
    17fc:	e9 00 00 00 00       	jmp    1801 <getname_flags.part.0+0xa1>
    1801:	48 89 df             	mov    %rbx,%rdi
    1804:	e8 00 00 00 00       	call   1809 <getname_flags.part.0+0xa9>
    1809:	48 89 d8             	mov    %rbx,%rax
    180c:	48 83 c4 08          	add    $0x8,%rsp
    1810:	5b                   	pop    %rbx
    1811:	41 5c                	pop    %r12
    1813:	41 5d                	pop    %r13
    1815:	41 5e                	pop    %r14
    1817:	5d                   	pop    %rbp
    1818:	31 d2                	xor    %edx,%edx
    181a:	31 f6                	xor    %esi,%esi
    181c:	31 ff                	xor    %edi,%edi
    181e:	e9 00 00 00 00       	jmp    1823 <getname_flags.part.0+0xc3>
    1823:	0f 85 97 00 00 00    	jne    18c0 <getname_flags.part.0+0x160>
    1829:	41 83 e5 08          	and    $0x8,%r13d
    182d:	75 8b                	jne    17ba <getname_flags.part.0+0x5a>
    182f:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 1836 <getname_flags.part.0+0xd6>
    1836:	48 89 de             	mov    %rbx,%rsi
    1839:	e8 00 00 00 00       	call   183e <getname_flags.part.0+0xde>
    183e:	48 c7 c3 fe ff ff ff 	mov    $0xfffffffffffffffe,%rbx
    1845:	eb a0                	jmp    17e7 <getname_flags.part.0+0x87>
    1847:	48 8b 45 08          	mov    0x8(%rbp),%rax
    184b:	48 33 05 00 00 00 00 	xor    0x0(%rip),%rax        # 1852 <getname_flags.part.0+0xf2>
    1852:	be c0 0d 00 00       	mov    $0xdc0,%esi
    1857:	48 ba eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rdx
    185e:	86 c8 61 
    1861:	48 0f af c2          	imul   %rdx,%rax
    1865:	48 c1 e8 3c          	shr    $0x3c,%rax
    1869:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1870:	00 
    1871:	48 29 c2             	sub    %rax,%rdx
    1874:	48 89 d0             	mov    %rdx,%rax
    1877:	ba 21 00 00 00       	mov    $0x21,%edx
    187c:	48 c1 e0 04          	shl    $0x4,%rax
    1880:	48 8b b8 00 00 00 00 	mov    0x0(%rax),%rdi
    1887:	e8 00 00 00 00       	call   188c <getname_flags.part.0+0x12c>
    188c:	49 89 c6             	mov    %rax,%r14
    188f:	48 85 c0             	test   %rax,%rax
    1892:	74 4b                	je     18df <getname_flags.part.0+0x17f>
    1894:	48 89 18             	mov    %rbx,(%rax)
    1897:	ba 00 10 00 00       	mov    $0x1000,%edx
    189c:	4c 89 e6             	mov    %r12,%rsi
    189f:	48 89 df             	mov    %rbx,%rdi
    18a2:	e8 00 00 00 00       	call   18a7 <getname_flags.part.0+0x147>
    18a7:	85 c0                	test   %eax,%eax
    18a9:	78 4f                	js     18fa <getname_flags.part.0+0x19a>
    18ab:	74 74                	je     1921 <getname_flags.part.0+0x1c1>
    18ad:	3d 00 10 00 00       	cmp    $0x1000,%eax
    18b2:	0f 84 8b 00 00 00    	je     1943 <getname_flags.part.0+0x1e3>
    18b8:	4c 89 f3             	mov    %r14,%rbx
    18bb:	e9 fa fe ff ff       	jmp    17ba <getname_flags.part.0+0x5a>
    18c0:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 18c7 <getname_flags.part.0+0x167>
    18c7:	48 89 de             	mov    %rbx,%rsi
    18ca:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    18ce:	e8 00 00 00 00       	call   18d3 <getname_flags.part.0+0x173>
    18d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    18d7:	48 63 d8             	movslq %eax,%rbx
    18da:	e9 08 ff ff ff       	jmp    17e7 <getname_flags.part.0+0x87>
    18df:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 18e6 <getname_flags.part.0+0x186>
    18e6:	48 89 de             	mov    %rbx,%rsi
    18e9:	e8 00 00 00 00       	call   18ee <getname_flags.part.0+0x18e>
    18ee:	48 c7 c3 f4 ff ff ff 	mov    $0xfffffffffffffff4,%rbx
    18f5:	e9 ed fe ff ff       	jmp    17e7 <getname_flags.part.0+0x87>
    18fa:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 1901 <getname_flags.part.0+0x1a1>
    1901:	48 89 de             	mov    %rbx,%rsi
    1904:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    1908:	e8 00 00 00 00       	call   190d <getname_flags.part.0+0x1ad>
    190d:	4c 89 f7             	mov    %r14,%rdi
    1910:	e8 00 00 00 00       	call   1915 <getname_flags.part.0+0x1b5>
    1915:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1919:	48 63 d8             	movslq %eax,%rbx
    191c:	e9 c6 fe ff ff       	jmp    17e7 <getname_flags.part.0+0x87>
    1921:	41 83 e5 08          	and    $0x8,%r13d
    1925:	75 91                	jne    18b8 <getname_flags.part.0+0x158>
    1927:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 192e <getname_flags.part.0+0x1ce>
    192e:	48 89 de             	mov    %rbx,%rsi
    1931:	e8 00 00 00 00       	call   1936 <getname_flags.part.0+0x1d6>
    1936:	4c 89 f7             	mov    %r14,%rdi
    1939:	e8 00 00 00 00       	call   193e <getname_flags.part.0+0x1de>
    193e:	e9 fb fe ff ff       	jmp    183e <getname_flags.part.0+0xde>
    1943:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 194a <getname_flags.part.0+0x1ea>
    194a:	48 89 de             	mov    %rbx,%rsi
    194d:	48 c7 c3 dc ff ff ff 	mov    $0xffffffffffffffdc,%rbx
    1954:	e8 00 00 00 00       	call   1959 <getname_flags.part.0+0x1f9>
    1959:	4c 89 f7             	mov    %r14,%rdi
    195c:	e8 00 00 00 00       	call   1961 <getname_flags.part.0+0x201>
    1961:	e9 81 fe ff ff       	jmp    17e7 <getname_flags.part.0+0x87>
    1966:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    196d:	00 00 00 

0000000000001970 <__pfx_lookup_dcache>:
    1970:	90                   	nop
    1971:	90                   	nop
    1972:	90                   	nop
    1973:	90                   	nop
    1974:	90                   	nop
    1975:	90                   	nop
    1976:	90                   	nop
    1977:	90                   	nop
    1978:	90                   	nop
    1979:	90                   	nop
    197a:	90                   	nop
    197b:	90                   	nop
    197c:	90                   	nop
    197d:	90                   	nop
    197e:	90                   	nop
    197f:	90                   	nop

0000000000001980 <lookup_dcache>:
    1980:	e8 00 00 00 00       	call   1985 <lookup_dcache+0x5>
    1985:	55                   	push   %rbp
    1986:	48 89 e5             	mov    %rsp,%rbp
    1989:	41 56                	push   %r14
    198b:	41 89 d6             	mov    %edx,%r14d
    198e:	41 55                	push   %r13
    1990:	49 89 f5             	mov    %rsi,%r13
    1993:	48 89 fe             	mov    %rdi,%rsi
    1996:	41 54                	push   %r12
    1998:	49 89 fc             	mov    %rdi,%r12
    199b:	4c 89 ef             	mov    %r13,%rdi
    199e:	53                   	push   %rbx
    199f:	e8 00 00 00 00       	call   19a4 <lookup_dcache+0x24>
    19a4:	48 89 c3             	mov    %rax,%rbx
    19a7:	48 85 c0             	test   %rax,%rax
    19aa:	74 05                	je     19b1 <lookup_dcache+0x31>
    19ac:	f6 00 04             	testb  $0x4,(%rax)
    19af:	75 18                	jne    19c9 <lookup_dcache+0x49>
    19b1:	48 89 d8             	mov    %rbx,%rax
    19b4:	5b                   	pop    %rbx
    19b5:	41 5c                	pop    %r12
    19b7:	41 5d                	pop    %r13
    19b9:	41 5e                	pop    %r14
    19bb:	5d                   	pop    %rbp
    19bc:	31 d2                	xor    %edx,%edx
    19be:	31 c9                	xor    %ecx,%ecx
    19c0:	31 f6                	xor    %esi,%esi
    19c2:	31 ff                	xor    %edi,%edi
    19c4:	e9 00 00 00 00       	jmp    19c9 <lookup_dcache+0x49>
    19c9:	48 8b 40 60          	mov    0x60(%rax),%rax
    19cd:	4c 89 e6             	mov    %r12,%rsi
    19d0:	49 8b 7d 30          	mov    0x30(%r13),%rdi
    19d4:	44 89 f1             	mov    %r14d,%ecx
    19d7:	48 89 da             	mov    %rbx,%rdx
    19da:	48 8b 00             	mov    (%rax),%rax
    19dd:	e8 00 00 00 00       	call   19e2 <lookup_dcache+0x62>
    19e2:	41 89 c4             	mov    %eax,%r12d
    19e5:	85 c0                	test   %eax,%eax
    19e7:	7f c8                	jg     19b1 <lookup_dcache+0x31>
    19e9:	74 0d                	je     19f8 <lookup_dcache+0x78>
    19eb:	48 89 df             	mov    %rbx,%rdi
    19ee:	49 63 dc             	movslq %r12d,%rbx
    19f1:	e8 00 00 00 00       	call   19f6 <lookup_dcache+0x76>
    19f6:	eb b9                	jmp    19b1 <lookup_dcache+0x31>
    19f8:	48 89 df             	mov    %rbx,%rdi
    19fb:	e8 00 00 00 00       	call   1a00 <lookup_dcache+0x80>
    1a00:	eb e9                	jmp    19eb <lookup_dcache+0x6b>
    1a02:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1a09:	00 00 00 00 
    1a0d:	0f 1f 00             	nopl   (%rax)

0000000000001a10 <__pfx_lookup_one_qstr_excl>:
    1a10:	90                   	nop
    1a11:	90                   	nop
    1a12:	90                   	nop
    1a13:	90                   	nop
    1a14:	90                   	nop
    1a15:	90                   	nop
    1a16:	90                   	nop
    1a17:	90                   	nop
    1a18:	90                   	nop
    1a19:	90                   	nop
    1a1a:	90                   	nop
    1a1b:	90                   	nop
    1a1c:	90                   	nop
    1a1d:	90                   	nop
    1a1e:	90                   	nop
    1a1f:	90                   	nop

0000000000001a20 <lookup_one_qstr_excl>:
    1a20:	e8 00 00 00 00       	call   1a25 <lookup_one_qstr_excl+0x5>
    1a25:	55                   	push   %rbp
    1a26:	48 89 e5             	mov    %rsp,%rbp
    1a29:	41 57                	push   %r15
    1a2b:	41 56                	push   %r14
    1a2d:	49 89 fe             	mov    %rdi,%r14
    1a30:	41 55                	push   %r13
    1a32:	49 89 f5             	mov    %rsi,%r13
    1a35:	41 54                	push   %r12
    1a37:	41 89 d4             	mov    %edx,%r12d
    1a3a:	53                   	push   %rbx
    1a3b:	48 83 ec 08          	sub    $0x8,%rsp
    1a3f:	e8 3c ff ff ff       	call   1980 <lookup_dcache>
    1a44:	48 89 c3             	mov    %rax,%rbx
    1a47:	48 85 c0             	test   %rax,%rax
    1a4a:	74 54                	je     1aa0 <lookup_one_qstr_excl+0x80>
    1a4c:	48 81 fb 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rbx
    1a53:	77 15                	ja     1a6a <lookup_one_qstr_excl+0x4a>
    1a55:	f7 03 00 00 38 00    	testl  $0x380000,(%rbx)
    1a5b:	75 29                	jne    1a86 <lookup_one_qstr_excl+0x66>
    1a5d:	41 81 e4 00 00 02 00 	and    $0x20000,%r12d
    1a64:	0f 84 87 00 00 00    	je     1af1 <lookup_one_qstr_excl+0xd1>
    1a6a:	48 83 c4 08          	add    $0x8,%rsp
    1a6e:	48 89 d8             	mov    %rbx,%rax
    1a71:	5b                   	pop    %rbx
    1a72:	41 5c                	pop    %r12
    1a74:	41 5d                	pop    %r13
    1a76:	41 5e                	pop    %r14
    1a78:	41 5f                	pop    %r15
    1a7a:	5d                   	pop    %rbp
    1a7b:	31 d2                	xor    %edx,%edx
    1a7d:	31 f6                	xor    %esi,%esi
    1a7f:	31 ff                	xor    %edi,%edi
    1a81:	e9 00 00 00 00       	jmp    1a86 <lookup_one_qstr_excl+0x66>
    1a86:	41 81 e4 00 00 04 00 	and    $0x40000,%r12d
    1a8d:	74 db                	je     1a6a <lookup_one_qstr_excl+0x4a>
    1a8f:	48 89 df             	mov    %rbx,%rdi
    1a92:	48 c7 c3 ef ff ff ff 	mov    $0xffffffffffffffef,%rbx
    1a99:	e8 00 00 00 00       	call   1a9e <lookup_one_qstr_excl+0x7e>
    1a9e:	eb ca                	jmp    1a6a <lookup_one_qstr_excl+0x4a>
    1aa0:	4d 8b 7d 30          	mov    0x30(%r13),%r15
    1aa4:	41 f6 47 0c 10       	testb  $0x10,0xc(%r15)
    1aa9:	75 4e                	jne    1af9 <lookup_one_qstr_excl+0xd9>
    1aab:	4c 89 f6             	mov    %r14,%rsi
    1aae:	4c 89 ef             	mov    %r13,%rdi
    1ab1:	e8 00 00 00 00       	call   1ab6 <lookup_one_qstr_excl+0x96>
    1ab6:	48 89 c3             	mov    %rax,%rbx
    1ab9:	48 85 c0             	test   %rax,%rax
    1abc:	74 47                	je     1b05 <lookup_one_qstr_excl+0xe5>
    1abe:	49 8b 47 20          	mov    0x20(%r15),%rax
    1ac2:	44 89 e2             	mov    %r12d,%edx
    1ac5:	48 89 de             	mov    %rbx,%rsi
    1ac8:	4c 89 ff             	mov    %r15,%rdi
    1acb:	48 8b 00             	mov    (%rax),%rax
    1ace:	e8 00 00 00 00       	call   1ad3 <lookup_one_qstr_excl+0xb3>
    1ad3:	48 85 c0             	test   %rax,%rax
    1ad6:	0f 84 70 ff ff ff    	je     1a4c <lookup_one_qstr_excl+0x2c>
    1adc:	48 89 df             	mov    %rbx,%rdi
    1adf:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    1ae3:	e8 00 00 00 00       	call   1ae8 <lookup_one_qstr_excl+0xc8>
    1ae8:	48 8b 5d d0          	mov    -0x30(%rbp),%rbx
    1aec:	e9 5b ff ff ff       	jmp    1a4c <lookup_one_qstr_excl+0x2c>
    1af1:	48 89 df             	mov    %rbx,%rdi
    1af4:	e8 00 00 00 00       	call   1af9 <lookup_one_qstr_excl+0xd9>
    1af9:	48 c7 c3 fe ff ff ff 	mov    $0xfffffffffffffffe,%rbx
    1b00:	e9 65 ff ff ff       	jmp    1a6a <lookup_one_qstr_excl+0x4a>
    1b05:	48 c7 c3 f4 ff ff ff 	mov    $0xfffffffffffffff4,%rbx
    1b0c:	e9 59 ff ff ff       	jmp    1a6a <lookup_one_qstr_excl+0x4a>
    1b11:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1b18:	00 00 00 00 
    1b1c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001b20 <__pfx___lookup_slow>:
    1b20:	90                   	nop
    1b21:	90                   	nop
    1b22:	90                   	nop
    1b23:	90                   	nop
    1b24:	90                   	nop
    1b25:	90                   	nop
    1b26:	90                   	nop
    1b27:	90                   	nop
    1b28:	90                   	nop
    1b29:	90                   	nop
    1b2a:	90                   	nop
    1b2b:	90                   	nop
    1b2c:	90                   	nop
    1b2d:	90                   	nop
    1b2e:	90                   	nop
    1b2f:	90                   	nop

0000000000001b30 <__lookup_slow>:
    1b30:	e8 00 00 00 00       	call   1b35 <__lookup_slow+0x5>
    1b35:	55                   	push   %rbp
    1b36:	48 89 e5             	mov    %rsp,%rbp
    1b39:	41 57                	push   %r15
    1b3b:	41 56                	push   %r14
    1b3d:	41 55                	push   %r13
    1b3f:	41 54                	push   %r12
    1b41:	53                   	push   %rbx
    1b42:	48 83 ec 28          	sub    $0x28,%rsp
    1b46:	4c 8b 7e 30          	mov    0x30(%rsi),%r15
    1b4a:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 1b52 <__lookup_slow+0x22>
    1b51:	00 
    1b52:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    1b56:	31 c0                	xor    %eax,%eax
    1b58:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
    1b5c:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
    1b63:	00 
    1b64:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    1b68:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    1b6c:	41 f6 47 0c 10       	testb  $0x10,0xc(%r15)
    1b71:	75 7d                	jne    1bf0 <__lookup_slow+0xc0>
    1b73:	49 89 fd             	mov    %rdi,%r13
    1b76:	49 89 f4             	mov    %rsi,%r12
    1b79:	41 89 d6             	mov    %edx,%r14d
    1b7c:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
    1b80:	4c 89 ee             	mov    %r13,%rsi
    1b83:	4c 89 e7             	mov    %r12,%rdi
    1b86:	e8 00 00 00 00       	call   1b8b <__lookup_slow+0x5b>
    1b8b:	48 89 c3             	mov    %rax,%rbx
    1b8e:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    1b94:	77 2e                	ja     1bc4 <__lookup_slow+0x94>
    1b96:	8b 00                	mov    (%rax),%eax
    1b98:	a9 00 00 00 01       	test   $0x1000000,%eax
    1b9d:	74 5a                	je     1bf9 <__lookup_slow+0xc9>
    1b9f:	49 8b 47 20          	mov    0x20(%r15),%rax
    1ba3:	44 89 f2             	mov    %r14d,%edx
    1ba6:	48 89 de             	mov    %rbx,%rsi
    1ba9:	4c 89 ff             	mov    %r15,%rdi
    1bac:	48 8b 00             	mov    (%rax),%rax
    1baf:	e8 00 00 00 00       	call   1bb4 <__lookup_slow+0x84>
    1bb4:	49 89 c4             	mov    %rax,%r12
    1bb7:	f7 03 00 00 00 01    	testl  $0x1000000,(%rbx)
    1bbd:	75 71                	jne    1c30 <__lookup_slow+0x100>
    1bbf:	4d 85 e4             	test   %r12,%r12
    1bc2:	75 76                	jne    1c3a <__lookup_slow+0x10a>
    1bc4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1bc8:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 1bd0 <__lookup_slow+0xa0>
    1bcf:	00 
    1bd0:	75 78                	jne    1c4a <__lookup_slow+0x11a>
    1bd2:	48 83 c4 28          	add    $0x28,%rsp
    1bd6:	48 89 d8             	mov    %rbx,%rax
    1bd9:	5b                   	pop    %rbx
    1bda:	41 5c                	pop    %r12
    1bdc:	41 5d                	pop    %r13
    1bde:	41 5e                	pop    %r14
    1be0:	41 5f                	pop    %r15
    1be2:	5d                   	pop    %rbp
    1be3:	31 d2                	xor    %edx,%edx
    1be5:	31 c9                	xor    %ecx,%ecx
    1be7:	31 f6                	xor    %esi,%esi
    1be9:	31 ff                	xor    %edi,%edi
    1beb:	e9 00 00 00 00       	jmp    1bf0 <__lookup_slow+0xc0>
    1bf0:	48 c7 c3 fe ff ff ff 	mov    $0xfffffffffffffffe,%rbx
    1bf7:	eb cb                	jmp    1bc4 <__lookup_slow+0x94>
    1bf9:	a8 04                	test   $0x4,%al
    1bfb:	74 c7                	je     1bc4 <__lookup_slow+0x94>
    1bfd:	48 8b 43 60          	mov    0x60(%rbx),%rax
    1c01:	44 89 f1             	mov    %r14d,%ecx
    1c04:	48 89 da             	mov    %rbx,%rdx
    1c07:	4c 89 ee             	mov    %r13,%rsi
    1c0a:	4c 89 ff             	mov    %r15,%rdi
    1c0d:	48 8b 00             	mov    (%rax),%rax
    1c10:	e8 00 00 00 00       	call   1c15 <__lookup_slow+0xe5>
    1c15:	85 c0                	test   %eax,%eax
    1c17:	7f ab                	jg     1bc4 <__lookup_slow+0x94>
    1c19:	75 34                	jne    1c4f <__lookup_slow+0x11f>
    1c1b:	48 89 df             	mov    %rbx,%rdi
    1c1e:	e8 00 00 00 00       	call   1c23 <__lookup_slow+0xf3>
    1c23:	48 89 df             	mov    %rbx,%rdi
    1c26:	e8 00 00 00 00       	call   1c2b <__lookup_slow+0xfb>
    1c2b:	e9 4c ff ff ff       	jmp    1b7c <__lookup_slow+0x4c>
    1c30:	48 89 df             	mov    %rbx,%rdi
    1c33:	e8 00 00 00 00       	call   1c38 <__lookup_slow+0x108>
    1c38:	eb 85                	jmp    1bbf <__lookup_slow+0x8f>
    1c3a:	48 89 df             	mov    %rbx,%rdi
    1c3d:	4c 89 e3             	mov    %r12,%rbx
    1c40:	e8 00 00 00 00       	call   1c45 <__lookup_slow+0x115>
    1c45:	e9 7a ff ff ff       	jmp    1bc4 <__lookup_slow+0x94>
    1c4a:	e8 00 00 00 00       	call   1c4f <__lookup_slow+0x11f>
    1c4f:	48 89 df             	mov    %rbx,%rdi
    1c52:	89 45 b4             	mov    %eax,-0x4c(%rbp)
    1c55:	e8 00 00 00 00       	call   1c5a <__lookup_slow+0x12a>
    1c5a:	48 63 5d b4          	movslq -0x4c(%rbp),%rbx
    1c5e:	e9 61 ff ff ff       	jmp    1bc4 <__lookup_slow+0x94>
    1c63:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1c6a:	00 00 00 00 
    1c6e:	66 90                	xchg   %ax,%ax

0000000000001c70 <__pfx_lookup_noperm>:
    1c70:	90                   	nop
    1c71:	90                   	nop
    1c72:	90                   	nop
    1c73:	90                   	nop
    1c74:	90                   	nop
    1c75:	90                   	nop
    1c76:	90                   	nop
    1c77:	90                   	nop
    1c78:	90                   	nop
    1c79:	90                   	nop
    1c7a:	90                   	nop
    1c7b:	90                   	nop
    1c7c:	90                   	nop
    1c7d:	90                   	nop
    1c7e:	90                   	nop
    1c7f:	90                   	nop

0000000000001c80 <lookup_noperm>:
    1c80:	e8 00 00 00 00       	call   1c85 <lookup_noperm+0x5>
    1c85:	55                   	push   %rbp
    1c86:	48 89 e5             	mov    %rsp,%rbp
    1c89:	41 54                	push   %r12
    1c8b:	49 89 f4             	mov    %rsi,%r12
    1c8e:	53                   	push   %rbx
    1c8f:	48 8b 46 30          	mov    0x30(%rsi),%rax
    1c93:	48 89 fb             	mov    %rdi,%rbx
    1c96:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
    1c9d:	48 85 c0             	test   %rax,%rax
    1ca0:	74 41                	je     1ce3 <lookup_noperm+0x63>
    1ca2:	4c 89 e6             	mov    %r12,%rsi
    1ca5:	48 89 df             	mov    %rbx,%rdi
    1ca8:	e8 23 e4 ff ff       	call   d0 <lookup_noperm_common>
    1cad:	85 c0                	test   %eax,%eax
    1caf:	74 11                	je     1cc2 <lookup_noperm+0x42>
    1cb1:	48 98                	cltq
    1cb3:	5b                   	pop    %rbx
    1cb4:	41 5c                	pop    %r12
    1cb6:	5d                   	pop    %rbp
    1cb7:	31 d2                	xor    %edx,%edx
    1cb9:	31 f6                	xor    %esi,%esi
    1cbb:	31 ff                	xor    %edi,%edi
    1cbd:	e9 00 00 00 00       	jmp    1cc2 <lookup_noperm+0x42>
    1cc2:	31 d2                	xor    %edx,%edx
    1cc4:	4c 89 e6             	mov    %r12,%rsi
    1cc7:	48 89 df             	mov    %rbx,%rdi
    1cca:	e8 b1 fc ff ff       	call   1980 <lookup_dcache>
    1ccf:	48 85 c0             	test   %rax,%rax
    1cd2:	75 df                	jne    1cb3 <lookup_noperm+0x33>
    1cd4:	31 d2                	xor    %edx,%edx
    1cd6:	4c 89 e6             	mov    %r12,%rsi
    1cd9:	48 89 df             	mov    %rbx,%rdi
    1cdc:	e8 4f fe ff ff       	call   1b30 <__lookup_slow>
    1ce1:	eb d0                	jmp    1cb3 <lookup_noperm+0x33>
    1ce3:	0f 0b                	ud2
    1ce5:	eb bb                	jmp    1ca2 <lookup_noperm+0x22>
    1ce7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    1cee:	00 00 

0000000000001cf0 <__pfx_lookup_one>:
    1cf0:	90                   	nop
    1cf1:	90                   	nop
    1cf2:	90                   	nop
    1cf3:	90                   	nop
    1cf4:	90                   	nop
    1cf5:	90                   	nop
    1cf6:	90                   	nop
    1cf7:	90                   	nop
    1cf8:	90                   	nop
    1cf9:	90                   	nop
    1cfa:	90                   	nop
    1cfb:	90                   	nop
    1cfc:	90                   	nop
    1cfd:	90                   	nop
    1cfe:	90                   	nop
    1cff:	90                   	nop

0000000000001d00 <lookup_one>:
    1d00:	e8 00 00 00 00       	call   1d05 <lookup_one+0x5>
    1d05:	55                   	push   %rbp
    1d06:	48 89 e5             	mov    %rsp,%rbp
    1d09:	41 55                	push   %r13
    1d0b:	49 89 fd             	mov    %rdi,%r13
    1d0e:	41 54                	push   %r12
    1d10:	49 89 d4             	mov    %rdx,%r12
    1d13:	53                   	push   %rbx
    1d14:	48 8b 42 30          	mov    0x30(%rdx),%rax
    1d18:	48 89 f3             	mov    %rsi,%rbx
    1d1b:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
    1d22:	48 85 c0             	test   %rax,%rax
    1d25:	74 59                	je     1d80 <lookup_one+0x80>
    1d27:	4c 89 e6             	mov    %r12,%rsi
    1d2a:	48 89 df             	mov    %rbx,%rdi
    1d2d:	e8 9e e3 ff ff       	call   d0 <lookup_noperm_common>
    1d32:	85 c0                	test   %eax,%eax
    1d34:	78 37                	js     1d6d <lookup_one+0x6d>
    1d36:	49 8b 74 24 30       	mov    0x30(%r12),%rsi
    1d3b:	ba 01 00 00 00       	mov    $0x1,%edx
    1d40:	4c 89 ef             	mov    %r13,%rdi
    1d43:	e8 00 00 00 00       	call   1d48 <lookup_one+0x48>
    1d48:	85 c0                	test   %eax,%eax
    1d4a:	75 21                	jne    1d6d <lookup_one+0x6d>
    1d4c:	31 d2                	xor    %edx,%edx
    1d4e:	4c 89 e6             	mov    %r12,%rsi
    1d51:	48 89 df             	mov    %rbx,%rdi
    1d54:	e8 27 fc ff ff       	call   1980 <lookup_dcache>
    1d59:	48 85 c0             	test   %rax,%rax
    1d5c:	75 11                	jne    1d6f <lookup_one+0x6f>
    1d5e:	31 d2                	xor    %edx,%edx
    1d60:	4c 89 e6             	mov    %r12,%rsi
    1d63:	48 89 df             	mov    %rbx,%rdi
    1d66:	e8 c5 fd ff ff       	call   1b30 <__lookup_slow>
    1d6b:	eb 02                	jmp    1d6f <lookup_one+0x6f>
    1d6d:	48 98                	cltq
    1d6f:	5b                   	pop    %rbx
    1d70:	41 5c                	pop    %r12
    1d72:	41 5d                	pop    %r13
    1d74:	5d                   	pop    %rbp
    1d75:	31 d2                	xor    %edx,%edx
    1d77:	31 f6                	xor    %esi,%esi
    1d79:	31 ff                	xor    %edi,%edi
    1d7b:	e9 00 00 00 00       	jmp    1d80 <lookup_one+0x80>
    1d80:	0f 0b                	ud2
    1d82:	eb a3                	jmp    1d27 <lookup_one+0x27>
    1d84:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1d8b:	00 00 00 00 
    1d8f:	90                   	nop

0000000000001d90 <__pfx_lookup_one_unlocked>:
    1d90:	90                   	nop
    1d91:	90                   	nop
    1d92:	90                   	nop
    1d93:	90                   	nop
    1d94:	90                   	nop
    1d95:	90                   	nop
    1d96:	90                   	nop
    1d97:	90                   	nop
    1d98:	90                   	nop
    1d99:	90                   	nop
    1d9a:	90                   	nop
    1d9b:	90                   	nop
    1d9c:	90                   	nop
    1d9d:	90                   	nop
    1d9e:	90                   	nop
    1d9f:	90                   	nop

0000000000001da0 <lookup_one_unlocked>:
    1da0:	e8 00 00 00 00       	call   1da5 <lookup_one_unlocked+0x5>
    1da5:	55                   	push   %rbp
    1da6:	48 89 e5             	mov    %rsp,%rbp
    1da9:	41 55                	push   %r13
    1dab:	49 89 fd             	mov    %rdi,%r13
    1dae:	41 54                	push   %r12
    1db0:	49 89 f4             	mov    %rsi,%r12
    1db3:	48 89 d6             	mov    %rdx,%rsi
    1db6:	53                   	push   %rbx
    1db7:	4c 89 e7             	mov    %r12,%rdi
    1dba:	48 89 d3             	mov    %rdx,%rbx
    1dbd:	48 83 ec 08          	sub    $0x8,%rsp
    1dc1:	e8 0a e3 ff ff       	call   d0 <lookup_noperm_common>
    1dc6:	85 c0                	test   %eax,%eax
    1dc8:	78 59                	js     1e23 <lookup_one_unlocked+0x83>
    1dca:	48 8b 73 30          	mov    0x30(%rbx),%rsi
    1dce:	ba 01 00 00 00       	mov    $0x1,%edx
    1dd3:	4c 89 ef             	mov    %r13,%rdi
    1dd6:	e8 00 00 00 00       	call   1ddb <lookup_one_unlocked+0x3b>
    1ddb:	85 c0                	test   %eax,%eax
    1ddd:	75 44                	jne    1e23 <lookup_one_unlocked+0x83>
    1ddf:	31 d2                	xor    %edx,%edx
    1de1:	48 89 de             	mov    %rbx,%rsi
    1de4:	4c 89 e7             	mov    %r12,%rdi
    1de7:	e8 94 fb ff ff       	call   1980 <lookup_dcache>
    1dec:	48 85 c0             	test   %rax,%rax
    1def:	75 34                	jne    1e25 <lookup_one_unlocked+0x85>
    1df1:	48 8b 43 30          	mov    0x30(%rbx),%rax
    1df5:	4c 8d a8 98 00 00 00 	lea    0x98(%rax),%r13
    1dfc:	4c 89 ef             	mov    %r13,%rdi
    1dff:	e8 00 00 00 00       	call   1e04 <lookup_one_unlocked+0x64>
    1e04:	31 d2                	xor    %edx,%edx
    1e06:	48 89 de             	mov    %rbx,%rsi
    1e09:	4c 89 e7             	mov    %r12,%rdi
    1e0c:	e8 1f fd ff ff       	call   1b30 <__lookup_slow>
    1e11:	4c 89 ef             	mov    %r13,%rdi
    1e14:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1e18:	e8 00 00 00 00       	call   1e1d <lookup_one_unlocked+0x7d>
    1e1d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1e21:	eb 02                	jmp    1e25 <lookup_one_unlocked+0x85>
    1e23:	48 98                	cltq
    1e25:	48 83 c4 08          	add    $0x8,%rsp
    1e29:	5b                   	pop    %rbx
    1e2a:	41 5c                	pop    %r12
    1e2c:	41 5d                	pop    %r13
    1e2e:	5d                   	pop    %rbp
    1e2f:	31 d2                	xor    %edx,%edx
    1e31:	31 f6                	xor    %esi,%esi
    1e33:	31 ff                	xor    %edi,%edi
    1e35:	e9 00 00 00 00       	jmp    1e3a <lookup_one_unlocked+0x9a>
    1e3a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001e40 <__pfx_lookup_one_positive_unlocked>:
    1e40:	90                   	nop
    1e41:	90                   	nop
    1e42:	90                   	nop
    1e43:	90                   	nop
    1e44:	90                   	nop
    1e45:	90                   	nop
    1e46:	90                   	nop
    1e47:	90                   	nop
    1e48:	90                   	nop
    1e49:	90                   	nop
    1e4a:	90                   	nop
    1e4b:	90                   	nop
    1e4c:	90                   	nop
    1e4d:	90                   	nop
    1e4e:	90                   	nop
    1e4f:	90                   	nop

0000000000001e50 <lookup_one_positive_unlocked>:
    1e50:	e8 00 00 00 00       	call   1e55 <lookup_one_positive_unlocked+0x5>
    1e55:	55                   	push   %rbp
    1e56:	48 89 e5             	mov    %rsp,%rbp
    1e59:	e8 00 00 00 00       	call   1e5e <lookup_one_positive_unlocked+0xe>
    1e5e:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    1e64:	77 0a                	ja     1e70 <lookup_one_positive_unlocked+0x20>
    1e66:	8b 10                	mov    (%rax),%edx
    1e68:	81 e2 00 00 38 00    	and    $0x380000,%edx
    1e6e:	74 0c                	je     1e7c <lookup_one_positive_unlocked+0x2c>
    1e70:	5d                   	pop    %rbp
    1e71:	31 d2                	xor    %edx,%edx
    1e73:	31 f6                	xor    %esi,%esi
    1e75:	31 ff                	xor    %edi,%edi
    1e77:	e9 00 00 00 00       	jmp    1e7c <lookup_one_positive_unlocked+0x2c>
    1e7c:	48 89 c7             	mov    %rax,%rdi
    1e7f:	e8 00 00 00 00       	call   1e84 <lookup_one_positive_unlocked+0x34>
    1e84:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    1e8b:	5d                   	pop    %rbp
    1e8c:	31 d2                	xor    %edx,%edx
    1e8e:	31 f6                	xor    %esi,%esi
    1e90:	31 ff                	xor    %edi,%edi
    1e92:	e9 00 00 00 00       	jmp    1e97 <lookup_one_positive_unlocked+0x47>
    1e97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    1e9e:	00 00 

0000000000001ea0 <__pfx_lookup_noperm_unlocked>:
    1ea0:	90                   	nop
    1ea1:	90                   	nop
    1ea2:	90                   	nop
    1ea3:	90                   	nop
    1ea4:	90                   	nop
    1ea5:	90                   	nop
    1ea6:	90                   	nop
    1ea7:	90                   	nop
    1ea8:	90                   	nop
    1ea9:	90                   	nop
    1eaa:	90                   	nop
    1eab:	90                   	nop
    1eac:	90                   	nop
    1ead:	90                   	nop
    1eae:	90                   	nop
    1eaf:	90                   	nop

0000000000001eb0 <lookup_noperm_unlocked>:
    1eb0:	e8 00 00 00 00       	call   1eb5 <lookup_noperm_unlocked+0x5>
    1eb5:	55                   	push   %rbp
    1eb6:	48 89 e5             	mov    %rsp,%rbp
    1eb9:	41 55                	push   %r13
    1ebb:	41 54                	push   %r12
    1ebd:	49 89 fc             	mov    %rdi,%r12
    1ec0:	53                   	push   %rbx
    1ec1:	48 89 f3             	mov    %rsi,%rbx
    1ec4:	48 83 ec 08          	sub    $0x8,%rsp
    1ec8:	e8 03 e2 ff ff       	call   d0 <lookup_noperm_common>
    1ecd:	85 c0                	test   %eax,%eax
    1ecf:	74 17                	je     1ee8 <lookup_noperm_unlocked+0x38>
    1ed1:	48 98                	cltq
    1ed3:	48 83 c4 08          	add    $0x8,%rsp
    1ed7:	5b                   	pop    %rbx
    1ed8:	41 5c                	pop    %r12
    1eda:	41 5d                	pop    %r13
    1edc:	5d                   	pop    %rbp
    1edd:	31 d2                	xor    %edx,%edx
    1edf:	31 f6                	xor    %esi,%esi
    1ee1:	31 ff                	xor    %edi,%edi
    1ee3:	e9 00 00 00 00       	jmp    1ee8 <lookup_noperm_unlocked+0x38>
    1ee8:	31 d2                	xor    %edx,%edx
    1eea:	48 89 de             	mov    %rbx,%rsi
    1eed:	4c 89 e7             	mov    %r12,%rdi
    1ef0:	e8 8b fa ff ff       	call   1980 <lookup_dcache>
    1ef5:	48 85 c0             	test   %rax,%rax
    1ef8:	75 d9                	jne    1ed3 <lookup_noperm_unlocked+0x23>
    1efa:	48 8b 43 30          	mov    0x30(%rbx),%rax
    1efe:	4c 8d a8 98 00 00 00 	lea    0x98(%rax),%r13
    1f05:	4c 89 ef             	mov    %r13,%rdi
    1f08:	e8 00 00 00 00       	call   1f0d <lookup_noperm_unlocked+0x5d>
    1f0d:	31 d2                	xor    %edx,%edx
    1f0f:	48 89 de             	mov    %rbx,%rsi
    1f12:	4c 89 e7             	mov    %r12,%rdi
    1f15:	e8 16 fc ff ff       	call   1b30 <__lookup_slow>
    1f1a:	4c 89 ef             	mov    %r13,%rdi
    1f1d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1f21:	e8 00 00 00 00       	call   1f26 <lookup_noperm_unlocked+0x76>
    1f26:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1f2a:	eb a7                	jmp    1ed3 <lookup_noperm_unlocked+0x23>
    1f2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001f30 <__pfx_lookup_noperm_positive_unlocked>:
    1f30:	90                   	nop
    1f31:	90                   	nop
    1f32:	90                   	nop
    1f33:	90                   	nop
    1f34:	90                   	nop
    1f35:	90                   	nop
    1f36:	90                   	nop
    1f37:	90                   	nop
    1f38:	90                   	nop
    1f39:	90                   	nop
    1f3a:	90                   	nop
    1f3b:	90                   	nop
    1f3c:	90                   	nop
    1f3d:	90                   	nop
    1f3e:	90                   	nop
    1f3f:	90                   	nop

0000000000001f40 <lookup_noperm_positive_unlocked>:
    1f40:	e8 00 00 00 00       	call   1f45 <lookup_noperm_positive_unlocked+0x5>
    1f45:	55                   	push   %rbp
    1f46:	48 89 e5             	mov    %rsp,%rbp
    1f49:	e8 00 00 00 00       	call   1f4e <lookup_noperm_positive_unlocked+0xe>
    1f4e:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    1f54:	77 0a                	ja     1f60 <lookup_noperm_positive_unlocked+0x20>
    1f56:	8b 10                	mov    (%rax),%edx
    1f58:	81 e2 00 00 38 00    	and    $0x380000,%edx
    1f5e:	74 0c                	je     1f6c <lookup_noperm_positive_unlocked+0x2c>
    1f60:	5d                   	pop    %rbp
    1f61:	31 d2                	xor    %edx,%edx
    1f63:	31 f6                	xor    %esi,%esi
    1f65:	31 ff                	xor    %edi,%edi
    1f67:	e9 00 00 00 00       	jmp    1f6c <lookup_noperm_positive_unlocked+0x2c>
    1f6c:	48 89 c7             	mov    %rax,%rdi
    1f6f:	e8 00 00 00 00       	call   1f74 <lookup_noperm_positive_unlocked+0x34>
    1f74:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    1f7b:	5d                   	pop    %rbp
    1f7c:	31 d2                	xor    %edx,%edx
    1f7e:	31 f6                	xor    %esi,%esi
    1f80:	31 ff                	xor    %edi,%edi
    1f82:	e9 00 00 00 00       	jmp    1f87 <lookup_noperm_positive_unlocked+0x47>
    1f87:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    1f8e:	00 00 

0000000000001f90 <__pfx_may_open>:
    1f90:	90                   	nop
    1f91:	90                   	nop
    1f92:	90                   	nop
    1f93:	90                   	nop
    1f94:	90                   	nop
    1f95:	90                   	nop
    1f96:	90                   	nop
    1f97:	90                   	nop
    1f98:	90                   	nop
    1f99:	90                   	nop
    1f9a:	90                   	nop
    1f9b:	90                   	nop
    1f9c:	90                   	nop
    1f9d:	90                   	nop
    1f9e:	90                   	nop
    1f9f:	90                   	nop

0000000000001fa0 <may_open>:
    1fa0:	e8 00 00 00 00       	call   1fa5 <may_open+0x5>
    1fa5:	55                   	push   %rbp
    1fa6:	48 89 e5             	mov    %rsp,%rbp
    1fa9:	41 55                	push   %r13
    1fab:	41 54                	push   %r12
    1fad:	53                   	push   %rbx
    1fae:	48 83 ec 08          	sub    $0x8,%rsp
    1fb2:	48 8b 46 08          	mov    0x8(%rsi),%rax
    1fb6:	4c 8b 68 30          	mov    0x30(%rax),%r13
    1fba:	4d 85 ed             	test   %r13,%r13
    1fbd:	0f 84 59 01 00 00    	je     211c <may_open+0x17c>
    1fc3:	41 0f b7 45 00       	movzwl 0x0(%r13),%eax
    1fc8:	48 89 fb             	mov    %rdi,%rbx
    1fcb:	41 89 cc             	mov    %ecx,%r12d
    1fce:	66 25 00 f0          	and    $0xf000,%ax
    1fd2:	66 3d 00 60          	cmp    $0x6000,%ax
    1fd6:	74 79                	je     2051 <may_open+0xb1>
    1fd8:	76 49                	jbe    2023 <may_open+0x83>
    1fda:	66 3d 00 a0          	cmp    $0xa000,%ax
    1fde:	0f 84 1c 01 00 00    	je     2100 <may_open+0x160>
    1fe4:	66 3d 00 c0          	cmp    $0xc000,%ax
    1fe8:	74 7a                	je     2064 <may_open+0xc4>
    1fea:	66 3d 00 80          	cmp    $0x8000,%ax
    1fee:	75 49                	jne    2039 <may_open+0x99>
    1ff0:	f6 c2 01             	test   $0x1,%dl
    1ff3:	74 7b                	je     2070 <may_open+0xd0>
    1ff5:	48 89 f7             	mov    %rsi,%rdi
    1ff8:	89 55 e4             	mov    %edx,-0x1c(%rbp)
    1ffb:	e8 00 00 00 00       	call   2000 <may_open+0x60>
    2000:	8b 55 e4             	mov    -0x1c(%rbp),%edx
    2003:	84 c0                	test   %al,%al
    2005:	74 69                	je     2070 <may_open+0xd0>
    2007:	48 83 c4 08          	add    $0x8,%rsp
    200b:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
    2010:	5b                   	pop    %rbx
    2011:	41 5c                	pop    %r12
    2013:	41 5d                	pop    %r13
    2015:	5d                   	pop    %rbp
    2016:	31 d2                	xor    %edx,%edx
    2018:	31 c9                	xor    %ecx,%ecx
    201a:	31 f6                	xor    %esi,%esi
    201c:	31 ff                	xor    %edi,%edi
    201e:	e9 00 00 00 00       	jmp    2023 <may_open+0x83>
    2023:	66 3d 00 20          	cmp    $0x2000,%ax
    2027:	74 28                	je     2051 <may_open+0xb1>
    2029:	66 3d 00 40          	cmp    $0x4000,%ax
    202d:	0f 84 86 00 00 00    	je     20b9 <may_open+0x119>
    2033:	66 3d 00 10          	cmp    $0x1000,%ax
    2037:	74 2b                	je     2064 <may_open+0xc4>
    2039:	41 f6 45 0e 08       	testb  $0x8,0xe(%r13)
    203e:	75 30                	jne    2070 <may_open+0xd0>
    2040:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
    2047:	4c 89 ef             	mov    %r13,%rdi
    204a:	e8 00 00 00 00       	call   204f <may_open+0xaf>
    204f:	0f 0b                	ud2
    2051:	48 8b 06             	mov    (%rsi),%rax
    2054:	f6 40 10 02          	testb  $0x2,0x10(%rax)
    2058:	75 ad                	jne    2007 <may_open+0x67>
    205a:	48 8b 40 08          	mov    0x8(%rax),%rax
    205e:	f6 40 58 04          	testb  $0x4,0x58(%rax)
    2062:	75 a3                	jne    2007 <may_open+0x67>
    2064:	f6 c2 01             	test   $0x1,%dl
    2067:	75 9e                	jne    2007 <may_open+0x67>
    2069:	41 81 e4 ff fd ff ff 	and    $0xfffffdff,%r12d
    2070:	83 ca 20             	or     $0x20,%edx
    2073:	4c 89 ee             	mov    %r13,%rsi
    2076:	48 89 df             	mov    %rbx,%rdi
    2079:	e8 00 00 00 00       	call   207e <may_open+0xde>
    207e:	85 c0                	test   %eax,%eax
    2080:	75 20                	jne    20a2 <may_open+0x102>
    2082:	41 f6 45 0c 04       	testb  $0x4,0xc(%r13)
    2087:	74 0f                	je     2098 <may_open+0xf8>
    2089:	41 f6 c4 03          	test   $0x3,%r12b
    208d:	75 39                	jne    20c8 <may_open+0x128>
    208f:	41 f7 c4 00 02 00 00 	test   $0x200,%r12d
    2096:	75 39                	jne    20d1 <may_open+0x131>
    2098:	44 89 e0             	mov    %r12d,%eax
    209b:	25 00 00 04 00       	and    $0x40000,%eax
    20a0:	75 36                	jne    20d8 <may_open+0x138>
    20a2:	48 83 c4 08          	add    $0x8,%rsp
    20a6:	5b                   	pop    %rbx
    20a7:	41 5c                	pop    %r12
    20a9:	41 5d                	pop    %r13
    20ab:	5d                   	pop    %rbp
    20ac:	31 d2                	xor    %edx,%edx
    20ae:	31 c9                	xor    %ecx,%ecx
    20b0:	31 f6                	xor    %esi,%esi
    20b2:	31 ff                	xor    %edi,%edi
    20b4:	e9 00 00 00 00       	jmp    20b9 <may_open+0x119>
    20b9:	f6 c2 02             	test   $0x2,%dl
    20bc:	75 68                	jne    2126 <may_open+0x186>
    20be:	f6 c2 01             	test   $0x1,%dl
    20c1:	74 ad                	je     2070 <may_open+0xd0>
    20c3:	e9 3f ff ff ff       	jmp    2007 <may_open+0x67>
    20c8:	41 f7 c4 00 04 00 00 	test   $0x400,%r12d
    20cf:	75 be                	jne    208f <may_open+0xef>
    20d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    20d6:	eb ca                	jmp    20a2 <may_open+0x102>
    20d8:	4c 89 ee             	mov    %r13,%rsi
    20db:	48 89 df             	mov    %rbx,%rdi
    20de:	e8 00 00 00 00       	call   20e3 <may_open+0x143>
    20e3:	48 83 c4 08          	add    $0x8,%rsp
    20e7:	0f b6 c0             	movzbl %al,%eax
    20ea:	5b                   	pop    %rbx
    20eb:	83 e8 01             	sub    $0x1,%eax
    20ee:	41 5c                	pop    %r12
    20f0:	41 5d                	pop    %r13
    20f2:	5d                   	pop    %rbp
    20f3:	31 d2                	xor    %edx,%edx
    20f5:	31 c9                	xor    %ecx,%ecx
    20f7:	31 f6                	xor    %esi,%esi
    20f9:	31 ff                	xor    %edi,%edi
    20fb:	e9 00 00 00 00       	jmp    2100 <may_open+0x160>
    2100:	48 83 c4 08          	add    $0x8,%rsp
    2104:	b8 d8 ff ff ff       	mov    $0xffffffd8,%eax
    2109:	5b                   	pop    %rbx
    210a:	41 5c                	pop    %r12
    210c:	41 5d                	pop    %r13
    210e:	5d                   	pop    %rbp
    210f:	31 d2                	xor    %edx,%edx
    2111:	31 c9                	xor    %ecx,%ecx
    2113:	31 f6                	xor    %esi,%esi
    2115:	31 ff                	xor    %edi,%edi
    2117:	e9 00 00 00 00       	jmp    211c <may_open+0x17c>
    211c:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    2121:	e9 7c ff ff ff       	jmp    20a2 <may_open+0x102>
    2126:	b8 eb ff ff ff       	mov    $0xffffffeb,%eax
    212b:	e9 72 ff ff ff       	jmp    20a2 <may_open+0x102>

0000000000002130 <__pfx_done_path_create>:
    2130:	90                   	nop
    2131:	90                   	nop
    2132:	90                   	nop
    2133:	90                   	nop
    2134:	90                   	nop
    2135:	90                   	nop
    2136:	90                   	nop
    2137:	90                   	nop
    2138:	90                   	nop
    2139:	90                   	nop
    213a:	90                   	nop
    213b:	90                   	nop
    213c:	90                   	nop
    213d:	90                   	nop
    213e:	90                   	nop
    213f:	90                   	nop

0000000000002140 <done_path_create>:
    2140:	e8 00 00 00 00       	call   2145 <done_path_create+0x5>
    2145:	55                   	push   %rbp
    2146:	48 89 e5             	mov    %rsp,%rbp
    2149:	53                   	push   %rbx
    214a:	48 89 fb             	mov    %rdi,%rbx
    214d:	48 81 fe 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rsi
    2154:	77 08                	ja     215e <done_path_create+0x1e>
    2156:	48 89 f7             	mov    %rsi,%rdi
    2159:	e8 00 00 00 00       	call   215e <done_path_create+0x1e>
    215e:	48 8b 43 08          	mov    0x8(%rbx),%rax
    2162:	48 8b 78 30          	mov    0x30(%rax),%rdi
    2166:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    216d:	e8 00 00 00 00       	call   2172 <done_path_create+0x32>
    2172:	48 8b 3b             	mov    (%rbx),%rdi
    2175:	e8 00 00 00 00       	call   217a <done_path_create+0x3a>
    217a:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    217e:	e8 00 00 00 00       	call   2183 <done_path_create+0x43>
    2183:	48 8b 3b             	mov    (%rbx),%rdi
    2186:	e8 00 00 00 00       	call   218b <done_path_create+0x4b>
    218b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    218f:	c9                   	leave
    2190:	31 c0                	xor    %eax,%eax
    2192:	31 f6                	xor    %esi,%esi
    2194:	31 ff                	xor    %edi,%edi
    2196:	e9 00 00 00 00       	jmp    219b <done_path_create+0x5b>
    219b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000021a0 <__pfx_legitimize_links>:
    21a0:	90                   	nop
    21a1:	90                   	nop
    21a2:	90                   	nop
    21a3:	90                   	nop
    21a4:	90                   	nop
    21a5:	90                   	nop
    21a6:	90                   	nop
    21a7:	90                   	nop
    21a8:	90                   	nop
    21a9:	90                   	nop
    21aa:	90                   	nop
    21ab:	90                   	nop
    21ac:	90                   	nop
    21ad:	90                   	nop
    21ae:	90                   	nop
    21af:	90                   	nop

00000000000021b0 <legitimize_links>:
    21b0:	e8 00 00 00 00       	call   21b5 <legitimize_links+0x5>
    21b5:	55                   	push   %rbp
    21b6:	48 89 e5             	mov    %rsp,%rbp
    21b9:	41 56                	push   %r14
    21bb:	41 55                	push   %r13
    21bd:	49 89 fd             	mov    %rdi,%r13
    21c0:	41 54                	push   %r12
    21c2:	53                   	push   %rbx
    21c3:	8b 47 54             	mov    0x54(%rdi),%eax
    21c6:	f6 47 39 02          	testb  $0x2,0x39(%rdi)
    21ca:	0f 85 9f 00 00 00    	jne    226f <legitimize_links+0xbf>
    21d0:	31 db                	xor    %ebx,%ebx
    21d2:	85 c0                	test   %eax,%eax
    21d4:	75 08                	jne    21de <legitimize_links+0x2e>
    21d6:	eb 7f                	jmp    2257 <legitimize_links+0xa7>
    21d8:	41 3b 5d 54          	cmp    0x54(%r13),%ebx
    21dc:	73 79                	jae    2257 <legitimize_links+0xa7>
    21de:	48 63 c3             	movslq %ebx,%rax
    21e1:	41 8b 55 48          	mov    0x48(%r13),%edx
    21e5:	83 c3 01             	add    $0x1,%ebx
    21e8:	48 8d 3c 40          	lea    (%rax,%rax,2),%rdi
    21ec:	41 89 dc             	mov    %ebx,%r12d
    21ef:	48 c1 e7 04          	shl    $0x4,%rdi
    21f3:	49 03 7d 60          	add    0x60(%r13),%rdi
    21f7:	8b 77 28             	mov    0x28(%rdi),%esi
    21fa:	e8 11 e6 ff ff       	call   810 <__legitimize_path>
    21ff:	84 c0                	test   %al,%al
    2201:	75 d5                	jne    21d8 <legitimize_links+0x28>
    2203:	41 8b 45 54          	mov    0x54(%r13),%eax
    2207:	44 8d 70 ff          	lea    -0x1(%rax),%r14d
    220b:	85 c0                	test   %eax,%eax
    220d:	74 2f                	je     223e <legitimize_links+0x8e>
    220f:	49 63 c6             	movslq %r14d,%rax
    2212:	48 8d 1c 40          	lea    (%rax,%rax,2),%rbx
    2216:	48 c1 e3 04          	shl    $0x4,%rbx
    221a:	49 03 5d 60          	add    0x60(%r13),%rbx
    221e:	48 8b 43 10          	mov    0x10(%rbx),%rax
    2222:	48 85 c0             	test   %rax,%rax
    2225:	74 09                	je     2230 <legitimize_links+0x80>
    2227:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    222b:	e8 00 00 00 00       	call   2230 <legitimize_links+0x80>
    2230:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
    2237:	00 
    2238:	41 83 ee 01          	sub    $0x1,%r14d
    223c:	73 d1                	jae    220f <legitimize_links+0x5f>
    223e:	45 89 65 54          	mov    %r12d,0x54(%r13)
    2242:	31 c0                	xor    %eax,%eax
    2244:	5b                   	pop    %rbx
    2245:	41 5c                	pop    %r12
    2247:	41 5d                	pop    %r13
    2249:	41 5e                	pop    %r14
    224b:	5d                   	pop    %rbp
    224c:	31 d2                	xor    %edx,%edx
    224e:	31 f6                	xor    %esi,%esi
    2250:	31 ff                	xor    %edi,%edi
    2252:	e9 00 00 00 00       	jmp    2257 <legitimize_links+0xa7>
    2257:	5b                   	pop    %rbx
    2258:	b8 01 00 00 00       	mov    $0x1,%eax
    225d:	41 5c                	pop    %r12
    225f:	41 5d                	pop    %r13
    2261:	41 5e                	pop    %r14
    2263:	5d                   	pop    %rbp
    2264:	31 d2                	xor    %edx,%edx
    2266:	31 f6                	xor    %esi,%esi
    2268:	31 ff                	xor    %edi,%edi
    226a:	e9 00 00 00 00       	jmp    226f <legitimize_links+0xbf>
    226f:	44 8d 60 ff          	lea    -0x1(%rax),%r12d
    2273:	85 c0                	test   %eax,%eax
    2275:	74 2f                	je     22a6 <legitimize_links+0xf6>
    2277:	49 63 c4             	movslq %r12d,%rax
    227a:	48 8d 1c 40          	lea    (%rax,%rax,2),%rbx
    227e:	48 c1 e3 04          	shl    $0x4,%rbx
    2282:	49 03 5d 60          	add    0x60(%r13),%rbx
    2286:	48 8b 43 10          	mov    0x10(%rbx),%rax
    228a:	48 85 c0             	test   %rax,%rax
    228d:	74 09                	je     2298 <legitimize_links+0xe8>
    228f:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    2293:	e8 00 00 00 00       	call   2298 <legitimize_links+0xe8>
    2298:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
    229f:	00 
    22a0:	41 83 ec 01          	sub    $0x1,%r12d
    22a4:	73 d1                	jae    2277 <legitimize_links+0xc7>
    22a6:	45 31 e4             	xor    %r12d,%r12d
    22a9:	eb 93                	jmp    223e <legitimize_links+0x8e>
    22ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000022b0 <__pfx_try_to_unlazy_next>:
    22b0:	90                   	nop
    22b1:	90                   	nop
    22b2:	90                   	nop
    22b3:	90                   	nop
    22b4:	90                   	nop
    22b5:	90                   	nop
    22b6:	90                   	nop
    22b7:	90                   	nop
    22b8:	90                   	nop
    22b9:	90                   	nop
    22ba:	90                   	nop
    22bb:	90                   	nop
    22bc:	90                   	nop
    22bd:	90                   	nop
    22be:	90                   	nop
    22bf:	90                   	nop

00000000000022c0 <try_to_unlazy_next>:
    22c0:	e8 00 00 00 00       	call   22c5 <try_to_unlazy_next+0x5>
    22c5:	f6 47 39 01          	testb  $0x1,0x39(%rdi)
    22c9:	0f 84 11 01 00 00    	je     23e0 <try_to_unlazy_next+0x120>
    22cf:	55                   	push   %rbp
    22d0:	48 89 e5             	mov    %rsp,%rbp
    22d3:	41 55                	push   %r13
    22d5:	49 89 f5             	mov    %rsi,%r13
    22d8:	41 54                	push   %r12
    22da:	53                   	push   %rbx
    22db:	48 89 fb             	mov    %rdi,%rbx
    22de:	e8 cd fe ff ff       	call   21b0 <legitimize_links>
    22e3:	84 c0                	test   %al,%al
    22e5:	0f 84 9d 00 00 00    	je     2388 <try_to_unlazy_next+0xc8>
    22eb:	8b 73 48             	mov    0x48(%rbx),%esi
    22ee:	48 8b 3b             	mov    (%rbx),%rdi
    22f1:	e8 00 00 00 00       	call   22f6 <try_to_unlazy_next+0x36>
    22f6:	85 c0                	test   %eax,%eax
    22f8:	0f 85 88 00 00 00    	jne    2386 <try_to_unlazy_next+0xc6>
    22fe:	48 8b 43 08          	mov    0x8(%rbx),%rax
    2302:	48 8d b8 80 00 00 00 	lea    0x80(%rax),%rdi
    2309:	e8 00 00 00 00       	call   230e <try_to_unlazy_next+0x4e>
    230e:	84 c0                	test   %al,%al
    2310:	74 7d                	je     238f <try_to_unlazy_next+0xcf>
    2312:	49 8d bd 80 00 00 00 	lea    0x80(%r13),%rdi
    2319:	e8 00 00 00 00       	call   231e <try_to_unlazy_next+0x5e>
    231e:	41 89 c4             	mov    %eax,%r12d
    2321:	84 c0                	test   %al,%al
    2323:	74 72                	je     2397 <try_to_unlazy_next+0xd7>
    2325:	8b 53 44             	mov    0x44(%rbx),%edx
    2328:	41 8b 45 04          	mov    0x4(%r13),%eax
    232c:	39 c2                	cmp    %eax,%edx
    232e:	0f 85 8e 00 00 00    	jne    23c2 <try_to_unlazy_next+0x102>
    2334:	48 83 7b 20 00       	cmpq   $0x0,0x20(%rbx)
    2339:	74 23                	je     235e <try_to_unlazy_next+0x9e>
    233b:	8b 43 3c             	mov    0x3c(%rbx),%eax
    233e:	a8 01                	test   $0x1,%al
    2340:	75 1c                	jne    235e <try_to_unlazy_next+0x9e>
    2342:	83 c8 02             	or     $0x2,%eax
    2345:	8b 53 48             	mov    0x48(%rbx),%edx
    2348:	8b b3 e0 00 00 00    	mov    0xe0(%rbx),%esi
    234e:	48 8d 7b 20          	lea    0x20(%rbx),%rdi
    2352:	89 43 3c             	mov    %eax,0x3c(%rbx)
    2355:	e8 b6 e4 ff ff       	call   810 <__legitimize_path>
    235a:	84 c0                	test   %al,%al
    235c:	74 64                	je     23c2 <try_to_unlazy_next+0x102>
    235e:	81 63 38 ff fe ff ff 	andl   $0xfffffeff,0x38(%rbx)
    2365:	48 c7 43 40 00 00 00 	movq   $0x0,0x40(%rbx)
    236c:	00 
    236d:	e8 00 00 00 00       	call   2372 <try_to_unlazy_next+0xb2>
    2372:	44 89 e0             	mov    %r12d,%eax
    2375:	5b                   	pop    %rbx
    2376:	41 5c                	pop    %r12
    2378:	41 5d                	pop    %r13
    237a:	5d                   	pop    %rbp
    237b:	31 d2                	xor    %edx,%edx
    237d:	31 f6                	xor    %esi,%esi
    237f:	31 ff                	xor    %edi,%edi
    2381:	e9 00 00 00 00       	jmp    2386 <try_to_unlazy_next+0xc6>
    2386:	7e 07                	jle    238f <try_to_unlazy_next+0xcf>
    2388:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    238f:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    2396:	00 
    2397:	81 63 38 ff fe ff ff 	andl   $0xfffffeff,0x38(%rbx)
    239e:	48 c7 43 40 00 00 00 	movq   $0x0,0x40(%rbx)
    23a5:	00 
    23a6:	e8 00 00 00 00       	call   23ab <try_to_unlazy_next+0xeb>
    23ab:	45 31 e4             	xor    %r12d,%r12d
    23ae:	5b                   	pop    %rbx
    23af:	44 89 e0             	mov    %r12d,%eax
    23b2:	41 5c                	pop    %r12
    23b4:	41 5d                	pop    %r13
    23b6:	5d                   	pop    %rbp
    23b7:	31 d2                	xor    %edx,%edx
    23b9:	31 f6                	xor    %esi,%esi
    23bb:	31 ff                	xor    %edi,%edi
    23bd:	e9 00 00 00 00       	jmp    23c2 <try_to_unlazy_next+0x102>
    23c2:	81 63 38 ff fe ff ff 	andl   $0xfffffeff,0x38(%rbx)
    23c9:	48 c7 43 40 00 00 00 	movq   $0x0,0x40(%rbx)
    23d0:	00 
    23d1:	e8 00 00 00 00       	call   23d6 <try_to_unlazy_next+0x116>
    23d6:	4c 89 ef             	mov    %r13,%rdi
    23d9:	e8 00 00 00 00       	call   23de <try_to_unlazy_next+0x11e>
    23de:	eb cb                	jmp    23ab <try_to_unlazy_next+0xeb>
    23e0:	0f 0b                	ud2
    23e2:	90                   	nop
    23e3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    23ea:	00 00 00 00 
    23ee:	66 90                	xchg   %ax,%ax

00000000000023f0 <__pfx_try_to_unlazy>:
    23f0:	90                   	nop
    23f1:	90                   	nop
    23f2:	90                   	nop
    23f3:	90                   	nop
    23f4:	90                   	nop
    23f5:	90                   	nop
    23f6:	90                   	nop
    23f7:	90                   	nop
    23f8:	90                   	nop
    23f9:	90                   	nop
    23fa:	90                   	nop
    23fb:	90                   	nop
    23fc:	90                   	nop
    23fd:	90                   	nop
    23fe:	90                   	nop
    23ff:	90                   	nop

0000000000002400 <try_to_unlazy>:
    2400:	e8 00 00 00 00       	call   2405 <try_to_unlazy+0x5>
    2405:	55                   	push   %rbp
    2406:	48 89 e5             	mov    %rsp,%rbp
    2409:	41 55                	push   %r13
    240b:	41 54                	push   %r12
    240d:	53                   	push   %rbx
    240e:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    2412:	f6 47 39 01          	testb  $0x1,0x39(%rdi)
    2416:	0f 84 ac 00 00 00    	je     24c8 <try_to_unlazy+0xc8>
    241c:	48 89 fb             	mov    %rdi,%rbx
    241f:	e8 8c fd ff ff       	call   21b0 <legitimize_links>
    2424:	84 c0                	test   %al,%al
    2426:	0f 84 9e 00 00 00    	je     24ca <try_to_unlazy+0xca>
    242c:	8b 53 48             	mov    0x48(%rbx),%edx
    242f:	8b 73 40             	mov    0x40(%rbx),%esi
    2432:	48 89 df             	mov    %rbx,%rdi
    2435:	e8 d6 e3 ff ff       	call   810 <__legitimize_path>
    243a:	41 89 c4             	mov    %eax,%r12d
    243d:	84 c0                	test   %al,%al
    243f:	74 5c                	je     249d <try_to_unlazy+0x9d>
    2441:	48 83 7b 20 00       	cmpq   $0x0,0x20(%rbx)
    2446:	74 07                	je     244f <try_to_unlazy+0x4f>
    2448:	8b 43 3c             	mov    0x3c(%rbx),%eax
    244b:	a8 01                	test   $0x1,%al
    244d:	74 32                	je     2481 <try_to_unlazy+0x81>
    244f:	81 63 38 ff fe ff ff 	andl   $0xfffffeff,0x38(%rbx)
    2456:	48 c7 43 40 00 00 00 	movq   $0x0,0x40(%rbx)
    245d:	00 
    245e:	e8 00 00 00 00       	call   2463 <try_to_unlazy+0x63>
    2463:	49 8b 45 30          	mov    0x30(%r13),%rax
    2467:	48 39 43 30          	cmp    %rax,0x30(%rbx)
    246b:	75 6e                	jne    24db <try_to_unlazy+0xdb>
    246d:	5b                   	pop    %rbx
    246e:	44 89 e0             	mov    %r12d,%eax
    2471:	41 5c                	pop    %r12
    2473:	41 5d                	pop    %r13
    2475:	5d                   	pop    %rbp
    2476:	31 d2                	xor    %edx,%edx
    2478:	31 f6                	xor    %esi,%esi
    247a:	31 ff                	xor    %edi,%edi
    247c:	e9 00 00 00 00       	jmp    2481 <try_to_unlazy+0x81>
    2481:	83 c8 02             	or     $0x2,%eax
    2484:	8b 53 48             	mov    0x48(%rbx),%edx
    2487:	8b b3 e0 00 00 00    	mov    0xe0(%rbx),%esi
    248d:	48 8d 7b 20          	lea    0x20(%rbx),%rdi
    2491:	89 43 3c             	mov    %eax,0x3c(%rbx)
    2494:	e8 77 e3 ff ff       	call   810 <__legitimize_path>
    2499:	84 c0                	test   %al,%al
    249b:	75 b2                	jne    244f <try_to_unlazy+0x4f>
    249d:	81 63 38 ff fe ff ff 	andl   $0xfffffeff,0x38(%rbx)
    24a4:	45 31 e4             	xor    %r12d,%r12d
    24a7:	48 c7 43 40 00 00 00 	movq   $0x0,0x40(%rbx)
    24ae:	00 
    24af:	e8 00 00 00 00       	call   24b4 <try_to_unlazy+0xb4>
    24b4:	44 89 e0             	mov    %r12d,%eax
    24b7:	5b                   	pop    %rbx
    24b8:	41 5c                	pop    %r12
    24ba:	41 5d                	pop    %r13
    24bc:	5d                   	pop    %rbp
    24bd:	31 d2                	xor    %edx,%edx
    24bf:	31 f6                	xor    %esi,%esi
    24c1:	31 ff                	xor    %edi,%edi
    24c3:	e9 00 00 00 00       	jmp    24c8 <try_to_unlazy+0xc8>
    24c8:	0f 0b                	ud2
    24ca:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    24d1:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    24d8:	00 
    24d9:	eb c2                	jmp    249d <try_to_unlazy+0x9d>
    24db:	0f 0b                	ud2
    24dd:	90                   	nop
    24de:	66 90                	xchg   %ax,%ax

00000000000024e0 <__pfx_lookup_fast>:
    24e0:	90                   	nop
    24e1:	90                   	nop
    24e2:	90                   	nop
    24e3:	90                   	nop
    24e4:	90                   	nop
    24e5:	90                   	nop
    24e6:	90                   	nop
    24e7:	90                   	nop
    24e8:	90                   	nop
    24e9:	90                   	nop
    24ea:	90                   	nop
    24eb:	90                   	nop
    24ec:	90                   	nop
    24ed:	90                   	nop
    24ee:	90                   	nop
    24ef:	90                   	nop

00000000000024f0 <lookup_fast>:
    24f0:	e8 00 00 00 00       	call   24f5 <lookup_fast+0x5>
    24f5:	55                   	push   %rbp
    24f6:	48 89 e5             	mov    %rsp,%rbp
    24f9:	41 56                	push   %r14
    24fb:	4c 8d 77 10          	lea    0x10(%rdi),%r14
    24ff:	41 55                	push   %r13
    2501:	41 54                	push   %r12
    2503:	53                   	push   %rbx
    2504:	48 89 fb             	mov    %rdi,%rbx
    2507:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    250b:	f6 47 39 01          	testb  $0x1,0x39(%rdi)
    250f:	74 41                	je     2552 <lookup_fast+0x62>
    2511:	48 8d 57 44          	lea    0x44(%rdi),%rdx
    2515:	4c 89 f6             	mov    %r14,%rsi
    2518:	4c 89 ef             	mov    %r13,%rdi
    251b:	e8 00 00 00 00       	call   2520 <lookup_fast+0x30>
    2520:	49 89 c4             	mov    %rax,%r12
    2523:	48 85 c0             	test   %rax,%rax
    2526:	74 77                	je     259f <lookup_fast+0xaf>
    2528:	8b 53 40             	mov    0x40(%rbx),%edx
    252b:	41 8b 45 04          	mov    0x4(%r13),%eax
    252f:	39 c2                	cmp    %eax,%edx
    2531:	75 78                	jne    25ab <lookup_fast+0xbb>
    2533:	41 f6 04 24 04       	testb  $0x4,(%r12)
    2538:	75 7f                	jne    25b9 <lookup_fast+0xc9>
    253a:	5b                   	pop    %rbx
    253b:	4c 89 e0             	mov    %r12,%rax
    253e:	41 5c                	pop    %r12
    2540:	41 5d                	pop    %r13
    2542:	41 5e                	pop    %r14
    2544:	5d                   	pop    %rbp
    2545:	31 d2                	xor    %edx,%edx
    2547:	31 c9                	xor    %ecx,%ecx
    2549:	31 f6                	xor    %esi,%esi
    254b:	31 ff                	xor    %edi,%edi
    254d:	e9 00 00 00 00       	jmp    2552 <lookup_fast+0x62>
    2552:	4c 89 f6             	mov    %r14,%rsi
    2555:	4c 89 ef             	mov    %r13,%rdi
    2558:	e8 00 00 00 00       	call   255d <lookup_fast+0x6d>
    255d:	49 89 c4             	mov    %rax,%r12
    2560:	48 85 c0             	test   %rax,%rax
    2563:	74 4f                	je     25b4 <lookup_fast+0xc4>
    2565:	41 f6 04 24 04       	testb  $0x4,(%r12)
    256a:	74 ce                	je     253a <lookup_fast+0x4a>
    256c:	49 8b 44 24 60       	mov    0x60(%r12),%rax
    2571:	8b 4b 38             	mov    0x38(%rbx),%ecx
    2574:	4c 89 e2             	mov    %r12,%rdx
    2577:	4c 89 f6             	mov    %r14,%rsi
    257a:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    257e:	48 8b 00             	mov    (%rax),%rax
    2581:	e8 00 00 00 00       	call   2586 <lookup_fast+0x96>
    2586:	41 89 c5             	mov    %eax,%r13d
    2589:	85 c0                	test   %eax,%eax
    258b:	7f ad                	jg     253a <lookup_fast+0x4a>
    258d:	45 85 ed             	test   %r13d,%r13d
    2590:	74 66                	je     25f8 <lookup_fast+0x108>
    2592:	4c 89 e7             	mov    %r12,%rdi
    2595:	4d 63 e5             	movslq %r13d,%r12
    2598:	e8 00 00 00 00       	call   259d <lookup_fast+0xad>
    259d:	eb 9b                	jmp    253a <lookup_fast+0x4a>
    259f:	48 89 df             	mov    %rbx,%rdi
    25a2:	e8 59 fe ff ff       	call   2400 <try_to_unlazy>
    25a7:	84 c0                	test   %al,%al
    25a9:	75 09                	jne    25b4 <lookup_fast+0xc4>
    25ab:	49 c7 c4 f6 ff ff ff 	mov    $0xfffffffffffffff6,%r12
    25b2:	eb 86                	jmp    253a <lookup_fast+0x4a>
    25b4:	45 31 e4             	xor    %r12d,%r12d
    25b7:	eb 81                	jmp    253a <lookup_fast+0x4a>
    25b9:	49 8b 44 24 60       	mov    0x60(%r12),%rax
    25be:	8b 4b 38             	mov    0x38(%rbx),%ecx
    25c1:	4c 89 e2             	mov    %r12,%rdx
    25c4:	4c 89 f6             	mov    %r14,%rsi
    25c7:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    25cb:	48 8b 00             	mov    (%rax),%rax
    25ce:	e8 00 00 00 00       	call   25d3 <lookup_fast+0xe3>
    25d3:	41 89 c5             	mov    %eax,%r13d
    25d6:	85 c0                	test   %eax,%eax
    25d8:	0f 8f 5c ff ff ff    	jg     253a <lookup_fast+0x4a>
    25de:	4c 89 e6             	mov    %r12,%rsi
    25e1:	48 89 df             	mov    %rbx,%rdi
    25e4:	e8 d7 fc ff ff       	call   22c0 <try_to_unlazy_next>
    25e9:	84 c0                	test   %al,%al
    25eb:	74 be                	je     25ab <lookup_fast+0xbb>
    25ed:	41 83 fd f6          	cmp    $0xfffffff6,%r13d
    25f1:	75 9a                	jne    258d <lookup_fast+0x9d>
    25f3:	e9 6d ff ff ff       	jmp    2565 <lookup_fast+0x75>
    25f8:	4c 89 e7             	mov    %r12,%rdi
    25fb:	e8 00 00 00 00       	call   2600 <lookup_fast+0x110>
    2600:	eb 90                	jmp    2592 <lookup_fast+0xa2>
    2602:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    2609:	00 00 00 00 
    260d:	0f 1f 00             	nopl   (%rax)

0000000000002610 <__pfx_complete_walk>:
    2610:	90                   	nop
    2611:	90                   	nop
    2612:	90                   	nop
    2613:	90                   	nop
    2614:	90                   	nop
    2615:	90                   	nop
    2616:	90                   	nop
    2617:	90                   	nop
    2618:	90                   	nop
    2619:	90                   	nop
    261a:	90                   	nop
    261b:	90                   	nop
    261c:	90                   	nop
    261d:	90                   	nop
    261e:	90                   	nop
    261f:	90                   	nop

0000000000002620 <complete_walk>:
    2620:	e8 00 00 00 00       	call   2625 <complete_walk+0x5>
    2625:	55                   	push   %rbp
    2626:	48 89 e5             	mov    %rsp,%rbp
    2629:	41 54                	push   %r12
    262b:	53                   	push   %rbx
    262c:	8b 47 38             	mov    0x38(%rdi),%eax
    262f:	48 89 fb             	mov    %rdi,%rbx
    2632:	4c 8b 67 08          	mov    0x8(%rdi),%r12
    2636:	f6 c4 01             	test   $0x1,%ah
    2639:	74 2f                	je     266a <complete_walk+0x4a>
    263b:	8b 57 3c             	mov    0x3c(%rdi),%edx
    263e:	89 c1                	mov    %eax,%ecx
    2640:	81 e1 00 00 00 18    	and    $0x18000000,%ecx
    2646:	83 e2 01             	and    $0x1,%edx
    2649:	09 ca                	or     %ecx,%edx
    264b:	75 08                	jne    2655 <complete_walk+0x35>
    264d:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
    2654:	00 
    2655:	80 e4 fd             	and    $0xfd,%ah
    2658:	48 89 df             	mov    %rbx,%rdi
    265b:	89 43 38             	mov    %eax,0x38(%rbx)
    265e:	e8 9d fd ff ff       	call   2400 <try_to_unlazy>
    2663:	84 c0                	test   %al,%al
    2665:	74 66                	je     26cd <complete_walk+0xad>
    2667:	8b 43 38             	mov    0x38(%rbx),%eax
    266a:	a9 00 00 00 18       	test   $0x18000000,%eax
    266f:	75 45                	jne    26b6 <complete_walk+0x96>
    2671:	f6 43 3c 04          	testb  $0x4,0x3c(%rbx)
    2675:	75 13                	jne    268a <complete_walk+0x6a>
    2677:	31 c0                	xor    %eax,%eax
    2679:	5b                   	pop    %rbx
    267a:	41 5c                	pop    %r12
    267c:	5d                   	pop    %rbp
    267d:	31 d2                	xor    %edx,%edx
    267f:	31 c9                	xor    %ecx,%ecx
    2681:	31 f6                	xor    %esi,%esi
    2683:	31 ff                	xor    %edi,%edi
    2685:	e9 00 00 00 00       	jmp    268a <complete_walk+0x6a>
    268a:	41 f7 04 24 00 08 00 	testl  $0x800,(%r12)
    2691:	00 
    2692:	74 e3                	je     2677 <complete_walk+0x57>
    2694:	49 8b 44 24 60       	mov    0x60(%r12),%rax
    2699:	8b 73 38             	mov    0x38(%rbx),%esi
    269c:	4c 89 e7             	mov    %r12,%rdi
    269f:	48 8b 40 08          	mov    0x8(%rax),%rax
    26a3:	e8 00 00 00 00       	call   26a8 <complete_walk+0x88>
    26a8:	85 c0                	test   %eax,%eax
    26aa:	7f cb                	jg     2677 <complete_walk+0x57>
    26ac:	ba 8c ff ff ff       	mov    $0xffffff8c,%edx
    26b1:	0f 44 c2             	cmove  %edx,%eax
    26b4:	eb c3                	jmp    2679 <complete_walk+0x59>
    26b6:	48 8d 73 20          	lea    0x20(%rbx),%rsi
    26ba:	48 89 df             	mov    %rbx,%rdi
    26bd:	e8 00 00 00 00       	call   26c2 <complete_walk+0xa2>
    26c2:	84 c0                	test   %al,%al
    26c4:	75 ab                	jne    2671 <complete_walk+0x51>
    26c6:	b8 ee ff ff ff       	mov    $0xffffffee,%eax
    26cb:	eb ac                	jmp    2679 <complete_walk+0x59>
    26cd:	b8 f6 ff ff ff       	mov    $0xfffffff6,%eax
    26d2:	eb a5                	jmp    2679 <complete_walk+0x59>
    26d4:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    26db:	00 00 00 00 
    26df:	90                   	nop

00000000000026e0 <__pfx_fsnotify_move>:
    26e0:	90                   	nop
    26e1:	90                   	nop
    26e2:	90                   	nop
    26e3:	90                   	nop
    26e4:	90                   	nop
    26e5:	90                   	nop
    26e6:	90                   	nop
    26e7:	90                   	nop
    26e8:	90                   	nop
    26e9:	90                   	nop
    26ea:	90                   	nop
    26eb:	90                   	nop
    26ec:	90                   	nop
    26ed:	90                   	nop
    26ee:	90                   	nop
    26ef:	90                   	nop

00000000000026f0 <fsnotify_move>:
    26f0:	55                   	push   %rbp
    26f1:	48 89 e5             	mov    %rsp,%rbp
    26f4:	41 57                	push   %r15
    26f6:	49 89 f7             	mov    %rsi,%r15
    26f9:	41 56                	push   %r14
    26fb:	41 55                	push   %r13
    26fd:	41 89 cd             	mov    %ecx,%r13d
    2700:	41 54                	push   %r12
    2702:	53                   	push   %rbx
    2703:	4c 89 c3             	mov    %r8,%rbx
    2706:	48 83 ec 20          	sub    $0x20,%rsp
    270a:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    270e:	4d 8b 71 30          	mov    0x30(%r9),%r14
    2712:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
    2716:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
    271a:	e8 00 00 00 00       	call   271f <fsnotify_move+0x2f>
    271f:	41 83 fd 01          	cmp    $0x1,%r13d
    2723:	4c 8b 55 c8          	mov    -0x38(%rbp),%r10
    2727:	19 ff                	sbb    %edi,%edi
    2729:	41 89 c3             	mov    %eax,%r11d
    272c:	81 e7 00 00 00 c0    	and    $0xc0000000,%edi
    2732:	49 8b 42 28          	mov    0x28(%r10),%rax
    2736:	81 c7 00 00 00 50    	add    $0x50000000,%edi
    273c:	41 83 fd 01          	cmp    $0x1,%r13d
    2740:	45 19 e4             	sbb    %r12d,%r12d
    2743:	48 8b 90 c0 03 00 00 	mov    0x3c0(%rax),%rdx
    274a:	41 81 e4 00 00 00 c0 	and    $0xc0000000,%r12d
    2751:	41 81 c4 80 00 00 40 	add    $0x40000080,%r12d
    2758:	41 83 fd 01          	cmp    $0x1,%r13d
    275c:	45 19 ed             	sbb    %r13d,%r13d
    275f:	41 81 e5 00 00 00 c0 	and    $0xc0000000,%r13d
    2766:	41 81 c5 40 00 00 40 	add    $0x40000040,%r13d
    276d:	48 85 d2             	test   %rdx,%rdx
    2770:	74 0d                	je     277f <fsnotify_move+0x8f>
    2772:	48 8b 52 08          	mov    0x8(%rdx),%rdx
    2776:	48 85 d2             	test   %rdx,%rdx
    2779:	0f 85 65 01 00 00    	jne    28e4 <fsnotify_move+0x1f4>
    277f:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    2786:	48 85 c0             	test   %rax,%rax
    2789:	74 0d                	je     2798 <fsnotify_move+0xa8>
    278b:	48 8b 40 08          	mov    0x8(%rax),%rax
    278f:	48 85 c0             	test   %rax,%rax
    2792:	0f 85 22 01 00 00    	jne    28ba <fsnotify_move+0x1ca>
    2798:	49 8b 47 28          	mov    0x28(%r15),%rax
    279c:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    27a3:	48 85 c0             	test   %rax,%rax
    27a6:	74 0d                	je     27b5 <fsnotify_move+0xc5>
    27a8:	48 8b 40 08          	mov    0x8(%rax),%rax
    27ac:	48 85 c0             	test   %rax,%rax
    27af:	0f 85 df 00 00 00    	jne    2894 <fsnotify_move+0x1a4>
    27b5:	48 85 db             	test   %rbx,%rbx
    27b8:	74 49                	je     2803 <fsnotify_move+0x113>
    27ba:	48 8b 43 28          	mov    0x28(%rbx),%rax
    27be:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    27c5:	48 85 c0             	test   %rax,%rax
    27c8:	74 39                	je     2803 <fsnotify_move+0x113>
    27ca:	48 8b 40 08          	mov    0x8(%rax),%rax
    27ce:	48 85 c0             	test   %rax,%rax
    27d1:	74 30                	je     2803 <fsnotify_move+0x113>
    27d3:	0f b7 03             	movzwl (%rbx),%eax
    27d6:	bf 04 00 00 40       	mov    $0x40000004,%edi
    27db:	6a 00                	push   $0x0
    27dd:	49 89 d9             	mov    %rbx,%r9
    27e0:	ba 03 00 00 00       	mov    $0x3,%edx
    27e5:	48 89 de             	mov    %rbx,%rsi
    27e8:	66 25 00 f0          	and    $0xf000,%ax
    27ec:	66 3d 00 40          	cmp    $0x4000,%ax
    27f0:	b8 04 00 00 00       	mov    $0x4,%eax
    27f5:	0f 45 f8             	cmovne %eax,%edi
    27f8:	31 c9                	xor    %ecx,%ecx
    27fa:	45 31 c0             	xor    %r8d,%r8d
    27fd:	e8 00 00 00 00       	call   2802 <fsnotify_move+0x112>
    2802:	59                   	pop    %rcx
    2803:	49 8b 46 28          	mov    0x28(%r14),%rax
    2807:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    280e:	48 85 c0             	test   %rax,%rax
    2811:	74 3a                	je     284d <fsnotify_move+0x15d>
    2813:	48 8b 40 08          	mov    0x8(%rax),%rax
    2817:	48 85 c0             	test   %rax,%rax
    281a:	74 31                	je     284d <fsnotify_move+0x15d>
    281c:	41 0f b7 06          	movzwl (%r14),%eax
    2820:	bf 00 08 00 40       	mov    $0x40000800,%edi
    2825:	6a 00                	push   $0x0
    2827:	ba 03 00 00 00       	mov    $0x3,%edx
    282c:	4d 89 f1             	mov    %r14,%r9
    282f:	4c 89 f6             	mov    %r14,%rsi
    2832:	66 25 00 f0          	and    $0xf000,%ax
    2836:	66 3d 00 40          	cmp    $0x4000,%ax
    283a:	b8 00 08 00 00       	mov    $0x800,%eax
    283f:	0f 45 f8             	cmovne %eax,%edi
    2842:	45 31 c0             	xor    %r8d,%r8d
    2845:	31 c9                	xor    %ecx,%ecx
    2847:	e8 00 00 00 00       	call   284c <fsnotify_move+0x15c>
    284c:	5a                   	pop    %rdx
    284d:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 2855 <fsnotify_move+0x165>
    2854:	00 
    2855:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    285c:	48 85 c0             	test   %rax,%rax
    285f:	74 0a                	je     286b <fsnotify_move+0x17b>
    2861:	8b 00                	mov    (%rax),%eax
    2863:	85 c0                	test   %eax,%eax
    2865:	0f 84 aa 00 00 00    	je     2915 <fsnotify_move+0x225>
    286b:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    286f:	5b                   	pop    %rbx
    2870:	41 5c                	pop    %r12
    2872:	41 5d                	pop    %r13
    2874:	41 5e                	pop    %r14
    2876:	41 5f                	pop    %r15
    2878:	5d                   	pop    %rbp
    2879:	31 c0                	xor    %eax,%eax
    287b:	31 d2                	xor    %edx,%edx
    287d:	31 c9                	xor    %ecx,%ecx
    287f:	31 f6                	xor    %esi,%esi
    2881:	31 ff                	xor    %edi,%edi
    2883:	45 31 c0             	xor    %r8d,%r8d
    2886:	45 31 c9             	xor    %r9d,%r9d
    2889:	45 31 d2             	xor    %r10d,%r10d
    288c:	45 31 db             	xor    %r11d,%r11d
    288f:	e9 00 00 00 00       	jmp    2894 <fsnotify_move+0x1a4>
    2894:	41 53                	push   %r11
    2896:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    289a:	4c 89 f6             	mov    %r14,%rsi
    289d:	45 31 c9             	xor    %r9d,%r9d
    28a0:	4c 89 f9             	mov    %r15,%rcx
    28a3:	ba 03 00 00 00       	mov    $0x3,%edx
    28a8:	44 89 e7             	mov    %r12d,%edi
    28ab:	4c 8d 40 20          	lea    0x20(%rax),%r8
    28af:	e8 00 00 00 00       	call   28b4 <fsnotify_move+0x1c4>
    28b4:	5e                   	pop    %rsi
    28b5:	e9 fb fe ff ff       	jmp    27b5 <fsnotify_move+0xc5>
    28ba:	41 53                	push   %r11
    28bc:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
    28c0:	44 89 ef             	mov    %r13d,%edi
    28c3:	45 31 c9             	xor    %r9d,%r9d
    28c6:	4c 89 d1             	mov    %r10,%rcx
    28c9:	ba 03 00 00 00       	mov    $0x3,%edx
    28ce:	4c 89 f6             	mov    %r14,%rsi
    28d1:	44 89 5d c8          	mov    %r11d,-0x38(%rbp)
    28d5:	e8 00 00 00 00       	call   28da <fsnotify_move+0x1ea>
    28da:	44 8b 5d c8          	mov    -0x38(%rbp),%r11d
    28de:	5f                   	pop    %rdi
    28df:	e9 b4 fe ff ff       	jmp    2798 <fsnotify_move+0xa8>
    28e4:	44 89 5d bc          	mov    %r11d,-0x44(%rbp)
    28e8:	4c 89 d1             	mov    %r10,%rcx
    28eb:	45 31 c9             	xor    %r9d,%r9d
    28ee:	ba 04 00 00 00       	mov    $0x4,%edx
    28f3:	6a 00                	push   $0x0
    28f5:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
    28f9:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    28fd:	e8 00 00 00 00       	call   2902 <fsnotify_move+0x212>
    2902:	4c 8b 55 c8          	mov    -0x38(%rbp),%r10
    2906:	44 8b 5d bc          	mov    -0x44(%rbp),%r11d
    290a:	41 58                	pop    %r8
    290c:	49 8b 42 28          	mov    0x28(%r10),%rax
    2910:	e9 6a fe ff ff       	jmp    277f <fsnotify_move+0x8f>
    2915:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    2919:	4c 89 ff             	mov    %r15,%rdi
    291c:	ba 04 00 00 00       	mov    $0x4,%edx
    2921:	e8 00 00 00 00       	call   2926 <fsnotify_move+0x236>
    2926:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    292a:	5b                   	pop    %rbx
    292b:	41 5c                	pop    %r12
    292d:	41 5d                	pop    %r13
    292f:	41 5e                	pop    %r14
    2931:	41 5f                	pop    %r15
    2933:	5d                   	pop    %rbp
    2934:	31 c0                	xor    %eax,%eax
    2936:	31 d2                	xor    %edx,%edx
    2938:	31 c9                	xor    %ecx,%ecx
    293a:	31 f6                	xor    %esi,%esi
    293c:	31 ff                	xor    %edi,%edi
    293e:	45 31 c0             	xor    %r8d,%r8d
    2941:	45 31 c9             	xor    %r9d,%r9d
    2944:	45 31 d2             	xor    %r10d,%r10d
    2947:	45 31 db             	xor    %r11d,%r11d
    294a:	e9 00 00 00 00       	jmp    294f <fsnotify_move+0x25f>
    294f:	90                   	nop

0000000000002950 <__pfx_may_delete>:
    2950:	90                   	nop
    2951:	90                   	nop
    2952:	90                   	nop
    2953:	90                   	nop
    2954:	90                   	nop
    2955:	90                   	nop
    2956:	90                   	nop
    2957:	90                   	nop
    2958:	90                   	nop
    2959:	90                   	nop
    295a:	90                   	nop
    295b:	90                   	nop
    295c:	90                   	nop
    295d:	90                   	nop
    295e:	90                   	nop
    295f:	90                   	nop

0000000000002960 <may_delete>:
    2960:	e8 00 00 00 00       	call   2965 <may_delete+0x5>
    2965:	55                   	push   %rbp
    2966:	48 89 e5             	mov    %rsp,%rbp
    2969:	41 57                	push   %r15
    296b:	41 56                	push   %r14
    296d:	41 55                	push   %r13
    296f:	41 54                	push   %r12
    2971:	53                   	push   %rbx
    2972:	48 83 ec 08          	sub    $0x8,%rsp
    2976:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
    2979:	48 8b 5a 30          	mov    0x30(%rdx),%rbx
    297d:	f7 02 00 00 38 00    	testl  $0x380000,(%rdx)
    2983:	0f 84 ac 01 00 00    	je     2b35 <may_delete+0x1d5>
    2989:	48 85 db             	test   %rbx,%rbx
    298c:	0f 84 97 01 00 00    	je     2b29 <may_delete+0x1c9>
    2992:	48 8b 42 18          	mov    0x18(%rdx),%rax
    2996:	49 89 f5             	mov    %rsi,%r13
    2999:	49 89 d4             	mov    %rdx,%r12
    299c:	48 39 70 30          	cmp    %rsi,0x30(%rax)
    29a0:	0f 85 85 01 00 00    	jne    2b2b <may_delete+0x1cb>
    29a6:	48 8b 43 28          	mov    0x28(%rbx),%rax
    29aa:	8b 53 04             	mov    0x4(%rbx),%edx
    29ad:	49 89 fe             	mov    %rdi,%r14
    29b0:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    29b7:	e8 00 00 00 00       	call   29bc <may_delete+0x5c>
    29bc:	83 f8 ff             	cmp    $0xffffffff,%eax
    29bf:	0f 84 68 01 00 00    	je     2b2d <may_delete+0x1cd>
    29c5:	48 8b 43 28          	mov    0x28(%rbx),%rax
    29c9:	8b 53 08             	mov    0x8(%rbx),%edx
    29cc:	4c 89 f7             	mov    %r14,%rdi
    29cf:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    29d6:	e8 00 00 00 00       	call   29db <may_delete+0x7b>
    29db:	83 f8 ff             	cmp    $0xffffffff,%eax
    29de:	0f 84 49 01 00 00    	je     2b2d <may_delete+0x1cd>
    29e4:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 29ec <may_delete+0x8c>
    29eb:	00 
    29ec:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    29f3:	48 85 c0             	test   %rax,%rax
    29f6:	74 0a                	je     2a02 <may_delete+0xa2>
    29f8:	8b 00                	mov    (%rax),%eax
    29fa:	85 c0                	test   %eax,%eax
    29fc:	0f 84 dc 00 00 00    	je     2ade <may_delete+0x17e>
    2a02:	ba 03 00 00 00       	mov    $0x3,%edx
    2a07:	4c 89 ee             	mov    %r13,%rsi
    2a0a:	4c 89 f7             	mov    %r14,%rdi
    2a0d:	e8 00 00 00 00       	call   2a12 <may_delete+0xb2>
    2a12:	41 89 c7             	mov    %eax,%r15d
    2a15:	85 c0                	test   %eax,%eax
    2a17:	0f 85 a3 00 00 00    	jne    2ac0 <may_delete+0x160>
    2a1d:	41 f6 45 0c 04       	testb  $0x4,0xc(%r13)
    2a22:	0f 85 e1 00 00 00    	jne    2b09 <may_delete+0x1a9>
    2a28:	66 41 f7 45 00 00 02 	testw  $0x200,0x0(%r13)
    2a2f:	0f 85 be 00 00 00    	jne    2af3 <may_delete+0x193>
    2a35:	f7 43 0c 0c 01 00 00 	testl  $0x10c,0xc(%rbx)
    2a3c:	0f 85 c7 00 00 00    	jne    2b09 <may_delete+0x1a9>
    2a42:	48 8b 43 28          	mov    0x28(%rbx),%rax
    2a46:	8b 53 04             	mov    0x4(%rbx),%edx
    2a49:	4c 89 f7             	mov    %r14,%rdi
    2a4c:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    2a53:	e8 00 00 00 00       	call   2a58 <may_delete+0xf8>
    2a58:	83 f8 ff             	cmp    $0xffffffff,%eax
    2a5b:	0f 84 a8 00 00 00    	je     2b09 <may_delete+0x1a9>
    2a61:	48 8b 43 28          	mov    0x28(%rbx),%rax
    2a65:	8b 53 08             	mov    0x8(%rbx),%edx
    2a68:	4c 89 f7             	mov    %r14,%rdi
    2a6b:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    2a72:	e8 00 00 00 00       	call   2a77 <may_delete+0x117>
    2a77:	83 f8 ff             	cmp    $0xffffffff,%eax
    2a7a:	0f 84 89 00 00 00    	je     2b09 <may_delete+0x1a9>
    2a80:	41 8b 04 24          	mov    (%r12),%eax
    2a84:	89 c2                	mov    %eax,%edx
    2a86:	81 e2 00 00 30 00    	and    $0x300000,%edx
    2a8c:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
    2a90:	74 7f                	je     2b11 <may_delete+0x1b1>
    2a92:	81 fa 00 00 10 00    	cmp    $0x100000,%edx
    2a98:	0f 85 83 00 00 00    	jne    2b21 <may_delete+0x1c1>
    2a9e:	4d 39 64 24 18       	cmp    %r12,0x18(%r12)
    2aa3:	0f 84 94 00 00 00    	je     2b3d <may_delete+0x1dd>
    2aa9:	41 f6 45 0c 10       	testb  $0x10,0xc(%r13)
    2aae:	0f 85 81 00 00 00    	jne    2b35 <may_delete+0x1d5>
    2ab4:	f6 c4 10             	test   $0x10,%ah
    2ab7:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
    2abc:	44 0f 45 f8          	cmovne %eax,%r15d
    2ac0:	48 83 c4 08          	add    $0x8,%rsp
    2ac4:	44 89 f8             	mov    %r15d,%eax
    2ac7:	5b                   	pop    %rbx
    2ac8:	41 5c                	pop    %r12
    2aca:	41 5d                	pop    %r13
    2acc:	41 5e                	pop    %r14
    2ace:	41 5f                	pop    %r15
    2ad0:	5d                   	pop    %rbp
    2ad1:	31 d2                	xor    %edx,%edx
    2ad3:	31 c9                	xor    %ecx,%ecx
    2ad5:	31 f6                	xor    %esi,%esi
    2ad7:	31 ff                	xor    %edi,%edi
    2ad9:	e9 00 00 00 00       	jmp    2ade <may_delete+0x17e>
    2ade:	ba 03 00 00 00       	mov    $0x3,%edx
    2ae3:	4c 89 e6             	mov    %r12,%rsi
    2ae6:	4c 89 ef             	mov    %r13,%rdi
    2ae9:	e8 00 00 00 00       	call   2aee <may_delete+0x18e>
    2aee:	e9 0f ff ff ff       	jmp    2a02 <may_delete+0xa2>
    2af3:	48 89 da             	mov    %rbx,%rdx
    2af6:	4c 89 ee             	mov    %r13,%rsi
    2af9:	4c 89 f7             	mov    %r14,%rdi
    2afc:	e8 00 00 00 00       	call   2b01 <may_delete+0x1a1>
    2b01:	85 c0                	test   %eax,%eax
    2b03:	0f 84 2c ff ff ff    	je     2a35 <may_delete+0xd5>
    2b09:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
    2b0f:	eb af                	jmp    2ac0 <may_delete+0x160>
    2b11:	81 fa 00 00 10 00    	cmp    $0x100000,%edx
    2b17:	75 90                	jne    2aa9 <may_delete+0x149>
    2b19:	41 bf eb ff ff ff    	mov    $0xffffffeb,%r15d
    2b1f:	eb 9f                	jmp    2ac0 <may_delete+0x160>
    2b21:	41 bf ec ff ff ff    	mov    $0xffffffec,%r15d
    2b27:	eb 97                	jmp    2ac0 <may_delete+0x160>
    2b29:	0f 0b                	ud2
    2b2b:	0f 0b                	ud2
    2b2d:	41 bf b5 ff ff ff    	mov    $0xffffffb5,%r15d
    2b33:	eb 8b                	jmp    2ac0 <may_delete+0x160>
    2b35:	41 bf fe ff ff ff    	mov    $0xfffffffe,%r15d
    2b3b:	eb 83                	jmp    2ac0 <may_delete+0x160>
    2b3d:	41 bf f0 ff ff ff    	mov    $0xfffffff0,%r15d
    2b43:	e9 78 ff ff ff       	jmp    2ac0 <may_delete+0x160>
    2b48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    2b4f:	00 

0000000000002b50 <__pfx_set_root>:
    2b50:	90                   	nop
    2b51:	90                   	nop
    2b52:	90                   	nop
    2b53:	90                   	nop
    2b54:	90                   	nop
    2b55:	90                   	nop
    2b56:	90                   	nop
    2b57:	90                   	nop
    2b58:	90                   	nop
    2b59:	90                   	nop
    2b5a:	90                   	nop
    2b5b:	90                   	nop
    2b5c:	90                   	nop
    2b5d:	90                   	nop
    2b5e:	90                   	nop
    2b5f:	90                   	nop

0000000000002b60 <set_root>:
    2b60:	e8 00 00 00 00       	call   2b65 <set_root+0x5>
    2b65:	55                   	push   %rbp
    2b66:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 2b6e <set_root+0xe>
    2b6d:	00 
    2b6e:	48 89 e5             	mov    %rsp,%rbp
    2b71:	41 55                	push   %r13
    2b73:	41 54                	push   %r12
    2b75:	53                   	push   %rbx
    2b76:	4c 8b a0 f0 0c 00 00 	mov    0xcf0(%rax),%r12
    2b7d:	8b 47 38             	mov    0x38(%rdi),%eax
    2b80:	a9 00 00 00 18       	test   $0x18000000,%eax
    2b85:	0f 85 a0 00 00 00    	jne    2c2b <set_root+0xcb>
    2b8b:	48 89 fb             	mov    %rdi,%rbx
    2b8e:	f6 c4 01             	test   $0x1,%ah
    2b91:	74 51                	je     2be4 <set_root+0x84>
    2b93:	41 8b 4c 24 04       	mov    0x4(%r12),%ecx
    2b98:	f6 c1 01             	test   $0x1,%cl
    2b9b:	0f 85 a2 00 00 00    	jne    2c43 <set_root+0xe3>
    2ba1:	49 8b 44 24 18       	mov    0x18(%r12),%rax
    2ba6:	49 8b 54 24 20       	mov    0x20(%r12),%rdx
    2bab:	48 89 43 20          	mov    %rax,0x20(%rbx)
    2baf:	48 89 53 28          	mov    %rdx,0x28(%rbx)
    2bb3:	48 8b 43 28          	mov    0x28(%rbx),%rax
    2bb7:	8b 40 04             	mov    0x4(%rax),%eax
    2bba:	a8 01                	test   $0x1,%al
    2bbc:	0f 85 88 00 00 00    	jne    2c4a <set_root+0xea>
    2bc2:	89 83 e0 00 00 00    	mov    %eax,0xe0(%rbx)
    2bc8:	41 8b 44 24 04       	mov    0x4(%r12),%eax
    2bcd:	39 c8                	cmp    %ecx,%eax
    2bcf:	75 c2                	jne    2b93 <set_root+0x33>
    2bd1:	5b                   	pop    %rbx
    2bd2:	31 c0                	xor    %eax,%eax
    2bd4:	41 5c                	pop    %r12
    2bd6:	41 5d                	pop    %r13
    2bd8:	5d                   	pop    %rbp
    2bd9:	31 d2                	xor    %edx,%edx
    2bdb:	31 c9                	xor    %ecx,%ecx
    2bdd:	31 ff                	xor    %edi,%edi
    2bdf:	e9 00 00 00 00       	jmp    2be4 <set_root+0x84>
    2be4:	4d 8d 6c 24 08       	lea    0x8(%r12),%r13
    2be9:	4c 89 ef             	mov    %r13,%rdi
    2bec:	e8 00 00 00 00       	call   2bf1 <set_root+0x91>
    2bf1:	49 8b 44 24 18       	mov    0x18(%r12),%rax
    2bf6:	49 8b 54 24 20       	mov    0x20(%r12),%rdx
    2bfb:	48 89 43 20          	mov    %rax,0x20(%rbx)
    2bff:	48 89 c7             	mov    %rax,%rdi
    2c02:	48 89 53 28          	mov    %rdx,0x28(%rbx)
    2c06:	e8 00 00 00 00       	call   2c0b <set_root+0xab>
    2c0b:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    2c0f:	48 85 ff             	test   %rdi,%rdi
    2c12:	74 09                	je     2c1d <set_root+0xbd>
    2c14:	48 83 ef 80          	sub    $0xffffffffffffff80,%rdi
    2c18:	e8 00 00 00 00       	call   2c1d <set_root+0xbd>
    2c1d:	4c 89 ef             	mov    %r13,%rdi
    2c20:	e8 00 00 00 00       	call   2c25 <set_root+0xc5>
    2c25:	83 4b 3c 02          	orl    $0x2,0x3c(%rbx)
    2c29:	eb a6                	jmp    2bd1 <set_root+0x71>
    2c2b:	0f 0b                	ud2
    2c2d:	b8 7d ff ff ff       	mov    $0xffffff7d,%eax
    2c32:	5b                   	pop    %rbx
    2c33:	41 5c                	pop    %r12
    2c35:	41 5d                	pop    %r13
    2c37:	5d                   	pop    %rbp
    2c38:	31 d2                	xor    %edx,%edx
    2c3a:	31 c9                	xor    %ecx,%ecx
    2c3c:	31 ff                	xor    %edi,%edi
    2c3e:	e9 00 00 00 00       	jmp    2c43 <set_root+0xe3>
    2c43:	f3 90                	pause
    2c45:	e9 49 ff ff ff       	jmp    2b93 <set_root+0x33>
    2c4a:	f3 90                	pause
    2c4c:	e9 62 ff ff ff       	jmp    2bb3 <set_root+0x53>
    2c51:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    2c58:	00 00 00 00 
    2c5c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002c60 <__pfx_vfs_rmdir>:
    2c60:	90                   	nop
    2c61:	90                   	nop
    2c62:	90                   	nop
    2c63:	90                   	nop
    2c64:	90                   	nop
    2c65:	90                   	nop
    2c66:	90                   	nop
    2c67:	90                   	nop
    2c68:	90                   	nop
    2c69:	90                   	nop
    2c6a:	90                   	nop
    2c6b:	90                   	nop
    2c6c:	90                   	nop
    2c6d:	90                   	nop
    2c6e:	90                   	nop
    2c6f:	90                   	nop

0000000000002c70 <vfs_rmdir>:
    2c70:	e8 00 00 00 00       	call   2c75 <vfs_rmdir+0x5>
    2c75:	55                   	push   %rbp
    2c76:	b9 01 00 00 00       	mov    $0x1,%ecx
    2c7b:	48 89 e5             	mov    %rsp,%rbp
    2c7e:	41 56                	push   %r14
    2c80:	41 55                	push   %r13
    2c82:	49 89 f5             	mov    %rsi,%r13
    2c85:	41 54                	push   %r12
    2c87:	53                   	push   %rbx
    2c88:	48 89 d3             	mov    %rdx,%rbx
    2c8b:	e8 d0 fc ff ff       	call   2960 <may_delete>
    2c90:	41 89 c4             	mov    %eax,%r12d
    2c93:	85 c0                	test   %eax,%eax
    2c95:	0f 85 37 01 00 00    	jne    2dd2 <vfs_rmdir+0x162>
    2c9b:	49 8b 45 20          	mov    0x20(%r13),%rax
    2c9f:	48 83 78 50 00       	cmpq   $0x0,0x50(%rax)
    2ca4:	0f 84 f7 01 00 00    	je     2ea1 <vfs_rmdir+0x231>
    2caa:	48 85 db             	test   %rbx,%rbx
    2cad:	74 0c                	je     2cbb <vfs_rmdir+0x4b>
    2caf:	48 8d bb 80 00 00 00 	lea    0x80(%rbx),%rdi
    2cb6:	e8 00 00 00 00       	call   2cbb <vfs_rmdir+0x4b>
    2cbb:	48 8b 43 30          	mov    0x30(%rbx),%rax
    2cbf:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    2cc6:	e8 00 00 00 00       	call   2ccb <vfs_rmdir+0x5b>
    2ccb:	f7 03 00 80 00 00    	testl  $0x8000,(%rbx)
    2cd1:	0f 85 1d 01 00 00    	jne    2df4 <vfs_rmdir+0x184>
    2cd7:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    2cdb:	f6 47 0e 02          	testb  $0x2,0xe(%rdi)
    2cdf:	0f 85 5f 01 00 00    	jne    2e44 <vfs_rmdir+0x1d4>
    2ce5:	48 89 de             	mov    %rbx,%rsi
    2ce8:	4c 89 ef             	mov    %r13,%rdi
    2ceb:	e8 00 00 00 00       	call   2cf0 <vfs_rmdir+0x80>
    2cf0:	41 89 c4             	mov    %eax,%r12d
    2cf3:	85 c0                	test   %eax,%eax
    2cf5:	0f 85 5f 01 00 00    	jne    2e5a <vfs_rmdir+0x1ea>
    2cfb:	49 8b 45 20          	mov    0x20(%r13),%rax
    2cff:	48 89 de             	mov    %rbx,%rsi
    2d02:	4c 89 ef             	mov    %r13,%rdi
    2d05:	48 8b 40 50          	mov    0x50(%rax),%rax
    2d09:	e8 00 00 00 00       	call   2d0e <vfs_rmdir+0x9e>
    2d0e:	41 89 c4             	mov    %eax,%r12d
    2d11:	85 c0                	test   %eax,%eax
    2d13:	0f 85 41 01 00 00    	jne    2e5a <vfs_rmdir+0x1ea>
    2d19:	48 89 df             	mov    %rbx,%rdi
    2d1c:	4c 8d b3 80 00 00 00 	lea    0x80(%rbx),%r14
    2d23:	e8 00 00 00 00       	call   2d28 <vfs_rmdir+0xb8>
    2d28:	48 8b 43 30          	mov    0x30(%rbx),%rax
    2d2c:	4c 89 f7             	mov    %r14,%rdi
    2d2f:	83 48 0c 10          	orl    $0x10,0xc(%rax)
    2d33:	e8 00 00 00 00       	call   2d38 <vfs_rmdir+0xc8>
    2d38:	81 0b 00 01 00 00    	orl    $0x100,(%rbx)
    2d3e:	4c 89 f7             	mov    %r14,%rdi
    2d41:	e8 00 00 00 00       	call   2d46 <vfs_rmdir+0xd6>
    2d46:	f7 03 00 80 00 00    	testl  $0x8000,(%rbx)
    2d4c:	0f 85 42 01 00 00    	jne    2e94 <vfs_rmdir+0x224>
    2d52:	48 8b 43 30          	mov    0x30(%rbx),%rax
    2d56:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    2d5d:	e8 00 00 00 00       	call   2d62 <vfs_rmdir+0xf2>
    2d62:	48 89 df             	mov    %rbx,%rdi
    2d65:	e8 00 00 00 00       	call   2d6a <vfs_rmdir+0xfa>
    2d6a:	4c 8b 73 30          	mov    0x30(%rbx),%r14
    2d6e:	4c 89 f7             	mov    %r14,%rdi
    2d71:	e8 00 00 00 00       	call   2d76 <vfs_rmdir+0x106>
    2d76:	48 89 df             	mov    %rbx,%rdi
    2d79:	e8 00 00 00 00       	call   2d7e <vfs_rmdir+0x10e>
    2d7e:	41 0f b7 06          	movzwl (%r14),%eax
    2d82:	bf 00 02 00 40       	mov    $0x40000200,%edi
    2d87:	66 25 00 f0          	and    $0xf000,%ax
    2d8b:	66 3d 00 40          	cmp    $0x4000,%ax
    2d8f:	b8 00 02 00 00       	mov    $0x200,%eax
    2d94:	0f 45 f8             	cmovne %eax,%edi
    2d97:	49 8b 45 28          	mov    0x28(%r13),%rax
    2d9b:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    2da2:	48 85 c0             	test   %rax,%rax
    2da5:	74 23                	je     2dca <vfs_rmdir+0x15a>
    2da7:	48 8b 40 08          	mov    0x8(%rax),%rax
    2dab:	48 85 c0             	test   %rax,%rax
    2dae:	74 1a                	je     2dca <vfs_rmdir+0x15a>
    2db0:	6a 00                	push   $0x0
    2db2:	45 31 c9             	xor    %r9d,%r9d
    2db5:	4c 8d 43 20          	lea    0x20(%rbx),%r8
    2db9:	4c 89 e9             	mov    %r13,%rcx
    2dbc:	ba 03 00 00 00       	mov    $0x3,%edx
    2dc1:	4c 89 f6             	mov    %r14,%rsi
    2dc4:	e8 00 00 00 00       	call   2dc9 <vfs_rmdir+0x159>
    2dc9:	58                   	pop    %rax
    2dca:	4c 89 f7             	mov    %r14,%rdi
    2dcd:	e8 00 00 00 00       	call   2dd2 <vfs_rmdir+0x162>
    2dd2:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
    2dd6:	44 89 e0             	mov    %r12d,%eax
    2dd9:	5b                   	pop    %rbx
    2dda:	41 5c                	pop    %r12
    2ddc:	41 5d                	pop    %r13
    2dde:	41 5e                	pop    %r14
    2de0:	5d                   	pop    %rbp
    2de1:	31 d2                	xor    %edx,%edx
    2de3:	31 c9                	xor    %ecx,%ecx
    2de5:	31 f6                	xor    %esi,%esi
    2de7:	31 ff                	xor    %edi,%edi
    2de9:	45 31 c0             	xor    %r8d,%r8d
    2dec:	45 31 c9             	xor    %r9d,%r9d
    2def:	e9 00 00 00 00       	jmp    2df4 <vfs_rmdir+0x184>
    2df4:	48 89 df             	mov    %rbx,%rdi
    2df7:	e8 00 00 00 00       	call   2dfc <vfs_rmdir+0x18c>
    2dfc:	84 c0                	test   %al,%al
    2dfe:	0f 84 d3 fe ff ff    	je     2cd7 <vfs_rmdir+0x67>
    2e04:	48 8b 43 30          	mov    0x30(%rbx),%rax
    2e08:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    2e0f:	e8 00 00 00 00       	call   2e14 <vfs_rmdir+0x1a4>
    2e14:	48 89 df             	mov    %rbx,%rdi
    2e17:	e8 00 00 00 00       	call   2e1c <vfs_rmdir+0x1ac>
    2e1c:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
    2e20:	41 bc f0 ff ff ff    	mov    $0xfffffff0,%r12d
    2e26:	5b                   	pop    %rbx
    2e27:	44 89 e0             	mov    %r12d,%eax
    2e2a:	41 5c                	pop    %r12
    2e2c:	41 5d                	pop    %r13
    2e2e:	41 5e                	pop    %r14
    2e30:	5d                   	pop    %rbp
    2e31:	31 d2                	xor    %edx,%edx
    2e33:	31 c9                	xor    %ecx,%ecx
    2e35:	31 f6                	xor    %esi,%esi
    2e37:	31 ff                	xor    %edi,%edi
    2e39:	45 31 c0             	xor    %r8d,%r8d
    2e3c:	45 31 c9             	xor    %r9d,%r9d
    2e3f:	e9 00 00 00 00       	jmp    2e44 <vfs_rmdir+0x1d4>
    2e44:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    2e4b:	e8 00 00 00 00       	call   2e50 <vfs_rmdir+0x1e0>
    2e50:	48 89 df             	mov    %rbx,%rdi
    2e53:	e8 00 00 00 00       	call   2e58 <vfs_rmdir+0x1e8>
    2e58:	eb c2                	jmp    2e1c <vfs_rmdir+0x1ac>
    2e5a:	48 8b 43 30          	mov    0x30(%rbx),%rax
    2e5e:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    2e65:	e8 00 00 00 00       	call   2e6a <vfs_rmdir+0x1fa>
    2e6a:	48 89 df             	mov    %rbx,%rdi
    2e6d:	e8 00 00 00 00       	call   2e72 <vfs_rmdir+0x202>
    2e72:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
    2e76:	44 89 e0             	mov    %r12d,%eax
    2e79:	5b                   	pop    %rbx
    2e7a:	41 5c                	pop    %r12
    2e7c:	41 5d                	pop    %r13
    2e7e:	41 5e                	pop    %r14
    2e80:	5d                   	pop    %rbp
    2e81:	31 d2                	xor    %edx,%edx
    2e83:	31 c9                	xor    %ecx,%ecx
    2e85:	31 f6                	xor    %esi,%esi
    2e87:	31 ff                	xor    %edi,%edi
    2e89:	45 31 c0             	xor    %r8d,%r8d
    2e8c:	45 31 c9             	xor    %r9d,%r9d
    2e8f:	e9 00 00 00 00       	jmp    2e94 <vfs_rmdir+0x224>
    2e94:	48 89 df             	mov    %rbx,%rdi
    2e97:	e8 00 00 00 00       	call   2e9c <vfs_rmdir+0x22c>
    2e9c:	e9 b1 fe ff ff       	jmp    2d52 <vfs_rmdir+0xe2>
    2ea1:	41 bc ff ff ff ff    	mov    $0xffffffff,%r12d
    2ea7:	e9 26 ff ff ff       	jmp    2dd2 <vfs_rmdir+0x162>
    2eac:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002eb0 <__pfx_nd_jump_root>:
    2eb0:	90                   	nop
    2eb1:	90                   	nop
    2eb2:	90                   	nop
    2eb3:	90                   	nop
    2eb4:	90                   	nop
    2eb5:	90                   	nop
    2eb6:	90                   	nop
    2eb7:	90                   	nop
    2eb8:	90                   	nop
    2eb9:	90                   	nop
    2eba:	90                   	nop
    2ebb:	90                   	nop
    2ebc:	90                   	nop
    2ebd:	90                   	nop
    2ebe:	90                   	nop
    2ebf:	90                   	nop

0000000000002ec0 <nd_jump_root>:
    2ec0:	e8 00 00 00 00       	call   2ec5 <nd_jump_root+0x5>
    2ec5:	8b 47 38             	mov    0x38(%rdi),%eax
    2ec8:	a9 00 00 00 08       	test   $0x8000000,%eax
    2ecd:	0f 85 c6 00 00 00    	jne    2f99 <nd_jump_root+0xd9>
    2ed3:	55                   	push   %rbp
    2ed4:	48 89 e5             	mov    %rsp,%rbp
    2ed7:	53                   	push   %rbx
    2ed8:	48 8b 57 20          	mov    0x20(%rdi),%rdx
    2edc:	48 89 fb             	mov    %rdi,%rbx
    2edf:	a9 00 00 00 04       	test   $0x4000000,%eax
    2ee4:	0f 85 bf 00 00 00    	jne    2fa9 <nd_jump_root+0xe9>
    2eea:	48 85 d2             	test   %rdx,%rdx
    2eed:	0f 84 92 00 00 00    	je     2f85 <nd_jump_root+0xc5>
    2ef3:	f6 c4 01             	test   $0x1,%ah
    2ef6:	74 45                	je     2f3d <nd_jump_root+0x7d>
    2ef8:	48 8b 53 28          	mov    0x28(%rbx),%rdx
    2efc:	48 8b 43 20          	mov    0x20(%rbx),%rax
    2f00:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    2f04:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    2f08:	48 89 03             	mov    %rax,(%rbx)
    2f0b:	48 8b 42 30          	mov    0x30(%rdx),%rax
    2f0f:	48 89 43 30          	mov    %rax,0x30(%rbx)
    2f13:	8b 83 e0 00 00 00    	mov    0xe0(%rbx),%eax
    2f19:	89 43 40             	mov    %eax,0x40(%rbx)
    2f1c:	8b 52 04             	mov    0x4(%rdx),%edx
    2f1f:	39 d0                	cmp    %edx,%eax
    2f21:	0f 85 a1 00 00 00    	jne    2fc8 <nd_jump_root+0x108>
    2f27:	83 4b 3c 04          	orl    $0x4,0x3c(%rbx)
    2f2b:	31 c0                	xor    %eax,%eax
    2f2d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    2f31:	c9                   	leave
    2f32:	31 d2                	xor    %edx,%edx
    2f34:	31 c9                	xor    %ecx,%ecx
    2f36:	31 ff                	xor    %edi,%edi
    2f38:	e9 00 00 00 00       	jmp    2f3d <nd_jump_root+0x7d>
    2f3d:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    2f41:	e8 00 00 00 00       	call   2f46 <nd_jump_root+0x86>
    2f46:	48 8b 3b             	mov    (%rbx),%rdi
    2f49:	e8 00 00 00 00       	call   2f4e <nd_jump_root+0x8e>
    2f4e:	48 8b 43 20          	mov    0x20(%rbx),%rax
    2f52:	48 8b 53 28          	mov    0x28(%rbx),%rdx
    2f56:	48 89 03             	mov    %rax,(%rbx)
    2f59:	48 89 c7             	mov    %rax,%rdi
    2f5c:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    2f60:	e8 00 00 00 00       	call   2f65 <nd_jump_root+0xa5>
    2f65:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    2f69:	48 85 ff             	test   %rdi,%rdi
    2f6c:	74 0d                	je     2f7b <nd_jump_root+0xbb>
    2f6e:	48 83 ef 80          	sub    $0xffffffffffffff80,%rdi
    2f72:	e8 00 00 00 00       	call   2f77 <nd_jump_root+0xb7>
    2f77:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    2f7b:	48 8b 47 30          	mov    0x30(%rdi),%rax
    2f7f:	48 89 43 30          	mov    %rax,0x30(%rbx)
    2f83:	eb a2                	jmp    2f27 <nd_jump_root+0x67>
    2f85:	48 89 df             	mov    %rbx,%rdi
    2f88:	e8 d3 fb ff ff       	call   2b60 <set_root>
    2f8d:	85 c0                	test   %eax,%eax
    2f8f:	75 9c                	jne    2f2d <nd_jump_root+0x6d>
    2f91:	8b 43 38             	mov    0x38(%rbx),%eax
    2f94:	e9 5a ff ff ff       	jmp    2ef3 <nd_jump_root+0x33>
    2f99:	b8 ee ff ff ff       	mov    $0xffffffee,%eax
    2f9e:	31 d2                	xor    %edx,%edx
    2fa0:	31 c9                	xor    %ecx,%ecx
    2fa2:	31 ff                	xor    %edi,%edi
    2fa4:	e9 00 00 00 00       	jmp    2fa9 <nd_jump_root+0xe9>
    2fa9:	48 8b 0f             	mov    (%rdi),%rcx
    2fac:	48 85 c9             	test   %rcx,%rcx
    2faf:	0f 84 35 ff ff ff    	je     2eea <nd_jump_root+0x2a>
    2fb5:	48 39 d1             	cmp    %rdx,%rcx
    2fb8:	0f 84 35 ff ff ff    	je     2ef3 <nd_jump_root+0x33>
    2fbe:	b8 ee ff ff ff       	mov    $0xffffffee,%eax
    2fc3:	e9 65 ff ff ff       	jmp    2f2d <nd_jump_root+0x6d>
    2fc8:	b8 f6 ff ff ff       	mov    $0xfffffff6,%eax
    2fcd:	e9 5b ff ff ff       	jmp    2f2d <nd_jump_root+0x6d>
    2fd2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    2fd9:	00 00 00 00 
    2fdd:	0f 1f 00             	nopl   (%rax)

0000000000002fe0 <__pfx_vfs_unlink>:
    2fe0:	90                   	nop
    2fe1:	90                   	nop
    2fe2:	90                   	nop
    2fe3:	90                   	nop
    2fe4:	90                   	nop
    2fe5:	90                   	nop
    2fe6:	90                   	nop
    2fe7:	90                   	nop
    2fe8:	90                   	nop
    2fe9:	90                   	nop
    2fea:	90                   	nop
    2feb:	90                   	nop
    2fec:	90                   	nop
    2fed:	90                   	nop
    2fee:	90                   	nop
    2fef:	90                   	nop

0000000000002ff0 <vfs_unlink>:
    2ff0:	e8 00 00 00 00       	call   2ff5 <vfs_unlink+0x5>
    2ff5:	55                   	push   %rbp
    2ff6:	48 89 e5             	mov    %rsp,%rbp
    2ff9:	41 57                	push   %r15
    2ffb:	41 56                	push   %r14
    2ffd:	41 55                	push   %r13
    2fff:	49 89 cd             	mov    %rcx,%r13
    3002:	31 c9                	xor    %ecx,%ecx
    3004:	41 54                	push   %r12
    3006:	49 89 f4             	mov    %rsi,%r12
    3009:	53                   	push   %rbx
    300a:	48 89 d3             	mov    %rdx,%rbx
    300d:	48 83 ec 08          	sub    $0x8,%rsp
    3011:	4c 8b 72 30          	mov    0x30(%rdx),%r14
    3015:	e8 46 f9 ff ff       	call   2960 <may_delete>
    301a:	41 89 c2             	mov    %eax,%r10d
    301d:	85 c0                	test   %eax,%eax
    301f:	75 30                	jne    3051 <vfs_unlink+0x61>
    3021:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    3026:	48 83 78 38 00       	cmpq   $0x0,0x38(%rax)
    302b:	74 1e                	je     304b <vfs_unlink+0x5b>
    302d:	4d 8d be 98 00 00 00 	lea    0x98(%r14),%r15
    3034:	4c 89 ff             	mov    %r15,%rdi
    3037:	e8 00 00 00 00       	call   303c <vfs_unlink+0x4c>
    303c:	41 f6 46 0d 01       	testb  $0x1,0xd(%r14)
    3041:	74 35                	je     3078 <vfs_unlink+0x88>
    3043:	4c 89 ff             	mov    %r15,%rdi
    3046:	e8 00 00 00 00       	call   304b <vfs_unlink+0x5b>
    304b:	41 ba ff ff ff ff    	mov    $0xffffffff,%r10d
    3051:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    3055:	44 89 d0             	mov    %r10d,%eax
    3058:	5b                   	pop    %rbx
    3059:	41 5c                	pop    %r12
    305b:	41 5d                	pop    %r13
    305d:	41 5e                	pop    %r14
    305f:	41 5f                	pop    %r15
    3061:	5d                   	pop    %rbp
    3062:	31 d2                	xor    %edx,%edx
    3064:	31 c9                	xor    %ecx,%ecx
    3066:	31 f6                	xor    %esi,%esi
    3068:	31 ff                	xor    %edi,%edi
    306a:	45 31 c0             	xor    %r8d,%r8d
    306d:	45 31 c9             	xor    %r9d,%r9d
    3070:	45 31 d2             	xor    %r10d,%r10d
    3073:	e9 00 00 00 00       	jmp    3078 <vfs_unlink+0x88>
    3078:	f7 03 00 80 00 00    	testl  $0x8000,(%rbx)
    307e:	75 24                	jne    30a4 <vfs_unlink+0xb4>
    3080:	48 89 de             	mov    %rbx,%rsi
    3083:	4c 89 e7             	mov    %r12,%rdi
    3086:	e8 00 00 00 00       	call   308b <vfs_unlink+0x9b>
    308b:	41 89 c2             	mov    %eax,%r10d
    308e:	85 c0                	test   %eax,%eax
    3090:	74 2e                	je     30c0 <vfs_unlink+0xd0>
    3092:	4c 89 ff             	mov    %r15,%rdi
    3095:	44 89 55 d4          	mov    %r10d,-0x2c(%rbp)
    3099:	e8 00 00 00 00       	call   309e <vfs_unlink+0xae>
    309e:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
    30a2:	eb ad                	jmp    3051 <vfs_unlink+0x61>
    30a4:	48 89 df             	mov    %rbx,%rdi
    30a7:	e8 00 00 00 00       	call   30ac <vfs_unlink+0xbc>
    30ac:	84 c0                	test   %al,%al
    30ae:	74 d0                	je     3080 <vfs_unlink+0x90>
    30b0:	4c 89 ff             	mov    %r15,%rdi
    30b3:	e8 00 00 00 00       	call   30b8 <vfs_unlink+0xc8>
    30b8:	41 ba f0 ff ff ff    	mov    $0xfffffff0,%r10d
    30be:	eb 91                	jmp    3051 <vfs_unlink+0x61>
    30c0:	49 8b 86 68 01 00 00 	mov    0x168(%r14),%rax
    30c7:	48 85 c0             	test   %rax,%rax
    30ca:	74 56                	je     3122 <vfs_unlink+0x132>
    30cc:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
    30d2:	48 8b 50 28          	mov    0x28(%rax),%rdx
    30d6:	48 8d 48 28          	lea    0x28(%rax),%rcx
    30da:	48 39 ca             	cmp    %rcx,%rdx
    30dd:	0f 84 f2 01 00 00    	je     32d5 <vfs_unlink+0x2e5>
    30e3:	ba 04 00 00 00       	mov    $0x4,%edx
    30e8:	be 01 08 00 00       	mov    $0x801,%esi
    30ed:	4c 89 f7             	mov    %r14,%rdi
    30f0:	e8 00 00 00 00       	call   30f5 <vfs_unlink+0x105>
    30f5:	41 89 c2             	mov    %eax,%r10d
    30f8:	83 f8 f5             	cmp    $0xfffffff5,%eax
    30fb:	75 1c                	jne    3119 <vfs_unlink+0x129>
    30fd:	4d 85 ed             	test   %r13,%r13
    3100:	74 17                	je     3119 <vfs_unlink+0x129>
    3102:	4d 89 75 00          	mov    %r14,0x0(%r13)
    3106:	4c 89 f7             	mov    %r14,%rdi
    3109:	e8 00 00 00 00       	call   310e <vfs_unlink+0x11e>
    310e:	41 ba f5 ff ff ff    	mov    $0xfffffff5,%r10d
    3114:	e9 79 ff ff ff       	jmp    3092 <vfs_unlink+0xa2>
    3119:	45 85 d2             	test   %r10d,%r10d
    311c:	0f 85 70 ff ff ff    	jne    3092 <vfs_unlink+0xa2>
    3122:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    3127:	48 89 de             	mov    %rbx,%rsi
    312a:	4c 89 e7             	mov    %r12,%rdi
    312d:	48 8b 40 38          	mov    0x38(%rax),%rax
    3131:	e8 00 00 00 00       	call   3136 <vfs_unlink+0x146>
    3136:	41 89 c2             	mov    %eax,%r10d
    3139:	85 c0                	test   %eax,%eax
    313b:	0f 85 51 ff ff ff    	jne    3092 <vfs_unlink+0xa2>
    3141:	4c 8d ab 80 00 00 00 	lea    0x80(%rbx),%r13
    3148:	89 45 d4             	mov    %eax,-0x2c(%rbp)
    314b:	4c 89 ef             	mov    %r13,%rdi
    314e:	e8 00 00 00 00       	call   3153 <vfs_unlink+0x163>
    3153:	81 0b 00 01 00 00    	orl    $0x100,(%rbx)
    3159:	4c 89 ef             	mov    %r13,%rdi
    315c:	e8 00 00 00 00       	call   3161 <vfs_unlink+0x171>
    3161:	f7 03 00 80 00 00    	testl  $0x8000,(%rbx)
    3167:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
    316b:	74 0c                	je     3179 <vfs_unlink+0x189>
    316d:	48 89 df             	mov    %rbx,%rdi
    3170:	44 89 55 d4          	mov    %r10d,-0x2c(%rbp)
    3174:	e8 00 00 00 00       	call   3179 <vfs_unlink+0x189>
    3179:	4c 89 ff             	mov    %r15,%rdi
    317c:	e8 00 00 00 00       	call   3181 <vfs_unlink+0x191>
    3181:	8b 03                	mov    (%rbx),%eax
    3183:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
    3187:	f6 c4 10             	test   $0x10,%ah
    318a:	74 6d                	je     31f9 <vfs_unlink+0x209>
    318c:	a9 00 00 38 00       	test   $0x380000,%eax
    3191:	0f 84 37 01 00 00    	je     32ce <vfs_unlink+0x2de>
    3197:	48 8b 73 30          	mov    0x30(%rbx),%rsi
    319b:	bf 00 02 00 40       	mov    $0x40000200,%edi
    31a0:	0f b7 06             	movzwl (%rsi),%eax
    31a3:	66 25 00 f0          	and    $0xf000,%ax
    31a7:	66 3d 00 40          	cmp    $0x4000,%ax
    31ab:	b8 00 02 00 00       	mov    $0x200,%eax
    31b0:	0f 45 f8             	cmovne %eax,%edi
    31b3:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    31b8:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    31bf:	48 85 c0             	test   %rax,%rax
    31c2:	0f 84 89 fe ff ff    	je     3051 <vfs_unlink+0x61>
    31c8:	48 8b 40 08          	mov    0x8(%rax),%rax
    31cc:	48 85 c0             	test   %rax,%rax
    31cf:	0f 84 7c fe ff ff    	je     3051 <vfs_unlink+0x61>
    31d5:	44 89 55 d4          	mov    %r10d,-0x2c(%rbp)
    31d9:	4c 89 e1             	mov    %r12,%rcx
    31dc:	45 31 c9             	xor    %r9d,%r9d
    31df:	4c 8d 43 20          	lea    0x20(%rbx),%r8
    31e3:	6a 00                	push   $0x0
    31e5:	ba 03 00 00 00       	mov    $0x3,%edx
    31ea:	e8 00 00 00 00       	call   31ef <vfs_unlink+0x1ff>
    31ef:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
    31f3:	59                   	pop    %rcx
    31f4:	e9 58 fe ff ff       	jmp    3051 <vfs_unlink+0x61>
    31f9:	49 8b 46 28          	mov    0x28(%r14),%rax
    31fd:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    3204:	48 85 c0             	test   %rax,%rax
    3207:	74 42                	je     324b <vfs_unlink+0x25b>
    3209:	48 8b 40 08          	mov    0x8(%rax),%rax
    320d:	48 85 c0             	test   %rax,%rax
    3210:	74 39                	je     324b <vfs_unlink+0x25b>
    3212:	41 0f b7 06          	movzwl (%r14),%eax
    3216:	44 89 55 d4          	mov    %r10d,-0x2c(%rbp)
    321a:	bf 04 00 00 40       	mov    $0x40000004,%edi
    321f:	4d 89 f1             	mov    %r14,%r9
    3222:	6a 00                	push   $0x0
    3224:	ba 03 00 00 00       	mov    $0x3,%edx
    3229:	4c 89 f6             	mov    %r14,%rsi
    322c:	66 25 00 f0          	and    $0xf000,%ax
    3230:	66 3d 00 40          	cmp    $0x4000,%ax
    3234:	b8 04 00 00 00       	mov    $0x4,%eax
    3239:	0f 45 f8             	cmovne %eax,%edi
    323c:	45 31 c0             	xor    %r8d,%r8d
    323f:	31 c9                	xor    %ecx,%ecx
    3241:	e8 00 00 00 00       	call   3246 <vfs_unlink+0x256>
    3246:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
    324a:	5a                   	pop    %rdx
    324b:	4c 8b 6b 30          	mov    0x30(%rbx),%r13
    324f:	44 89 55 d4          	mov    %r10d,-0x2c(%rbp)
    3253:	4c 89 ef             	mov    %r13,%rdi
    3256:	e8 00 00 00 00       	call   325b <vfs_unlink+0x26b>
    325b:	48 89 df             	mov    %rbx,%rdi
    325e:	e8 00 00 00 00       	call   3263 <vfs_unlink+0x273>
    3263:	41 0f b7 45 00       	movzwl 0x0(%r13),%eax
    3268:	bf 00 02 00 40       	mov    $0x40000200,%edi
    326d:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
    3271:	66 25 00 f0          	and    $0xf000,%ax
    3275:	66 3d 00 40          	cmp    $0x4000,%ax
    3279:	b8 00 02 00 00       	mov    $0x200,%eax
    327e:	0f 45 f8             	cmovne %eax,%edi
    3281:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    3286:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    328d:	48 85 c0             	test   %rax,%rax
    3290:	74 27                	je     32b9 <vfs_unlink+0x2c9>
    3292:	48 8b 40 08          	mov    0x8(%rax),%rax
    3296:	48 85 c0             	test   %rax,%rax
    3299:	74 1e                	je     32b9 <vfs_unlink+0x2c9>
    329b:	6a 00                	push   $0x0
    329d:	45 31 c9             	xor    %r9d,%r9d
    32a0:	4c 8d 43 20          	lea    0x20(%rbx),%r8
    32a4:	4c 89 e1             	mov    %r12,%rcx
    32a7:	ba 03 00 00 00       	mov    $0x3,%edx
    32ac:	4c 89 ee             	mov    %r13,%rsi
    32af:	e8 00 00 00 00       	call   32b4 <vfs_unlink+0x2c4>
    32b4:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
    32b8:	58                   	pop    %rax
    32b9:	4c 89 ef             	mov    %r13,%rdi
    32bc:	44 89 55 d4          	mov    %r10d,-0x2c(%rbp)
    32c0:	e8 00 00 00 00       	call   32c5 <vfs_unlink+0x2d5>
    32c5:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
    32c9:	e9 83 fd ff ff       	jmp    3051 <vfs_unlink+0x61>
    32ce:	0f 0b                	ud2
    32d0:	e9 7c fd ff ff       	jmp    3051 <vfs_unlink+0x61>
    32d5:	48 8b 40 30          	mov    0x30(%rax),%rax
    32d9:	48 39 c2             	cmp    %rax,%rdx
    32dc:	0f 85 01 fe ff ff    	jne    30e3 <vfs_unlink+0xf3>
    32e2:	e9 3b fe ff ff       	jmp    3122 <vfs_unlink+0x132>
    32e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    32ee:	00 00 

00000000000032f0 <__pfx_terminate_walk>:
    32f0:	90                   	nop
    32f1:	90                   	nop
    32f2:	90                   	nop
    32f3:	90                   	nop
    32f4:	90                   	nop
    32f5:	90                   	nop
    32f6:	90                   	nop
    32f7:	90                   	nop
    32f8:	90                   	nop
    32f9:	90                   	nop
    32fa:	90                   	nop
    32fb:	90                   	nop
    32fc:	90                   	nop
    32fd:	90                   	nop
    32fe:	90                   	nop
    32ff:	90                   	nop

0000000000003300 <terminate_walk>:
    3300:	e8 00 00 00 00       	call   3305 <terminate_walk+0x5>
    3305:	55                   	push   %rbp
    3306:	48 89 e5             	mov    %rsp,%rbp
    3309:	41 55                	push   %r13
    330b:	49 89 fd             	mov    %rdi,%r13
    330e:	41 54                	push   %r12
    3310:	53                   	push   %rbx
    3311:	8b 47 54             	mov    0x54(%rdi),%eax
    3314:	85 c0                	test   %eax,%eax
    3316:	74 33                	je     334b <terminate_walk+0x4b>
    3318:	44 8d 60 ff          	lea    -0x1(%rax),%r12d
    331c:	49 63 c4             	movslq %r12d,%rax
    331f:	48 8d 1c 40          	lea    (%rax,%rax,2),%rbx
    3323:	48 c1 e3 04          	shl    $0x4,%rbx
    3327:	49 03 5d 60          	add    0x60(%r13),%rbx
    332b:	48 8b 43 10          	mov    0x10(%rbx),%rax
    332f:	48 85 c0             	test   %rax,%rax
    3332:	74 09                	je     333d <terminate_walk+0x3d>
    3334:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    3338:	e8 00 00 00 00       	call   333d <terminate_walk+0x3d>
    333d:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
    3344:	00 
    3345:	41 83 ec 01          	sub    $0x1,%r12d
    3349:	73 d1                	jae    331c <terminate_walk+0x1c>
    334b:	41 8b 45 38          	mov    0x38(%r13),%eax
    334f:	f6 c4 01             	test   $0x1,%ah
    3352:	75 75                	jne    33c9 <terminate_walk+0xc9>
    3354:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    3358:	e8 00 00 00 00       	call   335d <terminate_walk+0x5d>
    335d:	49 8b 7d 00          	mov    0x0(%r13),%rdi
    3361:	e8 00 00 00 00       	call   3366 <terminate_walk+0x66>
    3366:	41 8b 45 54          	mov    0x54(%r13),%eax
    336a:	85 c0                	test   %eax,%eax
    336c:	74 2d                	je     339b <terminate_walk+0x9b>
    336e:	45 31 e4             	xor    %r12d,%r12d
    3371:	49 63 c4             	movslq %r12d,%rax
    3374:	41 83 c4 01          	add    $0x1,%r12d
    3378:	48 8d 1c 40          	lea    (%rax,%rax,2),%rbx
    337c:	48 c1 e3 04          	shl    $0x4,%rbx
    3380:	49 03 5d 60          	add    0x60(%r13),%rbx
    3384:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    3388:	e8 00 00 00 00       	call   338d <terminate_walk+0x8d>
    338d:	48 8b 3b             	mov    (%rbx),%rdi
    3390:	e8 00 00 00 00       	call   3395 <terminate_walk+0x95>
    3395:	45 3b 65 54          	cmp    0x54(%r13),%r12d
    3399:	72 d6                	jb     3371 <terminate_walk+0x71>
    339b:	41 f6 45 3c 02       	testb  $0x2,0x3c(%r13)
    33a0:	75 3d                	jne    33df <terminate_walk+0xdf>
    33a2:	41 c7 45 54 00 00 00 	movl   $0x0,0x54(%r13)
    33a9:	00 
    33aa:	49 c7 45 00 00 00 00 	movq   $0x0,0x0(%r13)
    33b1:	00 
    33b2:	49 c7 45 08 00 00 00 	movq   $0x0,0x8(%r13)
    33b9:	00 
    33ba:	5b                   	pop    %rbx
    33bb:	41 5c                	pop    %r12
    33bd:	41 5d                	pop    %r13
    33bf:	5d                   	pop    %rbp
    33c0:	31 c0                	xor    %eax,%eax
    33c2:	31 ff                	xor    %edi,%edi
    33c4:	e9 00 00 00 00       	jmp    33c9 <terminate_walk+0xc9>
    33c9:	80 e4 fe             	and    $0xfe,%ah
    33cc:	49 c7 45 40 00 00 00 	movq   $0x0,0x40(%r13)
    33d3:	00 
    33d4:	41 89 45 38          	mov    %eax,0x38(%r13)
    33d8:	e8 00 00 00 00       	call   33dd <terminate_walk+0xdd>
    33dd:	eb c3                	jmp    33a2 <terminate_walk+0xa2>
    33df:	49 8b 7d 28          	mov    0x28(%r13),%rdi
    33e3:	e8 00 00 00 00       	call   33e8 <terminate_walk+0xe8>
    33e8:	49 8b 7d 20          	mov    0x20(%r13),%rdi
    33ec:	e8 00 00 00 00       	call   33f1 <terminate_walk+0xf1>
    33f1:	41 83 65 3c fd       	andl   $0xfffffffd,0x3c(%r13)
    33f6:	eb aa                	jmp    33a2 <terminate_walk+0xa2>
    33f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    33ff:	00 

0000000000003400 <__pfx_vfs_mkobj>:
    3400:	90                   	nop
    3401:	90                   	nop
    3402:	90                   	nop
    3403:	90                   	nop
    3404:	90                   	nop
    3405:	90                   	nop
    3406:	90                   	nop
    3407:	90                   	nop
    3408:	90                   	nop
    3409:	90                   	nop
    340a:	90                   	nop
    340b:	90                   	nop
    340c:	90                   	nop
    340d:	90                   	nop
    340e:	90                   	nop
    340f:	90                   	nop

0000000000003410 <vfs_mkobj>:
    3410:	e8 00 00 00 00       	call   3415 <vfs_mkobj+0x5>
    3415:	55                   	push   %rbp
    3416:	48 89 e5             	mov    %rsp,%rbp
    3419:	41 57                	push   %r15
    341b:	41 56                	push   %r14
    341d:	41 55                	push   %r13
    341f:	41 89 f5             	mov    %esi,%r13d
    3422:	41 54                	push   %r12
    3424:	53                   	push   %rbx
    3425:	48 89 fb             	mov    %rdi,%rbx
    3428:	48 83 ec 18          	sub    $0x18,%rsp
    342c:	48 8b 47 18          	mov    0x18(%rdi),%rax
    3430:	65 4c 8b 35 00 00 00 	mov    %gs:0x0(%rip),%r14        # 3438 <vfs_mkobj+0x28>
    3437:	00 
    3438:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
    343c:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    3440:	4c 8b 60 30          	mov    0x30(%rax),%r12
    3444:	49 8b 86 70 0d 00 00 	mov    0xd70(%r14),%rax
    344b:	48 85 c0             	test   %rax,%rax
    344e:	74 0a                	je     345a <vfs_mkobj+0x4a>
    3450:	8b 08                	mov    (%rax),%ecx
    3452:	85 c9                	test   %ecx,%ecx
    3454:	0f 84 9f 00 00 00    	je     34f9 <vfs_mkobj+0xe9>
    345a:	48 83 7b 30 00       	cmpq   $0x0,0x30(%rbx)
    345f:	0f 85 83 01 00 00    	jne    35e8 <vfs_mkobj+0x1d8>
    3465:	41 f6 44 24 0c 10    	testb  $0x10,0xc(%r12)
    346b:	0f 85 82 01 00 00    	jne    35f3 <vfs_mkobj+0x1e3>
    3471:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    3476:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    347d:	4c 8b b8 80 04 00 00 	mov    0x480(%rax),%r15
    3484:	49 8b 86 a0 0c 00 00 	mov    0xca0(%r14),%rax
    348b:	8b 50 20             	mov    0x20(%rax),%edx
    348e:	4c 89 fe             	mov    %r15,%rsi
    3491:	e8 00 00 00 00       	call   3496 <vfs_mkobj+0x86>
    3496:	83 f8 ff             	cmp    $0xffffffff,%eax
    3499:	74 34                	je     34cf <vfs_mkobj+0xbf>
    349b:	89 45 c4             	mov    %eax,-0x3c(%rbp)
    349e:	49 8b 86 a0 0c 00 00 	mov    0xca0(%r14),%rax
    34a5:	4c 89 fe             	mov    %r15,%rsi
    34a8:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    34af:	8b 50 24             	mov    0x24(%rax),%edx
    34b2:	e8 00 00 00 00       	call   34b7 <vfs_mkobj+0xa7>
    34b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    34ba:	89 45 c0             	mov    %eax,-0x40(%rbp)
    34bd:	74 10                	je     34cf <vfs_mkobj+0xbf>
    34bf:	8b 75 c4             	mov    -0x3c(%rbp),%esi
    34c2:	4c 89 ff             	mov    %r15,%rdi
    34c5:	e8 00 00 00 00       	call   34ca <vfs_mkobj+0xba>
    34ca:	83 f8 ff             	cmp    $0xffffffff,%eax
    34cd:	75 3f                	jne    350e <vfs_mkobj+0xfe>
    34cf:	41 bf b5 ff ff ff    	mov    $0xffffffb5,%r15d
    34d5:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    34d9:	44 89 f8             	mov    %r15d,%eax
    34dc:	5b                   	pop    %rbx
    34dd:	41 5c                	pop    %r12
    34df:	41 5d                	pop    %r13
    34e1:	41 5e                	pop    %r14
    34e3:	41 5f                	pop    %r15
    34e5:	5d                   	pop    %rbp
    34e6:	31 d2                	xor    %edx,%edx
    34e8:	31 c9                	xor    %ecx,%ecx
    34ea:	31 f6                	xor    %esi,%esi
    34ec:	31 ff                	xor    %edi,%edi
    34ee:	45 31 c0             	xor    %r8d,%r8d
    34f1:	45 31 c9             	xor    %r9d,%r9d
    34f4:	e9 00 00 00 00       	jmp    34f9 <vfs_mkobj+0xe9>
    34f9:	48 89 fe             	mov    %rdi,%rsi
    34fc:	ba 04 00 00 00       	mov    $0x4,%edx
    3501:	4c 89 e7             	mov    %r12,%rdi
    3504:	e8 00 00 00 00       	call   3509 <vfs_mkobj+0xf9>
    3509:	e9 4c ff ff ff       	jmp    345a <vfs_mkobj+0x4a>
    350e:	8b 75 c0             	mov    -0x40(%rbp),%esi
    3511:	4c 89 ff             	mov    %r15,%rdi
    3514:	e8 00 00 00 00       	call   3519 <vfs_mkobj+0x109>
    3519:	83 f8 ff             	cmp    $0xffffffff,%eax
    351c:	74 b1                	je     34cf <vfs_mkobj+0xbf>
    351e:	ba 03 00 00 00       	mov    $0x3,%edx
    3523:	4c 89 e6             	mov    %r12,%rsi
    3526:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    352d:	e8 00 00 00 00       	call   3532 <vfs_mkobj+0x122>
    3532:	41 89 c7             	mov    %eax,%r15d
    3535:	85 c0                	test   %eax,%eax
    3537:	75 9c                	jne    34d5 <vfs_mkobj+0xc5>
    3539:	41 81 e5 ff 0f 00 00 	and    $0xfff,%r13d
    3540:	48 89 de             	mov    %rbx,%rsi
    3543:	4c 89 e7             	mov    %r12,%rdi
    3546:	41 81 cd 00 80 00 00 	or     $0x8000,%r13d
    354d:	44 89 ea             	mov    %r13d,%edx
    3550:	e8 00 00 00 00       	call   3555 <vfs_mkobj+0x145>
    3555:	41 89 c7             	mov    %eax,%r15d
    3558:	85 c0                	test   %eax,%eax
    355a:	0f 85 75 ff ff ff    	jne    34d5 <vfs_mkobj+0xc5>
    3560:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
    3564:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    3568:	44 89 ee             	mov    %r13d,%esi
    356b:	48 89 df             	mov    %rbx,%rdi
    356e:	e8 00 00 00 00       	call   3573 <vfs_mkobj+0x163>
    3573:	41 89 c7             	mov    %eax,%r15d
    3576:	85 c0                	test   %eax,%eax
    3578:	0f 85 57 ff ff ff    	jne    34d5 <vfs_mkobj+0xc5>
    357e:	49 8b 86 70 0d 00 00 	mov    0xd70(%r14),%rax
    3585:	48 85 c0             	test   %rax,%rax
    3588:	74 06                	je     3590 <vfs_mkobj+0x180>
    358a:	8b 10                	mov    (%rax),%edx
    358c:	85 d2                	test   %edx,%edx
    358e:	74 46                	je     35d6 <vfs_mkobj+0x1c6>
    3590:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    3595:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    359c:	48 85 c0             	test   %rax,%rax
    359f:	0f 84 30 ff ff ff    	je     34d5 <vfs_mkobj+0xc5>
    35a5:	48 8b 40 08          	mov    0x8(%rax),%rax
    35a9:	48 85 c0             	test   %rax,%rax
    35ac:	0f 84 23 ff ff ff    	je     34d5 <vfs_mkobj+0xc5>
    35b2:	6a 00                	push   $0x0
    35b4:	45 31 c9             	xor    %r9d,%r9d
    35b7:	4c 8d 43 20          	lea    0x20(%rbx),%r8
    35bb:	4c 89 e1             	mov    %r12,%rcx
    35be:	ba 04 00 00 00       	mov    $0x4,%edx
    35c3:	48 89 de             	mov    %rbx,%rsi
    35c6:	bf 00 01 00 00       	mov    $0x100,%edi
    35cb:	e8 00 00 00 00       	call   35d0 <vfs_mkobj+0x1c0>
    35d0:	58                   	pop    %rax
    35d1:	e9 ff fe ff ff       	jmp    34d5 <vfs_mkobj+0xc5>
    35d6:	ba 04 00 00 00       	mov    $0x4,%edx
    35db:	48 89 de             	mov    %rbx,%rsi
    35de:	4c 89 e7             	mov    %r12,%rdi
    35e1:	e8 00 00 00 00       	call   35e6 <vfs_mkobj+0x1d6>
    35e6:	eb a8                	jmp    3590 <vfs_mkobj+0x180>
    35e8:	41 bf ef ff ff ff    	mov    $0xffffffef,%r15d
    35ee:	e9 e2 fe ff ff       	jmp    34d5 <vfs_mkobj+0xc5>
    35f3:	41 bf fe ff ff ff    	mov    $0xfffffffe,%r15d
    35f9:	e9 d7 fe ff ff       	jmp    34d5 <vfs_mkobj+0xc5>
    35fe:	66 90                	xchg   %ax,%ax

0000000000003600 <__pfx_vfs_symlink>:
    3600:	90                   	nop
    3601:	90                   	nop
    3602:	90                   	nop
    3603:	90                   	nop
    3604:	90                   	nop
    3605:	90                   	nop
    3606:	90                   	nop
    3607:	90                   	nop
    3608:	90                   	nop
    3609:	90                   	nop
    360a:	90                   	nop
    360b:	90                   	nop
    360c:	90                   	nop
    360d:	90                   	nop
    360e:	90                   	nop
    360f:	90                   	nop

0000000000003610 <vfs_symlink>:
    3610:	e8 00 00 00 00       	call   3615 <vfs_symlink+0x5>
    3615:	55                   	push   %rbp
    3616:	48 89 e5             	mov    %rsp,%rbp
    3619:	41 57                	push   %r15
    361b:	41 56                	push   %r14
    361d:	41 55                	push   %r13
    361f:	49 89 d5             	mov    %rdx,%r13
    3622:	41 54                	push   %r12
    3624:	49 89 fc             	mov    %rdi,%r12
    3627:	53                   	push   %rbx
    3628:	48 89 f3             	mov    %rsi,%rbx
    362b:	48 83 ec 10          	sub    $0x10,%rsp
    362f:	65 4c 8b 35 00 00 00 	mov    %gs:0x0(%rip),%r14        # 3637 <vfs_symlink+0x27>
    3636:	00 
    3637:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
    363b:	49 8b 86 70 0d 00 00 	mov    0xd70(%r14),%rax
    3642:	48 85 c0             	test   %rax,%rax
    3645:	74 0a                	je     3651 <vfs_symlink+0x41>
    3647:	8b 08                	mov    (%rax),%ecx
    3649:	85 c9                	test   %ecx,%ecx
    364b:	0f 84 94 00 00 00    	je     36e5 <vfs_symlink+0xd5>
    3651:	49 83 7d 30 00       	cmpq   $0x0,0x30(%r13)
    3656:	0f 85 7c 01 00 00    	jne    37d8 <vfs_symlink+0x1c8>
    365c:	f6 43 0c 10          	testb  $0x10,0xc(%rbx)
    3660:	0f 85 7d 01 00 00    	jne    37e3 <vfs_symlink+0x1d3>
    3666:	48 8b 43 28          	mov    0x28(%rbx),%rax
    366a:	4c 89 e7             	mov    %r12,%rdi
    366d:	4c 8b b8 80 04 00 00 	mov    0x480(%rax),%r15
    3674:	49 8b 86 a0 0c 00 00 	mov    0xca0(%r14),%rax
    367b:	8b 50 20             	mov    0x20(%rax),%edx
    367e:	4c 89 fe             	mov    %r15,%rsi
    3681:	e8 00 00 00 00       	call   3686 <vfs_symlink+0x76>
    3686:	83 f8 ff             	cmp    $0xffffffff,%eax
    3689:	74 30                	je     36bb <vfs_symlink+0xab>
    368b:	89 45 cc             	mov    %eax,-0x34(%rbp)
    368e:	49 8b 86 a0 0c 00 00 	mov    0xca0(%r14),%rax
    3695:	4c 89 fe             	mov    %r15,%rsi
    3698:	4c 89 e7             	mov    %r12,%rdi
    369b:	8b 50 24             	mov    0x24(%rax),%edx
    369e:	e8 00 00 00 00       	call   36a3 <vfs_symlink+0x93>
    36a3:	83 f8 ff             	cmp    $0xffffffff,%eax
    36a6:	89 45 c8             	mov    %eax,-0x38(%rbp)
    36a9:	74 10                	je     36bb <vfs_symlink+0xab>
    36ab:	8b 75 cc             	mov    -0x34(%rbp),%esi
    36ae:	4c 89 ff             	mov    %r15,%rdi
    36b1:	e8 00 00 00 00       	call   36b6 <vfs_symlink+0xa6>
    36b6:	83 f8 ff             	cmp    $0xffffffff,%eax
    36b9:	75 3f                	jne    36fa <vfs_symlink+0xea>
    36bb:	41 bf b5 ff ff ff    	mov    $0xffffffb5,%r15d
    36c1:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    36c5:	44 89 f8             	mov    %r15d,%eax
    36c8:	5b                   	pop    %rbx
    36c9:	41 5c                	pop    %r12
    36cb:	41 5d                	pop    %r13
    36cd:	41 5e                	pop    %r14
    36cf:	41 5f                	pop    %r15
    36d1:	5d                   	pop    %rbp
    36d2:	31 d2                	xor    %edx,%edx
    36d4:	31 c9                	xor    %ecx,%ecx
    36d6:	31 f6                	xor    %esi,%esi
    36d8:	31 ff                	xor    %edi,%edi
    36da:	45 31 c0             	xor    %r8d,%r8d
    36dd:	45 31 c9             	xor    %r9d,%r9d
    36e0:	e9 00 00 00 00       	jmp    36e5 <vfs_symlink+0xd5>
    36e5:	ba 04 00 00 00       	mov    $0x4,%edx
    36ea:	4c 89 ee             	mov    %r13,%rsi
    36ed:	48 89 df             	mov    %rbx,%rdi
    36f0:	e8 00 00 00 00       	call   36f5 <vfs_symlink+0xe5>
    36f5:	e9 57 ff ff ff       	jmp    3651 <vfs_symlink+0x41>
    36fa:	8b 75 c8             	mov    -0x38(%rbp),%esi
    36fd:	4c 89 ff             	mov    %r15,%rdi
    3700:	e8 00 00 00 00       	call   3705 <vfs_symlink+0xf5>
    3705:	83 f8 ff             	cmp    $0xffffffff,%eax
    3708:	74 b1                	je     36bb <vfs_symlink+0xab>
    370a:	ba 03 00 00 00       	mov    $0x3,%edx
    370f:	48 89 de             	mov    %rbx,%rsi
    3712:	4c 89 e7             	mov    %r12,%rdi
    3715:	e8 00 00 00 00       	call   371a <vfs_symlink+0x10a>
    371a:	41 89 c7             	mov    %eax,%r15d
    371d:	85 c0                	test   %eax,%eax
    371f:	75 a0                	jne    36c1 <vfs_symlink+0xb1>
    3721:	48 8b 43 20          	mov    0x20(%rbx),%rax
    3725:	48 83 78 40 00       	cmpq   $0x0,0x40(%rax)
    372a:	0f 84 be 00 00 00    	je     37ee <vfs_symlink+0x1de>
    3730:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
    3734:	4c 89 ee             	mov    %r13,%rsi
    3737:	48 89 df             	mov    %rbx,%rdi
    373a:	e8 00 00 00 00       	call   373f <vfs_symlink+0x12f>
    373f:	41 89 c7             	mov    %eax,%r15d
    3742:	85 c0                	test   %eax,%eax
    3744:	0f 85 77 ff ff ff    	jne    36c1 <vfs_symlink+0xb1>
    374a:	48 8b 43 20          	mov    0x20(%rbx),%rax
    374e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    3752:	4c 89 ea             	mov    %r13,%rdx
    3755:	48 89 de             	mov    %rbx,%rsi
    3758:	4c 89 e7             	mov    %r12,%rdi
    375b:	48 8b 40 40          	mov    0x40(%rax),%rax
    375f:	e8 00 00 00 00       	call   3764 <vfs_symlink+0x154>
    3764:	41 89 c7             	mov    %eax,%r15d
    3767:	85 c0                	test   %eax,%eax
    3769:	0f 85 52 ff ff ff    	jne    36c1 <vfs_symlink+0xb1>
    376f:	49 8b 86 70 0d 00 00 	mov    0xd70(%r14),%rax
    3776:	48 85 c0             	test   %rax,%rax
    3779:	74 06                	je     3781 <vfs_symlink+0x171>
    377b:	8b 10                	mov    (%rax),%edx
    377d:	85 d2                	test   %edx,%edx
    377f:	74 45                	je     37c6 <vfs_symlink+0x1b6>
    3781:	48 8b 43 28          	mov    0x28(%rbx),%rax
    3785:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    378c:	48 85 c0             	test   %rax,%rax
    378f:	0f 84 2c ff ff ff    	je     36c1 <vfs_symlink+0xb1>
    3795:	48 8b 40 08          	mov    0x8(%rax),%rax
    3799:	48 85 c0             	test   %rax,%rax
    379c:	0f 84 1f ff ff ff    	je     36c1 <vfs_symlink+0xb1>
    37a2:	6a 00                	push   $0x0
    37a4:	45 31 c9             	xor    %r9d,%r9d
    37a7:	4d 8d 45 20          	lea    0x20(%r13),%r8
    37ab:	48 89 d9             	mov    %rbx,%rcx
    37ae:	ba 04 00 00 00       	mov    $0x4,%edx
    37b3:	4c 89 ee             	mov    %r13,%rsi
    37b6:	bf 00 01 00 00       	mov    $0x100,%edi
    37bb:	e8 00 00 00 00       	call   37c0 <vfs_symlink+0x1b0>
    37c0:	58                   	pop    %rax
    37c1:	e9 fb fe ff ff       	jmp    36c1 <vfs_symlink+0xb1>
    37c6:	ba 04 00 00 00       	mov    $0x4,%edx
    37cb:	4c 89 ee             	mov    %r13,%rsi
    37ce:	48 89 df             	mov    %rbx,%rdi
    37d1:	e8 00 00 00 00       	call   37d6 <vfs_symlink+0x1c6>
    37d6:	eb a9                	jmp    3781 <vfs_symlink+0x171>
    37d8:	41 bf ef ff ff ff    	mov    $0xffffffef,%r15d
    37de:	e9 de fe ff ff       	jmp    36c1 <vfs_symlink+0xb1>
    37e3:	41 bf fe ff ff ff    	mov    $0xfffffffe,%r15d
    37e9:	e9 d3 fe ff ff       	jmp    36c1 <vfs_symlink+0xb1>
    37ee:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
    37f4:	e9 c8 fe ff ff       	jmp    36c1 <vfs_symlink+0xb1>
    37f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003800 <__pfx_vfs_create>:
    3800:	90                   	nop
    3801:	90                   	nop
    3802:	90                   	nop
    3803:	90                   	nop
    3804:	90                   	nop
    3805:	90                   	nop
    3806:	90                   	nop
    3807:	90                   	nop
    3808:	90                   	nop
    3809:	90                   	nop
    380a:	90                   	nop
    380b:	90                   	nop
    380c:	90                   	nop
    380d:	90                   	nop
    380e:	90                   	nop
    380f:	90                   	nop

0000000000003810 <vfs_create>:
    3810:	e8 00 00 00 00       	call   3815 <vfs_create+0x5>
    3815:	55                   	push   %rbp
    3816:	48 89 e5             	mov    %rsp,%rbp
    3819:	41 57                	push   %r15
    381b:	41 56                	push   %r14
    381d:	41 55                	push   %r13
    381f:	49 89 d5             	mov    %rdx,%r13
    3822:	41 54                	push   %r12
    3824:	49 89 fc             	mov    %rdi,%r12
    3827:	53                   	push   %rbx
    3828:	48 89 f3             	mov    %rsi,%rbx
    382b:	48 83 ec 10          	sub    $0x10,%rsp
    382f:	65 4c 8b 35 00 00 00 	mov    %gs:0x0(%rip),%r14        # 3837 <vfs_create+0x27>
    3836:	00 
    3837:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
    383a:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
    383e:	49 8b 86 70 0d 00 00 	mov    0xd70(%r14),%rax
    3845:	48 85 c0             	test   %rax,%rax
    3848:	74 0a                	je     3854 <vfs_create+0x44>
    384a:	8b 08                	mov    (%rax),%ecx
    384c:	85 c9                	test   %ecx,%ecx
    384e:	0f 84 94 00 00 00    	je     38e8 <vfs_create+0xd8>
    3854:	49 83 7d 30 00       	cmpq   $0x0,0x30(%r13)
    3859:	0f 85 c3 01 00 00    	jne    3a22 <vfs_create+0x212>
    385f:	f6 43 0c 10          	testb  $0x10,0xc(%rbx)
    3863:	0f 85 c4 01 00 00    	jne    3a2d <vfs_create+0x21d>
    3869:	48 8b 43 28          	mov    0x28(%rbx),%rax
    386d:	4c 89 e7             	mov    %r12,%rdi
    3870:	4c 8b b8 80 04 00 00 	mov    0x480(%rax),%r15
    3877:	49 8b 86 a0 0c 00 00 	mov    0xca0(%r14),%rax
    387e:	8b 50 20             	mov    0x20(%rax),%edx
    3881:	4c 89 fe             	mov    %r15,%rsi
    3884:	e8 00 00 00 00       	call   3889 <vfs_create+0x79>
    3889:	83 f8 ff             	cmp    $0xffffffff,%eax
    388c:	74 30                	je     38be <vfs_create+0xae>
    388e:	89 45 cc             	mov    %eax,-0x34(%rbp)
    3891:	49 8b 86 a0 0c 00 00 	mov    0xca0(%r14),%rax
    3898:	4c 89 fe             	mov    %r15,%rsi
    389b:	4c 89 e7             	mov    %r12,%rdi
    389e:	8b 50 24             	mov    0x24(%rax),%edx
    38a1:	e8 00 00 00 00       	call   38a6 <vfs_create+0x96>
    38a6:	83 f8 ff             	cmp    $0xffffffff,%eax
    38a9:	89 45 c8             	mov    %eax,-0x38(%rbp)
    38ac:	74 10                	je     38be <vfs_create+0xae>
    38ae:	8b 75 cc             	mov    -0x34(%rbp),%esi
    38b1:	4c 89 ff             	mov    %r15,%rdi
    38b4:	e8 00 00 00 00       	call   38b9 <vfs_create+0xa9>
    38b9:	83 f8 ff             	cmp    $0xffffffff,%eax
    38bc:	75 3f                	jne    38fd <vfs_create+0xed>
    38be:	41 bf b5 ff ff ff    	mov    $0xffffffb5,%r15d
    38c4:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    38c8:	44 89 f8             	mov    %r15d,%eax
    38cb:	5b                   	pop    %rbx
    38cc:	41 5c                	pop    %r12
    38ce:	41 5d                	pop    %r13
    38d0:	41 5e                	pop    %r14
    38d2:	41 5f                	pop    %r15
    38d4:	5d                   	pop    %rbp
    38d5:	31 d2                	xor    %edx,%edx
    38d7:	31 c9                	xor    %ecx,%ecx
    38d9:	31 f6                	xor    %esi,%esi
    38db:	31 ff                	xor    %edi,%edi
    38dd:	45 31 c0             	xor    %r8d,%r8d
    38e0:	45 31 c9             	xor    %r9d,%r9d
    38e3:	e9 00 00 00 00       	jmp    38e8 <vfs_create+0xd8>
    38e8:	ba 04 00 00 00       	mov    $0x4,%edx
    38ed:	4c 89 ee             	mov    %r13,%rsi
    38f0:	48 89 df             	mov    %rbx,%rdi
    38f3:	e8 00 00 00 00       	call   38f8 <vfs_create+0xe8>
    38f8:	e9 57 ff ff ff       	jmp    3854 <vfs_create+0x44>
    38fd:	8b 75 c8             	mov    -0x38(%rbp),%esi
    3900:	4c 89 ff             	mov    %r15,%rdi
    3903:	e8 00 00 00 00       	call   3908 <vfs_create+0xf8>
    3908:	83 f8 ff             	cmp    $0xffffffff,%eax
    390b:	74 b1                	je     38be <vfs_create+0xae>
    390d:	ba 03 00 00 00       	mov    $0x3,%edx
    3912:	48 89 de             	mov    %rbx,%rsi
    3915:	4c 89 e7             	mov    %r12,%rdi
    3918:	e8 00 00 00 00       	call   391d <vfs_create+0x10d>
    391d:	41 89 c7             	mov    %eax,%r15d
    3920:	85 c0                	test   %eax,%eax
    3922:	75 a0                	jne    38c4 <vfs_create+0xb4>
    3924:	48 8b 43 20          	mov    0x20(%rbx),%rax
    3928:	48 83 78 28 00       	cmpq   $0x0,0x28(%rax)
    392d:	0f 84 05 01 00 00    	je     3a38 <vfs_create+0x228>
    3933:	0f b7 55 d4          	movzwl -0x2c(%rbp),%edx
    3937:	48 89 de             	mov    %rbx,%rsi
    393a:	4c 89 e7             	mov    %r12,%rdi
    393d:	e8 00 00 00 00       	call   3942 <vfs_create+0x132>
    3942:	41 89 c7             	mov    %eax,%r15d
    3945:	48 8b 43 28          	mov    0x28(%rbx),%rax
    3949:	f6 40 52 01          	testb  $0x1,0x52(%rax)
    394d:	75 0a                	jne    3959 <vfs_create+0x149>
    394f:	f6 40 59 10          	testb  $0x10,0x59(%rax)
    3953:	0f 84 a8 00 00 00    	je     3a01 <vfs_create+0x1f1>
    3959:	41 81 e7 ff 0f 00 00 	and    $0xfff,%r15d
    3960:	4c 89 ee             	mov    %r13,%rsi
    3963:	48 89 df             	mov    %rbx,%rdi
    3966:	44 89 f9             	mov    %r15d,%ecx
    3969:	80 cd 80             	or     $0x80,%ch
    396c:	89 ca                	mov    %ecx,%edx
    396e:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
    3971:	e8 00 00 00 00       	call   3976 <vfs_create+0x166>
    3976:	41 89 c7             	mov    %eax,%r15d
    3979:	85 c0                	test   %eax,%eax
    397b:	0f 85 43 ff ff ff    	jne    38c4 <vfs_create+0xb4>
    3981:	48 8b 43 20          	mov    0x20(%rbx),%rax
    3985:	44 0f b6 45 d0       	movzbl -0x30(%rbp),%r8d
    398a:	4c 89 ea             	mov    %r13,%rdx
    398d:	48 89 de             	mov    %rbx,%rsi
    3990:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
    3993:	4c 89 e7             	mov    %r12,%rdi
    3996:	48 8b 40 28          	mov    0x28(%rax),%rax
    399a:	e8 00 00 00 00       	call   399f <vfs_create+0x18f>
    399f:	41 89 c7             	mov    %eax,%r15d
    39a2:	85 c0                	test   %eax,%eax
    39a4:	0f 85 1a ff ff ff    	jne    38c4 <vfs_create+0xb4>
    39aa:	49 8b 86 70 0d 00 00 	mov    0xd70(%r14),%rax
    39b1:	48 85 c0             	test   %rax,%rax
    39b4:	74 06                	je     39bc <vfs_create+0x1ac>
    39b6:	8b 10                	mov    (%rax),%edx
    39b8:	85 d2                	test   %edx,%edx
    39ba:	74 54                	je     3a10 <vfs_create+0x200>
    39bc:	48 8b 43 28          	mov    0x28(%rbx),%rax
    39c0:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    39c7:	48 85 c0             	test   %rax,%rax
    39ca:	0f 84 f4 fe ff ff    	je     38c4 <vfs_create+0xb4>
    39d0:	48 8b 40 08          	mov    0x8(%rax),%rax
    39d4:	48 85 c0             	test   %rax,%rax
    39d7:	0f 84 e7 fe ff ff    	je     38c4 <vfs_create+0xb4>
    39dd:	6a 00                	push   $0x0
    39df:	45 31 c9             	xor    %r9d,%r9d
    39e2:	4d 8d 45 20          	lea    0x20(%r13),%r8
    39e6:	48 89 d9             	mov    %rbx,%rcx
    39e9:	ba 04 00 00 00       	mov    $0x4,%edx
    39ee:	4c 89 ee             	mov    %r13,%rsi
    39f1:	bf 00 01 00 00       	mov    $0x100,%edi
    39f6:	e8 00 00 00 00       	call   39fb <vfs_create+0x1eb>
    39fb:	58                   	pop    %rax
    39fc:	e9 c3 fe ff ff       	jmp    38c4 <vfs_create+0xb4>
    3a01:	e8 00 00 00 00       	call   3a06 <vfs_create+0x1f6>
    3a06:	f7 d0                	not    %eax
    3a08:	41 21 c7             	and    %eax,%r15d
    3a0b:	e9 49 ff ff ff       	jmp    3959 <vfs_create+0x149>
    3a10:	ba 04 00 00 00       	mov    $0x4,%edx
    3a15:	4c 89 ee             	mov    %r13,%rsi
    3a18:	48 89 df             	mov    %rbx,%rdi
    3a1b:	e8 00 00 00 00       	call   3a20 <vfs_create+0x210>
    3a20:	eb 9a                	jmp    39bc <vfs_create+0x1ac>
    3a22:	41 bf ef ff ff ff    	mov    $0xffffffef,%r15d
    3a28:	e9 97 fe ff ff       	jmp    38c4 <vfs_create+0xb4>
    3a2d:	41 bf fe ff ff ff    	mov    $0xfffffffe,%r15d
    3a33:	e9 8c fe ff ff       	jmp    38c4 <vfs_create+0xb4>
    3a38:	41 bf f3 ff ff ff    	mov    $0xfffffff3,%r15d
    3a3e:	e9 81 fe ff ff       	jmp    38c4 <vfs_create+0xb4>
    3a43:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    3a4a:	00 00 00 00 
    3a4e:	66 90                	xchg   %ax,%ax

0000000000003a50 <__pfx_vfs_mkdir>:
    3a50:	90                   	nop
    3a51:	90                   	nop
    3a52:	90                   	nop
    3a53:	90                   	nop
    3a54:	90                   	nop
    3a55:	90                   	nop
    3a56:	90                   	nop
    3a57:	90                   	nop
    3a58:	90                   	nop
    3a59:	90                   	nop
    3a5a:	90                   	nop
    3a5b:	90                   	nop
    3a5c:	90                   	nop
    3a5d:	90                   	nop
    3a5e:	90                   	nop
    3a5f:	90                   	nop

0000000000003a60 <vfs_mkdir>:
    3a60:	e8 00 00 00 00       	call   3a65 <vfs_mkdir+0x5>
    3a65:	55                   	push   %rbp
    3a66:	48 89 e5             	mov    %rsp,%rbp
    3a69:	41 57                	push   %r15
    3a6b:	49 89 f7             	mov    %rsi,%r15
    3a6e:	41 56                	push   %r14
    3a70:	41 55                	push   %r13
    3a72:	41 54                	push   %r12
    3a74:	49 89 fc             	mov    %rdi,%r12
    3a77:	53                   	push   %rbx
    3a78:	48 89 d3             	mov    %rdx,%rbx
    3a7b:	48 83 ec 10          	sub    $0x10,%rsp
    3a7f:	48 8b 46 28          	mov    0x28(%rsi),%rax
    3a83:	65 4c 8b 2d 00 00 00 	mov    %gs:0x0(%rip),%r13        # 3a8b <vfs_mkdir+0x2b>
    3a8a:	00 
    3a8b:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
    3a8e:	8b 80 20 04 00 00    	mov    0x420(%rax),%eax
    3a94:	89 45 d0             	mov    %eax,-0x30(%rbp)
    3a97:	49 8b 85 70 0d 00 00 	mov    0xd70(%r13),%rax
    3a9e:	48 85 c0             	test   %rax,%rax
    3aa1:	74 0a                	je     3aad <vfs_mkdir+0x4d>
    3aa3:	8b 08                	mov    (%rax),%ecx
    3aa5:	85 c9                	test   %ecx,%ecx
    3aa7:	0f 84 9e 00 00 00    	je     3b4b <vfs_mkdir+0xeb>
    3aad:	48 83 7b 30 00       	cmpq   $0x0,0x30(%rbx)
    3ab2:	0f 85 fc 01 00 00    	jne    3cb4 <vfs_mkdir+0x254>
    3ab8:	41 f6 47 0c 10       	testb  $0x10,0xc(%r15)
    3abd:	0f 85 fd 01 00 00    	jne    3cc0 <vfs_mkdir+0x260>
    3ac3:	49 8b 47 28          	mov    0x28(%r15),%rax
    3ac7:	4c 89 e7             	mov    %r12,%rdi
    3aca:	4c 8b b0 80 04 00 00 	mov    0x480(%rax),%r14
    3ad1:	49 8b 85 a0 0c 00 00 	mov    0xca0(%r13),%rax
    3ad8:	8b 50 20             	mov    0x20(%rax),%edx
    3adb:	4c 89 f6             	mov    %r14,%rsi
    3ade:	e8 00 00 00 00       	call   3ae3 <vfs_mkdir+0x83>
    3ae3:	83 f8 ff             	cmp    $0xffffffff,%eax
    3ae6:	74 30                	je     3b18 <vfs_mkdir+0xb8>
    3ae8:	89 45 cc             	mov    %eax,-0x34(%rbp)
    3aeb:	49 8b 85 a0 0c 00 00 	mov    0xca0(%r13),%rax
    3af2:	4c 89 f6             	mov    %r14,%rsi
    3af5:	4c 89 e7             	mov    %r12,%rdi
    3af8:	8b 50 24             	mov    0x24(%rax),%edx
    3afb:	e8 00 00 00 00       	call   3b00 <vfs_mkdir+0xa0>
    3b00:	83 f8 ff             	cmp    $0xffffffff,%eax
    3b03:	89 45 c8             	mov    %eax,-0x38(%rbp)
    3b06:	74 10                	je     3b18 <vfs_mkdir+0xb8>
    3b08:	8b 75 cc             	mov    -0x34(%rbp),%esi
    3b0b:	4c 89 f7             	mov    %r14,%rdi
    3b0e:	e8 00 00 00 00       	call   3b13 <vfs_mkdir+0xb3>
    3b13:	83 f8 ff             	cmp    $0xffffffff,%eax
    3b16:	75 48                	jne    3b60 <vfs_mkdir+0x100>
    3b18:	49 c7 c4 b5 ff ff ff 	mov    $0xffffffffffffffb5,%r12
    3b1f:	48 89 df             	mov    %rbx,%rdi
    3b22:	e8 00 00 00 00       	call   3b27 <vfs_mkdir+0xc7>
    3b27:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    3b2b:	4c 89 e0             	mov    %r12,%rax
    3b2e:	5b                   	pop    %rbx
    3b2f:	41 5c                	pop    %r12
    3b31:	41 5d                	pop    %r13
    3b33:	41 5e                	pop    %r14
    3b35:	41 5f                	pop    %r15
    3b37:	5d                   	pop    %rbp
    3b38:	31 d2                	xor    %edx,%edx
    3b3a:	31 c9                	xor    %ecx,%ecx
    3b3c:	31 f6                	xor    %esi,%esi
    3b3e:	31 ff                	xor    %edi,%edi
    3b40:	45 31 c0             	xor    %r8d,%r8d
    3b43:	45 31 c9             	xor    %r9d,%r9d
    3b46:	e9 00 00 00 00       	jmp    3b4b <vfs_mkdir+0xeb>
    3b4b:	ba 04 00 00 00       	mov    $0x4,%edx
    3b50:	48 89 de             	mov    %rbx,%rsi
    3b53:	4c 89 ff             	mov    %r15,%rdi
    3b56:	e8 00 00 00 00       	call   3b5b <vfs_mkdir+0xfb>
    3b5b:	e9 4d ff ff ff       	jmp    3aad <vfs_mkdir+0x4d>
    3b60:	8b 75 c8             	mov    -0x38(%rbp),%esi
    3b63:	4c 89 f7             	mov    %r14,%rdi
    3b66:	e8 00 00 00 00       	call   3b6b <vfs_mkdir+0x10b>
    3b6b:	83 f8 ff             	cmp    $0xffffffff,%eax
    3b6e:	74 a8                	je     3b18 <vfs_mkdir+0xb8>
    3b70:	ba 03 00 00 00       	mov    $0x3,%edx
    3b75:	4c 89 fe             	mov    %r15,%rsi
    3b78:	4c 89 e7             	mov    %r12,%rdi
    3b7b:	e8 00 00 00 00       	call   3b80 <vfs_mkdir+0x120>
    3b80:	85 c0                	test   %eax,%eax
    3b82:	0f 85 fd 00 00 00    	jne    3c85 <vfs_mkdir+0x225>
    3b88:	49 8b 47 20          	mov    0x20(%r15),%rax
    3b8c:	48 83 78 48 00       	cmpq   $0x0,0x48(%rax)
    3b91:	0f 84 f6 00 00 00    	je     3c8d <vfs_mkdir+0x22d>
    3b97:	0f b7 55 d4          	movzwl -0x2c(%rbp),%edx
    3b9b:	4c 89 fe             	mov    %r15,%rsi
    3b9e:	4c 89 e7             	mov    %r12,%rdi
    3ba1:	e8 00 00 00 00       	call   3ba6 <vfs_mkdir+0x146>
    3ba6:	41 89 c6             	mov    %eax,%r14d
    3ba9:	49 8b 47 28          	mov    0x28(%r15),%rax
    3bad:	f6 40 52 01          	testb  $0x1,0x52(%rax)
    3bb1:	75 0a                	jne    3bbd <vfs_mkdir+0x15d>
    3bb3:	f6 40 59 10          	testb  $0x10,0x59(%rax)
    3bb7:	0f 84 dc 00 00 00    	je     3c99 <vfs_mkdir+0x239>
    3bbd:	41 81 e6 ff 03 00 00 	and    $0x3ff,%r14d
    3bc4:	48 89 de             	mov    %rbx,%rsi
    3bc7:	4c 89 ff             	mov    %r15,%rdi
    3bca:	44 89 f2             	mov    %r14d,%edx
    3bcd:	e8 00 00 00 00       	call   3bd2 <vfs_mkdir+0x172>
    3bd2:	85 c0                	test   %eax,%eax
    3bd4:	0f 85 ab 00 00 00    	jne    3c85 <vfs_mkdir+0x225>
    3bda:	8b 45 d0             	mov    -0x30(%rbp),%eax
    3bdd:	85 c0                	test   %eax,%eax
    3bdf:	74 0a                	je     3beb <vfs_mkdir+0x18b>
    3be1:	41 39 47 48          	cmp    %eax,0x48(%r15)
    3be5:	0f 83 bd 00 00 00    	jae    3ca8 <vfs_mkdir+0x248>
    3beb:	49 8b 47 20          	mov    0x20(%r15),%rax
    3bef:	4c 89 e7             	mov    %r12,%rdi
    3bf2:	44 89 f1             	mov    %r14d,%ecx
    3bf5:	48 89 da             	mov    %rbx,%rdx
    3bf8:	4c 89 fe             	mov    %r15,%rsi
    3bfb:	48 8b 40 48          	mov    0x48(%rax),%rax
    3bff:	e8 00 00 00 00       	call   3c04 <vfs_mkdir+0x1a4>
    3c04:	49 89 c4             	mov    %rax,%r12
    3c07:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    3c0d:	0f 87 0c ff ff ff    	ja     3b1f <vfs_mkdir+0xbf>
    3c13:	48 85 c0             	test   %rax,%rax
    3c16:	74 0b                	je     3c23 <vfs_mkdir+0x1c3>
    3c18:	48 89 df             	mov    %rbx,%rdi
    3c1b:	4c 89 e3             	mov    %r12,%rbx
    3c1e:	e8 00 00 00 00       	call   3c23 <vfs_mkdir+0x1c3>
    3c23:	49 8b 85 70 0d 00 00 	mov    0xd70(%r13),%rax
    3c2a:	48 85 c0             	test   %rax,%rax
    3c2d:	74 16                	je     3c45 <vfs_mkdir+0x1e5>
    3c2f:	8b 10                	mov    (%rax),%edx
    3c31:	85 d2                	test   %edx,%edx
    3c33:	75 10                	jne    3c45 <vfs_mkdir+0x1e5>
    3c35:	ba 04 00 00 00       	mov    $0x4,%edx
    3c3a:	48 89 de             	mov    %rbx,%rsi
    3c3d:	4c 89 ff             	mov    %r15,%rdi
    3c40:	e8 00 00 00 00       	call   3c45 <vfs_mkdir+0x1e5>
    3c45:	49 8b 47 28          	mov    0x28(%r15),%rax
    3c49:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    3c50:	48 85 c0             	test   %rax,%rax
    3c53:	74 28                	je     3c7d <vfs_mkdir+0x21d>
    3c55:	48 8b 40 08          	mov    0x8(%rax),%rax
    3c59:	48 85 c0             	test   %rax,%rax
    3c5c:	74 1f                	je     3c7d <vfs_mkdir+0x21d>
    3c5e:	6a 00                	push   $0x0
    3c60:	45 31 c9             	xor    %r9d,%r9d
    3c63:	4c 8d 43 20          	lea    0x20(%rbx),%r8
    3c67:	4c 89 f9             	mov    %r15,%rcx
    3c6a:	ba 04 00 00 00       	mov    $0x4,%edx
    3c6f:	48 89 de             	mov    %rbx,%rsi
    3c72:	bf 00 01 00 40       	mov    $0x40000100,%edi
    3c77:	e8 00 00 00 00       	call   3c7c <vfs_mkdir+0x21c>
    3c7c:	58                   	pop    %rax
    3c7d:	49 89 dc             	mov    %rbx,%r12
    3c80:	e9 a2 fe ff ff       	jmp    3b27 <vfs_mkdir+0xc7>
    3c85:	4c 63 e0             	movslq %eax,%r12
    3c88:	e9 92 fe ff ff       	jmp    3b1f <vfs_mkdir+0xbf>
    3c8d:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    3c94:	e9 86 fe ff ff       	jmp    3b1f <vfs_mkdir+0xbf>
    3c99:	e8 00 00 00 00       	call   3c9e <vfs_mkdir+0x23e>
    3c9e:	f7 d0                	not    %eax
    3ca0:	41 21 c6             	and    %eax,%r14d
    3ca3:	e9 15 ff ff ff       	jmp    3bbd <vfs_mkdir+0x15d>
    3ca8:	49 c7 c4 e1 ff ff ff 	mov    $0xffffffffffffffe1,%r12
    3caf:	e9 6b fe ff ff       	jmp    3b1f <vfs_mkdir+0xbf>
    3cb4:	49 c7 c4 ef ff ff ff 	mov    $0xffffffffffffffef,%r12
    3cbb:	e9 5f fe ff ff       	jmp    3b1f <vfs_mkdir+0xbf>
    3cc0:	49 c7 c4 fe ff ff ff 	mov    $0xfffffffffffffffe,%r12
    3cc7:	e9 53 fe ff ff       	jmp    3b1f <vfs_mkdir+0xbf>
    3ccc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003cd0 <__pfx_vfs_mknod>:
    3cd0:	90                   	nop
    3cd1:	90                   	nop
    3cd2:	90                   	nop
    3cd3:	90                   	nop
    3cd4:	90                   	nop
    3cd5:	90                   	nop
    3cd6:	90                   	nop
    3cd7:	90                   	nop
    3cd8:	90                   	nop
    3cd9:	90                   	nop
    3cda:	90                   	nop
    3cdb:	90                   	nop
    3cdc:	90                   	nop
    3cdd:	90                   	nop
    3cde:	90                   	nop
    3cdf:	90                   	nop

0000000000003ce0 <vfs_mknod>:
    3ce0:	e8 00 00 00 00       	call   3ce5 <vfs_mknod+0x5>
    3ce5:	55                   	push   %rbp
    3ce6:	48 89 e5             	mov    %rsp,%rbp
    3ce9:	41 57                	push   %r15
    3ceb:	41 56                	push   %r14
    3ced:	45 89 c6             	mov    %r8d,%r14d
    3cf0:	41 55                	push   %r13
    3cf2:	41 89 cd             	mov    %ecx,%r13d
    3cf5:	41 54                	push   %r12
    3cf7:	49 89 fc             	mov    %rdi,%r12
    3cfa:	53                   	push   %rbx
    3cfb:	48 89 f3             	mov    %rsi,%rbx
    3cfe:	48 83 ec 18          	sub    $0x18,%rsp
    3d02:	65 4c 8b 3d 00 00 00 	mov    %gs:0x0(%rip),%r15        # 3d0a <vfs_mknod+0x2a>
    3d09:	00 
    3d0a:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
    3d0e:	49 8b 87 70 0d 00 00 	mov    0xd70(%r15),%rax
    3d15:	48 85 c0             	test   %rax,%rax
    3d18:	74 0a                	je     3d24 <vfs_mknod+0x44>
    3d1a:	8b 08                	mov    (%rax),%ecx
    3d1c:	85 c9                	test   %ecx,%ecx
    3d1e:	0f 84 9e 00 00 00    	je     3dc2 <vfs_mknod+0xe2>
    3d24:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    3d28:	48 83 78 30 00       	cmpq   $0x0,0x30(%rax)
    3d2d:	0f 85 93 02 00 00    	jne    3fc6 <vfs_mknod+0x2e6>
    3d33:	f6 43 0c 10          	testb  $0x10,0xc(%rbx)
    3d37:	0f 85 94 02 00 00    	jne    3fd1 <vfs_mknod+0x2f1>
    3d3d:	48 8b 43 28          	mov    0x28(%rbx),%rax
    3d41:	4c 89 e7             	mov    %r12,%rdi
    3d44:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    3d4b:	49 8b 87 a0 0c 00 00 	mov    0xca0(%r15),%rax
    3d52:	8b 50 20             	mov    0x20(%rax),%edx
    3d55:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
    3d59:	e8 00 00 00 00       	call   3d5e <vfs_mknod+0x7e>
    3d5e:	83 f8 ff             	cmp    $0xffffffff,%eax
    3d61:	74 32                	je     3d95 <vfs_mknod+0xb5>
    3d63:	89 45 c4             	mov    %eax,-0x3c(%rbp)
    3d66:	49 8b 87 a0 0c 00 00 	mov    0xca0(%r15),%rax
    3d6d:	4c 89 e7             	mov    %r12,%rdi
    3d70:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
    3d74:	8b 50 24             	mov    0x24(%rax),%edx
    3d77:	e8 00 00 00 00       	call   3d7c <vfs_mknod+0x9c>
    3d7c:	83 f8 ff             	cmp    $0xffffffff,%eax
    3d7f:	89 45 c0             	mov    %eax,-0x40(%rbp)
    3d82:	74 11                	je     3d95 <vfs_mknod+0xb5>
    3d84:	8b 75 c4             	mov    -0x3c(%rbp),%esi
    3d87:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    3d8b:	e8 00 00 00 00       	call   3d90 <vfs_mknod+0xb0>
    3d90:	83 f8 ff             	cmp    $0xffffffff,%eax
    3d93:	75 42                	jne    3dd7 <vfs_mknod+0xf7>
    3d95:	41 ba b5 ff ff ff    	mov    $0xffffffb5,%r10d
    3d9b:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    3d9f:	44 89 d0             	mov    %r10d,%eax
    3da2:	5b                   	pop    %rbx
    3da3:	41 5c                	pop    %r12
    3da5:	41 5d                	pop    %r13
    3da7:	41 5e                	pop    %r14
    3da9:	41 5f                	pop    %r15
    3dab:	5d                   	pop    %rbp
    3dac:	31 d2                	xor    %edx,%edx
    3dae:	31 c9                	xor    %ecx,%ecx
    3db0:	31 f6                	xor    %esi,%esi
    3db2:	31 ff                	xor    %edi,%edi
    3db4:	45 31 c0             	xor    %r8d,%r8d
    3db7:	45 31 c9             	xor    %r9d,%r9d
    3dba:	45 31 d2             	xor    %r10d,%r10d
    3dbd:	e9 00 00 00 00       	jmp    3dc2 <vfs_mknod+0xe2>
    3dc2:	48 89 d6             	mov    %rdx,%rsi
    3dc5:	48 89 df             	mov    %rbx,%rdi
    3dc8:	ba 04 00 00 00       	mov    $0x4,%edx
    3dcd:	e8 00 00 00 00       	call   3dd2 <vfs_mknod+0xf2>
    3dd2:	e9 4d ff ff ff       	jmp    3d24 <vfs_mknod+0x44>
    3dd7:	8b 75 c0             	mov    -0x40(%rbp),%esi
    3dda:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    3dde:	e8 00 00 00 00       	call   3de3 <vfs_mknod+0x103>
    3de3:	83 f8 ff             	cmp    $0xffffffff,%eax
    3de6:	74 ad                	je     3d95 <vfs_mknod+0xb5>
    3de8:	ba 03 00 00 00       	mov    $0x3,%edx
    3ded:	48 89 de             	mov    %rbx,%rsi
    3df0:	4c 89 e7             	mov    %r12,%rdi
    3df3:	e8 00 00 00 00       	call   3df8 <vfs_mknod+0x118>
    3df8:	41 89 c2             	mov    %eax,%r10d
    3dfb:	85 c0                	test   %eax,%eax
    3dfd:	75 9c                	jne    3d9b <vfs_mknod+0xbb>
    3dff:	44 89 e9             	mov    %r13d,%ecx
    3e02:	66 81 e1 00 f0       	and    $0xf000,%cx
    3e07:	66 81 f9 00 20       	cmp    $0x2000,%cx
    3e0c:	0f 94 c2             	sete   %dl
    3e0f:	45 85 f6             	test   %r14d,%r14d
    3e12:	0f 94 c0             	sete   %al
    3e15:	84 c2                	test   %al,%dl
    3e17:	75 11                	jne    3e2a <vfs_mknod+0x14a>
    3e19:	44 89 e8             	mov    %r13d,%eax
    3e1c:	66 25 00 b0          	and    $0xb000,%ax
    3e20:	66 3d 00 20          	cmp    $0x2000,%ax
    3e24:	0f 84 62 01 00 00    	je     3f8c <vfs_mknod+0x2ac>
    3e2a:	48 8b 43 20          	mov    0x20(%rbx),%rax
    3e2e:	48 83 78 58 00       	cmpq   $0x0,0x58(%rax)
    3e33:	0f 84 6b 01 00 00    	je     3fa4 <vfs_mknod+0x2c4>
    3e39:	41 0f b7 d5          	movzwl %r13w,%edx
    3e3d:	48 89 de             	mov    %rbx,%rsi
    3e40:	4c 89 e7             	mov    %r12,%rdi
    3e43:	89 4d c8             	mov    %ecx,-0x38(%rbp)
    3e46:	e8 00 00 00 00       	call   3e4b <vfs_mknod+0x16b>
    3e4b:	8b 4d c8             	mov    -0x38(%rbp),%ecx
    3e4e:	89 c2                	mov    %eax,%edx
    3e50:	48 8b 43 28          	mov    0x28(%rbx),%rax
    3e54:	f6 40 52 01          	testb  $0x1,0x52(%rax)
    3e58:	75 0a                	jne    3e64 <vfs_mknod+0x184>
    3e5a:	f6 40 59 10          	testb  $0x10,0x59(%rax)
    3e5e:	0f 84 4b 01 00 00    	je     3faf <vfs_mknod+0x2cf>
    3e64:	44 21 ea             	and    %r13d,%edx
    3e67:	89 c8                	mov    %ecx,%eax
    3e69:	66 81 e2 ff 0f       	and    $0xfff,%dx
    3e6e:	66 25 00 b0          	and    $0xb000,%ax
    3e72:	09 ca                	or     %ecx,%edx
    3e74:	44 0f b7 ea          	movzwl %dx,%r13d
    3e78:	66 3d 00 20          	cmp    $0x2000,%ax
    3e7c:	75 3a                	jne    3eb8 <vfs_mknod+0x1d8>
    3e7e:	44 89 e8             	mov    %r13d,%eax
    3e81:	bf 01 00 00 00       	mov    $0x1,%edi
    3e86:	66 25 00 f0          	and    $0xf000,%ax
    3e8a:	66 3d 00 20          	cmp    $0x2000,%ax
    3e8e:	0f 84 e5 00 00 00    	je     3f79 <vfs_mknod+0x299>
    3e94:	44 89 f2             	mov    %r14d,%edx
    3e97:	44 89 f6             	mov    %r14d,%esi
    3e9a:	b9 01 00 00 00       	mov    $0x1,%ecx
    3e9f:	81 e2 ff ff 0f 00    	and    $0xfffff,%edx
    3ea5:	c1 ee 14             	shr    $0x14,%esi
    3ea8:	e8 00 00 00 00       	call   3ead <vfs_mknod+0x1cd>
    3ead:	41 89 c2             	mov    %eax,%r10d
    3eb0:	85 c0                	test   %eax,%eax
    3eb2:	0f 85 e3 fe ff ff    	jne    3d9b <vfs_mknod+0xbb>
    3eb8:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    3ebc:	44 89 f1             	mov    %r14d,%ecx
    3ebf:	44 89 ea             	mov    %r13d,%edx
    3ec2:	48 89 df             	mov    %rbx,%rdi
    3ec5:	e8 00 00 00 00       	call   3eca <vfs_mknod+0x1ea>
    3eca:	41 89 c2             	mov    %eax,%r10d
    3ecd:	85 c0                	test   %eax,%eax
    3ecf:	0f 85 c6 fe ff ff    	jne    3d9b <vfs_mknod+0xbb>
    3ed5:	48 8b 43 20          	mov    0x20(%rbx),%rax
    3ed9:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
    3edd:	45 89 f0             	mov    %r14d,%r8d
    3ee0:	44 89 e9             	mov    %r13d,%ecx
    3ee3:	48 89 de             	mov    %rbx,%rsi
    3ee6:	4c 89 e7             	mov    %r12,%rdi
    3ee9:	48 8b 40 58          	mov    0x58(%rax),%rax
    3eed:	e8 00 00 00 00       	call   3ef2 <vfs_mknod+0x212>
    3ef2:	41 89 c2             	mov    %eax,%r10d
    3ef5:	85 c0                	test   %eax,%eax
    3ef7:	0f 85 9e fe ff ff    	jne    3d9b <vfs_mknod+0xbb>
    3efd:	49 8b 87 70 0d 00 00 	mov    0xd70(%r15),%rax
    3f04:	48 85 c0             	test   %rax,%rax
    3f07:	74 1f                	je     3f28 <vfs_mknod+0x248>
    3f09:	8b 10                	mov    (%rax),%edx
    3f0b:	85 d2                	test   %edx,%edx
    3f0d:	75 19                	jne    3f28 <vfs_mknod+0x248>
    3f0f:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    3f13:	ba 04 00 00 00       	mov    $0x4,%edx
    3f18:	48 89 df             	mov    %rbx,%rdi
    3f1b:	44 89 55 c8          	mov    %r10d,-0x38(%rbp)
    3f1f:	e8 00 00 00 00       	call   3f24 <vfs_mknod+0x244>
    3f24:	44 8b 55 c8          	mov    -0x38(%rbp),%r10d
    3f28:	48 8b 43 28          	mov    0x28(%rbx),%rax
    3f2c:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    3f33:	48 85 c0             	test   %rax,%rax
    3f36:	0f 84 5f fe ff ff    	je     3d9b <vfs_mknod+0xbb>
    3f3c:	48 8b 40 08          	mov    0x8(%rax),%rax
    3f40:	48 85 c0             	test   %rax,%rax
    3f43:	0f 84 52 fe ff ff    	je     3d9b <vfs_mknod+0xbb>
    3f49:	44 89 55 c8          	mov    %r10d,-0x38(%rbp)
    3f4d:	45 31 c9             	xor    %r9d,%r9d
    3f50:	48 89 d9             	mov    %rbx,%rcx
    3f53:	ba 04 00 00 00       	mov    $0x4,%edx
    3f58:	6a 00                	push   $0x0
    3f5a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    3f5e:	bf 00 01 00 00       	mov    $0x100,%edi
    3f63:	4c 8d 40 20          	lea    0x20(%rax),%r8
    3f67:	48 89 c6             	mov    %rax,%rsi
    3f6a:	e8 00 00 00 00       	call   3f6f <vfs_mknod+0x28f>
    3f6f:	44 8b 55 c8          	mov    -0x38(%rbp),%r10d
    3f73:	58                   	pop    %rax
    3f74:	e9 22 fe ff ff       	jmp    3d9b <vfs_mknod+0xbb>
    3f79:	45 85 f6             	test   %r14d,%r14d
    3f7c:	0f 84 36 ff ff ff    	je     3eb8 <vfs_mknod+0x1d8>
    3f82:	bf 02 00 00 00       	mov    $0x2,%edi
    3f87:	e9 08 ff ff ff       	jmp    3e94 <vfs_mknod+0x1b4>
    3f8c:	bf 1b 00 00 00       	mov    $0x1b,%edi
    3f91:	89 4d c8             	mov    %ecx,-0x38(%rbp)
    3f94:	e8 00 00 00 00       	call   3f99 <vfs_mknod+0x2b9>
    3f99:	8b 4d c8             	mov    -0x38(%rbp),%ecx
    3f9c:	84 c0                	test   %al,%al
    3f9e:	0f 85 86 fe ff ff    	jne    3e2a <vfs_mknod+0x14a>
    3fa4:	41 ba ff ff ff ff    	mov    $0xffffffff,%r10d
    3faa:	e9 ec fd ff ff       	jmp    3d9b <vfs_mknod+0xbb>
    3faf:	89 55 c4             	mov    %edx,-0x3c(%rbp)
    3fb2:	e8 00 00 00 00       	call   3fb7 <vfs_mknod+0x2d7>
    3fb7:	8b 55 c4             	mov    -0x3c(%rbp),%edx
    3fba:	8b 4d c8             	mov    -0x38(%rbp),%ecx
    3fbd:	f7 d0                	not    %eax
    3fbf:	21 c2                	and    %eax,%edx
    3fc1:	e9 9e fe ff ff       	jmp    3e64 <vfs_mknod+0x184>
    3fc6:	41 ba ef ff ff ff    	mov    $0xffffffef,%r10d
    3fcc:	e9 ca fd ff ff       	jmp    3d9b <vfs_mknod+0xbb>
    3fd1:	41 ba fe ff ff ff    	mov    $0xfffffffe,%r10d
    3fd7:	e9 bf fd ff ff       	jmp    3d9b <vfs_mknod+0xbb>
    3fdc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003fe0 <__pfx_vfs_link>:
    3fe0:	90                   	nop
    3fe1:	90                   	nop
    3fe2:	90                   	nop
    3fe3:	90                   	nop
    3fe4:	90                   	nop
    3fe5:	90                   	nop
    3fe6:	90                   	nop
    3fe7:	90                   	nop
    3fe8:	90                   	nop
    3fe9:	90                   	nop
    3fea:	90                   	nop
    3feb:	90                   	nop
    3fec:	90                   	nop
    3fed:	90                   	nop
    3fee:	90                   	nop
    3fef:	90                   	nop

0000000000003ff0 <vfs_link>:
    3ff0:	e8 00 00 00 00       	call   3ff5 <vfs_link+0x5>
    3ff5:	55                   	push   %rbp
    3ff6:	48 89 e5             	mov    %rsp,%rbp
    3ff9:	41 57                	push   %r15
    3ffb:	41 56                	push   %r14
    3ffd:	41 55                	push   %r13
    3fff:	41 54                	push   %r12
    4001:	53                   	push   %rbx
    4002:	48 83 ec 28          	sub    $0x28,%rsp
    4006:	48 8b 42 28          	mov    0x28(%rdx),%rax
    400a:	4c 8b 67 30          	mov    0x30(%rdi),%r12
    400e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    4012:	4c 89 45 b8          	mov    %r8,-0x48(%rbp)
    4016:	8b 80 20 04 00 00    	mov    0x420(%rax),%eax
    401c:	89 45 c4             	mov    %eax,-0x3c(%rbp)
    401f:	4d 85 e4             	test   %r12,%r12
    4022:	0f 84 b4 01 00 00    	je     41dc <vfs_link+0x1ec>
    4028:	65 4c 8b 3d 00 00 00 	mov    %gs:0x0(%rip),%r15        # 4030 <vfs_link+0x40>
    402f:	00 
    4030:	49 89 f5             	mov    %rsi,%r13
    4033:	48 89 d3             	mov    %rdx,%rbx
    4036:	49 89 ce             	mov    %rcx,%r14
    4039:	49 8b 87 70 0d 00 00 	mov    0xd70(%r15),%rax
    4040:	48 85 c0             	test   %rax,%rax
    4043:	74 0a                	je     404f <vfs_link+0x5f>
    4045:	8b 30                	mov    (%rax),%esi
    4047:	85 f6                	test   %esi,%esi
    4049:	0f 84 9a 00 00 00    	je     40e9 <vfs_link+0xf9>
    404f:	49 83 7e 30 00       	cmpq   $0x0,0x30(%r14)
    4054:	0f 85 86 03 00 00    	jne    43e0 <vfs_link+0x3f0>
    405a:	f6 43 0c 10          	testb  $0x10,0xc(%rbx)
    405e:	0f 85 78 01 00 00    	jne    41dc <vfs_link+0x1ec>
    4064:	48 8b 43 28          	mov    0x28(%rbx),%rax
    4068:	4c 89 ef             	mov    %r13,%rdi
    406b:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    4072:	49 8b 87 a0 0c 00 00 	mov    0xca0(%r15),%rax
    4079:	8b 50 20             	mov    0x20(%rax),%edx
    407c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    4080:	e8 00 00 00 00       	call   4085 <vfs_link+0x95>
    4085:	83 f8 ff             	cmp    $0xffffffff,%eax
    4088:	74 32                	je     40bc <vfs_link+0xcc>
    408a:	89 45 c0             	mov    %eax,-0x40(%rbp)
    408d:	49 8b 87 a0 0c 00 00 	mov    0xca0(%r15),%rax
    4094:	4c 89 ef             	mov    %r13,%rdi
    4097:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    409b:	8b 50 24             	mov    0x24(%rax),%edx
    409e:	e8 00 00 00 00       	call   40a3 <vfs_link+0xb3>
    40a3:	83 f8 ff             	cmp    $0xffffffff,%eax
    40a6:	89 45 b4             	mov    %eax,-0x4c(%rbp)
    40a9:	74 11                	je     40bc <vfs_link+0xcc>
    40ab:	8b 75 c0             	mov    -0x40(%rbp),%esi
    40ae:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    40b2:	e8 00 00 00 00       	call   40b7 <vfs_link+0xc7>
    40b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    40ba:	75 42                	jne    40fe <vfs_link+0x10e>
    40bc:	41 ba b5 ff ff ff    	mov    $0xffffffb5,%r10d
    40c2:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    40c6:	44 89 d0             	mov    %r10d,%eax
    40c9:	5b                   	pop    %rbx
    40ca:	41 5c                	pop    %r12
    40cc:	41 5d                	pop    %r13
    40ce:	41 5e                	pop    %r14
    40d0:	41 5f                	pop    %r15
    40d2:	5d                   	pop    %rbp
    40d3:	31 d2                	xor    %edx,%edx
    40d5:	31 c9                	xor    %ecx,%ecx
    40d7:	31 f6                	xor    %esi,%esi
    40d9:	31 ff                	xor    %edi,%edi
    40db:	45 31 c0             	xor    %r8d,%r8d
    40de:	45 31 c9             	xor    %r9d,%r9d
    40e1:	45 31 d2             	xor    %r10d,%r10d
    40e4:	e9 00 00 00 00       	jmp    40e9 <vfs_link+0xf9>
    40e9:	ba 04 00 00 00       	mov    $0x4,%edx
    40ee:	48 89 ce             	mov    %rcx,%rsi
    40f1:	48 89 df             	mov    %rbx,%rdi
    40f4:	e8 00 00 00 00       	call   40f9 <vfs_link+0x109>
    40f9:	e9 51 ff ff ff       	jmp    404f <vfs_link+0x5f>
    40fe:	8b 75 b4             	mov    -0x4c(%rbp),%esi
    4101:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    4105:	e8 00 00 00 00       	call   410a <vfs_link+0x11a>
    410a:	83 f8 ff             	cmp    $0xffffffff,%eax
    410d:	74 ad                	je     40bc <vfs_link+0xcc>
    410f:	ba 03 00 00 00       	mov    $0x3,%edx
    4114:	48 89 de             	mov    %rbx,%rsi
    4117:	4c 89 ef             	mov    %r13,%rdi
    411a:	e8 00 00 00 00       	call   411f <vfs_link+0x12f>
    411f:	41 89 c2             	mov    %eax,%r10d
    4122:	85 c0                	test   %eax,%eax
    4124:	75 9c                	jne    40c2 <vfs_link+0xd2>
    4126:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    412b:	48 39 43 28          	cmp    %rax,0x28(%rbx)
    412f:	0f 85 b6 02 00 00    	jne    43eb <vfs_link+0x3fb>
    4135:	41 f6 44 24 0c 0c    	testb  $0xc,0xc(%r12)
    413b:	0f 85 a6 00 00 00    	jne    41e7 <vfs_link+0x1f7>
    4141:	41 8b 54 24 04       	mov    0x4(%r12),%edx
    4146:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    414d:	4c 89 ef             	mov    %r13,%rdi
    4150:	e8 00 00 00 00       	call   4155 <vfs_link+0x165>
    4155:	83 f8 ff             	cmp    $0xffffffff,%eax
    4158:	0f 84 89 00 00 00    	je     41e7 <vfs_link+0x1f7>
    415e:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    4163:	41 8b 54 24 08       	mov    0x8(%r12),%edx
    4168:	4c 89 ef             	mov    %r13,%rdi
    416b:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    4172:	e8 00 00 00 00       	call   4177 <vfs_link+0x187>
    4177:	83 f8 ff             	cmp    $0xffffffff,%eax
    417a:	74 6b                	je     41e7 <vfs_link+0x1f7>
    417c:	48 8b 43 20          	mov    0x20(%rbx),%rax
    4180:	48 83 78 30 00       	cmpq   $0x0,0x30(%rax)
    4185:	74 60                	je     41e7 <vfs_link+0x1f7>
    4187:	41 0f b7 04 24       	movzwl (%r12),%eax
    418c:	66 25 00 f0          	and    $0xf000,%ax
    4190:	66 3d 00 40          	cmp    $0x4000,%ax
    4194:	74 51                	je     41e7 <vfs_link+0x1f7>
    4196:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    419a:	4c 89 f2             	mov    %r14,%rdx
    419d:	48 89 de             	mov    %rbx,%rsi
    41a0:	e8 00 00 00 00       	call   41a5 <vfs_link+0x1b5>
    41a5:	41 89 c2             	mov    %eax,%r10d
    41a8:	85 c0                	test   %eax,%eax
    41aa:	0f 85 12 ff ff ff    	jne    40c2 <vfs_link+0xd2>
    41b0:	4d 8d ac 24 98 00 00 	lea    0x98(%r12),%r13
    41b7:	00 
    41b8:	4c 89 ef             	mov    %r13,%rdi
    41bb:	e8 00 00 00 00       	call   41c0 <vfs_link+0x1d0>
    41c0:	41 8b 54 24 48       	mov    0x48(%r12),%edx
    41c5:	85 d2                	test   %edx,%edx
    41c7:	75 29                	jne    41f2 <vfs_link+0x202>
    41c9:	41 f6 84 24 91 00 00 	testb  $0x4,0x91(%r12)
    41d0:	00 04 
    41d2:	75 3b                	jne    420f <vfs_link+0x21f>
    41d4:	4c 89 ef             	mov    %r13,%rdi
    41d7:	e8 00 00 00 00       	call   41dc <vfs_link+0x1ec>
    41dc:	41 ba fe ff ff ff    	mov    $0xfffffffe,%r10d
    41e2:	e9 db fe ff ff       	jmp    40c2 <vfs_link+0xd2>
    41e7:	41 ba ff ff ff ff    	mov    $0xffffffff,%r10d
    41ed:	e9 d0 fe ff ff       	jmp    40c2 <vfs_link+0xd2>
    41f2:	8b 45 c4             	mov    -0x3c(%rbp),%eax
    41f5:	83 e8 01             	sub    $0x1,%eax
    41f8:	39 d0                	cmp    %edx,%eax
    41fa:	73 13                	jae    420f <vfs_link+0x21f>
    41fc:	4c 89 ef             	mov    %r13,%rdi
    41ff:	e8 00 00 00 00       	call   4204 <vfs_link+0x214>
    4204:	41 ba e1 ff ff ff    	mov    $0xffffffe1,%r10d
    420a:	e9 b3 fe ff ff       	jmp    40c2 <vfs_link+0xd2>
    420f:	49 8b 84 24 68 01 00 	mov    0x168(%r12),%rax
    4216:	00 
    4217:	48 85 c0             	test   %rax,%rax
    421a:	74 47                	je     4263 <vfs_link+0x273>
    421c:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
    4222:	48 8b 50 28          	mov    0x28(%rax),%rdx
    4226:	48 8d 48 28          	lea    0x28(%rax),%rcx
    422a:	48 39 ca             	cmp    %rcx,%rdx
    422d:	0f 84 9b 01 00 00    	je     43ce <vfs_link+0x3de>
    4233:	ba 04 00 00 00       	mov    $0x4,%edx
    4238:	be 01 08 00 00       	mov    $0x801,%esi
    423d:	4c 89 e7             	mov    %r12,%rdi
    4240:	e8 00 00 00 00       	call   4245 <vfs_link+0x255>
    4245:	41 89 c2             	mov    %eax,%r10d
    4248:	83 f8 f5             	cmp    $0xfffffff5,%eax
    424b:	75 0d                	jne    425a <vfs_link+0x26a>
    424d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    4251:	48 85 c0             	test   %rax,%rax
    4254:	0f 85 14 01 00 00    	jne    436e <vfs_link+0x37e>
    425a:	45 85 d2             	test   %r10d,%r10d
    425d:	0f 85 1c 01 00 00    	jne    437f <vfs_link+0x38f>
    4263:	48 8b 43 20          	mov    0x20(%rbx),%rax
    4267:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    426b:	4c 89 f2             	mov    %r14,%rdx
    426e:	48 89 de             	mov    %rbx,%rsi
    4271:	48 8b 40 30          	mov    0x30(%rax),%rax
    4275:	e8 00 00 00 00       	call   427a <vfs_link+0x28a>
    427a:	41 89 c2             	mov    %eax,%r10d
    427d:	85 c0                	test   %eax,%eax
    427f:	0f 85 fa 00 00 00    	jne    437f <vfs_link+0x38f>
    4285:	41 f6 84 24 91 00 00 	testb  $0x4,0x91(%r12)
    428c:	00 04 
    428e:	0f 85 00 01 00 00    	jne    4394 <vfs_link+0x3a4>
    4294:	4c 89 ef             	mov    %r13,%rdi
    4297:	89 45 d0             	mov    %eax,-0x30(%rbp)
    429a:	e8 00 00 00 00       	call   429f <vfs_link+0x2af>
    429f:	44 8b 55 d0          	mov    -0x30(%rbp),%r10d
    42a3:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    42a8:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    42af:	48 85 c0             	test   %rax,%rax
    42b2:	74 43                	je     42f7 <vfs_link+0x307>
    42b4:	48 8b 40 08          	mov    0x8(%rax),%rax
    42b8:	48 85 c0             	test   %rax,%rax
    42bb:	74 3a                	je     42f7 <vfs_link+0x307>
    42bd:	41 0f b7 04 24       	movzwl (%r12),%eax
    42c2:	44 89 55 d0          	mov    %r10d,-0x30(%rbp)
    42c6:	4d 89 e1             	mov    %r12,%r9
    42c9:	4c 89 e6             	mov    %r12,%rsi
    42cc:	6a 00                	push   $0x0
    42ce:	bf 04 00 00 40       	mov    $0x40000004,%edi
    42d3:	ba 03 00 00 00       	mov    $0x3,%edx
    42d8:	66 25 00 f0          	and    $0xf000,%ax
    42dc:	66 3d 00 40          	cmp    $0x4000,%ax
    42e0:	b8 04 00 00 00       	mov    $0x4,%eax
    42e5:	0f 45 f8             	cmovne %eax,%edi
    42e8:	31 c9                	xor    %ecx,%ecx
    42ea:	45 31 c0             	xor    %r8d,%r8d
    42ed:	e8 00 00 00 00       	call   42f2 <vfs_link+0x302>
    42f2:	44 8b 55 d0          	mov    -0x30(%rbp),%r10d
    42f6:	59                   	pop    %rcx
    42f7:	49 8b 87 70 0d 00 00 	mov    0xd70(%r15),%rax
    42fe:	48 85 c0             	test   %rax,%rax
    4301:	74 1e                	je     4321 <vfs_link+0x331>
    4303:	8b 10                	mov    (%rax),%edx
    4305:	85 d2                	test   %edx,%edx
    4307:	75 18                	jne    4321 <vfs_link+0x331>
    4309:	ba 04 00 00 00       	mov    $0x4,%edx
    430e:	4c 89 f6             	mov    %r14,%rsi
    4311:	48 89 df             	mov    %rbx,%rdi
    4314:	44 89 55 d0          	mov    %r10d,-0x30(%rbp)
    4318:	e8 00 00 00 00       	call   431d <vfs_link+0x32d>
    431d:	44 8b 55 d0          	mov    -0x30(%rbp),%r10d
    4321:	48 8b 43 28          	mov    0x28(%rbx),%rax
    4325:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    432c:	48 85 c0             	test   %rax,%rax
    432f:	0f 84 8d fd ff ff    	je     40c2 <vfs_link+0xd2>
    4335:	48 8b 40 08          	mov    0x8(%rax),%rax
    4339:	48 85 c0             	test   %rax,%rax
    433c:	0f 84 80 fd ff ff    	je     40c2 <vfs_link+0xd2>
    4342:	44 89 55 d0          	mov    %r10d,-0x30(%rbp)
    4346:	45 31 c9             	xor    %r9d,%r9d
    4349:	4d 8d 46 20          	lea    0x20(%r14),%r8
    434d:	48 89 d9             	mov    %rbx,%rcx
    4350:	6a 00                	push   $0x0
    4352:	ba 03 00 00 00       	mov    $0x3,%edx
    4357:	4c 89 e6             	mov    %r12,%rsi
    435a:	bf 00 01 00 00       	mov    $0x100,%edi
    435f:	e8 00 00 00 00       	call   4364 <vfs_link+0x374>
    4364:	44 8b 55 d0          	mov    -0x30(%rbp),%r10d
    4368:	58                   	pop    %rax
    4369:	e9 54 fd ff ff       	jmp    40c2 <vfs_link+0xd2>
    436e:	4c 89 20             	mov    %r12,(%rax)
    4371:	4c 89 e7             	mov    %r12,%rdi
    4374:	e8 00 00 00 00       	call   4379 <vfs_link+0x389>
    4379:	41 ba f5 ff ff ff    	mov    $0xfffffff5,%r10d
    437f:	4c 89 ef             	mov    %r13,%rdi
    4382:	44 89 55 d0          	mov    %r10d,-0x30(%rbp)
    4386:	e8 00 00 00 00       	call   438b <vfs_link+0x39b>
    438b:	44 8b 55 d0          	mov    -0x30(%rbp),%r10d
    438f:	e9 2e fd ff ff       	jmp    40c2 <vfs_link+0xd2>
    4394:	49 8d bc 24 80 00 00 	lea    0x80(%r12),%rdi
    439b:	00 
    439c:	89 45 c8             	mov    %eax,-0x38(%rbp)
    439f:	48 89 7d d0          	mov    %rdi,-0x30(%rbp)
    43a3:	e8 00 00 00 00       	call   43a8 <vfs_link+0x3b8>
    43a8:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    43ac:	41 81 a4 24 90 00 00 	andl   $0xfffffbff,0x90(%r12)
    43b3:	00 ff fb ff ff 
    43b8:	e8 00 00 00 00       	call   43bd <vfs_link+0x3cd>
    43bd:	4c 89 ef             	mov    %r13,%rdi
    43c0:	e8 00 00 00 00       	call   43c5 <vfs_link+0x3d5>
    43c5:	44 8b 55 c8          	mov    -0x38(%rbp),%r10d
    43c9:	e9 d5 fe ff ff       	jmp    42a3 <vfs_link+0x2b3>
    43ce:	48 8b 40 30          	mov    0x30(%rax),%rax
    43d2:	48 39 c2             	cmp    %rax,%rdx
    43d5:	0f 85 58 fe ff ff    	jne    4233 <vfs_link+0x243>
    43db:	e9 83 fe ff ff       	jmp    4263 <vfs_link+0x273>
    43e0:	41 ba ef ff ff ff    	mov    $0xffffffef,%r10d
    43e6:	e9 d7 fc ff ff       	jmp    40c2 <vfs_link+0xd2>
    43eb:	41 ba ee ff ff ff    	mov    $0xffffffee,%r10d
    43f1:	e9 cc fc ff ff       	jmp    40c2 <vfs_link+0xd2>
    43f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    43fd:	00 00 00 

0000000000004400 <__pfx_path_init>:
    4400:	90                   	nop
    4401:	90                   	nop
    4402:	90                   	nop
    4403:	90                   	nop
    4404:	90                   	nop
    4405:	90                   	nop
    4406:	90                   	nop
    4407:	90                   	nop
    4408:	90                   	nop
    4409:	90                   	nop
    440a:	90                   	nop
    440b:	90                   	nop
    440c:	90                   	nop
    440d:	90                   	nop
    440e:	90                   	nop
    440f:	90                   	nop

0000000000004410 <path_init>:
    4410:	e8 00 00 00 00       	call   4415 <path_init+0x5>
    4415:	55                   	push   %rbp
    4416:	89 f0                	mov    %esi,%eax
    4418:	25 00 03 00 00       	and    $0x300,%eax
    441d:	48 89 e5             	mov    %rsp,%rbp
    4420:	41 57                	push   %r15
    4422:	41 56                	push   %r14
    4424:	41 55                	push   %r13
    4426:	49 c7 c5 f5 ff ff ff 	mov    $0xfffffffffffffff5,%r13
    442d:	41 54                	push   %r12
    442f:	53                   	push   %rbx
    4430:	48 83 ec 08          	sub    $0x8,%rsp
    4434:	3d 00 02 00 00       	cmp    $0x200,%eax
    4439:	0f 84 b4 00 00 00    	je     44f3 <path_init+0xe3>
    443f:	4c 8b af d0 00 00 00 	mov    0xd0(%rdi),%r13
    4446:	48 89 fb             	mov    %rdi,%rbx
    4449:	41 89 f4             	mov    %esi,%r12d
    444c:	41 80 7d 00 00       	cmpb   $0x0,0x0(%r13)
    4451:	0f 84 ba 00 00 00    	je     4511 <path_init+0x101>
    4457:	f7 c6 00 01 00 00    	test   $0x100,%esi
    445d:	0f 84 b5 00 00 00    	je     4518 <path_init+0x108>
    4463:	e8 00 00 00 00       	call   4468 <path_init+0x58>
    4468:	41 be 00 01 00 00    	mov    $0x100,%r14d
    446e:	83 4b 3c 04          	orl    $0x4,0x3c(%rbx)
    4472:	44 89 63 38          	mov    %r12d,0x38(%rbx)
    4476:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 447c <path_init+0x6c>
    447c:	a8 01                	test   $0x1,%al
    447e:	0f 85 66 02 00 00    	jne    46ea <path_init+0x2da>
    4484:	89 43 48             	mov    %eax,0x48(%rbx)
    4487:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 448d <path_init+0x7d>
    448d:	a8 01                	test   $0x1,%al
    448f:	0f 85 43 02 00 00    	jne    46d8 <path_init+0x2c8>
    4495:	89 43 4c             	mov    %eax,0x4c(%rbx)
    4498:	f6 43 3c 01          	testb  $0x1,0x3c(%rbx)
    449c:	0f 84 86 00 00 00    	je     4528 <path_init+0x118>
    44a2:	48 8b 4b 28          	mov    0x28(%rbx),%rcx
    44a6:	41 80 7d 00 00       	cmpb   $0x0,0x0(%r13)
    44ab:	48 8b 71 30          	mov    0x30(%rcx),%rsi
    44af:	74 12                	je     44c3 <path_init+0xb3>
    44b1:	8b 01                	mov    (%rcx),%eax
    44b3:	25 00 00 38 00       	and    $0x380000,%eax
    44b8:	3d 00 00 10 00       	cmp    $0x100000,%eax
    44bd:	0f 85 59 03 00 00    	jne    481c <path_init+0x40c>
    44c3:	48 8b 43 20          	mov    0x20(%rbx),%rax
    44c7:	48 8b 53 28          	mov    0x28(%rbx),%rdx
    44cb:	48 89 73 30          	mov    %rsi,0x30(%rbx)
    44cf:	48 89 03             	mov    %rax,(%rbx)
    44d2:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    44d6:	45 85 f6             	test   %r14d,%r14d
    44d9:	0f 84 40 02 00 00    	je     471f <path_init+0x30f>
    44df:	8b 41 04             	mov    0x4(%rcx),%eax
    44e2:	a8 01                	test   $0x1,%al
    44e4:	0f 85 c2 02 00 00    	jne    47ac <path_init+0x39c>
    44ea:	89 43 40             	mov    %eax,0x40(%rbx)
    44ed:	89 83 e0 00 00 00    	mov    %eax,0xe0(%rbx)
    44f3:	48 83 c4 08          	add    $0x8,%rsp
    44f7:	4c 89 e8             	mov    %r13,%rax
    44fa:	5b                   	pop    %rbx
    44fb:	41 5c                	pop    %r12
    44fd:	41 5d                	pop    %r13
    44ff:	41 5e                	pop    %r14
    4501:	41 5f                	pop    %r15
    4503:	5d                   	pop    %rbp
    4504:	31 d2                	xor    %edx,%edx
    4506:	31 c9                	xor    %ecx,%ecx
    4508:	31 f6                	xor    %esi,%esi
    450a:	31 ff                	xor    %edi,%edi
    450c:	e9 00 00 00 00       	jmp    4511 <path_init+0x101>
    4511:	41 81 e4 ff fe ff ff 	and    $0xfffffeff,%r12d
    4518:	48 c7 43 40 00 00 00 	movq   $0x0,0x40(%rbx)
    451f:	00 
    4520:	45 31 f6             	xor    %r14d,%r14d
    4523:	e9 46 ff ff ff       	jmp    446e <path_init+0x5e>
    4528:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
    452f:	00 
    4530:	41 80 7d 00 2f       	cmpb   $0x2f,0x0(%r13)
    4535:	0f 84 c1 01 00 00    	je     46fc <path_init+0x2ec>
    453b:	8b bb e4 00 00 00    	mov    0xe4(%rbx),%edi
    4541:	83 ff 9c             	cmp    $0xffffff9c,%edi
    4544:	0f 85 80 00 00 00    	jne    45ca <path_init+0x1ba>
    454a:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 4552 <path_init+0x142>
    4551:	00 
    4552:	4c 8b b8 f0 0c 00 00 	mov    0xcf0(%rax),%r15
    4559:	45 85 f6             	test   %r14d,%r14d
    455c:	0f 84 e0 01 00 00    	je     4742 <path_init+0x332>
    4562:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    4566:	f6 c1 01             	test   $0x1,%cl
    4569:	0f 85 c5 02 00 00    	jne    4834 <path_init+0x424>
    456f:	49 8b 47 28          	mov    0x28(%r15),%rax
    4573:	49 8b 57 30          	mov    0x30(%r15),%rdx
    4577:	48 89 03             	mov    %rax,(%rbx)
    457a:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    457e:	48 8b 43 08          	mov    0x8(%rbx),%rax
    4582:	48 8b 50 30          	mov    0x30(%rax),%rdx
    4586:	48 89 53 30          	mov    %rdx,0x30(%rbx)
    458a:	8b 40 04             	mov    0x4(%rax),%eax
    458d:	a8 01                	test   $0x1,%al
    458f:	0f 85 2a 02 00 00    	jne    47bf <path_init+0x3af>
    4595:	89 43 40             	mov    %eax,0x40(%rbx)
    4598:	41 8b 47 04          	mov    0x4(%r15),%eax
    459c:	39 c1                	cmp    %eax,%ecx
    459e:	75 c2                	jne    4562 <path_init+0x152>
    45a0:	41 81 e4 00 00 00 18 	and    $0x18000000,%r12d
    45a7:	0f 84 46 ff ff ff    	je     44f3 <path_init+0xe3>
    45ad:	48 8b 03             	mov    (%rbx),%rax
    45b0:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    45b4:	48 89 43 20          	mov    %rax,0x20(%rbx)
    45b8:	48 89 53 28          	mov    %rdx,0x28(%rbx)
    45bc:	8b 43 40             	mov    0x40(%rbx),%eax
    45bf:	89 83 e0 00 00 00    	mov    %eax,0xe0(%rbx)
    45c5:	e9 29 ff ff ff       	jmp    44f3 <path_init+0xe3>
    45ca:	e8 00 00 00 00       	call   45cf <path_init+0x1bf>
    45cf:	49 89 c7             	mov    %rax,%r15
    45d2:	48 85 c0             	test   %rax,%rax
    45d5:	0f 84 4d 02 00 00    	je     4828 <path_init+0x418>
    45db:	48 89 c2             	mov    %rax,%rdx
    45de:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
    45e2:	41 f6 c4 10          	test   $0x10,%r12b
    45e6:	74 50                	je     4638 <path_init+0x228>
    45e8:	65 48 8b 0d 00 00 00 	mov    %gs:0x0(%rip),%rcx        # 45f0 <path_init+0x1e0>
    45ef:	00 
    45f0:	48 8b 42 30          	mov    0x30(%rdx),%rax
    45f4:	48 3b 81 a0 0c 00 00 	cmp    0xca0(%rcx),%rax
    45fb:	74 3b                	je     4638 <path_init+0x228>
    45fd:	48 8b b8 90 00 00 00 	mov    0x90(%rax),%rdi
    4604:	be 02 00 00 00       	mov    $0x2,%esi
    4609:	48 89 14 24          	mov    %rdx,(%rsp)
    460d:	e8 00 00 00 00       	call   4612 <path_init+0x202>
    4612:	48 8b 14 24          	mov    (%rsp),%rdx
    4616:	84 c0                	test   %al,%al
    4618:	75 1e                	jne    4638 <path_init+0x228>
    461a:	49 c7 c5 fe ff ff ff 	mov    $0xfffffffffffffffe,%r13
    4621:	41 83 e7 01          	and    $0x1,%r15d
    4625:	0f 84 c8 fe ff ff    	je     44f3 <path_init+0xe3>
    462b:	48 89 d7             	mov    %rdx,%rdi
    462e:	e8 00 00 00 00       	call   4633 <path_init+0x223>
    4633:	e9 bb fe ff ff       	jmp    44f3 <path_init+0xe3>
    4638:	41 80 7d 00 00       	cmpb   $0x0,0x0(%r13)
    463d:	48 8b 42 48          	mov    0x48(%rdx),%rax
    4641:	74 14                	je     4657 <path_init+0x247>
    4643:	8b 08                	mov    (%rax),%ecx
    4645:	81 e1 00 00 38 00    	and    $0x380000,%ecx
    464b:	81 f9 00 00 10 00    	cmp    $0x100000,%ecx
    4651:	0f 85 f1 01 00 00    	jne    4848 <path_init+0x438>
    4657:	48 8b 72 40          	mov    0x40(%rdx),%rsi
    465b:	48 8b 7a 48          	mov    0x48(%rdx),%rdi
    465f:	48 89 33             	mov    %rsi,(%rbx)
    4662:	48 89 7b 08          	mov    %rdi,0x8(%rbx)
    4666:	45 85 f6             	test   %r14d,%r14d
    4669:	0f 84 76 01 00 00    	je     47e5 <path_init+0x3d5>
    466f:	48 8b 48 30          	mov    0x30(%rax),%rcx
    4673:	48 89 4b 30          	mov    %rcx,0x30(%rbx)
    4677:	8b 40 04             	mov    0x4(%rax),%eax
    467a:	a8 01                	test   $0x1,%al
    467c:	0f 85 50 01 00 00    	jne    47d2 <path_init+0x3c2>
    4682:	89 43 40             	mov    %eax,0x40(%rbx)
    4685:	41 83 e7 01          	and    $0x1,%r15d
    4689:	0f 85 ac 01 00 00    	jne    483b <path_init+0x42b>
    468f:	41 81 e4 00 00 00 18 	and    $0x18000000,%r12d
    4696:	0f 84 57 fe ff ff    	je     44f3 <path_init+0xe3>
    469c:	48 8b 03             	mov    (%rbx),%rax
    469f:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    46a3:	48 89 43 20          	mov    %rax,0x20(%rbx)
    46a7:	48 89 53 28          	mov    %rdx,0x28(%rbx)
    46ab:	45 85 f6             	test   %r14d,%r14d
    46ae:	0f 85 08 ff ff ff    	jne    45bc <path_init+0x1ac>
    46b4:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    46b8:	e8 00 00 00 00       	call   46bd <path_init+0x2ad>
    46bd:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    46c1:	48 85 ff             	test   %rdi,%rdi
    46c4:	74 09                	je     46cf <path_init+0x2bf>
    46c6:	48 83 ef 80          	sub    $0xffffffffffffff80,%rdi
    46ca:	e8 00 00 00 00       	call   46cf <path_init+0x2bf>
    46cf:	83 4b 3c 02          	orl    $0x2,0x3c(%rbx)
    46d3:	e9 1b fe ff ff       	jmp    44f3 <path_init+0xe3>
    46d8:	f3 90                	pause
    46da:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 46e0 <path_init+0x2d0>
    46e0:	a8 01                	test   $0x1,%al
    46e2:	0f 84 ad fd ff ff    	je     4495 <path_init+0x85>
    46e8:	eb ee                	jmp    46d8 <path_init+0x2c8>
    46ea:	f3 90                	pause
    46ec:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 46f2 <path_init+0x2e2>
    46f2:	a8 01                	test   $0x1,%al
    46f4:	0f 84 8a fd ff ff    	je     4484 <path_init+0x74>
    46fa:	eb ee                	jmp    46ea <path_init+0x2da>
    46fc:	41 f7 c4 00 00 00 10 	test   $0x10000000,%r12d
    4703:	0f 85 32 fe ff ff    	jne    453b <path_init+0x12b>
    4709:	48 89 df             	mov    %rbx,%rdi
    470c:	e8 af e7 ff ff       	call   2ec0 <nd_jump_root>
    4711:	48 63 d0             	movslq %eax,%rdx
    4714:	85 c0                	test   %eax,%eax
    4716:	4c 0f 45 ea          	cmovne %rdx,%r13
    471a:	e9 d4 fd ff ff       	jmp    44f3 <path_init+0xe3>
    471f:	48 8b 3b             	mov    (%rbx),%rdi
    4722:	e8 00 00 00 00       	call   4727 <path_init+0x317>
    4727:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    472b:	48 85 ff             	test   %rdi,%rdi
    472e:	0f 84 bf fd ff ff    	je     44f3 <path_init+0xe3>
    4734:	48 83 ef 80          	sub    $0xffffffffffffff80,%rdi
    4738:	e8 00 00 00 00       	call   473d <path_init+0x32d>
    473d:	e9 b1 fd ff ff       	jmp    44f3 <path_init+0xe3>
    4742:	4d 8d 77 08          	lea    0x8(%r15),%r14
    4746:	4c 89 f7             	mov    %r14,%rdi
    4749:	e8 00 00 00 00       	call   474e <path_init+0x33e>
    474e:	49 8b 47 28          	mov    0x28(%r15),%rax
    4752:	49 8b 57 30          	mov    0x30(%r15),%rdx
    4756:	48 89 03             	mov    %rax,(%rbx)
    4759:	48 89 c7             	mov    %rax,%rdi
    475c:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    4760:	e8 00 00 00 00       	call   4765 <path_init+0x355>
    4765:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    4769:	48 85 ff             	test   %rdi,%rdi
    476c:	74 09                	je     4777 <path_init+0x367>
    476e:	48 83 ef 80          	sub    $0xffffffffffffff80,%rdi
    4772:	e8 00 00 00 00       	call   4777 <path_init+0x367>
    4777:	4c 89 f7             	mov    %r14,%rdi
    477a:	e8 00 00 00 00       	call   477f <path_init+0x36f>
    477f:	48 8b 43 08          	mov    0x8(%rbx),%rax
    4783:	41 81 e4 00 00 00 18 	and    $0x18000000,%r12d
    478a:	48 8b 40 30          	mov    0x30(%rax),%rax
    478e:	48 89 43 30          	mov    %rax,0x30(%rbx)
    4792:	0f 84 5b fd ff ff    	je     44f3 <path_init+0xe3>
    4798:	48 8b 03             	mov    (%rbx),%rax
    479b:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    479f:	48 89 43 20          	mov    %rax,0x20(%rbx)
    47a3:	48 89 53 28          	mov    %rdx,0x28(%rbx)
    47a7:	e9 08 ff ff ff       	jmp    46b4 <path_init+0x2a4>
    47ac:	f3 90                	pause
    47ae:	48 8b 43 08          	mov    0x8(%rbx),%rax
    47b2:	8b 40 04             	mov    0x4(%rax),%eax
    47b5:	a8 01                	test   $0x1,%al
    47b7:	0f 84 2d fd ff ff    	je     44ea <path_init+0xda>
    47bd:	eb ed                	jmp    47ac <path_init+0x39c>
    47bf:	f3 90                	pause
    47c1:	48 8b 43 08          	mov    0x8(%rbx),%rax
    47c5:	8b 40 04             	mov    0x4(%rax),%eax
    47c8:	a8 01                	test   $0x1,%al
    47ca:	0f 84 c5 fd ff ff    	je     4595 <path_init+0x185>
    47d0:	eb ed                	jmp    47bf <path_init+0x3af>
    47d2:	f3 90                	pause
    47d4:	48 8b 43 08          	mov    0x8(%rbx),%rax
    47d8:	8b 40 04             	mov    0x4(%rax),%eax
    47db:	a8 01                	test   $0x1,%al
    47dd:	0f 84 9f fe ff ff    	je     4682 <path_init+0x272>
    47e3:	eb ed                	jmp    47d2 <path_init+0x3c2>
    47e5:	48 8b 3b             	mov    (%rbx),%rdi
    47e8:	48 89 14 24          	mov    %rdx,(%rsp)
    47ec:	e8 00 00 00 00       	call   47f1 <path_init+0x3e1>
    47f1:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    47f5:	48 8b 14 24          	mov    (%rsp),%rdx
    47f9:	48 85 ff             	test   %rdi,%rdi
    47fc:	74 11                	je     480f <path_init+0x3ff>
    47fe:	48 83 ef 80          	sub    $0xffffffffffffff80,%rdi
    4802:	e8 00 00 00 00       	call   4807 <path_init+0x3f7>
    4807:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    480b:	48 8b 14 24          	mov    (%rsp),%rdx
    480f:	48 8b 47 30          	mov    0x30(%rdi),%rax
    4813:	48 89 43 30          	mov    %rax,0x30(%rbx)
    4817:	e9 69 fe ff ff       	jmp    4685 <path_init+0x275>
    481c:	49 c7 c5 ec ff ff ff 	mov    $0xffffffffffffffec,%r13
    4823:	e9 cb fc ff ff       	jmp    44f3 <path_init+0xe3>
    4828:	49 c7 c5 f7 ff ff ff 	mov    $0xfffffffffffffff7,%r13
    482f:	e9 bf fc ff ff       	jmp    44f3 <path_init+0xe3>
    4834:	f3 90                	pause
    4836:	e9 27 fd ff ff       	jmp    4562 <path_init+0x152>
    483b:	48 89 d7             	mov    %rdx,%rdi
    483e:	e8 00 00 00 00       	call   4843 <path_init+0x433>
    4843:	e9 47 fe ff ff       	jmp    468f <path_init+0x27f>
    4848:	49 c7 c5 ec ff ff ff 	mov    $0xffffffffffffffec,%r13
    484f:	e9 cd fd ff ff       	jmp    4621 <path_init+0x211>
    4854:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    485b:	00 00 00 00 
    485f:	90                   	nop

0000000000004860 <__pfx_vfs_rename>:
    4860:	90                   	nop
    4861:	90                   	nop
    4862:	90                   	nop
    4863:	90                   	nop
    4864:	90                   	nop
    4865:	90                   	nop
    4866:	90                   	nop
    4867:	90                   	nop
    4868:	90                   	nop
    4869:	90                   	nop
    486a:	90                   	nop
    486b:	90                   	nop
    486c:	90                   	nop
    486d:	90                   	nop
    486e:	90                   	nop
    486f:	90                   	nop

0000000000004870 <vfs_rename>:
    4870:	e8 00 00 00 00       	call   4875 <vfs_rename+0x5>
    4875:	55                   	push   %rbp
    4876:	b9 07 00 00 00       	mov    $0x7,%ecx
    487b:	48 89 e5             	mov    %rsp,%rbp
    487e:	41 57                	push   %r15
    4880:	45 31 ff             	xor    %r15d,%r15d
    4883:	41 56                	push   %r14
    4885:	49 89 fe             	mov    %rdi,%r14
    4888:	41 55                	push   %r13
    488a:	41 54                	push   %r12
    488c:	53                   	push   %rbx
    488d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    4891:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
    4898:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    489c:	4c 8b 67 28          	mov    0x28(%rdi),%r12
    48a0:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 48a8 <vfs_rename+0x38>
    48a7:	00 
    48a8:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    48af:	00 
    48b0:	48 8b 47 08          	mov    0x8(%rdi),%rax
    48b4:	4c 8b 5b 30          	mov    0x30(%rbx),%r11
    48b8:	4d 8b 54 24 30       	mov    0x30(%r12),%r10
    48bd:	8b 13                	mov    (%rbx),%edx
    48bf:	4c 89 5c 24 30       	mov    %r11,0x30(%rsp)
    48c4:	48 8b 70 30          	mov    0x30(%rax),%rsi
    48c8:	48 8b 47 20          	mov    0x20(%rdi),%rax
    48cc:	4c 8b 68 30          	mov    0x30(%rax),%r13
    48d0:	48 8b 47 30          	mov    0x30(%rdi),%rax
    48d4:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
    48d9:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    48de:	8b 47 38             	mov    0x38(%rdi),%eax
    48e1:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    48e6:	89 44 24 4c          	mov    %eax,0x4c(%rsp)
    48ea:	49 8b 45 28          	mov    0x28(%r13),%rax
    48ee:	4c 89 54 24 40       	mov    %r10,0x40(%rsp)
    48f3:	8b 80 20 04 00 00    	mov    0x420(%rax),%eax
    48f9:	89 44 24 2c          	mov    %eax,0x2c(%rsp)
    48fd:	31 c0                	xor    %eax,%eax
    48ff:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    4902:	4d 39 d3             	cmp    %r10,%r11
    4905:	0f 84 3a 02 00 00    	je     4b45 <vfs_rename+0x2d5>
    490b:	81 e2 00 00 30 00    	and    $0x300000,%edx
    4911:	49 8b 3e             	mov    (%r14),%rdi
    4914:	81 fa 00 00 10 00    	cmp    $0x100000,%edx
    491a:	89 54 24 48          	mov    %edx,0x48(%rsp)
    491e:	48 89 da             	mov    %rbx,%rdx
    4921:	0f 94 c0             	sete   %al
    4924:	0f 94 44 24 17       	sete   0x17(%rsp)
    4929:	0f b6 c0             	movzbl %al,%eax
    492c:	89 c1                	mov    %eax,%ecx
    492e:	89 44 24 28          	mov    %eax,0x28(%rsp)
    4932:	e8 29 e0 ff ff       	call   2960 <may_delete>
    4937:	41 89 c7             	mov    %eax,%r15d
    493a:	85 c0                	test   %eax,%eax
    493c:	0f 85 03 02 00 00    	jne    4b45 <vfs_rename+0x2d5>
    4942:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    4948:	4d 8b 7e 18          	mov    0x18(%r14),%r15
    494c:	0f 84 5b 02 00 00    	je     4bad <vfs_rename+0x33d>
    4952:	41 8b 04 24          	mov    (%r12),%eax
    4956:	25 00 00 30 00       	and    $0x300000,%eax
    495b:	3d 00 00 10 00       	cmp    $0x100000,%eax
    4960:	0f 94 44 24 18       	sete   0x18(%rsp)
    4965:	f6 44 24 4c 02       	testb  $0x2,0x4c(%rsp)
    496a:	0f 84 15 02 00 00    	je     4b85 <vfs_rename+0x315>
    4970:	0f b6 4c 24 18       	movzbl 0x18(%rsp),%ecx
    4975:	4c 89 ff             	mov    %r15,%rdi
    4978:	4c 89 e2             	mov    %r12,%rdx
    497b:	4c 89 ee             	mov    %r13,%rsi
    497e:	e8 dd df ff ff       	call   2960 <may_delete>
    4983:	41 89 c7             	mov    %eax,%r15d
    4986:	45 85 ff             	test   %r15d,%r15d
    4989:	0f 85 b6 01 00 00    	jne    4b45 <vfs_rename+0x2d5>
    498f:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    4994:	48 8b 41 20          	mov    0x20(%rcx),%rax
    4998:	48 83 78 60 00       	cmpq   $0x0,0x60(%rax)
    499d:	0f 84 bd 09 00 00    	je     5360 <vfs_rename+0xaf0>
    49a3:	49 39 cd             	cmp    %rcx,%r13
    49a6:	74 20                	je     49c8 <vfs_rename+0x158>
    49a8:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    49af:	00 
    49b0:	0f 84 d8 01 00 00    	je     4b8e <vfs_rename+0x31e>
    49b6:	f6 44 24 4c 02       	testb  $0x2,0x4c(%rsp)
    49bb:	74 0b                	je     49c8 <vfs_rename+0x158>
    49bd:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    49c2:	0f 85 87 04 00 00    	jne    4e4f <vfs_rename+0x5df>
    49c8:	44 8b 44 24 4c       	mov    0x4c(%rsp),%r8d
    49cd:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
    49d2:	4c 89 e1             	mov    %r12,%rcx
    49d5:	4c 89 ea             	mov    %r13,%rdx
    49d8:	48 89 de             	mov    %rbx,%rsi
    49db:	e8 00 00 00 00       	call   49e0 <vfs_rename+0x170>
    49e0:	41 89 c7             	mov    %eax,%r15d
    49e3:	85 c0                	test   %eax,%eax
    49e5:	0f 85 5a 01 00 00    	jne    4b45 <vfs_rename+0x2d5>
    49eb:	48 89 de             	mov    %rbx,%rsi
    49ee:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    49f3:	e8 00 00 00 00       	call   49f8 <vfs_rename+0x188>
    49f8:	4d 85 e4             	test   %r12,%r12
    49fb:	74 0d                	je     4a0a <vfs_rename+0x19a>
    49fd:	49 8d bc 24 80 00 00 	lea    0x80(%r12),%rdi
    4a04:	00 
    4a05:	e8 00 00 00 00       	call   4a0a <vfs_rename+0x19a>
    4a0a:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    4a0f:	49 39 c5             	cmp    %rax,%r13
    4a12:	0f 95 44 24 10       	setne  0x10(%rsp)
    4a17:	0f 84 03 03 00 00    	je     4d20 <vfs_rename+0x4b0>
    4a1d:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    4a24:	00 
    4a25:	0f 84 47 04 00 00    	je     4e72 <vfs_rename+0x602>
    4a2b:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    4a30:	0f 84 6a 02 00 00    	je     4ca0 <vfs_rename+0x430>
    4a36:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    4a3b:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    4a42:	e8 00 00 00 00       	call   4a47 <vfs_rename+0x1d7>
    4a47:	0f b6 44 24 18       	movzbl 0x18(%rsp),%eax
    4a4c:	88 44 24 08          	mov    %al,0x8(%rsp)
    4a50:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    4a55:	48 05 98 00 00 00    	add    $0x98,%rax
    4a5b:	48 89 c7             	mov    %rax,%rdi
    4a5e:	48 89 04 24          	mov    %rax,(%rsp)
    4a62:	e8 00 00 00 00       	call   4a67 <vfs_rename+0x1f7>
    4a67:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    4a6c:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    4a70:	0f 85 f8 04 00 00    	jne    4f6e <vfs_rename+0x6fe>
    4a76:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    4a7c:	74 0f                	je     4a8d <vfs_rename+0x21d>
    4a7e:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    4a83:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    4a87:	0f 85 17 05 00 00    	jne    4fa4 <vfs_rename+0x734>
    4a8d:	f7 03 00 80 00 00    	testl  $0x8000,(%rbx)
    4a93:	0f 84 b5 02 00 00    	je     4d4e <vfs_rename+0x4de>
    4a99:	48 89 df             	mov    %rbx,%rdi
    4a9c:	e8 00 00 00 00       	call   4aa1 <vfs_rename+0x231>
    4aa1:	84 c0                	test   %al,%al
    4aa3:	0f 84 a5 02 00 00    	je     4d4e <vfs_rename+0x4de>
    4aa9:	41 be f0 ff ff ff    	mov    $0xfffffff0,%r14d
    4aaf:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    4ab6:	00 
    4ab7:	0f 85 e1 07 00 00    	jne    529e <vfs_rename+0xa2e>
    4abd:	80 7c 24 10 00       	cmpb   $0x0,0x10(%rsp)
    4ac2:	0f 85 d6 07 00 00    	jne    529e <vfs_rename+0xa2e>
    4ac8:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    4ace:	74 16                	je     4ae6 <vfs_rename+0x276>
    4ad0:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    4ad5:	0f 84 db 06 00 00    	je     51b6 <vfs_rename+0x946>
    4adb:	80 7c 24 08 00       	cmpb   $0x0,0x8(%rsp)
    4ae0:	0f 85 d0 06 00 00    	jne    51b6 <vfs_rename+0x946>
    4ae6:	4c 89 e7             	mov    %r12,%rdi
    4ae9:	e8 00 00 00 00       	call   4aee <vfs_rename+0x27e>
    4aee:	45 85 f6             	test   %r14d,%r14d
    4af1:	0f 85 61 09 00 00    	jne    5458 <vfs_rename+0xbe8>
    4af7:	f6 44 24 4c 02       	testb  $0x2,0x4c(%rsp)
    4afc:	0f 84 e4 03 00 00    	je     4ee6 <vfs_rename+0x676>
    4b02:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
    4b07:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
    4b0b:	49 89 d9             	mov    %rbx,%r9
    4b0e:	45 31 c0             	xor    %r8d,%r8d
    4b11:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
    4b16:	4c 89 ee             	mov    %r13,%rsi
    4b19:	4c 89 f7             	mov    %r14,%rdi
    4b1c:	e8 cf db ff ff       	call   26f0 <fsnotify_move>
    4b21:	0f b6 4c 24 18       	movzbl 0x18(%rsp),%ecx
    4b26:	4d 89 e1             	mov    %r12,%r9
    4b29:	45 31 c0             	xor    %r8d,%r8d
    4b2c:	48 8d 53 20          	lea    0x20(%rbx),%rdx
    4b30:	4c 89 f6             	mov    %r14,%rsi
    4b33:	4c 89 ef             	mov    %r13,%rdi
    4b36:	e8 b5 db ff ff       	call   26f0 <fsnotify_move>
    4b3b:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    4b40:	e8 00 00 00 00       	call   4b45 <vfs_rename+0x2d5>
    4b45:	48 8b 84 24 88 00 00 	mov    0x88(%rsp),%rax
    4b4c:	00 
    4b4d:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 4b55 <vfs_rename+0x2e5>
    4b54:	00 
    4b55:	0f 85 73 08 00 00    	jne    53ce <vfs_rename+0xb5e>
    4b5b:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    4b5f:	44 89 f8             	mov    %r15d,%eax
    4b62:	5b                   	pop    %rbx
    4b63:	41 5c                	pop    %r12
    4b65:	41 5d                	pop    %r13
    4b67:	41 5e                	pop    %r14
    4b69:	41 5f                	pop    %r15
    4b6b:	5d                   	pop    %rbp
    4b6c:	31 d2                	xor    %edx,%edx
    4b6e:	31 c9                	xor    %ecx,%ecx
    4b70:	31 f6                	xor    %esi,%esi
    4b72:	31 ff                	xor    %edi,%edi
    4b74:	45 31 c0             	xor    %r8d,%r8d
    4b77:	45 31 c9             	xor    %r9d,%r9d
    4b7a:	45 31 d2             	xor    %r10d,%r10d
    4b7d:	45 31 db             	xor    %r11d,%r11d
    4b80:	e9 00 00 00 00       	jmp    4b85 <vfs_rename+0x315>
    4b85:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
    4b89:	e9 e7 fd ff ff       	jmp    4975 <vfs_rename+0x105>
    4b8e:	49 8b 3e             	mov    (%r14),%rdi
    4b91:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    4b96:	ba 02 00 00 00       	mov    $0x2,%edx
    4b9b:	e8 00 00 00 00       	call   4ba0 <vfs_rename+0x330>
    4ba0:	41 89 c7             	mov    %eax,%r15d
    4ba3:	85 c0                	test   %eax,%eax
    4ba5:	0f 84 0b fe ff ff    	je     49b6 <vfs_rename+0x146>
    4bab:	eb 98                	jmp    4b45 <vfs_rename+0x2d5>
    4bad:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 4bb5 <vfs_rename+0x345>
    4bb4:	00 
    4bb5:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    4bbc:	48 85 c0             	test   %rax,%rax
    4bbf:	74 0a                	je     4bcb <vfs_rename+0x35b>
    4bc1:	8b 10                	mov    (%rax),%edx
    4bc3:	85 d2                	test   %edx,%edx
    4bc5:	0f 84 c0 00 00 00    	je     4c8b <vfs_rename+0x41b>
    4bcb:	49 83 7c 24 30 00    	cmpq   $0x0,0x30(%r12)
    4bd1:	0f 85 2b 07 00 00    	jne    5302 <vfs_rename+0xa92>
    4bd7:	41 f6 45 0c 10       	testb  $0x10,0xc(%r13)
    4bdc:	0f 85 61 07 00 00    	jne    5343 <vfs_rename+0xad3>
    4be2:	49 8b 45 28          	mov    0x28(%r13),%rax
    4be6:	4c 89 ff             	mov    %r15,%rdi
    4be9:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    4bf0:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 4bf8 <vfs_rename+0x388>
    4bf7:	00 
    4bf8:	48 8b 80 a0 0c 00 00 	mov    0xca0(%rax),%rax
    4bff:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    4c04:	8b 50 20             	mov    0x20(%rax),%edx
    4c07:	e8 00 00 00 00       	call   4c0c <vfs_rename+0x39c>
    4c0c:	83 f8 ff             	cmp    $0xffffffff,%eax
    4c0f:	74 6f                	je     4c80 <vfs_rename+0x410>
    4c11:	89 44 24 10          	mov    %eax,0x10(%rsp)
    4c15:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 4c1d <vfs_rename+0x3ad>
    4c1c:	00 
    4c1d:	4c 89 ff             	mov    %r15,%rdi
    4c20:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    4c25:	48 8b 80 a0 0c 00 00 	mov    0xca0(%rax),%rax
    4c2c:	8b 50 24             	mov    0x24(%rax),%edx
    4c2f:	e8 00 00 00 00       	call   4c34 <vfs_rename+0x3c4>
    4c34:	83 f8 ff             	cmp    $0xffffffff,%eax
    4c37:	89 44 24 08          	mov    %eax,0x8(%rsp)
    4c3b:	74 43                	je     4c80 <vfs_rename+0x410>
    4c3d:	8b 74 24 10          	mov    0x10(%rsp),%esi
    4c41:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    4c46:	e8 00 00 00 00       	call   4c4b <vfs_rename+0x3db>
    4c4b:	83 f8 ff             	cmp    $0xffffffff,%eax
    4c4e:	74 30                	je     4c80 <vfs_rename+0x410>
    4c50:	8b 74 24 08          	mov    0x8(%rsp),%esi
    4c54:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    4c59:	e8 00 00 00 00       	call   4c5e <vfs_rename+0x3ee>
    4c5e:	83 f8 ff             	cmp    $0xffffffff,%eax
    4c61:	74 1d                	je     4c80 <vfs_rename+0x410>
    4c63:	4c 89 ff             	mov    %r15,%rdi
    4c66:	ba 03 00 00 00       	mov    $0x3,%edx
    4c6b:	4c 89 ee             	mov    %r13,%rsi
    4c6e:	e8 00 00 00 00       	call   4c73 <vfs_rename+0x403>
    4c73:	c6 44 24 18 00       	movb   $0x0,0x18(%rsp)
    4c78:	41 89 c7             	mov    %eax,%r15d
    4c7b:	e9 06 fd ff ff       	jmp    4986 <vfs_rename+0x116>
    4c80:	41 bf b5 ff ff ff    	mov    $0xffffffb5,%r15d
    4c86:	e9 ba fe ff ff       	jmp    4b45 <vfs_rename+0x2d5>
    4c8b:	ba 04 00 00 00       	mov    $0x4,%edx
    4c90:	4c 89 e6             	mov    %r12,%rsi
    4c93:	4c 89 ef             	mov    %r13,%rdi
    4c96:	e8 00 00 00 00       	call   4c9b <vfs_rename+0x42b>
    4c9b:	e9 2b ff ff ff       	jmp    4bcb <vfs_rename+0x35b>
    4ca0:	c6 44 24 08 01       	movb   $0x1,0x8(%rsp)
    4ca5:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
    4caa:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    4caf:	e8 00 00 00 00       	call   4cb4 <vfs_rename+0x444>
    4cb4:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    4cb9:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    4cbd:	0f 84 b3 fd ff ff    	je     4a76 <vfs_rename+0x206>
    4cc3:	48 89 c7             	mov    %rax,%rdi
    4cc6:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
    4ccc:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    4cd3:	e8 00 00 00 00       	call   4cd8 <vfs_rename+0x468>
    4cd8:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    4cde:	74 2d                	je     4d0d <vfs_rename+0x49d>
    4ce0:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
    4ce5:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    4cec:	e8 00 00 00 00       	call   4cf1 <vfs_rename+0x481>
    4cf1:	4c 89 e7             	mov    %r12,%rdi
    4cf4:	e8 00 00 00 00       	call   4cf9 <vfs_rename+0x489>
    4cf9:	e9 3d fe ff ff       	jmp    4b3b <vfs_rename+0x2cb>
    4cfe:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    4d03:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    4d07:	0f 84 97 01 00 00    	je     4ea4 <vfs_rename+0x634>
    4d0d:	4c 89 e7             	mov    %r12,%rdi
    4d10:	e8 00 00 00 00       	call   4d15 <vfs_rename+0x4a5>
    4d15:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
    4d1b:	e9 1b fe ff ff       	jmp    4b3b <vfs_rename+0x2cb>
    4d20:	f6 44 24 4c 02       	testb  $0x2,0x4c(%rsp)
    4d25:	0f 84 de 01 00 00    	je     4f09 <vfs_rename+0x699>
    4d2b:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    4d32:	00 
    4d33:	0f 84 3b 04 00 00    	je     5174 <vfs_rename+0x904>
    4d39:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    4d3e:	c6 44 24 08 00       	movb   $0x0,0x8(%rsp)
    4d43:	0f 85 07 fd ff ff    	jne    4a50 <vfs_rename+0x1e0>
    4d49:	e9 57 ff ff ff       	jmp    4ca5 <vfs_rename+0x435>
    4d4e:	41 f7 04 24 00 80 00 	testl  $0x8000,(%r12)
    4d55:	00 
    4d56:	74 10                	je     4d68 <vfs_rename+0x4f8>
    4d58:	4c 89 e7             	mov    %r12,%rdi
    4d5b:	e8 00 00 00 00       	call   4d60 <vfs_rename+0x4f0>
    4d60:	84 c0                	test   %al,%al
    4d62:	0f 85 41 fd ff ff    	jne    4aa9 <vfs_rename+0x239>
    4d68:	8b 44 24 2c          	mov    0x2c(%rsp),%eax
    4d6c:	85 c0                	test   %eax,%eax
    4d6e:	0f 84 4c 03 00 00    	je     50c0 <vfs_rename+0x850>
    4d74:	80 7c 24 10 00       	cmpb   $0x0,0x10(%rsp)
    4d79:	0f 84 41 03 00 00    	je     50c0 <vfs_rename+0x850>
    4d7f:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    4d84:	0f 85 74 04 00 00    	jne    51fe <vfs_rename+0x98e>
    4d8a:	80 7c 24 17 00       	cmpb   $0x0,0x17(%rsp)
    4d8f:	0f 84 69 04 00 00    	je     51fe <vfs_rename+0x98e>
    4d95:	8b 44 24 2c          	mov    0x2c(%rsp),%eax
    4d99:	41 39 45 48          	cmp    %eax,0x48(%r13)
    4d9d:	0f 83 6a 05 00 00    	jae    530d <vfs_rename+0xa9d>
    4da3:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    4da8:	48 85 c0             	test   %rax,%rax
    4dab:	0f 84 36 02 00 00    	je     4fe7 <vfs_rename+0x777>
    4db1:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    4db6:	0f 85 2b 02 00 00    	jne    4fe7 <vfs_rename+0x777>
    4dbc:	48 8b 80 68 01 00 00 	mov    0x168(%rax),%rax
    4dc3:	48 85 c0             	test   %rax,%rax
    4dc6:	0f 84 1b 02 00 00    	je     4fe7 <vfs_rename+0x777>
    4dcc:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
    4dd2:	48 8b 50 28          	mov    0x28(%rax),%rdx
    4dd6:	48 8d 48 28          	lea    0x28(%rax),%rcx
    4dda:	48 39 ca             	cmp    %rcx,%rdx
    4ddd:	0f 84 f7 01 00 00    	je     4fda <vfs_rename+0x76a>
    4de3:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
    4de8:	ba 04 00 00 00       	mov    $0x4,%edx
    4ded:	be 01 08 00 00       	mov    $0x801,%esi
    4df2:	e8 00 00 00 00       	call   4df7 <vfs_rename+0x587>
    4df7:	83 f8 f5             	cmp    $0xfffffff5,%eax
    4dfa:	0f 85 e5 04 00 00    	jne    52e5 <vfs_rename+0xa75>
    4e00:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    4e05:	48 85 c9             	test   %rcx,%rcx
    4e08:	0f 84 d7 04 00 00    	je     52e5 <vfs_rename+0xa75>
    4e0e:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    4e13:	41 bf f5 ff ff ff    	mov    $0xfffffff5,%r15d
    4e19:	48 89 01             	mov    %rax,(%rcx)
    4e1c:	48 89 c7             	mov    %rax,%rdi
    4e1f:	e8 00 00 00 00       	call   4e24 <vfs_rename+0x5b4>
    4e24:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    4e2b:	00 
    4e2c:	75 0b                	jne    4e39 <vfs_rename+0x5c9>
    4e2e:	80 7c 24 10 00       	cmpb   $0x0,0x10(%rsp)
    4e33:	0f 84 a7 fe ff ff    	je     4ce0 <vfs_rename+0x470>
    4e39:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    4e3e:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    4e45:	e8 00 00 00 00       	call   4e4a <vfs_rename+0x5da>
    4e4a:	e9 91 fe ff ff       	jmp    4ce0 <vfs_rename+0x470>
    4e4f:	49 8b 7e 18          	mov    0x18(%r14),%rdi
    4e53:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
    4e58:	ba 02 00 00 00       	mov    $0x2,%edx
    4e5d:	e8 00 00 00 00       	call   4e62 <vfs_rename+0x5f2>
    4e62:	41 89 c7             	mov    %eax,%r15d
    4e65:	85 c0                	test   %eax,%eax
    4e67:	0f 84 5b fb ff ff    	je     49c8 <vfs_rename+0x158>
    4e6d:	e9 d3 fc ff ff       	jmp    4b45 <vfs_rename+0x2d5>
    4e72:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    4e77:	48 05 98 00 00 00    	add    $0x98,%rax
    4e7d:	48 89 c7             	mov    %rax,%rdi
    4e80:	48 89 04 24          	mov    %rax,(%rsp)
    4e84:	e8 00 00 00 00       	call   4e89 <vfs_rename+0x619>
    4e89:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    4e8f:	0f 85 cb 05 00 00    	jne    5460 <vfs_rename+0xbf0>
    4e95:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    4e9a:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    4e9e:	0f 85 b7 02 00 00    	jne    515b <vfs_rename+0x8eb>
    4ea4:	c6 44 24 08 01       	movb   $0x1,0x8(%rsp)
    4ea9:	e9 df fb ff ff       	jmp    4a8d <vfs_rename+0x21d>
    4eae:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    4eb3:	48 8b 40 28          	mov    0x28(%rax),%rax
    4eb7:	48 8b 40 28          	mov    0x28(%rax),%rax
    4ebb:	f6 40 09 80          	testb  $0x80,0x9(%rax)
    4ebf:	0f 84 30 04 00 00    	je     52f5 <vfs_rename+0xa85>
    4ec5:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    4ecc:	00 
    4ecd:	0f 85 42 05 00 00    	jne    5415 <vfs_rename+0xba5>
    4ed3:	80 7c 24 10 00       	cmpb   $0x0,0x10(%rsp)
    4ed8:	0f 85 37 05 00 00    	jne    5415 <vfs_rename+0xba5>
    4ede:	4c 89 e7             	mov    %r12,%rdi
    4ee1:	e8 00 00 00 00       	call   4ee6 <vfs_rename+0x676>
    4ee6:	4c 8b 44 24 40       	mov    0x40(%rsp),%r8
    4eeb:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
    4eef:	49 89 d9             	mov    %rbx,%r9
    4ef2:	4c 89 ee             	mov    %r13,%rsi
    4ef5:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
    4efa:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
    4eff:	e8 ec d7 ff ff       	call   26f0 <fsnotify_move>
    4f04:	e9 32 fc ff ff       	jmp    4b3b <vfs_rename+0x2cb>
    4f09:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    4f10:	00 
    4f11:	0f 85 14 fb ff ff    	jne    4a2b <vfs_rename+0x1bb>
    4f17:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    4f1d:	0f 84 db fd ff ff    	je     4cfe <vfs_rename+0x48e>
    4f23:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    4f28:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    4f2f:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    4f34:	e8 00 00 00 00       	call   4f39 <vfs_rename+0x6c9>
    4f39:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    4f3e:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    4f43:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    4f47:	0f 85 a9 02 00 00    	jne    51f6 <vfs_rename+0x986>
    4f4d:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    4f52:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    4f56:	0f 84 48 ff ff ff    	je     4ea4 <vfs_rename+0x634>
    4f5c:	e8 00 00 00 00       	call   4f61 <vfs_rename+0x6f1>
    4f61:	4c 89 e7             	mov    %r12,%rdi
    4f64:	e8 00 00 00 00       	call   4f69 <vfs_rename+0x6f9>
    4f69:	e9 a7 fd ff ff       	jmp    4d15 <vfs_rename+0x4a5>
    4f6e:	48 8b 3c 24          	mov    (%rsp),%rdi
    4f72:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
    4f78:	e8 00 00 00 00       	call   4f7d <vfs_rename+0x70d>
    4f7d:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    4f83:	0f 84 84 fd ff ff    	je     4d0d <vfs_rename+0x49d>
    4f89:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    4f8e:	0f 84 4c fd ff ff    	je     4ce0 <vfs_rename+0x470>
    4f94:	80 7c 24 08 00       	cmpb   $0x0,0x8(%rsp)
    4f99:	0f 84 52 fd ff ff    	je     4cf1 <vfs_rename+0x481>
    4f9f:	e9 3c fd ff ff       	jmp    4ce0 <vfs_rename+0x470>
    4fa4:	0f b6 5c 24 18       	movzbl 0x18(%rsp),%ebx
    4fa9:	83 f3 01             	xor    $0x1,%ebx
    4fac:	0a 5c 24 08          	or     0x8(%rsp),%bl
    4fb0:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    4fb7:	00 
    4fb8:	0f 85 0e 02 00 00    	jne    51cc <vfs_rename+0x95c>
    4fbe:	80 7c 24 10 00       	cmpb   $0x0,0x10(%rsp)
    4fc3:	0f 85 03 02 00 00    	jne    51cc <vfs_rename+0x95c>
    4fc9:	84 db                	test   %bl,%bl
    4fcb:	0f 84 3c fd ff ff    	je     4d0d <vfs_rename+0x49d>
    4fd1:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    4fd8:	eb 82                	jmp    4f5c <vfs_rename+0x6ec>
    4fda:	48 8b 40 30          	mov    0x30(%rax),%rax
    4fde:	48 39 c2             	cmp    %rax,%rdx
    4fe1:	0f 85 fc fd ff ff    	jne    4de3 <vfs_rename+0x573>
    4fe7:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    4fec:	49 8b 7e 18          	mov    0x18(%r14),%rdi
    4ff0:	4d 89 e0             	mov    %r12,%r8
    4ff3:	4c 89 e9             	mov    %r13,%rcx
    4ff6:	44 8b 4c 24 4c       	mov    0x4c(%rsp),%r9d
    4ffb:	48 89 da             	mov    %rbx,%rdx
    4ffe:	48 8b 46 20          	mov    0x20(%rsi),%rax
    5002:	48 8b 40 60          	mov    0x60(%rax),%rax
    5006:	e8 00 00 00 00       	call   500b <vfs_rename+0x79b>
    500b:	41 89 c6             	mov    %eax,%r14d
    500e:	85 c0                	test   %eax,%eax
    5010:	0f 85 99 fa ff ff    	jne    4aaf <vfs_rename+0x23f>
    5016:	f6 44 24 4c 02       	testb  $0x2,0x4c(%rsp)
    501b:	0f 85 57 02 00 00    	jne    5278 <vfs_rename+0xa08>
    5021:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    5027:	0f 84 81 fe ff ff    	je     4eae <vfs_rename+0x63e>
    502d:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    5034:	00 
    5035:	0f 84 30 03 00 00    	je     536b <vfs_rename+0xafb>
    503b:	4d 8d b4 24 80 00 00 	lea    0x80(%r12),%r14
    5042:	00 
    5043:	4c 89 f7             	mov    %r14,%rdi
    5046:	e8 00 00 00 00       	call   504b <vfs_rename+0x7db>
    504b:	41 81 0c 24 00 01 00 	orl    $0x100,(%r12)
    5052:	00 
    5053:	4c 89 f7             	mov    %r14,%rdi
    5056:	e8 00 00 00 00       	call   505b <vfs_rename+0x7eb>
    505b:	41 f7 04 24 00 80 00 	testl  $0x8000,(%r12)
    5062:	00 
    5063:	74 08                	je     506d <vfs_rename+0x7fd>
    5065:	4c 89 e7             	mov    %r12,%rdi
    5068:	e8 00 00 00 00       	call   506d <vfs_rename+0x7fd>
    506d:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    5072:	48 8b 40 28          	mov    0x28(%rax),%rax
    5076:	48 8b 40 28          	mov    0x28(%rax),%rax
    507a:	f6 40 09 80          	testb  $0x80,0x9(%rax)
    507e:	0f 84 71 02 00 00    	je     52f5 <vfs_rename+0xa85>
    5084:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    508b:	00 
    508c:	0f 85 ef 02 00 00    	jne    5381 <vfs_rename+0xb11>
    5092:	80 7c 24 10 00       	cmpb   $0x0,0x10(%rsp)
    5097:	0f 85 e4 02 00 00    	jne    5381 <vfs_rename+0xb11>
    509d:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    50a2:	0f 84 0b 01 00 00    	je     51b3 <vfs_rename+0x943>
    50a8:	80 7c 24 08 00       	cmpb   $0x0,0x8(%rsp)
    50ad:	0f 85 00 01 00 00    	jne    51b3 <vfs_rename+0x943>
    50b3:	4c 89 e7             	mov    %r12,%rdi
    50b6:	e8 00 00 00 00       	call   50bb <vfs_rename+0x84b>
    50bb:	e9 37 fa ff ff       	jmp    4af7 <vfs_rename+0x287>
    50c0:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    50c7:	00 
    50c8:	0f 84 d5 fc ff ff    	je     4da3 <vfs_rename+0x533>
    50ce:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    50d3:	48 8b 80 68 01 00 00 	mov    0x168(%rax),%rax
    50da:	48 85 c0             	test   %rax,%rax
    50dd:	0f 84 c0 fc ff ff    	je     4da3 <vfs_rename+0x533>
    50e3:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
    50e9:	48 8b 50 28          	mov    0x28(%rax),%rdx
    50ed:	48 8d 48 28          	lea    0x28(%rax),%rcx
    50f1:	48 39 ca             	cmp    %rcx,%rdx
    50f4:	0f 84 54 02 00 00    	je     534e <vfs_rename+0xade>
    50fa:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    50ff:	ba 04 00 00 00       	mov    $0x4,%edx
    5104:	be 01 08 00 00       	mov    $0x801,%esi
    5109:	e8 00 00 00 00       	call   510e <vfs_rename+0x89e>
    510e:	83 f8 f5             	cmp    $0xfffffff5,%eax
    5111:	0f 85 9b 01 00 00    	jne    52b2 <vfs_rename+0xa42>
    5117:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    511c:	48 85 c9             	test   %rcx,%rcx
    511f:	0f 84 8d 01 00 00    	je     52b2 <vfs_rename+0xa42>
    5125:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    512a:	41 bf f5 ff ff ff    	mov    $0xfffffff5,%r15d
    5130:	48 89 01             	mov    %rax,(%rcx)
    5133:	48 89 c3             	mov    %rax,%rbx
    5136:	48 89 c7             	mov    %rax,%rdi
    5139:	e8 00 00 00 00       	call   513e <vfs_rename+0x8ce>
    513e:	48 8d bb 98 00 00 00 	lea    0x98(%rbx),%rdi
    5145:	e8 00 00 00 00       	call   514a <vfs_rename+0x8da>
    514a:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    5150:	0f 85 33 fe ff ff    	jne    4f89 <vfs_rename+0x719>
    5156:	e9 96 fb ff ff       	jmp    4cf1 <vfs_rename+0x481>
    515b:	c6 44 24 08 01       	movb   $0x1,0x8(%rsp)
    5160:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    5166:	48 8b 3c 24          	mov    (%rsp),%rdi
    516a:	e8 00 00 00 00       	call   516f <vfs_rename+0x8ff>
    516f:	e9 54 f9 ff ff       	jmp    4ac8 <vfs_rename+0x258>
    5174:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    517a:	0f 84 81 02 00 00    	je     5401 <vfs_rename+0xb91>
    5180:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    5185:	0f 84 48 02 00 00    	je     53d3 <vfs_rename+0xb63>
    518b:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5190:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    5194:	0f 85 73 fb ff ff    	jne    4d0d <vfs_rename+0x49d>
    519a:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    519f:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    51a3:	0f 85 64 fb ff ff    	jne    4d0d <vfs_rename+0x49d>
    51a9:	c6 44 24 08 00       	movb   $0x0,0x8(%rsp)
    51ae:	e9 da f8 ff ff       	jmp    4a8d <vfs_rename+0x21d>
    51b3:	45 31 f6             	xor    %r14d,%r14d
    51b6:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    51bb:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    51c2:	e8 00 00 00 00       	call   51c7 <vfs_rename+0x957>
    51c7:	e9 1a f9 ff ff       	jmp    4ae6 <vfs_rename+0x276>
    51cc:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    51d1:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    51d8:	e8 00 00 00 00       	call   51dd <vfs_rename+0x96d>
    51dd:	84 db                	test   %bl,%bl
    51df:	0f 84 28 fb ff ff    	je     4d0d <vfs_rename+0x49d>
    51e5:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    51ea:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    51f1:	e9 66 fd ff ff       	jmp    4f5c <vfs_rename+0x6ec>
    51f6:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    51fc:	eb c4                	jmp    51c2 <vfs_rename+0x952>
    51fe:	f6 44 24 4c 02       	testb  $0x2,0x4c(%rsp)
    5203:	0f 84 b7 fe ff ff    	je     50c0 <vfs_rename+0x850>
    5209:	81 7c 24 48 00 00 10 	cmpl   $0x100000,0x48(%rsp)
    5210:	00 
    5211:	0f 84 8c fb ff ff    	je     4da3 <vfs_rename+0x533>
    5217:	80 7c 24 18 00       	cmpb   $0x0,0x18(%rsp)
    521c:	0f 84 9e fe ff ff    	je     50c0 <vfs_rename+0x850>
    5222:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    5227:	8b 4c 24 2c          	mov    0x2c(%rsp),%ecx
    522b:	39 48 48             	cmp    %ecx,0x48(%rax)
    522e:	0f 83 72 01 00 00    	jae    53a6 <vfs_rename+0xb36>
    5234:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5239:	48 8b 80 68 01 00 00 	mov    0x168(%rax),%rax
    5240:	48 85 c0             	test   %rax,%rax
    5243:	0f 85 9a fe ff ff    	jne    50e3 <vfs_rename+0x873>
    5249:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    524e:	49 8b 7e 18          	mov    0x18(%r14),%rdi
    5252:	4d 89 e0             	mov    %r12,%r8
    5255:	4c 89 e9             	mov    %r13,%rcx
    5258:	44 8b 4c 24 4c       	mov    0x4c(%rsp),%r9d
    525d:	48 89 da             	mov    %rbx,%rdx
    5260:	48 8b 46 20          	mov    0x20(%rsi),%rax
    5264:	48 8b 40 60          	mov    0x60(%rax),%rax
    5268:	e8 00 00 00 00       	call   526d <vfs_rename+0x9fd>
    526d:	41 89 c6             	mov    %eax,%r14d
    5270:	85 c0                	test   %eax,%eax
    5272:	0f 85 b3 01 00 00    	jne    542b <vfs_rename+0xbbb>
    5278:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    527d:	48 8b 40 28          	mov    0x28(%rax),%rax
    5281:	48 8b 40 28          	mov    0x28(%rax),%rax
    5285:	f6 40 09 80          	testb  $0x80,0x9(%rax)
    5289:	75 0b                	jne    5296 <vfs_rename+0xa26>
    528b:	4c 89 e6             	mov    %r12,%rsi
    528e:	48 89 df             	mov    %rbx,%rdi
    5291:	e8 00 00 00 00       	call   5296 <vfs_rename+0xa26>
    5296:	45 31 f6             	xor    %r14d,%r14d
    5299:	e9 11 f8 ff ff       	jmp    4aaf <vfs_rename+0x23f>
    529e:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    52a3:	48 05 98 00 00 00    	add    $0x98,%rax
    52a9:	48 89 04 24          	mov    %rax,(%rsp)
    52ad:	e9 b4 fe ff ff       	jmp    5166 <vfs_rename+0x8f6>
    52b2:	85 c0                	test   %eax,%eax
    52b4:	0f 84 e9 fa ff ff    	je     4da3 <vfs_rename+0x533>
    52ba:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    52bf:	89 44 24 4c          	mov    %eax,0x4c(%rsp)
    52c3:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    52ca:	e8 00 00 00 00       	call   52cf <vfs_rename+0xa5f>
    52cf:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    52d5:	44 8b 7c 24 4c       	mov    0x4c(%rsp),%r15d
    52da:	0f 85 a9 fc ff ff    	jne    4f89 <vfs_rename+0x719>
    52e0:	e9 0c fa ff ff       	jmp    4cf1 <vfs_rename+0x481>
    52e5:	85 c0                	test   %eax,%eax
    52e7:	0f 84 fa fc ff ff    	je     4fe7 <vfs_rename+0x777>
    52ed:	41 89 c7             	mov    %eax,%r15d
    52f0:	e9 2f fb ff ff       	jmp    4e24 <vfs_rename+0x5b4>
    52f5:	4c 89 e6             	mov    %r12,%rsi
    52f8:	48 89 df             	mov    %rbx,%rdi
    52fb:	e8 00 00 00 00       	call   5300 <vfs_rename+0xa90>
    5300:	eb 94                	jmp    5296 <vfs_rename+0xa26>
    5302:	41 bf ef ff ff ff    	mov    $0xffffffef,%r15d
    5308:	e9 38 f8 ff ff       	jmp    4b45 <vfs_rename+0x2d5>
    530d:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    5312:	41 bf e1 ff ff ff    	mov    $0xffffffe1,%r15d
    5318:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    531f:	e8 00 00 00 00       	call   5324 <vfs_rename+0xab4>
    5324:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    532a:	0f 85 b0 f9 ff ff    	jne    4ce0 <vfs_rename+0x470>
    5330:	4c 89 e7             	mov    %r12,%rdi
    5333:	41 bf e1 ff ff ff    	mov    $0xffffffe1,%r15d
    5339:	e8 00 00 00 00       	call   533e <vfs_rename+0xace>
    533e:	e9 f8 f7 ff ff       	jmp    4b3b <vfs_rename+0x2cb>
    5343:	41 bf fe ff ff ff    	mov    $0xfffffffe,%r15d
    5349:	e9 f7 f7 ff ff       	jmp    4b45 <vfs_rename+0x2d5>
    534e:	48 8b 40 30          	mov    0x30(%rax),%rax
    5352:	48 39 c2             	cmp    %rax,%rdx
    5355:	0f 85 9f fd ff ff    	jne    50fa <vfs_rename+0x88a>
    535b:	e9 43 fa ff ff       	jmp    4da3 <vfs_rename+0x533>
    5360:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
    5366:	e9 da f7 ff ff       	jmp    4b45 <vfs_rename+0x2d5>
    536b:	4c 89 e7             	mov    %r12,%rdi
    536e:	e8 00 00 00 00       	call   5373 <vfs_rename+0xb03>
    5373:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    5378:	83 48 0c 10          	orl    $0x10,0xc(%rax)
    537c:	e9 ba fc ff ff       	jmp    503b <vfs_rename+0x7cb>
    5381:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    5386:	45 31 f6             	xor    %r14d,%r14d
    5389:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    5390:	e8 00 00 00 00       	call   5395 <vfs_rename+0xb25>
    5395:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    539b:	0f 85 2f f7 ff ff    	jne    4ad0 <vfs_rename+0x260>
    53a1:	e9 0d fd ff ff       	jmp    50b3 <vfs_rename+0x843>
    53a6:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    53ab:	41 bf e1 ff ff ff    	mov    $0xffffffe1,%r15d
    53b1:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    53b8:	e8 00 00 00 00       	call   53bd <vfs_rename+0xb4d>
    53bd:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    53c3:	0f 85 c0 fb ff ff    	jne    4f89 <vfs_rename+0x719>
    53c9:	e9 62 ff ff ff       	jmp    5330 <vfs_rename+0xac0>
    53ce:	e8 00 00 00 00       	call   53d3 <vfs_rename+0xb63>
    53d3:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    53d8:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    53df:	e8 00 00 00 00       	call   53e4 <vfs_rename+0xb74>
    53e4:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    53e9:	c6 44 24 08 00       	movb   $0x0,0x8(%rsp)
    53ee:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    53f2:	0f 84 86 f6 ff ff    	je     4a7e <vfs_rename+0x20e>
    53f8:	41 83 ce ff          	or     $0xffffffff,%r14d
    53fc:	e9 cf f6 ff ff       	jmp    4ad0 <vfs_rename+0x260>
    5401:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5406:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    540a:	0f 84 99 fd ff ff    	je     51a9 <vfs_rename+0x939>
    5410:	e9 f8 f8 ff ff       	jmp    4d0d <vfs_rename+0x49d>
    5415:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    541a:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    5421:	e8 00 00 00 00       	call   5426 <vfs_rename+0xbb6>
    5426:	e9 88 fc ff ff       	jmp    50b3 <vfs_rename+0x843>
    542b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    5430:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    5437:	e8 00 00 00 00       	call   543c <vfs_rename+0xbcc>
    543c:	48 83 7c 24 40 00    	cmpq   $0x0,0x40(%rsp)
    5442:	0f 85 88 f6 ff ff    	jne    4ad0 <vfs_rename+0x260>
    5448:	4c 89 e7             	mov    %r12,%rdi
    544b:	45 89 f7             	mov    %r14d,%r15d
    544e:	e8 00 00 00 00       	call   5453 <vfs_rename+0xbe3>
    5453:	e9 e3 f6 ff ff       	jmp    4b3b <vfs_rename+0x2cb>
    5458:	45 89 f7             	mov    %r14d,%r15d
    545b:	e9 db f6 ff ff       	jmp    4b3b <vfs_rename+0x2cb>
    5460:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    5465:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    546c:	e8 00 00 00 00       	call   5471 <vfs_rename+0xc01>
    5471:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5476:	f6 40 0d 01          	testb  $0x1,0xd(%rax)
    547a:	75 0a                	jne    5486 <vfs_rename+0xc16>
    547c:	c6 44 24 08 01       	movb   $0x1,0x8(%rsp)
    5481:	e9 f8 f5 ff ff       	jmp    4a7e <vfs_rename+0x20e>
    5486:	48 8b 3c 24          	mov    (%rsp),%rdi
    548a:	41 83 ce ff          	or     $0xffffffff,%r14d
    548e:	e8 00 00 00 00       	call   5493 <vfs_rename+0xc23>
    5493:	c6 44 24 08 01       	movb   $0x1,0x8(%rsp)
    5498:	e9 33 f6 ff ff       	jmp    4ad0 <vfs_rename+0x260>
    549d:	0f 1f 00             	nopl   (%rax)

00000000000054a0 <__pfx_step_into>:
    54a0:	90                   	nop
    54a1:	90                   	nop
    54a2:	90                   	nop
    54a3:	90                   	nop
    54a4:	90                   	nop
    54a5:	90                   	nop
    54a6:	90                   	nop
    54a7:	90                   	nop
    54a8:	90                   	nop
    54a9:	90                   	nop
    54aa:	90                   	nop
    54ab:	90                   	nop
    54ac:	90                   	nop
    54ad:	90                   	nop
    54ae:	90                   	nop
    54af:	90                   	nop

00000000000054b0 <step_into>:
    54b0:	e8 00 00 00 00       	call   54b5 <step_into+0x5>
    54b5:	55                   	push   %rbp
    54b6:	48 89 e5             	mov    %rsp,%rbp
    54b9:	41 57                	push   %r15
    54bb:	41 56                	push   %r14
    54bd:	41 89 f6             	mov    %esi,%r14d
    54c0:	41 55                	push   %r13
    54c2:	41 54                	push   %r12
    54c4:	49 89 d4             	mov    %rdx,%r12
    54c7:	53                   	push   %rbx
    54c8:	48 89 fb             	mov    %rdi,%rbx
    54cb:	48 83 ec 28          	sub    $0x28,%rsp
    54cf:	44 8b 47 38          	mov    0x38(%rdi),%r8d
    54d3:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 54db <step_into+0x2b>
    54da:	00 
    54db:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    54e0:	31 c0                	xor    %eax,%eax
    54e2:	48 8b 07             	mov    (%rdi),%rax
    54e5:	c6 44 24 0f 00       	movb   $0x0,0xf(%rsp)
    54ea:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
    54ef:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    54f4:	41 f7 c0 00 01 00 00 	test   $0x100,%r8d
    54fb:	0f 84 be 01 00 00    	je     56bf <step_into+0x20f>
    5501:	45 8b 2c 24          	mov    (%r12),%r13d
    5505:	8b 57 44             	mov    0x44(%rdi),%edx
    5508:	41 f7 c5 00 80 03 00 	test   $0x38000,%r13d
    550f:	0f 85 dd 02 00 00    	jne    57f2 <step_into+0x342>
    5515:	41 81 e5 00 00 38 00 	and    $0x380000,%r13d
    551c:	4d 8b 7c 24 30       	mov    0x30(%r12),%r15
    5521:	41 81 fd 00 00 30 00 	cmp    $0x300000,%r13d
    5528:	0f 85 e8 01 00 00    	jne    5716 <step_into+0x266>
    552e:	ba 00 01 00 00       	mov    $0x100,%edx
    5533:	44 89 f1             	mov    %r14d,%ecx
    5536:	83 e1 01             	and    $0x1,%ecx
    5539:	74 0a                	je     5545 <step_into+0x95>
    553b:	41 83 e0 01          	and    $0x1,%r8d
    553f:	0f 84 c6 01 00 00    	je     570b <step_into+0x25b>
    5545:	41 83 e6 04          	and    $0x4,%r14d
    5549:	0f 85 bc 01 00 00    	jne    570b <step_into+0x25b>
    554f:	85 d2                	test   %edx,%edx
    5551:	0f 84 cd 03 00 00    	je     5924 <step_into+0x474>
    5557:	8b 53 44             	mov    0x44(%rbx),%edx
    555a:	41 8b 44 24 04       	mov    0x4(%r12),%eax
    555f:	39 c2                	cmp    %eax,%edx
    5561:	0f 85 5a 03 00 00    	jne    58c1 <step_into+0x411>
    5567:	8b 43 58             	mov    0x58(%rbx),%eax
    556a:	8d 50 01             	lea    0x1(%rax),%edx
    556d:	89 53 58             	mov    %edx,0x58(%rbx)
    5570:	83 f8 27             	cmp    $0x27,%eax
    5573:	0f 8f fd 04 00 00    	jg     5a76 <step_into+0x5c6>
    5579:	8b 43 54             	mov    0x54(%rbx),%eax
    557c:	4c 8b 6b 60          	mov    0x60(%rbx),%r13
    5580:	83 f8 02             	cmp    $0x2,%eax
    5583:	0f 84 32 05 00 00    	je     5abb <step_into+0x60b>
    5589:	8d 50 01             	lea    0x1(%rax),%edx
    558c:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    5590:	48 c1 e0 04          	shl    $0x4,%rax
    5594:	89 53 54             	mov    %edx,0x54(%rbx)
    5597:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    559c:	49 01 c5             	add    %rax,%r13
    559f:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    55a4:	49 c7 45 10 00 00 00 	movq   $0x0,0x10(%r13)
    55ab:	00 
    55ac:	49 89 45 00          	mov    %rax,0x0(%r13)
    55b0:	49 89 55 08          	mov    %rdx,0x8(%r13)
    55b4:	8b 43 44             	mov    0x44(%rbx),%eax
    55b7:	41 89 45 28          	mov    %eax,0x28(%r13)
    55bb:	85 c9                	test   %ecx,%ecx
    55bd:	0f 85 81 03 00 00    	jne    5944 <step_into+0x494>
    55c3:	f6 43 3b 01          	testb  $0x1,0x3b(%rbx)
    55c7:	0f 85 79 04 00 00    	jne    5a46 <step_into+0x596>
    55cd:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    55d2:	f6 40 10 80          	testb  $0x80,0x10(%rax)
    55d6:	0f 85 6a 04 00 00    	jne    5a46 <step_into+0x596>
    55dc:	4c 89 fe             	mov    %r15,%rsi
    55df:	4c 89 ef             	mov    %r13,%rdi
    55e2:	e8 00 00 00 00       	call   55e7 <step_into+0x137>
    55e7:	84 c0                	test   %al,%al
    55e9:	0f 85 05 05 00 00    	jne    5af4 <step_into+0x644>
    55ef:	8b 53 38             	mov    0x38(%rbx),%edx
    55f2:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    55f7:	4c 89 fe             	mov    %r15,%rsi
    55fa:	c1 ea 08             	shr    $0x8,%edx
    55fd:	83 e2 01             	and    $0x1,%edx
    5600:	e8 00 00 00 00       	call   5605 <step_into+0x155>
    5605:	85 c0                	test   %eax,%eax
    5607:	0f 85 df 04 00 00    	jne    5aec <step_into+0x63c>
    560d:	4d 8b a7 40 02 00 00 	mov    0x240(%r15),%r12
    5614:	4d 85 e4             	test   %r12,%r12
    5617:	0f 84 dd 03 00 00    	je     59fa <step_into+0x54a>
    561d:	41 0f b6 04 24       	movzbl (%r12),%eax
    5622:	3c 2f                	cmp    $0x2f,%al
    5624:	0f 84 28 04 00 00    	je     5a52 <step_into+0x5a2>
    562a:	84 c0                	test   %al,%al
    562c:	0f 85 18 01 00 00    	jne    574a <step_into+0x29a>
    5632:	8b 43 54             	mov    0x54(%rbx),%eax
    5635:	83 e8 01             	sub    $0x1,%eax
    5638:	4c 8d 24 40          	lea    (%rax,%rax,2),%r12
    563c:	89 43 54             	mov    %eax,0x54(%rbx)
    563f:	49 c1 e4 04          	shl    $0x4,%r12
    5643:	4c 03 63 60          	add    0x60(%rbx),%r12
    5647:	49 8b 44 24 10       	mov    0x10(%r12),%rax
    564c:	48 85 c0             	test   %rax,%rax
    564f:	74 0a                	je     565b <step_into+0x1ab>
    5651:	49 8b 7c 24 18       	mov    0x18(%r12),%rdi
    5656:	e8 00 00 00 00       	call   565b <step_into+0x1ab>
    565b:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    565f:	0f 85 e2 00 00 00    	jne    5747 <step_into+0x297>
    5665:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    566a:	e8 00 00 00 00       	call   566f <step_into+0x1bf>
    566f:	49 8b 3c 24          	mov    (%r12),%rdi
    5673:	e8 00 00 00 00       	call   5678 <step_into+0x1c8>
    5678:	e9 ca 00 00 00       	jmp    5747 <step_into+0x297>
    567d:	8b 4b 48             	mov    0x48(%rbx),%ecx
    5680:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 5686 <step_into+0x1d6>
    5686:	39 c1                	cmp    %eax,%ecx
    5688:	75 09                	jne    5693 <step_into+0x1e3>
    568a:	41 81 e5 00 00 01 00 	and    $0x10000,%r13d
    5691:	74 4d                	je     56e0 <step_into+0x230>
    5693:	48 8b 03             	mov    (%rbx),%rax
    5696:	89 53 44             	mov    %edx,0x44(%rbx)
    5699:	4c 89 e6             	mov    %r12,%rsi
    569c:	48 89 df             	mov    %rbx,%rdi
    569f:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    56a4:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    56a9:	e8 12 cc ff ff       	call   22c0 <try_to_unlazy_next>
    56ae:	84 c0                	test   %al,%al
    56b0:	0f 84 33 02 00 00    	je     58e9 <step_into+0x439>
    56b6:	44 8b 43 38          	mov    0x38(%rbx),%r8d
    56ba:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    56bf:	41 8b 34 24          	mov    (%r12),%esi
    56c3:	f7 c6 00 80 03 00    	test   $0x38000,%esi
    56c9:	0f 85 af 00 00 00    	jne    577e <step_into+0x2ce>
    56cf:	81 e6 00 00 38 00    	and    $0x380000,%esi
    56d5:	c6 44 24 0f 00       	movb   $0x0,0xf(%rsp)
    56da:	0f 84 14 02 00 00    	je     58f4 <step_into+0x444>
    56e0:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    56e5:	44 8b 43 38          	mov    0x38(%rbx),%r8d
    56e9:	41 8b 04 24          	mov    (%r12),%eax
    56ed:	4d 8b 7c 24 30       	mov    0x30(%r12),%r15
    56f2:	44 89 c2             	mov    %r8d,%edx
    56f5:	25 00 00 38 00       	and    $0x380000,%eax
    56fa:	81 e2 00 01 00 00    	and    $0x100,%edx
    5700:	3d 00 00 30 00       	cmp    $0x300000,%eax
    5705:	0f 84 28 fe ff ff    	je     5533 <step_into+0x83>
    570b:	85 d2                	test   %edx,%edx
    570d:	0f 84 8d 01 00 00    	je     58a0 <step_into+0x3f0>
    5713:	8b 53 44             	mov    0x44(%rbx),%edx
    5716:	41 8b 44 24 04       	mov    0x4(%r12),%eax
    571b:	39 d0                	cmp    %edx,%eax
    571d:	0f 85 9e 01 00 00    	jne    58c1 <step_into+0x411>
    5723:	4d 85 ff             	test   %r15,%r15
    5726:	0f 84 a1 01 00 00    	je     58cd <step_into+0x41d>
    572c:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    5731:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    5736:	4c 89 7b 30          	mov    %r15,0x30(%rbx)
    573a:	48 89 03             	mov    %rax,(%rbx)
    573d:	8b 43 44             	mov    0x44(%rbx),%eax
    5740:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    5744:	89 43 40             	mov    %eax,0x40(%rbx)
    5747:	45 31 e4             	xor    %r12d,%r12d
    574a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    574f:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 5757 <step_into+0x2a7>
    5756:	00 
    5757:	0f 85 0e 04 00 00    	jne    5b6b <step_into+0x6bb>
    575d:	48 83 c4 28          	add    $0x28,%rsp
    5761:	4c 89 e0             	mov    %r12,%rax
    5764:	5b                   	pop    %rbx
    5765:	41 5c                	pop    %r12
    5767:	41 5d                	pop    %r13
    5769:	41 5e                	pop    %r14
    576b:	41 5f                	pop    %r15
    576d:	5d                   	pop    %rbp
    576e:	31 d2                	xor    %edx,%edx
    5770:	31 c9                	xor    %ecx,%ecx
    5772:	31 f6                	xor    %esi,%esi
    5774:	31 ff                	xor    %edi,%edi
    5776:	45 31 c0             	xor    %r8d,%r8d
    5779:	e9 00 00 00 00       	jmp    577e <step_into+0x2ce>
    577e:	48 8d 4b 58          	lea    0x58(%rbx),%rcx
    5782:	48 8d 54 24 0f       	lea    0xf(%rsp),%rdx
    5787:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    578c:	e8 9f ac ff ff       	call   430 <__traverse_mounts>
    5791:	44 0f b6 64 24 0f    	movzbl 0xf(%rsp),%r12d
    5797:	41 89 c5             	mov    %eax,%r13d
    579a:	41 80 fc 01          	cmp    $0x1,%r12b
    579e:	0f 87 00 00 00 00    	ja     57a4 <step_into+0x2f4>
    57a4:	41 83 e4 01          	and    $0x1,%r12d
    57a8:	74 0e                	je     57b8 <step_into+0x308>
    57aa:	f6 43 3b 04          	testb  $0x4,0x3b(%rbx)
    57ae:	0f 85 68 01 00 00    	jne    591c <step_into+0x46c>
    57b4:	83 4b 3c 04          	orl    $0x4,0x3c(%rbx)
    57b8:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    57bd:	45 85 ed             	test   %r13d,%r13d
    57c0:	0f 84 1f ff ff ff    	je     56e5 <step_into+0x235>
    57c6:	4c 89 e7             	mov    %r12,%rdi
    57c9:	e8 00 00 00 00       	call   57ce <step_into+0x31e>
    57ce:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    57d3:	48 3b 3b             	cmp    (%rbx),%rdi
    57d6:	0f 85 af 03 00 00    	jne    5b8b <step_into+0x6db>
    57dc:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    57e1:	45 85 ed             	test   %r13d,%r13d
    57e4:	0f 89 fb fe ff ff    	jns    56e5 <step_into+0x235>
    57ea:	4d 63 e5             	movslq %r13d,%r12
    57ed:	e9 58 ff ff ff       	jmp    574a <step_into+0x29a>
    57f2:	41 81 e0 00 00 00 04 	and    $0x4000000,%r8d
    57f9:	0f 85 97 fe ff ff    	jne    5696 <step_into+0x1e6>
    57ff:	4d 89 e7             	mov    %r12,%r15
    5802:	eb 64                	jmp    5868 <step_into+0x3b8>
    5804:	41 f7 c5 00 80 00 00 	test   $0x8000,%r13d
    580b:	0f 84 79 fe ff ff    	je     568a <step_into+0x1da>
    5811:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    5816:	4c 89 fe             	mov    %r15,%rsi
    5819:	89 54 24 04          	mov    %edx,0x4(%rsp)
    581d:	e8 00 00 00 00       	call   5822 <step_into+0x372>
    5822:	8b 54 24 04          	mov    0x4(%rsp),%edx
    5826:	48 85 c0             	test   %rax,%rax
    5829:	0f 84 4e fe ff ff    	je     567d <step_into+0x1cd>
    582f:	4c 8b 78 20          	mov    0x20(%rax),%r15
    5833:	48 8d 48 20          	lea    0x20(%rax),%rcx
    5837:	83 4b 3c 04          	orl    $0x4,0x3c(%rbx)
    583b:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    5840:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    5845:	41 8b 47 04          	mov    0x4(%r15),%eax
    5849:	a8 01                	test   $0x1,%al
    584b:	0f 85 88 00 00 00    	jne    58d9 <step_into+0x429>
    5851:	89 43 44             	mov    %eax,0x44(%rbx)
    5854:	8b 4b 48             	mov    0x48(%rbx),%ecx
    5857:	45 8b 2f             	mov    (%r15),%r13d
    585a:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 5860 <step_into+0x3b0>
    5860:	39 c1                	cmp    %eax,%ecx
    5862:	0f 85 2b fe ff ff    	jne    5693 <step_into+0x1e3>
    5868:	41 f7 c5 00 00 02 00 	test   $0x20000,%r13d
    586f:	74 93                	je     5804 <step_into+0x354>
    5871:	49 8b 47 60          	mov    0x60(%r15),%rax
    5875:	89 54 24 04          	mov    %edx,0x4(%rsp)
    5879:	be 01 00 00 00       	mov    $0x1,%esi
    587e:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    5883:	48 8b 40 58          	mov    0x58(%rax),%rax
    5887:	e8 00 00 00 00       	call   588c <step_into+0x3dc>
    588c:	8b 54 24 04          	mov    0x4(%rsp),%edx
    5890:	85 c0                	test   %eax,%eax
    5892:	0f 85 9c 02 00 00    	jne    5b34 <step_into+0x684>
    5898:	45 8b 2f             	mov    (%r15),%r13d
    589b:	e9 64 ff ff ff       	jmp    5804 <step_into+0x354>
    58a0:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    58a4:	e8 00 00 00 00       	call   58a9 <step_into+0x3f9>
    58a9:	48 8b 3b             	mov    (%rbx),%rdi
    58ac:	48 3b 7c 24 10       	cmp    0x10(%rsp),%rdi
    58b1:	0f 84 75 fe ff ff    	je     572c <step_into+0x27c>
    58b7:	e8 00 00 00 00       	call   58bc <step_into+0x40c>
    58bc:	e9 6b fe ff ff       	jmp    572c <step_into+0x27c>
    58c1:	49 c7 c4 f6 ff ff ff 	mov    $0xfffffffffffffff6,%r12
    58c8:	e9 7d fe ff ff       	jmp    574a <step_into+0x29a>
    58cd:	49 c7 c4 fe ff ff ff 	mov    $0xfffffffffffffffe,%r12
    58d4:	e9 71 fe ff ff       	jmp    574a <step_into+0x29a>
    58d9:	f3 90                	pause
    58db:	41 8b 47 04          	mov    0x4(%r15),%eax
    58df:	a8 01                	test   $0x1,%al
    58e1:	0f 84 6a ff ff ff    	je     5851 <step_into+0x3a1>
    58e7:	eb f0                	jmp    58d9 <step_into+0x429>
    58e9:	41 bd f6 ff ff ff    	mov    $0xfffffff6,%r13d
    58ef:	e9 f6 fe ff ff       	jmp    57ea <step_into+0x33a>
    58f4:	41 bd fe ff ff ff    	mov    $0xfffffffe,%r13d
    58fa:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    58ff:	e8 00 00 00 00       	call   5904 <step_into+0x454>
    5904:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    5909:	48 3b 3b             	cmp    (%rbx),%rdi
    590c:	0f 84 d8 fe ff ff    	je     57ea <step_into+0x33a>
    5912:	e8 00 00 00 00       	call   5917 <step_into+0x467>
    5917:	e9 ce fe ff ff       	jmp    57ea <step_into+0x33a>
    591c:	41 bd ee ff ff ff    	mov    $0xffffffee,%r13d
    5922:	eb d6                	jmp    58fa <step_into+0x44a>
    5924:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    5929:	48 3b 3b             	cmp    (%rbx),%rdi
    592c:	0f 85 35 fc ff ff    	jne    5567 <step_into+0xb7>
    5932:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
    5936:	e8 00 00 00 00       	call   593b <step_into+0x48b>
    593b:	8b 4c 24 04          	mov    0x4(%rsp),%ecx
    593f:	e9 23 fc ff ff       	jmp    5567 <step_into+0xb7>
    5944:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 594a <step_into+0x49a>
    594a:	85 c0                	test   %eax,%eax
    594c:	0f 84 71 fc ff ff    	je     55c3 <step_into+0x113>
    5952:	48 8b 03             	mov    (%rbx),%rax
    5955:	41 8b 57 04          	mov    0x4(%r15),%edx
    5959:	48 8b 78 18          	mov    0x18(%rax),%rdi
    595d:	49 8b 47 28          	mov    0x28(%r15),%rax
    5961:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    5968:	e8 00 00 00 00       	call   596d <step_into+0x4bd>
    596d:	65 48 8b 15 00 00 00 	mov    %gs:0x0(%rip),%rdx        # 5975 <step_into+0x4c5>
    5974:	00 
    5975:	48 8b 8a a0 0c 00 00 	mov    0xca0(%rdx),%rcx
    597c:	8b 49 20             	mov    0x20(%rcx),%ecx
    597f:	83 f8 ff             	cmp    $0xffffffff,%eax
    5982:	0f 84 94 01 00 00    	je     5b1c <step_into+0x66c>
    5988:	39 c8                	cmp    %ecx,%eax
    598a:	0f 84 33 fc ff ff    	je     55c3 <step_into+0x113>
    5990:	0f b7 8b ec 00 00 00 	movzwl 0xec(%rbx),%ecx
    5997:	f7 d1                	not    %ecx
    5999:	66 f7 c1 02 02       	test   $0x202,%cx
    599e:	0f 85 1f fc ff ff    	jne    55c3 <step_into+0x113>
    59a4:	8b 8b e8 00 00 00    	mov    0xe8(%rbx),%ecx
    59aa:	39 c8                	cmp    %ecx,%eax
    59ac:	75 09                	jne    59b7 <step_into+0x507>
    59ae:	83 c1 01             	add    $0x1,%ecx
    59b1:	0f 85 0c fc ff ff    	jne    55c3 <step_into+0x113>
    59b7:	49 c7 c4 f6 ff ff ff 	mov    $0xfffffffffffffff6,%r12
    59be:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    59c2:	0f 85 82 fd ff ff    	jne    574a <step_into+0x29a>
    59c8:	48 8b 82 70 0d 00 00 	mov    0xd70(%rdx),%rax
    59cf:	48 85 c0             	test   %rax,%rax
    59d2:	74 09                	je     59dd <step_into+0x52d>
    59d4:	83 38 00             	cmpl   $0x0,(%rax)
    59d7:	0f 84 93 01 00 00    	je     5b70 <step_into+0x6c0>
    59dd:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
    59e4:	bf a6 06 00 00       	mov    $0x6a6,%edi
    59e9:	49 c7 c4 f3 ff ff ff 	mov    $0xfffffffffffffff3,%r12
    59f0:	e8 00 00 00 00       	call   59f5 <step_into+0x545>
    59f5:	e9 50 fd ff ff       	jmp    574a <step_into+0x29a>
    59fa:	49 8b 47 20          	mov    0x20(%r15),%rax
    59fe:	4c 8b 70 08          	mov    0x8(%rax),%r14
    5a02:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    5a06:	0f 84 95 00 00 00    	je     5aa1 <step_into+0x5f1>
    5a0c:	49 83 c5 10          	add    $0x10,%r13
    5a10:	4c 89 fe             	mov    %r15,%rsi
    5a13:	31 ff                	xor    %edi,%edi
    5a15:	4c 89 ea             	mov    %r13,%rdx
    5a18:	2e e8 00 00 00 00    	cs call 5a1e <step_into+0x56e>
    5a1e:	49 89 c4             	mov    %rax,%r12
    5a21:	48 83 f8 f6          	cmp    $0xfffffffffffffff6,%rax
    5a25:	0f 84 17 01 00 00    	je     5b42 <step_into+0x692>
    5a2b:	4d 85 e4             	test   %r12,%r12
    5a2e:	0f 84 fe fb ff ff    	je     5632 <step_into+0x182>
    5a34:	49 81 fc 00 f0 ff ff 	cmp    $0xfffffffffffff000,%r12
    5a3b:	0f 86 dc fb ff ff    	jbe    561d <step_into+0x16d>
    5a41:	e9 04 fd ff ff       	jmp    574a <step_into+0x29a>
    5a46:	49 c7 c4 d8 ff ff ff 	mov    $0xffffffffffffffd8,%r12
    5a4d:	e9 f8 fc ff ff       	jmp    574a <step_into+0x29a>
    5a52:	48 89 df             	mov    %rbx,%rdi
    5a55:	e8 66 d4 ff ff       	call   2ec0 <nd_jump_root>
    5a5a:	85 c0                	test   %eax,%eax
    5a5c:	0f 85 8a 00 00 00    	jne    5aec <step_into+0x63c>
    5a62:	41 0f b6 44 24 01    	movzbl 0x1(%r12),%eax
    5a68:	49 83 c4 01          	add    $0x1,%r12
    5a6c:	3c 2f                	cmp    $0x2f,%al
    5a6e:	0f 85 b6 fb ff ff    	jne    562a <step_into+0x17a>
    5a74:	eb ec                	jmp    5a62 <step_into+0x5b2>
    5a76:	49 c7 c4 d8 ff ff ff 	mov    $0xffffffffffffffd8,%r12
    5a7d:	41 bd d8 ff ff ff    	mov    $0xffffffd8,%r13d
    5a83:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    5a87:	0f 85 bd fc ff ff    	jne    574a <step_into+0x29a>
    5a8d:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    5a92:	e8 00 00 00 00       	call   5a97 <step_into+0x5e7>
    5a97:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    5a9c:	e9 71 fe ff ff       	jmp    5912 <step_into+0x462>
    5aa1:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    5aa6:	49 8d 55 10          	lea    0x10(%r13),%rdx
    5aaa:	4c 89 fe             	mov    %r15,%rsi
    5aad:	2e e8 00 00 00 00    	cs call 5ab3 <step_into+0x603>
    5ab3:	49 89 c4             	mov    %rax,%r12
    5ab6:	e9 70 ff ff ff       	jmp    5a2b <step_into+0x57b>
    5abb:	48 8d 53 68          	lea    0x68(%rbx),%rdx
    5abf:	49 39 d5             	cmp    %rdx,%r13
    5ac2:	0f 85 c1 fa ff ff    	jne    5589 <step_into+0xd9>
    5ac8:	48 89 df             	mov    %rbx,%rdi
    5acb:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
    5acf:	e8 6c b4 ff ff       	call   f40 <nd_alloc_stack>
    5ad4:	8b 4c 24 04          	mov    0x4(%rsp),%ecx
    5ad8:	84 c0                	test   %al,%al
    5ada:	0f 84 b5 00 00 00    	je     5b95 <step_into+0x6e5>
    5ae0:	4c 8b 6b 60          	mov    0x60(%rbx),%r13
    5ae4:	8b 43 54             	mov    0x54(%rbx),%eax
    5ae7:	e9 9d fa ff ff       	jmp    5589 <step_into+0xd9>
    5aec:	4c 63 e0             	movslq %eax,%r12
    5aef:	e9 56 fc ff ff       	jmp    574a <step_into+0x29a>
    5af4:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    5af8:	74 10                	je     5b0a <step_into+0x65a>
    5afa:	48 89 df             	mov    %rbx,%rdi
    5afd:	e8 fe c8 ff ff       	call   2400 <try_to_unlazy>
    5b02:	84 c0                	test   %al,%al
    5b04:	0f 84 b7 fd ff ff    	je     58c1 <step_into+0x411>
    5b0a:	4c 89 ef             	mov    %r13,%rdi
    5b0d:	e8 00 00 00 00       	call   5b12 <step_into+0x662>
    5b12:	e8 00 00 00 00       	call   5b17 <step_into+0x667>
    5b17:	e9 d3 fa ff ff       	jmp    55ef <step_into+0x13f>
    5b1c:	0f b7 83 ec 00 00 00 	movzwl 0xec(%rbx),%eax
    5b23:	f7 d0                	not    %eax
    5b25:	66 a9 02 02          	test   $0x202,%ax
    5b29:	0f 85 94 fa ff ff    	jne    55c3 <step_into+0x113>
    5b2f:	e9 83 fe ff ff       	jmp    59b7 <step_into+0x507>
    5b34:	83 f8 eb             	cmp    $0xffffffeb,%eax
    5b37:	0f 84 a3 fb ff ff    	je     56e0 <step_into+0x230>
    5b3d:	e9 51 fb ff ff       	jmp    5693 <step_into+0x1e3>
    5b42:	48 89 df             	mov    %rbx,%rdi
    5b45:	e8 b6 c8 ff ff       	call   2400 <try_to_unlazy>
    5b4a:	84 c0                	test   %al,%al
    5b4c:	0f 84 6f fd ff ff    	je     58c1 <step_into+0x411>
    5b52:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    5b57:	4c 89 ea             	mov    %r13,%rdx
    5b5a:	4c 89 fe             	mov    %r15,%rsi
    5b5d:	2e e8 00 00 00 00    	cs call 5b63 <step_into+0x6b3>
    5b63:	49 89 c4             	mov    %rax,%r12
    5b66:	e9 c0 fe ff ff       	jmp    5a2b <step_into+0x57b>
    5b6b:	e8 00 00 00 00       	call   5b70 <step_into+0x6c0>
    5b70:	48 8b 43 60          	mov    0x60(%rbx),%rax
    5b74:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
    5b7b:	31 d2                	xor    %edx,%edx
    5b7d:	48 8b 70 08          	mov    0x8(%rax),%rsi
    5b81:	e8 00 00 00 00       	call   5b86 <step_into+0x6d6>
    5b86:	e9 52 fe ff ff       	jmp    59dd <step_into+0x52d>
    5b8b:	e8 00 00 00 00       	call   5b90 <step_into+0x6e0>
    5b90:	e9 47 fc ff ff       	jmp    57dc <step_into+0x32c>
    5b95:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
    5b99:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    5b9d:	74 40                	je     5bdf <step_into+0x72f>
    5b9f:	8b 53 48             	mov    0x48(%rbx),%edx
    5ba2:	8b 73 44             	mov    0x44(%rbx),%esi
    5ba5:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    5baa:	e8 61 ac ff ff       	call   810 <__legitimize_path>
    5baf:	48 89 df             	mov    %rbx,%rdi
    5bb2:	41 89 c4             	mov    %eax,%r12d
    5bb5:	e8 46 c8 ff ff       	call   2400 <try_to_unlazy>
    5bba:	45 84 e4             	test   %r12b,%r12b
    5bbd:	74 3d                	je     5bfc <step_into+0x74c>
    5bbf:	84 c0                	test   %al,%al
    5bc1:	74 39                	je     5bfc <step_into+0x74c>
    5bc3:	48 89 df             	mov    %rbx,%rdi
    5bc6:	e8 75 b3 ff ff       	call   f40 <nd_alloc_stack>
    5bcb:	84 c0                	test   %al,%al
    5bcd:	74 1b                	je     5bea <step_into+0x73a>
    5bcf:	4c 8b 6b 60          	mov    0x60(%rbx),%r13
    5bd3:	8b 43 54             	mov    0x54(%rbx),%eax
    5bd6:	8b 4c 24 04          	mov    0x4(%rsp),%ecx
    5bda:	e9 aa f9 ff ff       	jmp    5589 <step_into+0xd9>
    5bdf:	41 bd f4 ff ff ff    	mov    $0xfffffff4,%r13d
    5be5:	e9 a3 fe ff ff       	jmp    5a8d <step_into+0x5dd>
    5bea:	49 c7 c4 f4 ff ff ff 	mov    $0xfffffffffffffff4,%r12
    5bf1:	41 bd f4 ff ff ff    	mov    $0xfffffff4,%r13d
    5bf7:	e9 87 fe ff ff       	jmp    5a83 <step_into+0x5d3>
    5bfc:	49 c7 c4 f6 ff ff ff 	mov    $0xfffffffffffffff6,%r12
    5c03:	41 bd f6 ff ff ff    	mov    $0xfffffff6,%r13d
    5c09:	e9 75 fe ff ff       	jmp    5a83 <step_into+0x5d3>
    5c0e:	66 90                	xchg   %ax,%ax

0000000000005c10 <__pfx_handle_dots>:
    5c10:	90                   	nop
    5c11:	90                   	nop
    5c12:	90                   	nop
    5c13:	90                   	nop
    5c14:	90                   	nop
    5c15:	90                   	nop
    5c16:	90                   	nop
    5c17:	90                   	nop
    5c18:	90                   	nop
    5c19:	90                   	nop
    5c1a:	90                   	nop
    5c1b:	90                   	nop
    5c1c:	90                   	nop
    5c1d:	90                   	nop
    5c1e:	90                   	nop
    5c1f:	90                   	nop

0000000000005c20 <handle_dots>:
    5c20:	e8 00 00 00 00       	call   5c25 <handle_dots+0x5>
    5c25:	55                   	push   %rbp
    5c26:	48 89 e5             	mov    %rsp,%rbp
    5c29:	41 54                	push   %r12
    5c2b:	53                   	push   %rbx
    5c2c:	48 83 ec 18          	sub    $0x18,%rsp
    5c30:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 5c38 <handle_dots+0x18>
    5c37:	00 
    5c38:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5c3d:	31 c0                	xor    %eax,%eax
    5c3f:	83 fe 03             	cmp    $0x3,%esi
    5c42:	0f 85 a5 00 00 00    	jne    5ced <handle_dots+0xcd>
    5c48:	48 8b 57 20          	mov    0x20(%rdi),%rdx
    5c4c:	48 89 fb             	mov    %rdi,%rbx
    5c4f:	48 85 d2             	test   %rdx,%rdx
    5c52:	0f 84 16 01 00 00    	je     5d6e <handle_dots+0x14e>
    5c58:	8b 4b 38             	mov    0x38(%rbx),%ecx
    5c5b:	48 8b 03             	mov    (%rbx),%rax
    5c5e:	f6 c5 01             	test   $0x1,%ch
    5c61:	0f 84 b4 00 00 00    	je     5d1b <handle_dots+0xfb>
    5c67:	48 39 d0             	cmp    %rdx,%rax
    5c6a:	0f 84 17 01 00 00    	je     5d87 <handle_dots+0x167>
    5c70:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    5c74:	48 3b 08             	cmp    (%rax),%rcx
    5c77:	0f 84 2c 02 00 00    	je     5ea9 <handle_dots+0x289>
    5c7d:	4c 8b 61 18          	mov    0x18(%rcx),%r12
    5c81:	41 8b 44 24 04       	mov    0x4(%r12),%eax
    5c86:	a8 01                	test   $0x1,%al
    5c88:	0f 85 94 01 00 00    	jne    5e22 <handle_dots+0x202>
    5c8e:	89 43 44             	mov    %eax,0x44(%rbx)
    5c91:	8b 53 40             	mov    0x40(%rbx),%edx
    5c94:	8b 41 04             	mov    0x4(%rcx),%eax
    5c97:	39 c2                	cmp    %eax,%edx
    5c99:	0f 85 51 01 00 00    	jne    5df0 <handle_dots+0x1d0>
    5c9f:	48 8b 03             	mov    (%rbx),%rax
    5ca2:	48 8b 30             	mov    (%rax),%rsi
    5ca5:	48 8b 40 08          	mov    0x8(%rax),%rax
    5ca9:	48 3b 70 68          	cmp    0x68(%rax),%rsi
    5cad:	74 10                	je     5cbf <handle_dots+0x9f>
    5caf:	4c 89 e7             	mov    %r12,%rdi
    5cb2:	e8 00 00 00 00       	call   5cb7 <handle_dots+0x97>
    5cb7:	84 c0                	test   %al,%al
    5cb9:	0f 84 31 01 00 00    	je     5df0 <handle_dots+0x1d0>
    5cbf:	49 81 fc 00 f0 ff ff 	cmp    $0xfffffffffffff000,%r12
    5cc6:	77 28                	ja     5cf0 <handle_dots+0xd0>
    5cc8:	4c 89 e2             	mov    %r12,%rdx
    5ccb:	be 04 00 00 00       	mov    $0x4,%esi
    5cd0:	48 89 df             	mov    %rbx,%rdi
    5cd3:	e8 d8 f7 ff ff       	call   54b0 <step_into>
    5cd8:	49 89 c4             	mov    %rax,%r12
    5cdb:	48 85 c0             	test   %rax,%rax
    5cde:	75 10                	jne    5cf0 <handle_dots+0xd0>
    5ce0:	f7 43 38 00 00 00 18 	testl  $0x18000000,0x38(%rbx)
    5ce7:	0f 85 0f 01 00 00    	jne    5dfc <handle_dots+0x1dc>
    5ced:	45 31 e4             	xor    %r12d,%r12d
    5cf0:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    5cf5:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 5cfd <handle_dots+0xdd>
    5cfc:	00 
    5cfd:	0f 85 cc 02 00 00    	jne    5fcf <handle_dots+0x3af>
    5d03:	48 83 c4 18          	add    $0x18,%rsp
    5d07:	4c 89 e0             	mov    %r12,%rax
    5d0a:	5b                   	pop    %rbx
    5d0b:	41 5c                	pop    %r12
    5d0d:	5d                   	pop    %rbp
    5d0e:	31 d2                	xor    %edx,%edx
    5d10:	31 c9                	xor    %ecx,%ecx
    5d12:	31 f6                	xor    %esi,%esi
    5d14:	31 ff                	xor    %edi,%edi
    5d16:	e9 00 00 00 00       	jmp    5d1b <handle_dots+0xfb>
    5d1b:	48 39 d0             	cmp    %rdx,%rax
    5d1e:	0f 84 93 00 00 00    	je     5db7 <handle_dots+0x197>
    5d24:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5d28:	48 3b 38             	cmp    (%rax),%rdi
    5d2b:	0f 84 02 01 00 00    	je     5e33 <handle_dots+0x213>
    5d31:	e8 00 00 00 00       	call   5d36 <handle_dots+0x116>
    5d36:	49 89 c4             	mov    %rax,%r12
    5d39:	48 8b 03             	mov    (%rbx),%rax
    5d3c:	48 8b 30             	mov    (%rax),%rsi
    5d3f:	48 8b 40 08          	mov    0x8(%rax),%rax
    5d43:	48 3b 70 68          	cmp    0x68(%rax),%rsi
    5d47:	0f 84 72 ff ff ff    	je     5cbf <handle_dots+0x9f>
    5d4d:	4c 89 e7             	mov    %r12,%rdi
    5d50:	e8 00 00 00 00       	call   5d55 <handle_dots+0x135>
    5d55:	84 c0                	test   %al,%al
    5d57:	0f 85 62 ff ff ff    	jne    5cbf <handle_dots+0x9f>
    5d5d:	4c 89 e7             	mov    %r12,%rdi
    5d60:	49 c7 c4 fe ff ff ff 	mov    $0xfffffffffffffffe,%r12
    5d67:	e8 00 00 00 00       	call   5d6c <handle_dots+0x14c>
    5d6c:	eb 82                	jmp    5cf0 <handle_dots+0xd0>
    5d6e:	e8 ed cd ff ff       	call   2b60 <set_root>
    5d73:	4c 63 e0             	movslq %eax,%r12
    5d76:	85 c0                	test   %eax,%eax
    5d78:	0f 85 72 ff ff ff    	jne    5cf0 <handle_dots+0xd0>
    5d7e:	48 8b 53 20          	mov    0x20(%rbx),%rdx
    5d82:	e9 d1 fe ff ff       	jmp    5c58 <handle_dots+0x38>
    5d87:	48 8b 4b 28          	mov    0x28(%rbx),%rcx
    5d8b:	48 39 4b 08          	cmp    %rcx,0x8(%rbx)
    5d8f:	0f 85 db fe ff ff    	jne    5c70 <handle_dots+0x50>
    5d95:	8b 53 48             	mov    0x48(%rbx),%edx
    5d98:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 5d9e <handle_dots+0x17e>
    5d9e:	39 c2                	cmp    %eax,%edx
    5da0:	75 4e                	jne    5df0 <handle_dots+0x1d0>
    5da2:	f6 43 3b 08          	testb  $0x8,0x3b(%rbx)
    5da6:	75 48                	jne    5df0 <handle_dots+0x1d0>
    5da8:	8b 43 40             	mov    0x40(%rbx),%eax
    5dab:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    5daf:	89 43 44             	mov    %eax,0x44(%rbx)
    5db2:	e9 08 ff ff ff       	jmp    5cbf <handle_dots+0x9f>
    5db7:	48 8b 53 28          	mov    0x28(%rbx),%rdx
    5dbb:	48 39 53 08          	cmp    %rdx,0x8(%rbx)
    5dbf:	0f 85 5f ff ff ff    	jne    5d24 <handle_dots+0x104>
    5dc5:	81 e1 00 00 00 08    	and    $0x8000000,%ecx
    5dcb:	0f 85 75 01 00 00    	jne    5f46 <handle_dots+0x326>
    5dd1:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    5dd5:	4d 85 e4             	test   %r12,%r12
    5dd8:	0f 84 ea fe ff ff    	je     5cc8 <handle_dots+0xa8>
    5dde:	49 8d bc 24 80 00 00 	lea    0x80(%r12),%rdi
    5de5:	00 
    5de6:	e8 00 00 00 00       	call   5deb <handle_dots+0x1cb>
    5deb:	e9 cf fe ff ff       	jmp    5cbf <handle_dots+0x9f>
    5df0:	49 c7 c4 f6 ff ff ff 	mov    $0xfffffffffffffff6,%r12
    5df7:	e9 f4 fe ff ff       	jmp    5cf0 <handle_dots+0xd0>
    5dfc:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 5e02 <handle_dots+0x1e2>
    5e02:	39 43 48             	cmp    %eax,0x48(%rbx)
    5e05:	75 0f                	jne    5e16 <handle_dots+0x1f6>
    5e07:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 5e0d <handle_dots+0x1ed>
    5e0d:	39 43 4c             	cmp    %eax,0x4c(%rbx)
    5e10:	0f 84 d7 fe ff ff    	je     5ced <handle_dots+0xcd>
    5e16:	49 c7 c4 f5 ff ff ff 	mov    $0xfffffffffffffff5,%r12
    5e1d:	e9 ce fe ff ff       	jmp    5cf0 <handle_dots+0xd0>
    5e22:	f3 90                	pause
    5e24:	41 8b 44 24 04       	mov    0x4(%r12),%eax
    5e29:	a8 01                	test   $0x1,%al
    5e2b:	0f 84 5d fe ff ff    	je     5c8e <handle_dots+0x6e>
    5e31:	eb ef                	jmp    5e22 <handle_dots+0x202>
    5e33:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    5e3a:	00 
    5e3b:	4c 8d 60 e0          	lea    -0x20(%rax),%r12
    5e3f:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    5e46:	00 00 
    5e48:	e8 00 00 00 00       	call   5e4d <handle_dots+0x22d>
    5e4d:	8b 0d 00 00 00 00    	mov    0x0(%rip),%ecx        # 5e53 <handle_dots+0x233>
    5e53:	f6 c1 01             	test   $0x1,%cl
    5e56:	75 42                	jne    5e9a <handle_dots+0x27a>
    5e58:	4c 89 e0             	mov    %r12,%rax
    5e5b:	eb 06                	jmp    5e63 <handle_dots+0x243>
    5e5d:	48 3b 50 20          	cmp    0x20(%rax),%rdx
    5e61:	75 7e                	jne    5ee1 <handle_dots+0x2c1>
    5e63:	48 89 c2             	mov    %rax,%rdx
    5e66:	48 8b 40 10          	mov    0x10(%rax),%rax
    5e6a:	48 39 c2             	cmp    %rax,%rdx
    5e6d:	74 14                	je     5e83 <handle_dots+0x263>
    5e6f:	48 8b 52 18          	mov    0x18(%rdx),%rdx
    5e73:	48 3b 53 28          	cmp    0x28(%rbx),%rdx
    5e77:	75 e4                	jne    5e5d <handle_dots+0x23d>
    5e79:	48 8d 70 20          	lea    0x20(%rax),%rsi
    5e7d:	48 39 73 20          	cmp    %rsi,0x20(%rbx)
    5e81:	75 da                	jne    5e5d <handle_dots+0x23d>
    5e83:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 5e89 <handle_dots+0x269>
    5e89:	39 c1                	cmp    %eax,%ecx
    5e8b:	75 c0                	jne    5e4d <handle_dots+0x22d>
    5e8d:	e8 00 00 00 00       	call   5e92 <handle_dots+0x272>
    5e92:	8b 4b 38             	mov    0x38(%rbx),%ecx
    5e95:	e9 2b ff ff ff       	jmp    5dc5 <handle_dots+0x1a5>
    5e9a:	f3 90                	pause
    5e9c:	8b 0d 00 00 00 00    	mov    0x0(%rip),%ecx        # 5ea2 <handle_dots+0x282>
    5ea2:	f6 c1 01             	test   $0x1,%cl
    5ea5:	74 b1                	je     5e58 <handle_dots+0x238>
    5ea7:	eb f1                	jmp    5e9a <handle_dots+0x27a>
    5ea9:	48 83 e8 20          	sub    $0x20,%rax
    5ead:	eb 0a                	jmp    5eb9 <handle_dots+0x299>
    5eaf:	48 3b 48 20          	cmp    0x20(%rax),%rcx
    5eb3:	0f 85 a6 00 00 00    	jne    5f5f <handle_dots+0x33f>
    5eb9:	48 89 c1             	mov    %rax,%rcx
    5ebc:	48 8b 40 10          	mov    0x10(%rax),%rax
    5ec0:	48 39 c1             	cmp    %rax,%rcx
    5ec3:	0f 84 cc fe ff ff    	je     5d95 <handle_dots+0x175>
    5ec9:	48 8b 49 18          	mov    0x18(%rcx),%rcx
    5ecd:	48 3b 4b 28          	cmp    0x28(%rbx),%rcx
    5ed1:	75 dc                	jne    5eaf <handle_dots+0x28f>
    5ed3:	48 8d 70 20          	lea    0x20(%rax),%rsi
    5ed7:	48 39 f2             	cmp    %rsi,%rdx
    5eda:	75 d3                	jne    5eaf <handle_dots+0x28f>
    5edc:	e9 b4 fe ff ff       	jmp    5d95 <handle_dots+0x175>
    5ee1:	48 83 c0 20          	add    $0x20,%rax
    5ee5:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    5eea:	48 89 04 24          	mov    %rax,(%rsp)
    5eee:	8b 72 04             	mov    0x4(%rdx),%esi
    5ef1:	40 f6 c6 01          	test   $0x1,%sil
    5ef5:	75 5b                	jne    5f52 <handle_dots+0x332>
    5ef7:	89 ca                	mov    %ecx,%edx
    5ef9:	48 89 e7             	mov    %rsp,%rdi
    5efc:	e8 0f a9 ff ff       	call   810 <__legitimize_path>
    5f01:	84 c0                	test   %al,%al
    5f03:	0f 84 a4 00 00 00    	je     5fad <handle_dots+0x38d>
    5f09:	e8 00 00 00 00       	call   5f0e <handle_dots+0x2ee>
    5f0e:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5f12:	e8 00 00 00 00       	call   5f17 <handle_dots+0x2f7>
    5f17:	48 8b 3b             	mov    (%rbx),%rdi
    5f1a:	e8 00 00 00 00       	call   5f1f <handle_dots+0x2ff>
    5f1f:	48 8b 04 24          	mov    (%rsp),%rax
    5f23:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    5f28:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    5f2d:	48 89 03             	mov    %rax,(%rbx)
    5f30:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    5f34:	48 8b 47 30          	mov    0x30(%rdi),%rax
    5f38:	48 89 43 30          	mov    %rax,0x30(%rbx)
    5f3c:	f6 43 3b 04          	testb  $0x4,0x3b(%rbx)
    5f40:	0f 84 eb fd ff ff    	je     5d31 <handle_dots+0x111>
    5f46:	49 c7 c4 ee ff ff ff 	mov    $0xffffffffffffffee,%r12
    5f4d:	e9 9e fd ff ff       	jmp    5cf0 <handle_dots+0xd0>
    5f52:	f3 90                	pause
    5f54:	8b 72 04             	mov    0x4(%rdx),%esi
    5f57:	40 f6 c6 01          	test   $0x1,%sil
    5f5b:	74 9a                	je     5ef7 <handle_dots+0x2d7>
    5f5d:	eb f3                	jmp    5f52 <handle_dots+0x332>
    5f5f:	8b 51 04             	mov    0x4(%rcx),%edx
    5f62:	48 83 c0 20          	add    $0x20,%rax
    5f66:	f6 c2 01             	test   $0x1,%dl
    5f69:	75 36                	jne    5fa1 <handle_dots+0x381>
    5f6b:	f6 43 3b 04          	testb  $0x4,0x3b(%rbx)
    5f6f:	0f 85 7b fe ff ff    	jne    5df0 <handle_dots+0x1d0>
    5f75:	48 89 03             	mov    %rax,(%rbx)
    5f78:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    5f7c:	48 8b 41 30          	mov    0x30(%rcx),%rax
    5f80:	89 53 40             	mov    %edx,0x40(%rbx)
    5f83:	8b 53 48             	mov    0x48(%rbx),%edx
    5f86:	48 89 43 30          	mov    %rax,0x30(%rbx)
    5f8a:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 5f90 <handle_dots+0x370>
    5f90:	39 c2                	cmp    %eax,%edx
    5f92:	0f 85 58 fe ff ff    	jne    5df0 <handle_dots+0x1d0>
    5f98:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    5f9c:	e9 dc fc ff ff       	jmp    5c7d <handle_dots+0x5d>
    5fa1:	f3 90                	pause
    5fa3:	8b 51 04             	mov    0x4(%rcx),%edx
    5fa6:	f6 c2 01             	test   $0x1,%dl
    5fa9:	74 c0                	je     5f6b <handle_dots+0x34b>
    5fab:	eb f4                	jmp    5fa1 <handle_dots+0x381>
    5fad:	e8 00 00 00 00       	call   5fb2 <handle_dots+0x392>
    5fb2:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    5fb7:	e8 00 00 00 00       	call   5fbc <handle_dots+0x39c>
    5fbc:	48 8b 3c 24          	mov    (%rsp),%rdi
    5fc0:	e8 00 00 00 00       	call   5fc5 <handle_dots+0x3a5>
    5fc5:	e8 00 00 00 00       	call   5fca <handle_dots+0x3aa>
    5fca:	e9 7e fe ff ff       	jmp    5e4d <handle_dots+0x22d>
    5fcf:	e8 00 00 00 00       	call   5fd4 <handle_dots+0x3b4>
    5fd4:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5fdb:	00 00 00 00 
    5fdf:	90                   	nop

0000000000005fe0 <__pfx_walk_component>:
    5fe0:	90                   	nop
    5fe1:	90                   	nop
    5fe2:	90                   	nop
    5fe3:	90                   	nop
    5fe4:	90                   	nop
    5fe5:	90                   	nop
    5fe6:	90                   	nop
    5fe7:	90                   	nop
    5fe8:	90                   	nop
    5fe9:	90                   	nop
    5fea:	90                   	nop
    5feb:	90                   	nop
    5fec:	90                   	nop
    5fed:	90                   	nop
    5fee:	90                   	nop
    5fef:	90                   	nop

0000000000005ff0 <walk_component>:
    5ff0:	e8 00 00 00 00       	call   5ff5 <walk_component+0x5>
    5ff5:	55                   	push   %rbp
    5ff6:	48 89 e5             	mov    %rsp,%rbp
    5ff9:	41 57                	push   %r15
    5ffb:	41 56                	push   %r14
    5ffd:	41 55                	push   %r13
    5fff:	41 54                	push   %r12
    6001:	41 89 f4             	mov    %esi,%r12d
    6004:	53                   	push   %rbx
    6005:	48 89 fb             	mov    %rdi,%rbx
    6008:	48 83 ec 08          	sub    $0x8,%rsp
    600c:	8b 77 50             	mov    0x50(%rdi),%esi
    600f:	85 f6                	test   %esi,%esi
    6011:	0f 85 98 00 00 00    	jne    60af <walk_component+0xbf>
    6017:	e8 d4 c4 ff ff       	call   24f0 <lookup_fast>
    601c:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    6022:	77 1d                	ja     6041 <walk_component+0x51>
    6024:	48 85 c0             	test   %rax,%rax
    6027:	0f 84 b0 00 00 00    	je     60dd <walk_component+0xed>
    602d:	41 f6 c4 02          	test   $0x2,%r12b
    6031:	74 27                	je     605a <walk_component+0x6a>
    6033:	48 89 c2             	mov    %rax,%rdx
    6036:	44 89 e6             	mov    %r12d,%esi
    6039:	48 89 df             	mov    %rbx,%rdi
    603c:	e8 6f f4 ff ff       	call   54b0 <step_into>
    6041:	48 83 c4 08          	add    $0x8,%rsp
    6045:	5b                   	pop    %rbx
    6046:	41 5c                	pop    %r12
    6048:	41 5d                	pop    %r13
    604a:	41 5e                	pop    %r14
    604c:	41 5f                	pop    %r15
    604e:	5d                   	pop    %rbp
    604f:	31 d2                	xor    %edx,%edx
    6051:	31 f6                	xor    %esi,%esi
    6053:	31 ff                	xor    %edi,%edi
    6055:	e9 00 00 00 00       	jmp    605a <walk_component+0x6a>
    605a:	8b 53 54             	mov    0x54(%rbx),%edx
    605d:	85 d2                	test   %edx,%edx
    605f:	74 d2                	je     6033 <walk_component+0x43>
    6061:	83 ea 01             	sub    $0x1,%edx
    6064:	4c 8d 2c 52          	lea    (%rdx,%rdx,2),%r13
    6068:	89 53 54             	mov    %edx,0x54(%rbx)
    606b:	49 c1 e5 04          	shl    $0x4,%r13
    606f:	4c 03 6b 60          	add    0x60(%rbx),%r13
    6073:	49 8b 55 10          	mov    0x10(%r13),%rdx
    6077:	48 85 d2             	test   %rdx,%rdx
    607a:	74 11                	je     608d <walk_component+0x9d>
    607c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    6080:	49 8b 7d 18          	mov    0x18(%r13),%rdi
    6084:	e8 00 00 00 00       	call   6089 <walk_component+0x99>
    6089:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    608d:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    6091:	75 a0                	jne    6033 <walk_component+0x43>
    6093:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    6097:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    609b:	e8 00 00 00 00       	call   60a0 <walk_component+0xb0>
    60a0:	49 8b 7d 00          	mov    0x0(%r13),%rdi
    60a4:	e8 00 00 00 00       	call   60a9 <walk_component+0xb9>
    60a9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    60ad:	eb 84                	jmp    6033 <walk_component+0x43>
    60af:	41 83 e4 02          	and    $0x2,%r12d
    60b3:	75 07                	jne    60bc <walk_component+0xcc>
    60b5:	8b 47 54             	mov    0x54(%rdi),%eax
    60b8:	85 c0                	test   %eax,%eax
    60ba:	75 6c                	jne    6128 <walk_component+0x138>
    60bc:	48 89 df             	mov    %rbx,%rdi
    60bf:	e8 5c fb ff ff       	call   5c20 <handle_dots>
    60c4:	48 83 c4 08          	add    $0x8,%rsp
    60c8:	5b                   	pop    %rbx
    60c9:	41 5c                	pop    %r12
    60cb:	41 5d                	pop    %r13
    60cd:	41 5e                	pop    %r14
    60cf:	41 5f                	pop    %r15
    60d1:	5d                   	pop    %rbp
    60d2:	31 d2                	xor    %edx,%edx
    60d4:	31 f6                	xor    %esi,%esi
    60d6:	31 ff                	xor    %edi,%edi
    60d8:	e9 00 00 00 00       	jmp    60dd <walk_component+0xed>
    60dd:	4c 8b 73 08          	mov    0x8(%rbx),%r14
    60e1:	44 8b 7b 38          	mov    0x38(%rbx),%r15d
    60e5:	49 8b 46 30          	mov    0x30(%r14),%rax
    60e9:	4c 8d a8 98 00 00 00 	lea    0x98(%rax),%r13
    60f0:	4c 89 ef             	mov    %r13,%rdi
    60f3:	e8 00 00 00 00       	call   60f8 <walk_component+0x108>
    60f8:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
    60fc:	44 89 fa             	mov    %r15d,%edx
    60ff:	4c 89 f6             	mov    %r14,%rsi
    6102:	e8 29 ba ff ff       	call   1b30 <__lookup_slow>
    6107:	4c 89 ef             	mov    %r13,%rdi
    610a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    610e:	e8 00 00 00 00       	call   6113 <walk_component+0x123>
    6113:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    6117:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    611d:	0f 86 0a ff ff ff    	jbe    602d <walk_component+0x3d>
    6123:	e9 19 ff ff ff       	jmp    6041 <walk_component+0x51>
    6128:	83 e8 01             	sub    $0x1,%eax
    612b:	4c 8d 24 40          	lea    (%rax,%rax,2),%r12
    612f:	89 47 54             	mov    %eax,0x54(%rdi)
    6132:	49 c1 e4 04          	shl    $0x4,%r12
    6136:	4c 03 67 60          	add    0x60(%rdi),%r12
    613a:	49 8b 44 24 10       	mov    0x10(%r12),%rax
    613f:	48 85 c0             	test   %rax,%rax
    6142:	74 0a                	je     614e <walk_component+0x15e>
    6144:	49 8b 7c 24 18       	mov    0x18(%r12),%rdi
    6149:	e8 00 00 00 00       	call   614e <walk_component+0x15e>
    614e:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    6152:	74 08                	je     615c <walk_component+0x16c>
    6154:	8b 73 50             	mov    0x50(%rbx),%esi
    6157:	e9 60 ff ff ff       	jmp    60bc <walk_component+0xcc>
    615c:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    6161:	e8 00 00 00 00       	call   6166 <walk_component+0x176>
    6166:	49 8b 3c 24          	mov    (%r12),%rdi
    616a:	e8 00 00 00 00       	call   616f <walk_component+0x17f>
    616f:	eb e3                	jmp    6154 <walk_component+0x164>
    6171:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6178:	00 00 00 00 
    617c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006180 <__pfx_link_path_walk>:
    6180:	90                   	nop
    6181:	90                   	nop
    6182:	90                   	nop
    6183:	90                   	nop
    6184:	90                   	nop
    6185:	90                   	nop
    6186:	90                   	nop
    6187:	90                   	nop
    6188:	90                   	nop
    6189:	90                   	nop
    618a:	90                   	nop
    618b:	90                   	nop
    618c:	90                   	nop
    618d:	90                   	nop
    618e:	90                   	nop
    618f:	90                   	nop

0000000000006190 <link_path_walk>:
    6190:	e8 00 00 00 00       	call   6195 <link_path_walk+0x5>
    6195:	55                   	push   %rbp
    6196:	89 fa                	mov    %edi,%edx
    6198:	48 89 e5             	mov    %rsp,%rbp
    619b:	41 57                	push   %r15
    619d:	41 56                	push   %r14
    619f:	41 55                	push   %r13
    61a1:	41 54                	push   %r12
    61a3:	53                   	push   %rbx
    61a4:	48 89 fb             	mov    %rdi,%rbx
    61a7:	48 83 ec 10          	sub    $0x10,%rsp
    61ab:	8b 46 38             	mov    0x38(%rsi),%eax
    61ae:	c7 46 50 01 00 00 00 	movl   $0x1,0x50(%rsi)
    61b5:	80 cc 04             	or     $0x4,%ah
    61b8:	89 46 38             	mov    %eax,0x38(%rsi)
    61bb:	48 81 ff 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rdi
    61c2:	0f 87 7c 02 00 00    	ja     6444 <link_path_walk+0x2b4>
    61c8:	0f b6 17             	movzbl (%rdi),%edx
    61cb:	49 89 f6             	mov    %rsi,%r14
    61ce:	80 fa 2f             	cmp    $0x2f,%dl
    61d1:	0f 84 96 02 00 00    	je     646d <link_path_walk+0x2dd>
    61d7:	49 bd ff fe fe fe fe 	movabs $0xfefefefefefefeff,%r13
    61de:	fe fe fe 
    61e1:	45 31 db             	xor    %r11d,%r11d
    61e4:	49 bf d0 d0 d0 d0 d0 	movabs $0xd0d0d0d0d0d0d0d0,%r15
    61eb:	d0 d0 d0 
    61ee:	49 bc 80 80 80 80 80 	movabs $0x8080808080808080,%r12
    61f5:	80 80 80 
    61f8:	84 d2                	test   %dl,%dl
    61fa:	0f 84 05 03 00 00    	je     6505 <link_path_walk+0x375>
    6200:	44 89 5d d4          	mov    %r11d,-0x2c(%rbp)
    6204:	89 c2                	mov    %eax,%edx
    6206:	4c 89 f0             	mov    %r14,%rax
    6209:	49 89 de             	mov    %rbx,%r14
    620c:	48 89 c3             	mov    %rax,%rbx
    620f:	48 8b 03             	mov    (%rbx),%rax
    6212:	d1 ea                	shr    $1,%edx
    6214:	48 8b 73 30          	mov    0x30(%rbx),%rsi
    6218:	81 e2 80 00 00 00    	and    $0x80,%edx
    621e:	48 8b 78 18          	mov    0x18(%rax),%rdi
    6222:	83 ca 01             	or     $0x1,%edx
    6225:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    6229:	e8 00 00 00 00       	call   622e <link_path_walk+0x9e>
    622e:	49 b8 2f 2f 2f 2f 2f 	movabs $0x2f2f2f2f2f2f2f2f,%r8
    6235:	2f 2f 2f 
    6238:	85 c0                	test   %eax,%eax
    623a:	89 c2                	mov    %eax,%edx
    623c:	0f 85 3e 02 00 00    	jne    6480 <link_path_walk+0x2f0>
    6242:	4c 8b 5b 08          	mov    0x8(%rbx),%r11
    6246:	4c 89 73 18          	mov    %r14,0x18(%rbx)
    624a:	4c 89 de             	mov    %r11,%rsi
    624d:	49 8b 3e             	mov    (%r14),%rdi
    6250:	48 89 fa             	mov    %rdi,%rdx
    6253:	48 89 f8             	mov    %rdi,%rax
    6256:	49 89 fa             	mov    %rdi,%r10
    6259:	48 89 f9             	mov    %rdi,%rcx
    625c:	4c 31 c2             	xor    %r8,%rdx
    625f:	4c 31 f8             	xor    %r15,%rax
    6262:	49 f7 d2             	not    %r10
    6265:	4c 01 ea             	add    %r13,%rdx
    6268:	48 21 c2             	and    %rax,%rdx
    626b:	4a 8d 04 2f          	lea    (%rdi,%r13,1),%rax
    626f:	4c 21 d0             	and    %r10,%rax
    6272:	48 09 c2             	or     %rax,%rdx
    6275:	4c 21 e2             	and    %r12,%rdx
    6278:	0f 85 47 01 00 00    	jne    63c5 <link_path_walk+0x235>
    627e:	45 31 d2             	xor    %r10d,%r10d
    6281:	48 31 d1             	xor    %rdx,%rcx
    6284:	49 83 c2 08          	add    $0x8,%r10
    6288:	48 31 ce             	xor    %rcx,%rsi
    628b:	48 c1 c1 0c          	rol    $0xc,%rcx
    628f:	48 8d 14 0e          	lea    (%rsi,%rcx,1),%rdx
    6293:	48 c1 ce 13          	ror    $0x13,%rsi
    6297:	48 8d 34 f6          	lea    (%rsi,%rsi,8),%rsi
    629b:	4b 8b 0c 16          	mov    (%r14,%r10,1),%rcx
    629f:	48 89 c8             	mov    %rcx,%rax
    62a2:	48 89 cf             	mov    %rcx,%rdi
    62a5:	49 89 c9             	mov    %rcx,%r9
    62a8:	4c 31 c0             	xor    %r8,%rax
    62ab:	4c 31 ff             	xor    %r15,%rdi
    62ae:	49 f7 d1             	not    %r9
    62b1:	4c 01 e8             	add    %r13,%rax
    62b4:	48 21 f8             	and    %rdi,%rax
    62b7:	4a 8d 3c 29          	lea    (%rcx,%r13,1),%rdi
    62bb:	4c 21 cf             	and    %r9,%rdi
    62be:	48 09 f8             	or     %rdi,%rax
    62c1:	4c 21 e0             	and    %r12,%rax
    62c4:	74 bb                	je     6281 <link_path_walk+0xf1>
    62c6:	f3 48 0f bc f8       	tzcnt  %rax,%rdi
    62cb:	48 c1 ef 03          	shr    $0x3,%rdi
    62cf:	49 01 fa             	add    %rdi,%r10
    62d2:	48 8d 78 ff          	lea    -0x1(%rax),%rdi
    62d6:	48 f7 d0             	not    %rax
    62d9:	48 21 f8             	and    %rdi,%rax
    62dc:	44 89 53 14          	mov    %r10d,0x14(%rbx)
    62e0:	4d 01 d6             	add    %r10,%r14
    62e3:	48 c1 e8 07          	shr    $0x7,%rax
    62e7:	48 21 c8             	and    %rcx,%rax
    62ea:	48 31 d0             	xor    %rdx,%rax
    62ed:	48 ba eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rdx
    62f4:	86 c8 61 
    62f7:	48 0f af c2          	imul   %rdx,%rax
    62fb:	48 31 f0             	xor    %rsi,%rax
    62fe:	48 0f af c2          	imul   %rdx,%rax
    6302:	48 c1 e8 20          	shr    $0x20,%rax
    6306:	89 43 10             	mov    %eax,0x10(%rbx)
    6309:	83 63 3c fb          	andl   $0xfffffffb,0x3c(%rbx)
    630d:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%rbx)
    6314:	41 f6 03 01          	testb  $0x1,(%r11)
    6318:	0f 85 c4 01 00 00    	jne    64e2 <link_path_walk+0x352>
    631e:	41 80 3e 00          	cmpb   $0x0,(%r14)
    6322:	75 50                	jne    6374 <link_path_walk+0x1e4>
    6324:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    6327:	85 c0                	test   %eax,%eax
    6329:	0f 84 e7 01 00 00    	je     6516 <link_path_walk+0x386>
    632f:	83 6d d4 01          	subl   $0x1,-0x2c(%rbp)
    6333:	48 63 45 d4          	movslq -0x2c(%rbp),%rax
    6337:	31 f6                	xor    %esi,%esi
    6339:	48 89 df             	mov    %rbx,%rdi
    633c:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    6340:	48 c1 e0 04          	shl    $0x4,%rax
    6344:	48 03 43 60          	add    0x60(%rbx),%rax
    6348:	4c 8b 70 20          	mov    0x20(%rax),%r14
    634c:	e8 9f fc ff ff       	call   5ff0 <walk_component>
    6351:	48 85 c0             	test   %rax,%rax
    6354:	75 41                	jne    6397 <link_path_walk+0x207>
    6356:	48 8b 43 08          	mov    0x8(%rbx),%rax
    635a:	8b 00                	mov    (%rax),%eax
    635c:	25 00 00 38 00       	and    $0x380000,%eax
    6361:	3d 00 00 10 00       	cmp    $0x100000,%eax
    6366:	0f 85 c9 00 00 00    	jne    6435 <link_path_walk+0x2a5>
    636c:	8b 53 38             	mov    0x38(%rbx),%edx
    636f:	e9 9b fe ff ff       	jmp    620f <link_path_walk+0x7f>
    6374:	41 0f b6 46 01       	movzbl 0x1(%r14),%eax
    6379:	49 83 c6 01          	add    $0x1,%r14
    637d:	3c 2f                	cmp    $0x2f,%al
    637f:	74 f3                	je     6374 <link_path_walk+0x1e4>
    6381:	84 c0                	test   %al,%al
    6383:	74 9f                	je     6324 <link_path_walk+0x194>
    6385:	be 02 00 00 00       	mov    $0x2,%esi
    638a:	48 89 df             	mov    %rbx,%rdi
    638d:	e8 5e fc ff ff       	call   5ff0 <walk_component>
    6392:	48 85 c0             	test   %rax,%rax
    6395:	74 bf                	je     6356 <link_path_walk+0x1c6>
    6397:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    639d:	0f 87 b0 01 00 00    	ja     6553 <link_path_walk+0x3c3>
    63a3:	48 63 55 d4          	movslq -0x2c(%rbp),%rdx
    63a7:	48 89 d6             	mov    %rdx,%rsi
    63aa:	48 8d 14 52          	lea    (%rdx,%rdx,2),%rdx
    63ae:	48 c1 e2 04          	shl    $0x4,%rdx
    63b2:	48 03 53 60          	add    0x60(%rbx),%rdx
    63b6:	4c 89 72 20          	mov    %r14,0x20(%rdx)
    63ba:	8d 56 01             	lea    0x1(%rsi),%edx
    63bd:	49 89 c6             	mov    %rax,%r14
    63c0:	89 55 d4             	mov    %edx,-0x2c(%rbp)
    63c3:	eb a7                	jmp    636c <link_path_walk+0x1dc>
    63c5:	48 89 d1             	mov    %rdx,%rcx
    63c8:	48 8d 42 ff          	lea    -0x1(%rdx),%rax
    63cc:	48 be eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rsi
    63d3:	86 c8 61 
    63d6:	48 f7 d1             	not    %rcx
    63d9:	48 21 c8             	and    %rcx,%rax
    63dc:	48 c1 e8 07          	shr    $0x7,%rax
    63e0:	48 21 f8             	and    %rdi,%rax
    63e3:	48 89 c1             	mov    %rax,%rcx
    63e6:	48 0f af ce          	imul   %rsi,%rcx
    63ea:	f3 48 0f bc d2       	tzcnt  %rdx,%rdx
    63ef:	48 c1 ea 03          	shr    $0x3,%rdx
    63f3:	4c 31 d9             	xor    %r11,%rcx
    63f6:	89 53 14             	mov    %edx,0x14(%rbx)
    63f9:	49 01 d6             	add    %rdx,%r14
    63fc:	48 0f af ce          	imul   %rsi,%rcx
    6400:	48 c1 e9 20          	shr    $0x20,%rcx
    6404:	89 4b 10             	mov    %ecx,0x10(%rbx)
    6407:	48 83 f8 2e          	cmp    $0x2e,%rax
    640b:	74 1c                	je     6429 <link_path_walk+0x299>
    640d:	48 3d 2e 2e 00 00    	cmp    $0x2e2e,%rax
    6413:	0f 85 f0 fe ff ff    	jne    6309 <link_path_walk+0x179>
    6419:	83 4b 3c 04          	orl    $0x4,0x3c(%rbx)
    641d:	c7 43 50 03 00 00 00 	movl   $0x3,0x50(%rbx)
    6424:	e9 f5 fe ff ff       	jmp    631e <link_path_walk+0x18e>
    6429:	c7 43 50 02 00 00 00 	movl   $0x2,0x50(%rbx)
    6430:	e9 e9 fe ff ff       	jmp    631e <link_path_walk+0x18e>
    6435:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    6439:	0f 85 89 00 00 00    	jne    64c8 <link_path_walk+0x338>
    643f:	ba ec ff ff ff       	mov    $0xffffffec,%edx
    6444:	48 83 c4 10          	add    $0x10,%rsp
    6448:	89 d0                	mov    %edx,%eax
    644a:	5b                   	pop    %rbx
    644b:	41 5c                	pop    %r12
    644d:	41 5d                	pop    %r13
    644f:	41 5e                	pop    %r14
    6451:	41 5f                	pop    %r15
    6453:	5d                   	pop    %rbp
    6454:	31 d2                	xor    %edx,%edx
    6456:	31 c9                	xor    %ecx,%ecx
    6458:	31 f6                	xor    %esi,%esi
    645a:	31 ff                	xor    %edi,%edi
    645c:	45 31 c0             	xor    %r8d,%r8d
    645f:	45 31 c9             	xor    %r9d,%r9d
    6462:	45 31 d2             	xor    %r10d,%r10d
    6465:	45 31 db             	xor    %r11d,%r11d
    6468:	e9 00 00 00 00       	jmp    646d <link_path_walk+0x2dd>
    646d:	0f b6 53 01          	movzbl 0x1(%rbx),%edx
    6471:	48 83 c3 01          	add    $0x1,%rbx
    6475:	80 fa 2f             	cmp    $0x2f,%dl
    6478:	0f 85 59 fd ff ff    	jne    61d7 <link_path_walk+0x47>
    647e:	eb ed                	jmp    646d <link_path_walk+0x2dd>
    6480:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    6484:	74 be                	je     6444 <link_path_walk+0x2b4>
    6486:	48 89 df             	mov    %rbx,%rdi
    6489:	89 45 d0             	mov    %eax,-0x30(%rbp)
    648c:	e8 6f bf ff ff       	call   2400 <try_to_unlazy>
    6491:	84 c0                	test   %al,%al
    6493:	74 43                	je     64d8 <link_path_walk+0x348>
    6495:	8b 55 d0             	mov    -0x30(%rbp),%edx
    6498:	83 fa f6             	cmp    $0xfffffff6,%edx
    649b:	75 a7                	jne    6444 <link_path_walk+0x2b4>
    649d:	48 8b 73 30          	mov    0x30(%rbx),%rsi
    64a1:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    64a5:	ba 01 00 00 00       	mov    $0x1,%edx
    64aa:	e8 00 00 00 00       	call   64af <link_path_walk+0x31f>
    64af:	49 b8 2f 2f 2f 2f 2f 	movabs $0x2f2f2f2f2f2f2f2f,%r8
    64b6:	2f 2f 2f 
    64b9:	85 c0                	test   %eax,%eax
    64bb:	89 c2                	mov    %eax,%edx
    64bd:	0f 84 7f fd ff ff    	je     6242 <link_path_walk+0xb2>
    64c3:	e9 7c ff ff ff       	jmp    6444 <link_path_walk+0x2b4>
    64c8:	48 89 df             	mov    %rbx,%rdi
    64cb:	e8 30 bf ff ff       	call   2400 <try_to_unlazy>
    64d0:	84 c0                	test   %al,%al
    64d2:	0f 85 67 ff ff ff    	jne    643f <link_path_walk+0x2af>
    64d8:	ba f6 ff ff ff       	mov    $0xfffffff6,%edx
    64dd:	e9 62 ff ff ff       	jmp    6444 <link_path_walk+0x2b4>
    64e2:	49 8b 43 60          	mov    0x60(%r11),%rax
    64e6:	48 8d 73 10          	lea    0x10(%rbx),%rsi
    64ea:	4c 89 df             	mov    %r11,%rdi
    64ed:	48 8b 40 10          	mov    0x10(%rax),%rax
    64f1:	e8 00 00 00 00       	call   64f6 <link_path_walk+0x366>
    64f6:	89 c2                	mov    %eax,%edx
    64f8:	85 c0                	test   %eax,%eax
    64fa:	0f 89 1e fe ff ff    	jns    631e <link_path_walk+0x18e>
    6500:	e9 3f ff ff ff       	jmp    6444 <link_path_walk+0x2b4>
    6505:	31 d2                	xor    %edx,%edx
    6507:	66 41 89 96 ec 00 00 	mov    %dx,0xec(%r14)
    650e:	00 
    650f:	31 d2                	xor    %edx,%edx
    6511:	e9 2e ff ff ff       	jmp    6444 <link_path_walk+0x2b4>
    6516:	48 8b 43 30          	mov    0x30(%rbx),%rax
    651a:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    651e:	8b 50 04             	mov    0x4(%rax),%edx
    6521:	48 8b 40 28          	mov    0x28(%rax),%rax
    6525:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    652c:	e8 00 00 00 00       	call   6531 <link_path_walk+0x3a1>
    6531:	31 d2                	xor    %edx,%edx
    6533:	89 83 e8 00 00 00    	mov    %eax,0xe8(%rbx)
    6539:	48 8b 43 30          	mov    0x30(%rbx),%rax
    653d:	0f b7 00             	movzwl (%rax),%eax
    6540:	81 63 38 ff fb ff ff 	andl   $0xfffffbff,0x38(%rbx)
    6547:	66 89 83 ec 00 00 00 	mov    %ax,0xec(%rbx)
    654e:	e9 f1 fe ff ff       	jmp    6444 <link_path_walk+0x2b4>
    6553:	48 89 c2             	mov    %rax,%rdx
    6556:	e9 e9 fe ff ff       	jmp    6444 <link_path_walk+0x2b4>
    655b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006560 <__pfx_path_parentat>:
    6560:	90                   	nop
    6561:	90                   	nop
    6562:	90                   	nop
    6563:	90                   	nop
    6564:	90                   	nop
    6565:	90                   	nop
    6566:	90                   	nop
    6567:	90                   	nop
    6568:	90                   	nop
    6569:	90                   	nop
    656a:	90                   	nop
    656b:	90                   	nop
    656c:	90                   	nop
    656d:	90                   	nop
    656e:	90                   	nop
    656f:	90                   	nop

0000000000006570 <path_parentat>:
    6570:	e8 00 00 00 00       	call   6575 <path_parentat+0x5>
    6575:	55                   	push   %rbp
    6576:	48 89 e5             	mov    %rsp,%rbp
    6579:	41 55                	push   %r13
    657b:	49 89 d5             	mov    %rdx,%r13
    657e:	41 54                	push   %r12
    6580:	53                   	push   %rbx
    6581:	48 89 fb             	mov    %rdi,%rbx
    6584:	e8 87 de ff ff       	call   4410 <path_init>
    6589:	48 89 de             	mov    %rbx,%rsi
    658c:	48 89 c7             	mov    %rax,%rdi
    658f:	e8 fc fb ff ff       	call   6190 <link_path_walk>
    6594:	41 89 c4             	mov    %eax,%r12d
    6597:	85 c0                	test   %eax,%eax
    6599:	74 1c                	je     65b7 <path_parentat+0x47>
    659b:	48 89 df             	mov    %rbx,%rdi
    659e:	e8 5d cd ff ff       	call   3300 <terminate_walk>
    65a3:	44 89 e0             	mov    %r12d,%eax
    65a6:	5b                   	pop    %rbx
    65a7:	41 5c                	pop    %r12
    65a9:	41 5d                	pop    %r13
    65ab:	5d                   	pop    %rbp
    65ac:	31 d2                	xor    %edx,%edx
    65ae:	31 f6                	xor    %esi,%esi
    65b0:	31 ff                	xor    %edi,%edi
    65b2:	e9 00 00 00 00       	jmp    65b7 <path_parentat+0x47>
    65b7:	48 89 df             	mov    %rbx,%rdi
    65ba:	e8 61 c0 ff ff       	call   2620 <complete_walk>
    65bf:	41 89 c4             	mov    %eax,%r12d
    65c2:	85 c0                	test   %eax,%eax
    65c4:	75 d5                	jne    659b <path_parentat+0x2b>
    65c6:	48 8b 03             	mov    (%rbx),%rax
    65c9:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    65cd:	49 89 45 00          	mov    %rax,0x0(%r13)
    65d1:	49 89 55 08          	mov    %rdx,0x8(%r13)
    65d5:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    65dc:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    65e3:	00 
    65e4:	eb b5                	jmp    659b <path_parentat+0x2b>
    65e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    65ed:	00 00 00 

00000000000065f0 <__pfx___filename_parentat>:
    65f0:	90                   	nop
    65f1:	90                   	nop
    65f2:	90                   	nop
    65f3:	90                   	nop
    65f4:	90                   	nop
    65f5:	90                   	nop
    65f6:	90                   	nop
    65f7:	90                   	nop
    65f8:	90                   	nop
    65f9:	90                   	nop
    65fa:	90                   	nop
    65fb:	90                   	nop
    65fc:	90                   	nop
    65fd:	90                   	nop
    65fe:	90                   	nop
    65ff:	90                   	nop

0000000000006600 <__filename_parentat>:
    6600:	e8 00 00 00 00       	call   6605 <__filename_parentat+0x5>
    6605:	55                   	push   %rbp
    6606:	41 89 fa             	mov    %edi,%r10d
    6609:	48 89 e5             	mov    %rsp,%rbp
    660c:	41 57                	push   %r15
    660e:	49 89 cf             	mov    %rcx,%r15
    6611:	b9 1e 00 00 00       	mov    $0x1e,%ecx
    6616:	41 56                	push   %r14
    6618:	41 55                	push   %r13
    661a:	41 54                	push   %r12
    661c:	49 89 f4             	mov    %rsi,%r12
    661f:	53                   	push   %rbx
    6620:	89 f3                	mov    %esi,%ebx
    6622:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    6626:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
    662d:	89 54 24 1c          	mov    %edx,0x1c(%rsp)
    6631:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    6636:	48 8b 55 10          	mov    0x10(%rbp),%rdx
    663a:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    663f:	4c 89 ef             	mov    %r13,%rdi
    6642:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    6647:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 664f <__filename_parentat+0x4f>
    664e:	00 
    664f:	48 89 84 24 18 01 00 	mov    %rax,0x118(%rsp)
    6656:	00 
    6657:	31 c0                	xor    %eax,%eax
    6659:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    665c:	48 81 fe 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rsi
    6663:	0f 87 22 01 00 00    	ja     678b <__filename_parentat+0x18b>
    6669:	65 4c 8b 35 00 00 00 	mov    %gs:0x0(%rip),%r14        # 6671 <__filename_parentat+0x71>
    6670:	00 
    6671:	48 8d b4 24 88 00 00 	lea    0x88(%rsp),%rsi
    6678:	00 
    6679:	c7 44 24 74 00 00 00 	movl   $0x0,0x74(%rsp)
    6680:	00 
    6681:	48 89 b4 24 80 00 00 	mov    %rsi,0x80(%rsp)
    6688:	00 
    6689:	44 89 94 24 04 01 00 	mov    %r10d,0x104(%rsp)
    6690:	00 
    6691:	49 8b 86 c0 0c 00 00 	mov    0xcc0(%r14),%rax
    6698:	4c 89 a4 24 e8 00 00 	mov    %r12,0xe8(%rsp)
    669f:	00 
    66a0:	4d 85 e4             	test   %r12,%r12
    66a3:	0f 84 47 01 00 00    	je     67f0 <__filename_parentat+0x1f0>
    66a9:	49 8b 34 24          	mov    (%r12),%rsi
    66ad:	48 89 b4 24 f0 00 00 	mov    %rsi,0xf0(%rsp)
    66b4:	00 
    66b5:	31 f6                	xor    %esi,%esi
    66b7:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    66be:	00 00 
    66c0:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
    66c7:	00 00 
    66c9:	48 85 c0             	test   %rax,%rax
    66cc:	74 03                	je     66d1 <__filename_parentat+0xd1>
    66ce:	8b 70 58             	mov    0x58(%rax),%esi
    66d1:	89 74 24 78          	mov    %esi,0x78(%rsp)
    66d5:	48 89 84 24 f8 00 00 	mov    %rax,0xf8(%rsp)
    66dc:	00 
    66dd:	4d 89 ae c0 0c 00 00 	mov    %r13,0xcc0(%r14)
    66e4:	c7 44 24 5c 00 00 00 	movl   $0x0,0x5c(%rsp)
    66eb:	00 
    66ec:	48 85 d2             	test   %rdx,%rdx
    66ef:	0f 85 07 01 00 00    	jne    67fc <__filename_parentat+0x1fc>
    66f5:	8b 74 24 1c          	mov    0x1c(%rsp),%esi
    66f9:	4c 89 fa             	mov    %r15,%rdx
    66fc:	4c 89 ef             	mov    %r13,%rdi
    66ff:	81 ce 00 01 00 00    	or     $0x100,%esi
    6705:	e8 66 fe ff ff       	call   6570 <path_parentat>
    670a:	89 c3                	mov    %eax,%ebx
    670c:	83 f8 f6             	cmp    $0xfffffff6,%eax
    670f:	0f 84 05 01 00 00    	je     681a <__filename_parentat+0x21a>
    6715:	83 fb 8c             	cmp    $0xffffff8c,%ebx
    6718:	0f 84 b8 00 00 00    	je     67d6 <__filename_parentat+0x1d6>
    671e:	85 db                	test   %ebx,%ebx
    6720:	75 37                	jne    6759 <__filename_parentat+0x159>
    6722:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    6727:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    672c:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
    6731:	48 89 01             	mov    %rax,(%rcx)
    6734:	8b 44 24 70          	mov    0x70(%rsp),%eax
    6738:	48 89 51 08          	mov    %rdx,0x8(%rcx)
    673c:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    6741:	89 01                	mov    %eax,(%rcx)
    6743:	49 8b 86 70 0d 00 00 	mov    0xd70(%r14),%rax
    674a:	49 8b 77 08          	mov    0x8(%r15),%rsi
    674e:	48 85 c0             	test   %rax,%rax
    6751:	74 06                	je     6759 <__filename_parentat+0x159>
    6753:	8b 00                	mov    (%rax),%eax
    6755:	85 c0                	test   %eax,%eax
    6757:	74 6e                	je     67c7 <__filename_parentat+0x1c7>
    6759:	49 8b 86 c0 0c 00 00 	mov    0xcc0(%r14),%rax
    6760:	48 8b 90 d8 00 00 00 	mov    0xd8(%rax),%rdx
    6767:	49 89 96 c0 0c 00 00 	mov    %rdx,0xcc0(%r14)
    676e:	48 85 d2             	test   %rdx,%rdx
    6771:	74 06                	je     6779 <__filename_parentat+0x179>
    6773:	8b 48 58             	mov    0x58(%rax),%ecx
    6776:	89 4a 58             	mov    %ecx,0x58(%rdx)
    6779:	48 8b 78 60          	mov    0x60(%rax),%rdi
    677d:	48 83 c0 68          	add    $0x68,%rax
    6781:	48 39 c7             	cmp    %rax,%rdi
    6784:	74 05                	je     678b <__filename_parentat+0x18b>
    6786:	e8 00 00 00 00       	call   678b <__filename_parentat+0x18b>
    678b:	48 8b 84 24 18 01 00 	mov    0x118(%rsp),%rax
    6792:	00 
    6793:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 679b <__filename_parentat+0x19b>
    679a:	00 
    679b:	0f 85 8f 00 00 00    	jne    6830 <__filename_parentat+0x230>
    67a1:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    67a5:	89 d8                	mov    %ebx,%eax
    67a7:	5b                   	pop    %rbx
    67a8:	41 5c                	pop    %r12
    67aa:	41 5d                	pop    %r13
    67ac:	41 5e                	pop    %r14
    67ae:	41 5f                	pop    %r15
    67b0:	5d                   	pop    %rbp
    67b1:	31 d2                	xor    %edx,%edx
    67b3:	31 c9                	xor    %ecx,%ecx
    67b5:	31 f6                	xor    %esi,%esi
    67b7:	31 ff                	xor    %edi,%edi
    67b9:	45 31 c0             	xor    %r8d,%r8d
    67bc:	45 31 c9             	xor    %r9d,%r9d
    67bf:	45 31 d2             	xor    %r10d,%r10d
    67c2:	e9 00 00 00 00       	jmp    67c7 <__filename_parentat+0x1c7>
    67c7:	ba 01 00 00 00       	mov    $0x1,%edx
    67cc:	4c 89 e7             	mov    %r12,%rdi
    67cf:	e8 00 00 00 00       	call   67d4 <__filename_parentat+0x1d4>
    67d4:	eb 83                	jmp    6759 <__filename_parentat+0x159>
    67d6:	8b 74 24 1c          	mov    0x1c(%rsp),%esi
    67da:	4c 89 fa             	mov    %r15,%rdx
    67dd:	4c 89 ef             	mov    %r13,%rdi
    67e0:	40 80 ce 80          	or     $0x80,%sil
    67e4:	e8 87 fd ff ff       	call   6570 <path_parentat>
    67e9:	89 c3                	mov    %eax,%ebx
    67eb:	e9 2e ff ff ff       	jmp    671e <__filename_parentat+0x11e>
    67f0:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
    67f7:	e9 b1 fe ff ff       	jmp    66ad <__filename_parentat+0xad>
    67fc:	48 8b 02             	mov    (%rdx),%rax
    67ff:	48 8b 52 08          	mov    0x8(%rdx),%rdx
    6803:	c7 44 24 5c 01 00 00 	movl   $0x1,0x5c(%rsp)
    680a:	00 
    680b:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    6810:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    6815:	e9 db fe ff ff       	jmp    66f5 <__filename_parentat+0xf5>
    681a:	8b 74 24 1c          	mov    0x1c(%rsp),%esi
    681e:	4c 89 fa             	mov    %r15,%rdx
    6821:	4c 89 ef             	mov    %r13,%rdi
    6824:	e8 47 fd ff ff       	call   6570 <path_parentat>
    6829:	89 c3                	mov    %eax,%ebx
    682b:	e9 e5 fe ff ff       	jmp    6715 <__filename_parentat+0x115>
    6830:	e8 00 00 00 00       	call   6835 <__filename_parentat+0x235>
    6835:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    683c:	00 00 00 00 

0000000000006840 <__pfx___kern_path_locked>:
    6840:	90                   	nop
    6841:	90                   	nop
    6842:	90                   	nop
    6843:	90                   	nop
    6844:	90                   	nop
    6845:	90                   	nop
    6846:	90                   	nop
    6847:	90                   	nop
    6848:	90                   	nop
    6849:	90                   	nop
    684a:	90                   	nop
    684b:	90                   	nop
    684c:	90                   	nop
    684d:	90                   	nop
    684e:	90                   	nop
    684f:	90                   	nop

0000000000006850 <__kern_path_locked>:
    6850:	e8 00 00 00 00       	call   6855 <__kern_path_locked+0x5>
    6855:	55                   	push   %rbp
    6856:	48 89 e5             	mov    %rsp,%rbp
    6859:	41 56                	push   %r14
    685b:	41 55                	push   %r13
    685d:	4c 8d 4d b4          	lea    -0x4c(%rbp),%r9
    6861:	4c 8d 45 c8          	lea    -0x38(%rbp),%r8
    6865:	41 54                	push   %r12
    6867:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
    686b:	49 89 d4             	mov    %rdx,%r12
    686e:	31 d2                	xor    %edx,%edx
    6870:	53                   	push   %rbx
    6871:	48 83 ec 30          	sub    $0x30,%rsp
    6875:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 687d <__kern_path_locked+0x2d>
    687c:	00 
    687d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    6881:	31 c0                	xor    %eax,%eax
    6883:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
    688a:	00 
    688b:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    6892:	00 
    6893:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    689a:	00 
    689b:	48 c7 45 d0 00 00 00 	movq   $0x0,-0x30(%rbp)
    68a2:	00 
    68a3:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%rbp)
    68aa:	6a 00                	push   $0x0
    68ac:	e8 4f fd ff ff       	call   6600 <__filename_parentat>
    68b1:	5a                   	pop    %rdx
    68b2:	85 c0                	test   %eax,%eax
    68b4:	0f 85 8b 00 00 00    	jne    6945 <__kern_path_locked+0xf5>
    68ba:	8b 45 b4             	mov    -0x4c(%rbp),%eax
    68bd:	4c 8b 6d c0          	mov    -0x40(%rbp),%r13
    68c1:	4c 8b 75 b8          	mov    -0x48(%rbp),%r14
    68c5:	85 c0                	test   %eax,%eax
    68c7:	0f 85 85 00 00 00    	jne    6952 <__kern_path_locked+0x102>
    68cd:	49 8b 45 30          	mov    0x30(%r13),%rax
    68d1:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    68d8:	e8 00 00 00 00       	call   68dd <__kern_path_locked+0x8d>
    68dd:	31 d2                	xor    %edx,%edx
    68df:	4c 89 ee             	mov    %r13,%rsi
    68e2:	48 8d 7d c8          	lea    -0x38(%rbp),%rdi
    68e6:	e8 00 00 00 00       	call   68eb <__kern_path_locked+0x9b>
    68eb:	48 89 c3             	mov    %rax,%rbx
    68ee:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    68f4:	77 65                	ja     695b <__kern_path_locked+0x10b>
    68f6:	4d 89 6c 24 08       	mov    %r13,0x8(%r12)
    68fb:	45 31 ed             	xor    %r13d,%r13d
    68fe:	4d 89 34 24          	mov    %r14,(%r12)
    6902:	45 31 f6             	xor    %r14d,%r14d
    6905:	4c 89 ef             	mov    %r13,%rdi
    6908:	e8 00 00 00 00       	call   690d <__kern_path_locked+0xbd>
    690d:	4c 89 f7             	mov    %r14,%rdi
    6910:	e8 00 00 00 00       	call   6915 <__kern_path_locked+0xc5>
    6915:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    6919:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 6921 <__kern_path_locked+0xd1>
    6920:	00 
    6921:	75 4a                	jne    696d <__kern_path_locked+0x11d>
    6923:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
    6927:	48 89 d8             	mov    %rbx,%rax
    692a:	5b                   	pop    %rbx
    692b:	41 5c                	pop    %r12
    692d:	41 5d                	pop    %r13
    692f:	41 5e                	pop    %r14
    6931:	5d                   	pop    %rbp
    6932:	31 d2                	xor    %edx,%edx
    6934:	31 c9                	xor    %ecx,%ecx
    6936:	31 f6                	xor    %esi,%esi
    6938:	31 ff                	xor    %edi,%edi
    693a:	45 31 c0             	xor    %r8d,%r8d
    693d:	45 31 c9             	xor    %r9d,%r9d
    6940:	e9 00 00 00 00       	jmp    6945 <__kern_path_locked+0xf5>
    6945:	4c 8b 6d c0          	mov    -0x40(%rbp),%r13
    6949:	4c 8b 75 b8          	mov    -0x48(%rbp),%r14
    694d:	48 63 d8             	movslq %eax,%rbx
    6950:	eb b3                	jmp    6905 <__kern_path_locked+0xb5>
    6952:	48 c7 c3 ea ff ff ff 	mov    $0xffffffffffffffea,%rbx
    6959:	eb aa                	jmp    6905 <__kern_path_locked+0xb5>
    695b:	49 8b 45 30          	mov    0x30(%r13),%rax
    695f:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    6966:	e8 00 00 00 00       	call   696b <__kern_path_locked+0x11b>
    696b:	eb 98                	jmp    6905 <__kern_path_locked+0xb5>
    696d:	e8 00 00 00 00       	call   6972 <__kern_path_locked+0x122>
    6972:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6979:	00 00 00 00 
    697d:	0f 1f 00             	nopl   (%rax)

0000000000006980 <__pfx_filename_create>:
    6980:	90                   	nop
    6981:	90                   	nop
    6982:	90                   	nop
    6983:	90                   	nop
    6984:	90                   	nop
    6985:	90                   	nop
    6986:	90                   	nop
    6987:	90                   	nop
    6988:	90                   	nop
    6989:	90                   	nop
    698a:	90                   	nop
    698b:	90                   	nop
    698c:	90                   	nop
    698d:	90                   	nop
    698e:	90                   	nop
    698f:	90                   	nop

0000000000006990 <filename_create>:
    6990:	e8 00 00 00 00       	call   6995 <filename_create+0x5>
    6995:	55                   	push   %rbp
    6996:	48 89 e5             	mov    %rsp,%rbp
    6999:	41 56                	push   %r14
    699b:	41 55                	push   %r13
    699d:	41 89 cd             	mov    %ecx,%r13d
    69a0:	4c 8d 4d c4          	lea    -0x3c(%rbp),%r9
    69a4:	4c 8d 45 c8          	lea    -0x38(%rbp),%r8
    69a8:	41 54                	push   %r12
    69aa:	41 81 e5 80 00 00 00 	and    $0x80,%r13d
    69b1:	49 89 d4             	mov    %rdx,%r12
    69b4:	53                   	push   %rbx
    69b5:	89 cb                	mov    %ecx,%ebx
    69b7:	48 89 d1             	mov    %rdx,%rcx
    69ba:	44 89 ea             	mov    %r13d,%edx
    69bd:	48 83 ec 20          	sub    $0x20,%rsp
    69c1:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 69c9 <filename_create+0x39>
    69c8:	00 
    69c9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    69cd:	31 c0                	xor    %eax,%eax
    69cf:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    69d6:	00 
    69d7:	48 c7 45 d0 00 00 00 	movq   $0x0,-0x30(%rbp)
    69de:	00 
    69df:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%rbp)
    69e6:	6a 00                	push   $0x0
    69e8:	e8 13 fc ff ff       	call   6600 <__filename_parentat>
    69ed:	5a                   	pop    %rdx
    69ee:	85 c0                	test   %eax,%eax
    69f0:	0f 85 9f 00 00 00    	jne    6a95 <filename_create+0x105>
    69f6:	8b 45 c4             	mov    -0x3c(%rbp),%eax
    69f9:	85 c0                	test   %eax,%eax
    69fb:	0f 85 99 00 00 00    	jne    6a9a <filename_create+0x10a>
    6a01:	49 8b 3c 24          	mov    (%r12),%rdi
    6a05:	e8 00 00 00 00       	call   6a0a <filename_create+0x7a>
    6a0a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
    6a0e:	41 89 c6             	mov    %eax,%r14d
    6a11:	8b 45 cc             	mov    -0x34(%rbp),%eax
    6a14:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
    6a18:	74 0a                	je     6a24 <filename_create+0x94>
    6a1a:	83 e3 02             	and    $0x2,%ebx
    6a1d:	bb 00 00 04 00       	mov    $0x40000,%ebx
    6a22:	74 05                	je     6a29 <filename_create+0x99>
    6a24:	bb 00 00 06 00       	mov    $0x60000,%ebx
    6a29:	49 8b 44 24 08       	mov    0x8(%r12),%rax
    6a2e:	44 09 eb             	or     %r13d,%ebx
    6a31:	48 8b 78 30          	mov    0x30(%rax),%rdi
    6a35:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    6a3c:	e8 00 00 00 00       	call   6a41 <filename_create+0xb1>
    6a41:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    6a46:	89 da                	mov    %ebx,%edx
    6a48:	48 8d 7d c8          	lea    -0x38(%rbp),%rdi
    6a4c:	e8 00 00 00 00       	call   6a51 <filename_create+0xc1>
    6a51:	48 89 c3             	mov    %rax,%rbx
    6a54:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    6a5a:	77 5a                	ja     6ab6 <filename_create+0x126>
    6a5c:	45 85 f6             	test   %r14d,%r14d
    6a5f:	75 7a                	jne    6adb <filename_create+0x14b>
    6a61:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    6a65:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 6a6d <filename_create+0xdd>
    6a6c:	00 
    6a6d:	0f 85 8a 00 00 00    	jne    6afd <filename_create+0x16d>
    6a73:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
    6a77:	48 89 d8             	mov    %rbx,%rax
    6a7a:	5b                   	pop    %rbx
    6a7b:	41 5c                	pop    %r12
    6a7d:	41 5d                	pop    %r13
    6a7f:	41 5e                	pop    %r14
    6a81:	5d                   	pop    %rbp
    6a82:	31 d2                	xor    %edx,%edx
    6a84:	31 c9                	xor    %ecx,%ecx
    6a86:	31 f6                	xor    %esi,%esi
    6a88:	31 ff                	xor    %edi,%edi
    6a8a:	45 31 c0             	xor    %r8d,%r8d
    6a8d:	45 31 c9             	xor    %r9d,%r9d
    6a90:	e9 00 00 00 00       	jmp    6a95 <filename_create+0x105>
    6a95:	48 63 d8             	movslq %eax,%rbx
    6a98:	eb c7                	jmp    6a61 <filename_create+0xd1>
    6a9a:	48 c7 c3 ef ff ff ff 	mov    $0xffffffffffffffef,%rbx
    6aa1:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    6aa6:	e8 00 00 00 00       	call   6aab <filename_create+0x11b>
    6aab:	49 8b 3c 24          	mov    (%r12),%rdi
    6aaf:	e8 00 00 00 00       	call   6ab4 <filename_create+0x124>
    6ab4:	eb ab                	jmp    6a61 <filename_create+0xd1>
    6ab6:	49 8b 44 24 08       	mov    0x8(%r12),%rax
    6abb:	48 8b 78 30          	mov    0x30(%rax),%rdi
    6abf:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    6ac6:	e8 00 00 00 00       	call   6acb <filename_create+0x13b>
    6acb:	45 85 f6             	test   %r14d,%r14d
    6ace:	75 d1                	jne    6aa1 <filename_create+0x111>
    6ad0:	49 8b 3c 24          	mov    (%r12),%rdi
    6ad4:	e8 00 00 00 00       	call   6ad9 <filename_create+0x149>
    6ad9:	eb c6                	jmp    6aa1 <filename_create+0x111>
    6adb:	48 89 c7             	mov    %rax,%rdi
    6ade:	49 63 de             	movslq %r14d,%rbx
    6ae1:	e8 00 00 00 00       	call   6ae6 <filename_create+0x156>
    6ae6:	49 8b 44 24 08       	mov    0x8(%r12),%rax
    6aeb:	48 8b 78 30          	mov    0x30(%rax),%rdi
    6aef:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    6af6:	e8 00 00 00 00       	call   6afb <filename_create+0x16b>
    6afb:	eb a4                	jmp    6aa1 <filename_create+0x111>
    6afd:	e8 00 00 00 00       	call   6b02 <filename_create+0x172>
    6b02:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6b09:	00 00 00 00 
    6b0d:	0f 1f 00             	nopl   (%rax)

0000000000006b10 <__pfx_kern_path_create>:
    6b10:	90                   	nop
    6b11:	90                   	nop
    6b12:	90                   	nop
    6b13:	90                   	nop
    6b14:	90                   	nop
    6b15:	90                   	nop
    6b16:	90                   	nop
    6b17:	90                   	nop
    6b18:	90                   	nop
    6b19:	90                   	nop
    6b1a:	90                   	nop
    6b1b:	90                   	nop
    6b1c:	90                   	nop
    6b1d:	90                   	nop
    6b1e:	90                   	nop
    6b1f:	90                   	nop

0000000000006b20 <kern_path_create>:
    6b20:	e8 00 00 00 00       	call   6b25 <kern_path_create+0x5>
    6b25:	55                   	push   %rbp
    6b26:	48 89 e5             	mov    %rsp,%rbp
    6b29:	41 56                	push   %r14
    6b2b:	41 89 ce             	mov    %ecx,%r14d
    6b2e:	41 55                	push   %r13
    6b30:	49 89 d5             	mov    %rdx,%r13
    6b33:	41 54                	push   %r12
    6b35:	41 89 fc             	mov    %edi,%r12d
    6b38:	48 89 f7             	mov    %rsi,%rdi
    6b3b:	53                   	push   %rbx
    6b3c:	e8 00 00 00 00       	call   6b41 <kern_path_create+0x21>
    6b41:	44 89 f1             	mov    %r14d,%ecx
    6b44:	4c 89 ea             	mov    %r13,%rdx
    6b47:	44 89 e7             	mov    %r12d,%edi
    6b4a:	48 89 c6             	mov    %rax,%rsi
    6b4d:	48 89 c3             	mov    %rax,%rbx
    6b50:	e8 3b fe ff ff       	call   6990 <filename_create>
    6b55:	48 89 df             	mov    %rbx,%rdi
    6b58:	49 89 c4             	mov    %rax,%r12
    6b5b:	e8 00 00 00 00       	call   6b60 <kern_path_create+0x40>
    6b60:	4c 89 e0             	mov    %r12,%rax
    6b63:	5b                   	pop    %rbx
    6b64:	41 5c                	pop    %r12
    6b66:	41 5d                	pop    %r13
    6b68:	41 5e                	pop    %r14
    6b6a:	5d                   	pop    %rbp
    6b6b:	31 d2                	xor    %edx,%edx
    6b6d:	31 c9                	xor    %ecx,%ecx
    6b6f:	31 f6                	xor    %esi,%esi
    6b71:	31 ff                	xor    %edi,%edi
    6b73:	e9 00 00 00 00       	jmp    6b78 <kern_path_create+0x58>
    6b78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6b7f:	00 

0000000000006b80 <__pfx_do_mknodat>:
    6b80:	90                   	nop
    6b81:	90                   	nop
    6b82:	90                   	nop
    6b83:	90                   	nop
    6b84:	90                   	nop
    6b85:	90                   	nop
    6b86:	90                   	nop
    6b87:	90                   	nop
    6b88:	90                   	nop
    6b89:	90                   	nop
    6b8a:	90                   	nop
    6b8b:	90                   	nop
    6b8c:	90                   	nop
    6b8d:	90                   	nop
    6b8e:	90                   	nop
    6b8f:	90                   	nop

0000000000006b90 <do_mknodat>:
    6b90:	e8 00 00 00 00       	call   6b95 <do_mknodat+0x5>
    6b95:	55                   	push   %rbp
    6b96:	48 89 e5             	mov    %rsp,%rbp
    6b99:	41 57                	push   %r15
    6b9b:	41 89 d7             	mov    %edx,%r15d
    6b9e:	41 56                	push   %r14
    6ba0:	66 41 81 e7 00 f0    	and    $0xf000,%r15w
    6ba6:	41 55                	push   %r13
    6ba8:	49 89 f5             	mov    %rsi,%r13
    6bab:	41 54                	push   %r12
    6bad:	41 89 cc             	mov    %ecx,%r12d
    6bb0:	53                   	push   %rbx
    6bb1:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    6bb6:	48 83 ec 30          	sub    $0x30,%rsp
    6bba:	65 48 8b 0d 00 00 00 	mov    %gs:0x0(%rip),%rcx        # 6bc2 <do_mknodat+0x32>
    6bc1:	00 
    6bc2:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
    6bc6:	31 c9                	xor    %ecx,%ecx
    6bc8:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    6bcf:	00 
    6bd0:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    6bd7:	00 
    6bd8:	66 41 81 ff 00 40    	cmp    $0x4000,%r15w
    6bde:	74 22                	je     6c02 <do_mknodat+0x72>
    6be0:	89 f8                	mov    %edi,%eax
    6be2:	41 89 d1             	mov    %edx,%r9d
    6be5:	76 58                	jbe    6c3f <do_mknodat+0xaf>
    6be7:	89 d7                	mov    %edx,%edi
    6be9:	66 81 e7 00 b0       	and    $0xb000,%di
    6bee:	66 81 ff 00 80       	cmp    $0x8000,%di
    6bf3:	74 60                	je     6c55 <do_mknodat+0xc5>
    6bf5:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
    6bfa:	66 41 81 ff 00 60    	cmp    $0x6000,%r15w
    6c00:	74 53                	je     6c55 <do_mknodat+0xc5>
    6c02:	4c 89 ef             	mov    %r13,%rdi
    6c05:	e8 00 00 00 00       	call   6c0a <do_mknodat+0x7a>
    6c0a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    6c0e:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 6c16 <do_mknodat+0x86>
    6c15:	00 
    6c16:	0f 85 27 02 00 00    	jne    6e43 <do_mknodat+0x2b3>
    6c1c:	48 83 c4 30          	add    $0x30,%rsp
    6c20:	89 d8                	mov    %ebx,%eax
    6c22:	5b                   	pop    %rbx
    6c23:	41 5c                	pop    %r12
    6c25:	41 5d                	pop    %r13
    6c27:	41 5e                	pop    %r14
    6c29:	41 5f                	pop    %r15
    6c2b:	5d                   	pop    %rbp
    6c2c:	31 d2                	xor    %edx,%edx
    6c2e:	31 c9                	xor    %ecx,%ecx
    6c30:	31 f6                	xor    %esi,%esi
    6c32:	31 ff                	xor    %edi,%edi
    6c34:	45 31 c0             	xor    %r8d,%r8d
    6c37:	45 31 c9             	xor    %r9d,%r9d
    6c3a:	e9 00 00 00 00       	jmp    6c3f <do_mknodat+0xaf>
    6c3f:	66 f7 c2 00 e0       	test   $0xe000,%dx
    6c44:	74 0f                	je     6c55 <do_mknodat+0xc5>
    6c46:	66 41 81 ff 00 20    	cmp    $0x2000,%r15w
    6c4c:	74 07                	je     6c55 <do_mknodat+0xc5>
    6c4e:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
    6c53:	eb ad                	jmp    6c02 <do_mknodat+0x72>
    6c55:	0f b7 f2             	movzwl %dx,%esi
    6c58:	c7 45 b0 02 00 00 00 	movl   $0x2,-0x50(%rbp)
    6c5f:	31 c9                	xor    %ecx,%ecx
    6c61:	89 75 bc             	mov    %esi,-0x44(%rbp)
    6c64:	89 45 b8             	mov    %eax,-0x48(%rbp)
    6c67:	66 44 89 4d b6       	mov    %r9w,-0x4a(%rbp)
    6c6c:	8b 7d b8             	mov    -0x48(%rbp),%edi
    6c6f:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
    6c73:	4c 89 ee             	mov    %r13,%rsi
    6c76:	e8 15 fd ff ff       	call   6990 <filename_create>
    6c7b:	49 89 c6             	mov    %rax,%r14
    6c7e:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    6c84:	0f 87 a5 01 00 00    	ja     6e2f <do_mknodat+0x29f>
    6c8a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    6c8e:	8b 55 bc             	mov    -0x44(%rbp),%edx
    6c91:	48 8b 40 30          	mov    0x30(%rax),%rax
    6c95:	48 8b 40 28          	mov    0x28(%rax),%rax
    6c99:	f6 40 52 01          	testb  $0x1,0x52(%rax)
    6c9d:	75 0a                	jne    6ca9 <do_mknodat+0x119>
    6c9f:	f6 40 59 10          	testb  $0x10,0x59(%rax)
    6ca3:	0f 84 71 01 00 00    	je     6e1a <do_mknodat+0x28a>
    6ca9:	44 89 e1             	mov    %r12d,%ecx
    6cac:	4c 89 f6             	mov    %r14,%rsi
    6caf:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
    6cb3:	e8 00 00 00 00       	call   6cb8 <do_mknodat+0x128>
    6cb8:	89 c3                	mov    %eax,%ebx
    6cba:	85 c0                	test   %eax,%eax
    6cbc:	75 5d                	jne    6d1b <do_mknodat+0x18b>
    6cbe:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    6cc2:	48 8b 78 18          	mov    0x18(%rax),%rdi
    6cc6:	66 41 81 ff 00 60    	cmp    $0x6000,%r15w
    6ccc:	0f 84 11 01 00 00    	je     6de3 <do_mknodat+0x253>
    6cd2:	0f 87 9e 00 00 00    	ja     6d76 <do_mknodat+0x1e6>
    6cd8:	66 41 81 ff 00 10    	cmp    $0x1000,%r15w
    6cde:	0f 84 e2 00 00 00    	je     6dc6 <do_mknodat+0x236>
    6ce4:	66 41 81 ff 00 20    	cmp    $0x2000,%r15w
    6cea:	0f 84 f3 00 00 00    	je     6de3 <do_mknodat+0x253>
    6cf0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    6cf4:	8b 4d bc             	mov    -0x44(%rbp),%ecx
    6cf7:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    6cfd:	4c 89 f2             	mov    %r14,%rdx
    6d00:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
    6d04:	48 8b 70 30          	mov    0x30(%rax),%rsi
    6d08:	e8 00 00 00 00       	call   6d0d <do_mknodat+0x17d>
    6d0d:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
    6d11:	85 c0                	test   %eax,%eax
    6d13:	0f 84 1d 01 00 00    	je     6e36 <do_mknodat+0x2a6>
    6d19:	89 c3                	mov    %eax,%ebx
    6d1b:	4c 89 f7             	mov    %r14,%rdi
    6d1e:	e8 00 00 00 00       	call   6d23 <do_mknodat+0x193>
    6d23:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    6d27:	48 8b 78 30          	mov    0x30(%rax),%rdi
    6d2b:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    6d32:	e8 00 00 00 00       	call   6d37 <do_mknodat+0x1a7>
    6d37:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    6d3b:	e8 00 00 00 00       	call   6d40 <do_mknodat+0x1b0>
    6d40:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    6d44:	e8 00 00 00 00       	call   6d49 <do_mknodat+0x1b9>
    6d49:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    6d4d:	e8 00 00 00 00       	call   6d52 <do_mknodat+0x1c2>
    6d52:	83 fb 8c             	cmp    $0xffffff8c,%ebx
    6d55:	0f 85 a7 fe ff ff    	jne    6c02 <do_mknodat+0x72>
    6d5b:	83 7d b0 01          	cmpl   $0x1,-0x50(%rbp)
    6d5f:	b9 80 00 00 00       	mov    $0x80,%ecx
    6d64:	0f 84 98 fe ff ff    	je     6c02 <do_mknodat+0x72>
    6d6a:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%rbp)
    6d71:	e9 f6 fe ff ff       	jmp    6c6c <do_mknodat+0xdc>
    6d76:	66 41 81 ff 00 80    	cmp    $0x8000,%r15w
    6d7c:	0f 84 6e ff ff ff    	je     6cf0 <do_mknodat+0x160>
    6d82:	66 41 81 ff 00 c0    	cmp    $0xc000,%r15w
    6d88:	74 3c                	je     6dc6 <do_mknodat+0x236>
    6d8a:	4c 89 f7             	mov    %r14,%rdi
    6d8d:	e8 00 00 00 00       	call   6d92 <do_mknodat+0x202>
    6d92:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    6d96:	48 8b 78 30          	mov    0x30(%rax),%rdi
    6d9a:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    6da1:	e8 00 00 00 00       	call   6da6 <do_mknodat+0x216>
    6da6:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    6daa:	e8 00 00 00 00       	call   6daf <do_mknodat+0x21f>
    6daf:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    6db3:	e8 00 00 00 00       	call   6db8 <do_mknodat+0x228>
    6db8:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    6dbc:	e8 00 00 00 00       	call   6dc1 <do_mknodat+0x231>
    6dc1:	e9 3c fe ff ff       	jmp    6c02 <do_mknodat+0x72>
    6dc6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    6dca:	8b 4d bc             	mov    -0x44(%rbp),%ecx
    6dcd:	45 31 c0             	xor    %r8d,%r8d
    6dd0:	4c 89 f2             	mov    %r14,%rdx
    6dd3:	48 8b 70 30          	mov    0x30(%rax),%rsi
    6dd7:	e8 00 00 00 00       	call   6ddc <do_mknodat+0x24c>
    6ddc:	89 c3                	mov    %eax,%ebx
    6dde:	e9 38 ff ff ff       	jmp    6d1b <do_mknodat+0x18b>
    6de3:	44 89 e0             	mov    %r12d,%eax
    6de6:	44 89 e2             	mov    %r12d,%edx
    6de9:	8b 4d bc             	mov    -0x44(%rbp),%ecx
    6dec:	45 0f b6 c4          	movzbl %r12b,%r8d
    6df0:	c1 e8 0c             	shr    $0xc,%eax
    6df3:	c1 ea 08             	shr    $0x8,%edx
    6df6:	c1 e2 14             	shl    $0x14,%edx
    6df9:	25 00 ff 0f 00       	and    $0xfff00,%eax
    6dfe:	09 d0                	or     %edx,%eax
    6e00:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
    6e04:	41 09 c0             	or     %eax,%r8d
    6e07:	48 8b 72 30          	mov    0x30(%rdx),%rsi
    6e0b:	4c 89 f2             	mov    %r14,%rdx
    6e0e:	e8 00 00 00 00       	call   6e13 <do_mknodat+0x283>
    6e13:	89 c3                	mov    %eax,%ebx
    6e15:	e9 01 ff ff ff       	jmp    6d1b <do_mknodat+0x18b>
    6e1a:	e8 00 00 00 00       	call   6e1f <do_mknodat+0x28f>
    6e1f:	f7 d0                	not    %eax
    6e21:	89 c2                	mov    %eax,%edx
    6e23:	66 23 55 b6          	and    -0x4a(%rbp),%dx
    6e27:	0f b7 d2             	movzwl %dx,%edx
    6e2a:	e9 7a fe ff ff       	jmp    6ca9 <do_mknodat+0x119>
    6e2f:	89 c3                	mov    %eax,%ebx
    6e31:	e9 cc fd ff ff       	jmp    6c02 <do_mknodat+0x72>
    6e36:	4c 89 f6             	mov    %r14,%rsi
    6e39:	e8 00 00 00 00       	call   6e3e <do_mknodat+0x2ae>
    6e3e:	e9 47 ff ff ff       	jmp    6d8a <do_mknodat+0x1fa>
    6e43:	e8 00 00 00 00       	call   6e48 <do_mknodat+0x2b8>
    6e48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6e4f:	00 

0000000000006e50 <__pfx_vfs_path_parent_lookup>:
    6e50:	90                   	nop
    6e51:	90                   	nop
    6e52:	90                   	nop
    6e53:	90                   	nop
    6e54:	90                   	nop
    6e55:	90                   	nop
    6e56:	90                   	nop
    6e57:	90                   	nop
    6e58:	90                   	nop
    6e59:	90                   	nop
    6e5a:	90                   	nop
    6e5b:	90                   	nop
    6e5c:	90                   	nop
    6e5d:	90                   	nop
    6e5e:	90                   	nop
    6e5f:	90                   	nop

0000000000006e60 <vfs_path_parent_lookup>:
    6e60:	e8 00 00 00 00       	call   6e65 <vfs_path_parent_lookup+0x5>
    6e65:	55                   	push   %rbp
    6e66:	48 89 e5             	mov    %rsp,%rbp
    6e69:	41 51                	push   %r9
    6e6b:	4d 89 c1             	mov    %r8,%r9
    6e6e:	49 89 c8             	mov    %rcx,%r8
    6e71:	48 89 d1             	mov    %rdx,%rcx
    6e74:	89 f2                	mov    %esi,%edx
    6e76:	48 89 fe             	mov    %rdi,%rsi
    6e79:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    6e7e:	e8 7d f7 ff ff       	call   6600 <__filename_parentat>
    6e83:	c9                   	leave
    6e84:	31 d2                	xor    %edx,%edx
    6e86:	31 c9                	xor    %ecx,%ecx
    6e88:	31 f6                	xor    %esi,%esi
    6e8a:	31 ff                	xor    %edi,%edi
    6e8c:	45 31 c0             	xor    %r8d,%r8d
    6e8f:	45 31 c9             	xor    %r9d,%r9d
    6e92:	e9 00 00 00 00       	jmp    6e97 <vfs_path_parent_lookup+0x37>
    6e97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    6e9e:	00 00 

0000000000006ea0 <__pfx_path_lookupat>:
    6ea0:	90                   	nop
    6ea1:	90                   	nop
    6ea2:	90                   	nop
    6ea3:	90                   	nop
    6ea4:	90                   	nop
    6ea5:	90                   	nop
    6ea6:	90                   	nop
    6ea7:	90                   	nop
    6ea8:	90                   	nop
    6ea9:	90                   	nop
    6eaa:	90                   	nop
    6eab:	90                   	nop
    6eac:	90                   	nop
    6ead:	90                   	nop
    6eae:	90                   	nop
    6eaf:	90                   	nop

0000000000006eb0 <path_lookupat>:
    6eb0:	e8 00 00 00 00       	call   6eb5 <path_lookupat+0x5>
    6eb5:	55                   	push   %rbp
    6eb6:	48 89 e5             	mov    %rsp,%rbp
    6eb9:	41 56                	push   %r14
    6ebb:	41 89 f6             	mov    %esi,%r14d
    6ebe:	41 55                	push   %r13
    6ec0:	49 89 d5             	mov    %rdx,%r13
    6ec3:	41 54                	push   %r12
    6ec5:	53                   	push   %rbx
    6ec6:	48 89 fb             	mov    %rdi,%rbx
    6ec9:	48 83 ec 08          	sub    $0x8,%rsp
    6ecd:	e8 3e d5 ff ff       	call   4410 <path_init>
    6ed2:	41 83 e6 20          	and    $0x20,%r14d
    6ed6:	49 89 c4             	mov    %rax,%r12
    6ed9:	74 32                	je     6f0d <path_lookupat+0x5d>
    6edb:	e9 f6 00 00 00       	jmp    6fd6 <path_lookupat+0x126>
    6ee0:	8b 43 50             	mov    0x50(%rbx),%eax
    6ee3:	85 c0                	test   %eax,%eax
    6ee5:	75 11                	jne    6ef8 <path_lookupat+0x48>
    6ee7:	8b 43 14             	mov    0x14(%rbx),%eax
    6eea:	48 8b 53 18          	mov    0x18(%rbx),%rdx
    6eee:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
    6ef2:	74 04                	je     6ef8 <path_lookupat+0x48>
    6ef4:	83 4b 38 03          	orl    $0x3,0x38(%rbx)
    6ef8:	be 01 00 00 00       	mov    $0x1,%esi
    6efd:	48 89 df             	mov    %rbx,%rdi
    6f00:	e8 eb f0 ff ff       	call   5ff0 <walk_component>
    6f05:	49 89 c4             	mov    %rax,%r12
    6f08:	48 85 c0             	test   %rax,%rax
    6f0b:	74 36                	je     6f43 <path_lookupat+0x93>
    6f0d:	48 89 de             	mov    %rbx,%rsi
    6f10:	4c 89 e7             	mov    %r12,%rdi
    6f13:	e8 78 f2 ff ff       	call   6190 <link_path_walk>
    6f18:	85 c0                	test   %eax,%eax
    6f1a:	74 c4                	je     6ee0 <path_lookupat+0x30>
    6f1c:	48 89 df             	mov    %rbx,%rdi
    6f1f:	89 44 24 04          	mov    %eax,0x4(%rsp)
    6f23:	e8 d8 c3 ff ff       	call   3300 <terminate_walk>
    6f28:	8b 44 24 04          	mov    0x4(%rsp),%eax
    6f2c:	48 83 c4 08          	add    $0x8,%rsp
    6f30:	5b                   	pop    %rbx
    6f31:	41 5c                	pop    %r12
    6f33:	41 5d                	pop    %r13
    6f35:	41 5e                	pop    %r14
    6f37:	5d                   	pop    %rbp
    6f38:	31 d2                	xor    %edx,%edx
    6f3a:	31 f6                	xor    %esi,%esi
    6f3c:	31 ff                	xor    %edi,%edi
    6f3e:	e9 00 00 00 00       	jmp    6f43 <path_lookupat+0x93>
    6f43:	8b 43 38             	mov    0x38(%rbx),%eax
    6f46:	a8 40                	test   $0x40,%al
    6f48:	75 4a                	jne    6f94 <path_lookupat+0xe4>
    6f4a:	48 89 df             	mov    %rbx,%rdi
    6f4d:	e8 ce b6 ff ff       	call   2620 <complete_walk>
    6f52:	85 c0                	test   %eax,%eax
    6f54:	75 c6                	jne    6f1c <path_lookupat+0x6c>
    6f56:	f6 43 38 02          	testb  $0x2,0x38(%rbx)
    6f5a:	74 18                	je     6f74 <path_lookupat+0xc4>
    6f5c:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    6f60:	8b 12                	mov    (%rdx),%edx
    6f62:	81 e2 00 00 38 00    	and    $0x380000,%edx
    6f68:	81 fa 00 00 10 00    	cmp    $0x100000,%edx
    6f6e:	0f 85 ae 00 00 00    	jne    7022 <path_lookupat+0x172>
    6f74:	48 8b 33             	mov    (%rbx),%rsi
    6f77:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    6f7b:	49 89 75 00          	mov    %rsi,0x0(%r13)
    6f7f:	49 89 7d 08          	mov    %rdi,0x8(%r13)
    6f83:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    6f8a:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    6f91:	00 
    6f92:	eb 88                	jmp    6f1c <path_lookupat+0x6c>
    6f94:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    6f98:	f6 c4 01             	test   $0x1,%ah
    6f9b:	75 15                	jne    6fb2 <path_lookupat+0x102>
    6f9d:	48 85 d2             	test   %rdx,%rdx
    6fa0:	74 10                	je     6fb2 <path_lookupat+0x102>
    6fa2:	48 8d ba 80 00 00 00 	lea    0x80(%rdx),%rdi
    6fa9:	e8 00 00 00 00       	call   6fae <path_lookupat+0xfe>
    6fae:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    6fb2:	8b 43 40             	mov    0x40(%rbx),%eax
    6fb5:	be 04 00 00 00       	mov    $0x4,%esi
    6fba:	48 89 df             	mov    %rbx,%rdi
    6fbd:	89 43 44             	mov    %eax,0x44(%rbx)
    6fc0:	e8 eb e4 ff ff       	call   54b0 <step_into>
    6fc5:	83 63 3c fb          	andl   $0xfffffffb,0x3c(%rbx)
    6fc9:	85 c0                	test   %eax,%eax
    6fcb:	0f 85 4b ff ff ff    	jne    6f1c <path_lookupat+0x6c>
    6fd1:	e9 74 ff ff ff       	jmp    6f4a <path_lookupat+0x9a>
    6fd6:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    6fdc:	0f 87 2b ff ff ff    	ja     6f0d <path_lookupat+0x5d>
    6fe2:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    6fe6:	f6 43 39 01          	testb  $0x1,0x39(%rbx)
    6fea:	75 15                	jne    7001 <path_lookupat+0x151>
    6fec:	48 85 d2             	test   %rdx,%rdx
    6fef:	74 10                	je     7001 <path_lookupat+0x151>
    6ff1:	48 8d ba 80 00 00 00 	lea    0x80(%rdx),%rdi
    6ff8:	e8 00 00 00 00       	call   6ffd <path_lookupat+0x14d>
    6ffd:	48 8b 53 08          	mov    0x8(%rbx),%rdx
    7001:	8b 43 40             	mov    0x40(%rbx),%eax
    7004:	be 04 00 00 00       	mov    $0x4,%esi
    7009:	48 89 df             	mov    %rbx,%rdi
    700c:	89 43 44             	mov    %eax,0x44(%rbx)
    700f:	e8 9c e4 ff ff       	call   54b0 <step_into>
    7014:	48 63 d0             	movslq %eax,%rdx
    7017:	85 c0                	test   %eax,%eax
    7019:	4c 0f 48 e2          	cmovs  %rdx,%r12
    701d:	e9 eb fe ff ff       	jmp    6f0d <path_lookupat+0x5d>
    7022:	b8 ec ff ff ff       	mov    $0xffffffec,%eax
    7027:	e9 f0 fe ff ff       	jmp    6f1c <path_lookupat+0x6c>
    702c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007030 <__pfx_getname_flags>:
    7030:	90                   	nop
    7031:	90                   	nop
    7032:	90                   	nop
    7033:	90                   	nop
    7034:	90                   	nop
    7035:	90                   	nop
    7036:	90                   	nop
    7037:	90                   	nop
    7038:	90                   	nop
    7039:	90                   	nop
    703a:	90                   	nop
    703b:	90                   	nop
    703c:	90                   	nop
    703d:	90                   	nop
    703e:	90                   	nop
    703f:	90                   	nop

0000000000007040 <getname_flags>:
    7040:	e8 00 00 00 00       	call   7045 <getname_flags+0x5>
    7045:	55                   	push   %rbp
    7046:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 704e <getname_flags+0xe>
    704d:	00 
    704e:	48 89 e5             	mov    %rsp,%rbp
    7051:	41 54                	push   %r12
    7053:	41 89 f4             	mov    %esi,%r12d
    7056:	53                   	push   %rbx
    7057:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    705e:	48 89 fb             	mov    %rdi,%rbx
    7061:	48 85 c0             	test   %rax,%rax
    7064:	74 06                	je     706c <getname_flags+0x2c>
    7066:	8b 00                	mov    (%rax),%eax
    7068:	85 c0                	test   %eax,%eax
    706a:	74 18                	je     7084 <getname_flags+0x44>
    706c:	44 89 e6             	mov    %r12d,%esi
    706f:	48 89 df             	mov    %rbx,%rdi
    7072:	e8 e9 a6 ff ff       	call   1760 <getname_flags.part.0>
    7077:	5b                   	pop    %rbx
    7078:	41 5c                	pop    %r12
    707a:	5d                   	pop    %rbp
    707b:	31 f6                	xor    %esi,%esi
    707d:	31 ff                	xor    %edi,%edi
    707f:	e9 00 00 00 00       	jmp    7084 <getname_flags+0x44>
    7084:	e8 00 00 00 00       	call   7089 <getname_flags+0x49>
    7089:	48 85 c0             	test   %rax,%rax
    708c:	74 de                	je     706c <getname_flags+0x2c>
    708e:	5b                   	pop    %rbx
    708f:	41 5c                	pop    %r12
    7091:	5d                   	pop    %rbp
    7092:	31 f6                	xor    %esi,%esi
    7094:	31 ff                	xor    %edi,%edi
    7096:	e9 00 00 00 00       	jmp    709b <getname_flags+0x5b>
    709b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000070a0 <__pfx_user_path_locked_at>:
    70a0:	90                   	nop
    70a1:	90                   	nop
    70a2:	90                   	nop
    70a3:	90                   	nop
    70a4:	90                   	nop
    70a5:	90                   	nop
    70a6:	90                   	nop
    70a7:	90                   	nop
    70a8:	90                   	nop
    70a9:	90                   	nop
    70aa:	90                   	nop
    70ab:	90                   	nop
    70ac:	90                   	nop
    70ad:	90                   	nop
    70ae:	90                   	nop
    70af:	90                   	nop

00000000000070b0 <user_path_locked_at>:
    70b0:	e8 00 00 00 00       	call   70b5 <user_path_locked_at+0x5>
    70b5:	55                   	push   %rbp
    70b6:	48 89 e5             	mov    %rsp,%rbp
    70b9:	41 55                	push   %r13
    70bb:	49 89 d5             	mov    %rdx,%r13
    70be:	41 54                	push   %r12
    70c0:	41 89 fc             	mov    %edi,%r12d
    70c3:	48 89 f7             	mov    %rsi,%rdi
    70c6:	31 f6                	xor    %esi,%esi
    70c8:	53                   	push   %rbx
    70c9:	e8 00 00 00 00       	call   70ce <user_path_locked_at+0x1e>
    70ce:	4c 89 ea             	mov    %r13,%rdx
    70d1:	44 89 e7             	mov    %r12d,%edi
    70d4:	48 89 c6             	mov    %rax,%rsi
    70d7:	48 89 c3             	mov    %rax,%rbx
    70da:	e8 71 f7 ff ff       	call   6850 <__kern_path_locked>
    70df:	48 89 df             	mov    %rbx,%rdi
    70e2:	49 89 c4             	mov    %rax,%r12
    70e5:	e8 00 00 00 00       	call   70ea <user_path_locked_at+0x3a>
    70ea:	4c 89 e0             	mov    %r12,%rax
    70ed:	5b                   	pop    %rbx
    70ee:	41 5c                	pop    %r12
    70f0:	41 5d                	pop    %r13
    70f2:	5d                   	pop    %rbp
    70f3:	31 d2                	xor    %edx,%edx
    70f5:	31 f6                	xor    %esi,%esi
    70f7:	31 ff                	xor    %edi,%edi
    70f9:	e9 00 00 00 00       	jmp    70fe <user_path_locked_at+0x4e>
    70fe:	66 90                	xchg   %ax,%ax

0000000000007100 <__pfx_user_path_create>:
    7100:	90                   	nop
    7101:	90                   	nop
    7102:	90                   	nop
    7103:	90                   	nop
    7104:	90                   	nop
    7105:	90                   	nop
    7106:	90                   	nop
    7107:	90                   	nop
    7108:	90                   	nop
    7109:	90                   	nop
    710a:	90                   	nop
    710b:	90                   	nop
    710c:	90                   	nop
    710d:	90                   	nop
    710e:	90                   	nop
    710f:	90                   	nop

0000000000007110 <user_path_create>:
    7110:	55                   	push   %rbp
    7111:	48 89 e5             	mov    %rsp,%rbp
    7114:	41 56                	push   %r14
    7116:	41 89 ce             	mov    %ecx,%r14d
    7119:	41 55                	push   %r13
    711b:	49 89 d5             	mov    %rdx,%r13
    711e:	41 54                	push   %r12
    7120:	41 89 fc             	mov    %edi,%r12d
    7123:	48 89 f7             	mov    %rsi,%rdi
    7126:	31 f6                	xor    %esi,%esi
    7128:	53                   	push   %rbx
    7129:	e8 00 00 00 00       	call   712e <user_path_create+0x1e>
    712e:	44 89 f1             	mov    %r14d,%ecx
    7131:	4c 89 ea             	mov    %r13,%rdx
    7134:	44 89 e7             	mov    %r12d,%edi
    7137:	48 89 c6             	mov    %rax,%rsi
    713a:	48 89 c3             	mov    %rax,%rbx
    713d:	e8 4e f8 ff ff       	call   6990 <filename_create>
    7142:	48 89 df             	mov    %rbx,%rdi
    7145:	49 89 c4             	mov    %rax,%r12
    7148:	e8 00 00 00 00       	call   714d <user_path_create+0x3d>
    714d:	4c 89 e0             	mov    %r12,%rax
    7150:	5b                   	pop    %rbx
    7151:	41 5c                	pop    %r12
    7153:	41 5d                	pop    %r13
    7155:	41 5e                	pop    %r14
    7157:	5d                   	pop    %rbp
    7158:	31 d2                	xor    %edx,%edx
    715a:	31 c9                	xor    %ecx,%ecx
    715c:	31 f6                	xor    %esi,%esi
    715e:	31 ff                	xor    %edi,%edi
    7160:	e9 00 00 00 00       	jmp    7165 <user_path_create+0x55>
    7165:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    716c:	00 00 00 00 

0000000000007170 <__pfx___ia32_sys_mknodat>:
    7170:	90                   	nop
    7171:	90                   	nop
    7172:	90                   	nop
    7173:	90                   	nop
    7174:	90                   	nop
    7175:	90                   	nop
    7176:	90                   	nop
    7177:	90                   	nop
    7178:	90                   	nop
    7179:	90                   	nop
    717a:	90                   	nop
    717b:	90                   	nop
    717c:	90                   	nop
    717d:	90                   	nop
    717e:	90                   	nop
    717f:	90                   	nop

0000000000007180 <__ia32_sys_mknodat>:
    7180:	e8 00 00 00 00       	call   7185 <__ia32_sys_mknodat+0x5>
    7185:	55                   	push   %rbp
    7186:	31 f6                	xor    %esi,%esi
    7188:	48 89 e5             	mov    %rsp,%rbp
    718b:	41 55                	push   %r13
    718d:	41 54                	push   %r12
    718f:	53                   	push   %rbx
    7190:	44 8b 6f 68          	mov    0x68(%rdi),%r13d
    7194:	8b 5f 28             	mov    0x28(%rdi),%ebx
    7197:	44 0f b7 67 60       	movzwl 0x60(%rdi),%r12d
    719c:	8b 7f 58             	mov    0x58(%rdi),%edi
    719f:	e8 00 00 00 00       	call   71a4 <__ia32_sys_mknodat+0x24>
    71a4:	44 89 e9             	mov    %r13d,%ecx
    71a7:	44 89 e2             	mov    %r12d,%edx
    71aa:	89 df                	mov    %ebx,%edi
    71ac:	48 89 c6             	mov    %rax,%rsi
    71af:	e8 dc f9 ff ff       	call   6b90 <do_mknodat>
    71b4:	5b                   	pop    %rbx
    71b5:	41 5c                	pop    %r12
    71b7:	48 98                	cltq
    71b9:	41 5d                	pop    %r13
    71bb:	5d                   	pop    %rbp
    71bc:	31 d2                	xor    %edx,%edx
    71be:	31 c9                	xor    %ecx,%ecx
    71c0:	31 f6                	xor    %esi,%esi
    71c2:	31 ff                	xor    %edi,%edi
    71c4:	e9 00 00 00 00       	jmp    71c9 <__ia32_sys_mknodat+0x49>
    71c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000071d0 <__pfx___ia32_sys_mknod>:
    71d0:	90                   	nop
    71d1:	90                   	nop
    71d2:	90                   	nop
    71d3:	90                   	nop
    71d4:	90                   	nop
    71d5:	90                   	nop
    71d6:	90                   	nop
    71d7:	90                   	nop
    71d8:	90                   	nop
    71d9:	90                   	nop
    71da:	90                   	nop
    71db:	90                   	nop
    71dc:	90                   	nop
    71dd:	90                   	nop
    71de:	90                   	nop
    71df:	90                   	nop

00000000000071e0 <__ia32_sys_mknod>:
    71e0:	e8 00 00 00 00       	call   71e5 <__ia32_sys_mknod+0x5>
    71e5:	55                   	push   %rbp
    71e6:	31 f6                	xor    %esi,%esi
    71e8:	48 89 e5             	mov    %rsp,%rbp
    71eb:	41 54                	push   %r12
    71ed:	53                   	push   %rbx
    71ee:	44 8b 67 60          	mov    0x60(%rdi),%r12d
    71f2:	0f b7 5f 58          	movzwl 0x58(%rdi),%ebx
    71f6:	8b 7f 28             	mov    0x28(%rdi),%edi
    71f9:	e8 00 00 00 00       	call   71fe <__ia32_sys_mknod+0x1e>
    71fe:	44 89 e1             	mov    %r12d,%ecx
    7201:	89 da                	mov    %ebx,%edx
    7203:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    7208:	48 89 c6             	mov    %rax,%rsi
    720b:	e8 80 f9 ff ff       	call   6b90 <do_mknodat>
    7210:	5b                   	pop    %rbx
    7211:	41 5c                	pop    %r12
    7213:	48 98                	cltq
    7215:	5d                   	pop    %rbp
    7216:	31 d2                	xor    %edx,%edx
    7218:	31 c9                	xor    %ecx,%ecx
    721a:	31 f6                	xor    %esi,%esi
    721c:	31 ff                	xor    %edi,%edi
    721e:	e9 00 00 00 00       	jmp    7223 <__ia32_sys_mknod+0x43>
    7223:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    722a:	00 00 00 00 
    722e:	66 90                	xchg   %ax,%ax

0000000000007230 <__pfx___x64_sys_mknodat>:
    7230:	90                   	nop
    7231:	90                   	nop
    7232:	90                   	nop
    7233:	90                   	nop
    7234:	90                   	nop
    7235:	90                   	nop
    7236:	90                   	nop
    7237:	90                   	nop
    7238:	90                   	nop
    7239:	90                   	nop
    723a:	90                   	nop
    723b:	90                   	nop
    723c:	90                   	nop
    723d:	90                   	nop
    723e:	90                   	nop
    723f:	90                   	nop

0000000000007240 <__x64_sys_mknodat>:
    7240:	e8 00 00 00 00       	call   7245 <__x64_sys_mknodat+0x5>
    7245:	55                   	push   %rbp
    7246:	31 f6                	xor    %esi,%esi
    7248:	48 89 e5             	mov    %rsp,%rbp
    724b:	41 55                	push   %r13
    724d:	41 54                	push   %r12
    724f:	53                   	push   %rbx
    7250:	44 8b 6f 38          	mov    0x38(%rdi),%r13d
    7254:	8b 5f 70             	mov    0x70(%rdi),%ebx
    7257:	44 0f b7 67 60       	movzwl 0x60(%rdi),%r12d
    725c:	48 8b 7f 68          	mov    0x68(%rdi),%rdi
    7260:	e8 00 00 00 00       	call   7265 <__x64_sys_mknodat+0x25>
    7265:	44 89 e9             	mov    %r13d,%ecx
    7268:	44 89 e2             	mov    %r12d,%edx
    726b:	89 df                	mov    %ebx,%edi
    726d:	48 89 c6             	mov    %rax,%rsi
    7270:	e8 1b f9 ff ff       	call   6b90 <do_mknodat>
    7275:	5b                   	pop    %rbx
    7276:	41 5c                	pop    %r12
    7278:	48 98                	cltq
    727a:	41 5d                	pop    %r13
    727c:	5d                   	pop    %rbp
    727d:	31 d2                	xor    %edx,%edx
    727f:	31 c9                	xor    %ecx,%ecx
    7281:	31 f6                	xor    %esi,%esi
    7283:	31 ff                	xor    %edi,%edi
    7285:	e9 00 00 00 00       	jmp    728a <__x64_sys_mknodat+0x4a>
    728a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007290 <__pfx___x64_sys_mknod>:
    7290:	90                   	nop
    7291:	90                   	nop
    7292:	90                   	nop
    7293:	90                   	nop
    7294:	90                   	nop
    7295:	90                   	nop
    7296:	90                   	nop
    7297:	90                   	nop
    7298:	90                   	nop
    7299:	90                   	nop
    729a:	90                   	nop
    729b:	90                   	nop
    729c:	90                   	nop
    729d:	90                   	nop
    729e:	90                   	nop
    729f:	90                   	nop

00000000000072a0 <__x64_sys_mknod>:
    72a0:	e8 00 00 00 00       	call   72a5 <__x64_sys_mknod+0x5>
    72a5:	55                   	push   %rbp
    72a6:	31 f6                	xor    %esi,%esi
    72a8:	48 89 e5             	mov    %rsp,%rbp
    72ab:	41 54                	push   %r12
    72ad:	53                   	push   %rbx
    72ae:	44 8b 67 60          	mov    0x60(%rdi),%r12d
    72b2:	0f b7 5f 68          	movzwl 0x68(%rdi),%ebx
    72b6:	48 8b 7f 70          	mov    0x70(%rdi),%rdi
    72ba:	e8 00 00 00 00       	call   72bf <__x64_sys_mknod+0x1f>
    72bf:	44 89 e1             	mov    %r12d,%ecx
    72c2:	89 da                	mov    %ebx,%edx
    72c4:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    72c9:	48 89 c6             	mov    %rax,%rsi
    72cc:	e8 bf f8 ff ff       	call   6b90 <do_mknodat>
    72d1:	5b                   	pop    %rbx
    72d2:	41 5c                	pop    %r12
    72d4:	48 98                	cltq
    72d6:	5d                   	pop    %rbp
    72d7:	31 d2                	xor    %edx,%edx
    72d9:	31 c9                	xor    %ecx,%ecx
    72db:	31 f6                	xor    %esi,%esi
    72dd:	31 ff                	xor    %edi,%edi
    72df:	e9 00 00 00 00       	jmp    72e4 <__x64_sys_mknod+0x44>
    72e4:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    72eb:	00 00 00 00 
    72ef:	90                   	nop

00000000000072f0 <__pfx_getname_uflags>:
    72f0:	90                   	nop
    72f1:	90                   	nop
    72f2:	90                   	nop
    72f3:	90                   	nop
    72f4:	90                   	nop
    72f5:	90                   	nop
    72f6:	90                   	nop
    72f7:	90                   	nop
    72f8:	90                   	nop
    72f9:	90                   	nop
    72fa:	90                   	nop
    72fb:	90                   	nop
    72fc:	90                   	nop
    72fd:	90                   	nop
    72fe:	90                   	nop
    72ff:	90                   	nop

0000000000007300 <getname_uflags>:
    7300:	e8 00 00 00 00       	call   7305 <getname_uflags+0x5>
    7305:	55                   	push   %rbp
    7306:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 730e <getname_uflags+0xe>
    730d:	00 
    730e:	48 89 e5             	mov    %rsp,%rbp
    7311:	41 54                	push   %r12
    7313:	49 89 fc             	mov    %rdi,%r12
    7316:	53                   	push   %rbx
    7317:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    731e:	89 f3                	mov    %esi,%ebx
    7320:	48 85 c0             	test   %rax,%rax
    7323:	74 06                	je     732b <getname_uflags+0x2b>
    7325:	8b 00                	mov    (%rax),%eax
    7327:	85 c0                	test   %eax,%eax
    7329:	74 1d                	je     7348 <getname_uflags+0x48>
    732b:	c1 fb 09             	sar    $0x9,%ebx
    732e:	4c 89 e7             	mov    %r12,%rdi
    7331:	89 de                	mov    %ebx,%esi
    7333:	83 e6 08             	and    $0x8,%esi
    7336:	e8 25 a4 ff ff       	call   1760 <getname_flags.part.0>
    733b:	5b                   	pop    %rbx
    733c:	41 5c                	pop    %r12
    733e:	5d                   	pop    %rbp
    733f:	31 f6                	xor    %esi,%esi
    7341:	31 ff                	xor    %edi,%edi
    7343:	e9 00 00 00 00       	jmp    7348 <getname_uflags+0x48>
    7348:	e8 00 00 00 00       	call   734d <getname_uflags+0x4d>
    734d:	48 85 c0             	test   %rax,%rax
    7350:	74 d9                	je     732b <getname_uflags+0x2b>
    7352:	5b                   	pop    %rbx
    7353:	41 5c                	pop    %r12
    7355:	5d                   	pop    %rbp
    7356:	31 f6                	xor    %esi,%esi
    7358:	31 ff                	xor    %edi,%edi
    735a:	e9 00 00 00 00       	jmp    735f <getname_uflags+0x5f>
    735f:	90                   	nop

0000000000007360 <__pfx___getname_maybe_null>:
    7360:	90                   	nop
    7361:	90                   	nop
    7362:	90                   	nop
    7363:	90                   	nop
    7364:	90                   	nop
    7365:	90                   	nop
    7366:	90                   	nop
    7367:	90                   	nop
    7368:	90                   	nop
    7369:	90                   	nop
    736a:	90                   	nop
    736b:	90                   	nop
    736c:	90                   	nop
    736d:	90                   	nop
    736e:	90                   	nop
    736f:	90                   	nop

0000000000007370 <__getname_maybe_null>:
    7370:	e8 00 00 00 00       	call   7375 <__getname_maybe_null+0x5>
    7375:	55                   	push   %rbp
    7376:	48 89 f8             	mov    %rdi,%rax
    7379:	48 89 e5             	mov    %rsp,%rbp
    737c:	e8 00 00 00 00       	call   7381 <__getname_maybe_null+0x11>
    7381:	85 c0                	test   %eax,%eax
    7383:	75 40                	jne    73c5 <__getname_maybe_null+0x55>
    7385:	84 d2                	test   %dl,%dl
    7387:	74 2e                	je     73b7 <__getname_maybe_null+0x47>
    7389:	be 08 00 00 00       	mov    $0x8,%esi
    738e:	e8 00 00 00 00       	call   7393 <__getname_maybe_null+0x23>
    7393:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    7399:	77 08                	ja     73a3 <__getname_maybe_null+0x33>
    739b:	48 8b 10             	mov    (%rax),%rdx
    739e:	80 3a 00             	cmpb   $0x0,(%rdx)
    73a1:	74 0c                	je     73af <__getname_maybe_null+0x3f>
    73a3:	5d                   	pop    %rbp
    73a4:	31 d2                	xor    %edx,%edx
    73a6:	31 f6                	xor    %esi,%esi
    73a8:	31 ff                	xor    %edi,%edi
    73aa:	e9 00 00 00 00       	jmp    73af <__getname_maybe_null+0x3f>
    73af:	48 89 c7             	mov    %rax,%rdi
    73b2:	e8 00 00 00 00       	call   73b7 <__getname_maybe_null+0x47>
    73b7:	31 c0                	xor    %eax,%eax
    73b9:	5d                   	pop    %rbp
    73ba:	31 d2                	xor    %edx,%edx
    73bc:	31 f6                	xor    %esi,%esi
    73be:	31 ff                	xor    %edi,%edi
    73c0:	e9 00 00 00 00       	jmp    73c5 <__getname_maybe_null+0x55>
    73c5:	48 c7 c0 f2 ff ff ff 	mov    $0xfffffffffffffff2,%rax
    73cc:	5d                   	pop    %rbp
    73cd:	31 d2                	xor    %edx,%edx
    73cf:	31 f6                	xor    %esi,%esi
    73d1:	31 ff                	xor    %edi,%edi
    73d3:	e9 00 00 00 00       	jmp    73d8 <__getname_maybe_null+0x68>
    73d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    73df:	00 

00000000000073e0 <__pfx_nd_jump_link>:
    73e0:	90                   	nop
    73e1:	90                   	nop
    73e2:	90                   	nop
    73e3:	90                   	nop
    73e4:	90                   	nop
    73e5:	90                   	nop
    73e6:	90                   	nop
    73e7:	90                   	nop
    73e8:	90                   	nop
    73e9:	90                   	nop
    73ea:	90                   	nop
    73eb:	90                   	nop
    73ec:	90                   	nop
    73ed:	90                   	nop
    73ee:	90                   	nop
    73ef:	90                   	nop

00000000000073f0 <nd_jump_link>:
    73f0:	e8 00 00 00 00       	call   73f5 <nd_jump_link+0x5>
    73f5:	55                   	push   %rbp
    73f6:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 73fe <nd_jump_link+0xe>
    73fd:	00 
    73fe:	48 89 e5             	mov    %rsp,%rbp
    7401:	41 55                	push   %r13
    7403:	41 54                	push   %r12
    7405:	49 89 fc             	mov    %rdi,%r12
    7408:	53                   	push   %rbx
    7409:	48 8b 98 c0 0c 00 00 	mov    0xcc0(%rax),%rbx
    7410:	8b 43 38             	mov    0x38(%rbx),%eax
    7413:	a9 00 00 00 02       	test   $0x2000000,%eax
    7418:	75 58                	jne    7472 <nd_jump_link+0x82>
    741a:	a9 00 00 00 04       	test   $0x4000000,%eax
    741f:	75 7c                	jne    749d <nd_jump_link+0xad>
    7421:	a9 00 00 00 18       	test   $0x18000000,%eax
    7426:	0f 85 84 00 00 00    	jne    74b0 <nd_jump_link+0xc0>
    742c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    7430:	45 31 ed             	xor    %r13d,%r13d
    7433:	e8 00 00 00 00       	call   7438 <nd_jump_link+0x48>
    7438:	48 8b 3b             	mov    (%rbx),%rdi
    743b:	e8 00 00 00 00       	call   7440 <nd_jump_link+0x50>
    7440:	49 8b 04 24          	mov    (%r12),%rax
    7444:	49 8b 54 24 08       	mov    0x8(%r12),%rdx
    7449:	48 89 03             	mov    %rax,(%rbx)
    744c:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    7450:	48 8b 43 08          	mov    0x8(%rbx),%rax
    7454:	48 8b 40 30          	mov    0x30(%rax),%rax
    7458:	83 4b 3c 04          	orl    $0x4,0x3c(%rbx)
    745c:	48 89 43 30          	mov    %rax,0x30(%rbx)
    7460:	44 89 e8             	mov    %r13d,%eax
    7463:	5b                   	pop    %rbx
    7464:	41 5c                	pop    %r12
    7466:	41 5d                	pop    %r13
    7468:	5d                   	pop    %rbp
    7469:	31 d2                	xor    %edx,%edx
    746b:	31 ff                	xor    %edi,%edi
    746d:	e9 00 00 00 00       	jmp    7472 <nd_jump_link+0x82>
    7472:	41 bd d8 ff ff ff    	mov    $0xffffffd8,%r13d
    7478:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    747d:	e8 00 00 00 00       	call   7482 <nd_jump_link+0x92>
    7482:	49 8b 3c 24          	mov    (%r12),%rdi
    7486:	e8 00 00 00 00       	call   748b <nd_jump_link+0x9b>
    748b:	44 89 e8             	mov    %r13d,%eax
    748e:	5b                   	pop    %rbx
    748f:	41 5c                	pop    %r12
    7491:	41 5d                	pop    %r13
    7493:	5d                   	pop    %rbp
    7494:	31 d2                	xor    %edx,%edx
    7496:	31 ff                	xor    %edi,%edi
    7498:	e9 00 00 00 00       	jmp    749d <nd_jump_link+0xad>
    749d:	48 8b 17             	mov    (%rdi),%rdx
    74a0:	41 bd ee ff ff ff    	mov    $0xffffffee,%r13d
    74a6:	48 39 13             	cmp    %rdx,(%rbx)
    74a9:	75 cd                	jne    7478 <nd_jump_link+0x88>
    74ab:	e9 71 ff ff ff       	jmp    7421 <nd_jump_link+0x31>
    74b0:	41 bd ee ff ff ff    	mov    $0xffffffee,%r13d
    74b6:	eb c0                	jmp    7478 <nd_jump_link+0x88>
    74b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    74bf:	00 

00000000000074c0 <__pfx_may_linkat>:
    74c0:	90                   	nop
    74c1:	90                   	nop
    74c2:	90                   	nop
    74c3:	90                   	nop
    74c4:	90                   	nop
    74c5:	90                   	nop
    74c6:	90                   	nop
    74c7:	90                   	nop
    74c8:	90                   	nop
    74c9:	90                   	nop
    74ca:	90                   	nop
    74cb:	90                   	nop
    74cc:	90                   	nop
    74cd:	90                   	nop
    74ce:	90                   	nop
    74cf:	90                   	nop

00000000000074d0 <may_linkat>:
    74d0:	e8 00 00 00 00       	call   74d5 <may_linkat+0x5>
    74d5:	55                   	push   %rbp
    74d6:	48 89 e5             	mov    %rsp,%rbp
    74d9:	41 54                	push   %r12
    74db:	49 89 fc             	mov    %rdi,%r12
    74de:	53                   	push   %rbx
    74df:	48 8b 46 08          	mov    0x8(%rsi),%rax
    74e3:	48 8b 58 30          	mov    0x30(%rax),%rbx
    74e7:	48 8b 43 28          	mov    0x28(%rbx),%rax
    74eb:	8b 53 04             	mov    0x4(%rbx),%edx
    74ee:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    74f5:	e8 00 00 00 00       	call   74fa <may_linkat+0x2a>
    74fa:	83 f8 ff             	cmp    $0xffffffff,%eax
    74fd:	0f 84 8f 00 00 00    	je     7592 <may_linkat+0xc2>
    7503:	48 8b 43 28          	mov    0x28(%rbx),%rax
    7507:	8b 53 08             	mov    0x8(%rbx),%edx
    750a:	4c 89 e7             	mov    %r12,%rdi
    750d:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    7514:	e8 00 00 00 00       	call   7519 <may_linkat+0x49>
    7519:	83 f8 ff             	cmp    $0xffffffff,%eax
    751c:	74 74                	je     7592 <may_linkat+0xc2>
    751e:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 7524 <may_linkat+0x54>
    7524:	85 c0                	test   %eax,%eax
    7526:	75 11                	jne    7539 <may_linkat+0x69>
    7528:	31 c0                	xor    %eax,%eax
    752a:	5b                   	pop    %rbx
    752b:	41 5c                	pop    %r12
    752d:	5d                   	pop    %rbp
    752e:	31 d2                	xor    %edx,%edx
    7530:	31 f6                	xor    %esi,%esi
    7532:	31 ff                	xor    %edi,%edi
    7534:	e9 00 00 00 00       	jmp    7539 <may_linkat+0x69>
    7539:	0f b7 03             	movzwl (%rbx),%eax
    753c:	89 c2                	mov    %eax,%edx
    753e:	66 81 e2 00 f0       	and    $0xf000,%dx
    7543:	66 81 fa 00 80       	cmp    $0x8000,%dx
    7548:	75 21                	jne    756b <may_linkat+0x9b>
    754a:	f6 c4 08             	test   $0x8,%ah
    754d:	75 1c                	jne    756b <may_linkat+0x9b>
    754f:	f7 d0                	not    %eax
    7551:	66 a9 08 04          	test   $0x408,%ax
    7555:	74 14                	je     756b <may_linkat+0x9b>
    7557:	ba 06 00 00 00       	mov    $0x6,%edx
    755c:	48 89 de             	mov    %rbx,%rsi
    755f:	4c 89 e7             	mov    %r12,%rdi
    7562:	e8 00 00 00 00       	call   7567 <may_linkat+0x97>
    7567:	85 c0                	test   %eax,%eax
    7569:	74 bd                	je     7528 <may_linkat+0x58>
    756b:	48 89 de             	mov    %rbx,%rsi
    756e:	4c 89 e7             	mov    %r12,%rdi
    7571:	e8 00 00 00 00       	call   7576 <may_linkat+0xa6>
    7576:	84 c0                	test   %al,%al
    7578:	75 ae                	jne    7528 <may_linkat+0x58>
    757a:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
    7581:	bf a6 06 00 00       	mov    $0x6a6,%edi
    7586:	e8 00 00 00 00       	call   758b <may_linkat+0xbb>
    758b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    7590:	eb 98                	jmp    752a <may_linkat+0x5a>
    7592:	b8 b5 ff ff ff       	mov    $0xffffffb5,%eax
    7597:	eb 91                	jmp    752a <may_linkat+0x5a>
    7599:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000075a0 <__pfx_filename_lookup>:
    75a0:	90                   	nop
    75a1:	90                   	nop
    75a2:	90                   	nop
    75a3:	90                   	nop
    75a4:	90                   	nop
    75a5:	90                   	nop
    75a6:	90                   	nop
    75a7:	90                   	nop
    75a8:	90                   	nop
    75a9:	90                   	nop
    75aa:	90                   	nop
    75ab:	90                   	nop
    75ac:	90                   	nop
    75ad:	90                   	nop
    75ae:	90                   	nop
    75af:	90                   	nop

00000000000075b0 <filename_lookup>:
    75b0:	e8 00 00 00 00       	call   75b5 <filename_lookup+0x5>
    75b5:	55                   	push   %rbp
    75b6:	41 89 fa             	mov    %edi,%r10d
    75b9:	48 89 e5             	mov    %rsp,%rbp
    75bc:	41 57                	push   %r15
    75be:	49 89 cf             	mov    %rcx,%r15
    75c1:	b9 1e 00 00 00       	mov    $0x1e,%ecx
    75c6:	41 56                	push   %r14
    75c8:	41 55                	push   %r13
    75ca:	41 54                	push   %r12
    75cc:	49 89 f4             	mov    %rsi,%r12
    75cf:	53                   	push   %rbx
    75d0:	89 f3                	mov    %esi,%ebx
    75d2:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    75d6:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    75dd:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 75e5 <filename_lookup+0x35>
    75e4:	00 
    75e5:	48 89 84 24 f8 00 00 	mov    %rax,0xf8(%rsp)
    75ec:	00 
    75ed:	31 c0                	xor    %eax,%eax
    75ef:	49 89 e1             	mov    %rsp,%r9
    75f2:	4c 89 cf             	mov    %r9,%rdi
    75f5:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    75f8:	48 81 fe 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rsi
    75ff:	0f 87 fa 00 00 00    	ja     76ff <filename_lookup+0x14f>
    7605:	65 4c 8b 35 00 00 00 	mov    %gs:0x0(%rip),%r14        # 760d <filename_lookup+0x5d>
    760c:	00 
    760d:	41 89 d5             	mov    %edx,%r13d
    7610:	48 8d 54 24 68       	lea    0x68(%rsp),%rdx
    7615:	c7 44 24 54 00 00 00 	movl   $0x0,0x54(%rsp)
    761c:	00 
    761d:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
    7622:	44 89 94 24 e4 00 00 	mov    %r10d,0xe4(%rsp)
    7629:	00 
    762a:	49 8b 86 c0 0c 00 00 	mov    0xcc0(%r14),%rax
    7631:	48 89 b4 24 c8 00 00 	mov    %rsi,0xc8(%rsp)
    7638:	00 
    7639:	48 85 f6             	test   %rsi,%rsi
    763c:	0f 84 2c 01 00 00    	je     776e <filename_lookup+0x1be>
    7642:	48 8b 16             	mov    (%rsi),%rdx
    7645:	48 89 94 24 d0 00 00 	mov    %rdx,0xd0(%rsp)
    764c:	00 
    764d:	31 d2                	xor    %edx,%edx
    764f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    7656:	00 
    7657:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    765e:	00 00 
    7660:	48 85 c0             	test   %rax,%rax
    7663:	74 03                	je     7668 <filename_lookup+0xb8>
    7665:	8b 50 58             	mov    0x58(%rax),%edx
    7668:	89 54 24 58          	mov    %edx,0x58(%rsp)
    766c:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
    7673:	00 
    7674:	4d 89 8e c0 0c 00 00 	mov    %r9,0xcc0(%r14)
    767b:	c7 44 24 3c 00 00 00 	movl   $0x0,0x3c(%rsp)
    7682:	00 
    7683:	4d 85 c0             	test   %r8,%r8
    7686:	0f 85 ee 00 00 00    	jne    777a <filename_lookup+0x1ca>
    768c:	44 89 ee             	mov    %r13d,%esi
    768f:	4c 89 cf             	mov    %r9,%rdi
    7692:	4c 89 fa             	mov    %r15,%rdx
    7695:	81 ce 00 01 00 00    	or     $0x100,%esi
    769b:	e8 10 f8 ff ff       	call   6eb0 <path_lookupat>
    76a0:	83 f8 f6             	cmp    $0xfffffff6,%eax
    76a3:	89 c3                	mov    %eax,%ebx
    76a5:	49 89 e1             	mov    %rsp,%r9
    76a8:	0f 84 ea 00 00 00    	je     7798 <filename_lookup+0x1e8>
    76ae:	83 fb 8c             	cmp    $0xffffff8c,%ebx
    76b1:	0f 84 9e 00 00 00    	je     7755 <filename_lookup+0x1a5>
    76b7:	85 db                	test   %ebx,%ebx
    76b9:	75 12                	jne    76cd <filename_lookup+0x11d>
    76bb:	49 8b 86 70 0d 00 00 	mov    0xd70(%r14),%rax
    76c2:	48 85 c0             	test   %rax,%rax
    76c5:	74 06                	je     76cd <filename_lookup+0x11d>
    76c7:	8b 00                	mov    (%rax),%eax
    76c9:	85 c0                	test   %eax,%eax
    76cb:	74 6e                	je     773b <filename_lookup+0x18b>
    76cd:	49 8b 86 c0 0c 00 00 	mov    0xcc0(%r14),%rax
    76d4:	48 8b 90 d8 00 00 00 	mov    0xd8(%rax),%rdx
    76db:	49 89 96 c0 0c 00 00 	mov    %rdx,0xcc0(%r14)
    76e2:	48 85 d2             	test   %rdx,%rdx
    76e5:	74 06                	je     76ed <filename_lookup+0x13d>
    76e7:	8b 48 58             	mov    0x58(%rax),%ecx
    76ea:	89 4a 58             	mov    %ecx,0x58(%rdx)
    76ed:	48 8b 78 60          	mov    0x60(%rax),%rdi
    76f1:	48 83 c0 68          	add    $0x68,%rax
    76f5:	48 39 c7             	cmp    %rax,%rdi
    76f8:	74 05                	je     76ff <filename_lookup+0x14f>
    76fa:	e8 00 00 00 00       	call   76ff <filename_lookup+0x14f>
    76ff:	48 8b 84 24 f8 00 00 	mov    0xf8(%rsp),%rax
    7706:	00 
    7707:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 770f <filename_lookup+0x15f>
    770e:	00 
    770f:	0f 85 9b 00 00 00    	jne    77b0 <filename_lookup+0x200>
    7715:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    7719:	89 d8                	mov    %ebx,%eax
    771b:	5b                   	pop    %rbx
    771c:	41 5c                	pop    %r12
    771e:	41 5d                	pop    %r13
    7720:	41 5e                	pop    %r14
    7722:	41 5f                	pop    %r15
    7724:	5d                   	pop    %rbp
    7725:	31 d2                	xor    %edx,%edx
    7727:	31 c9                	xor    %ecx,%ecx
    7729:	31 f6                	xor    %esi,%esi
    772b:	31 ff                	xor    %edi,%edi
    772d:	45 31 c0             	xor    %r8d,%r8d
    7730:	45 31 c9             	xor    %r9d,%r9d
    7733:	45 31 d2             	xor    %r10d,%r10d
    7736:	e9 00 00 00 00       	jmp    773b <filename_lookup+0x18b>
    773b:	44 89 ea             	mov    %r13d,%edx
    773e:	49 8b 77 08          	mov    0x8(%r15),%rsi
    7742:	4c 89 e7             	mov    %r12,%rdi
    7745:	c1 ea 04             	shr    $0x4,%edx
    7748:	83 e2 04             	and    $0x4,%edx
    774b:	e8 00 00 00 00       	call   7750 <filename_lookup+0x1a0>
    7750:	e9 78 ff ff ff       	jmp    76cd <filename_lookup+0x11d>
    7755:	44 89 ee             	mov    %r13d,%esi
    7758:	4c 89 fa             	mov    %r15,%rdx
    775b:	4c 89 cf             	mov    %r9,%rdi
    775e:	40 80 ce 80          	or     $0x80,%sil
    7762:	e8 49 f7 ff ff       	call   6eb0 <path_lookupat>
    7767:	89 c3                	mov    %eax,%ebx
    7769:	e9 49 ff ff ff       	jmp    76b7 <filename_lookup+0x107>
    776e:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
    7775:	e9 cb fe ff ff       	jmp    7645 <filename_lookup+0x95>
    777a:	49 8b 00             	mov    (%r8),%rax
    777d:	49 8b 50 08          	mov    0x8(%r8),%rdx
    7781:	c7 44 24 3c 01 00 00 	movl   $0x1,0x3c(%rsp)
    7788:	00 
    7789:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    778e:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
    7793:	e9 f4 fe ff ff       	jmp    768c <filename_lookup+0xdc>
    7798:	4c 89 cf             	mov    %r9,%rdi
    779b:	4c 89 fa             	mov    %r15,%rdx
    779e:	44 89 ee             	mov    %r13d,%esi
    77a1:	e8 0a f7 ff ff       	call   6eb0 <path_lookupat>
    77a6:	89 c3                	mov    %eax,%ebx
    77a8:	49 89 e1             	mov    %rsp,%r9
    77ab:	e9 fe fe ff ff       	jmp    76ae <filename_lookup+0xfe>
    77b0:	e8 00 00 00 00       	call   77b5 <filename_lookup+0x205>
    77b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    77bc:	00 00 00 00 

00000000000077c0 <__pfx_kern_path>:
    77c0:	90                   	nop
    77c1:	90                   	nop
    77c2:	90                   	nop
    77c3:	90                   	nop
    77c4:	90                   	nop
    77c5:	90                   	nop
    77c6:	90                   	nop
    77c7:	90                   	nop
    77c8:	90                   	nop
    77c9:	90                   	nop
    77ca:	90                   	nop
    77cb:	90                   	nop
    77cc:	90                   	nop
    77cd:	90                   	nop
    77ce:	90                   	nop
    77cf:	90                   	nop

00000000000077d0 <kern_path>:
    77d0:	e8 00 00 00 00       	call   77d5 <kern_path+0x5>
    77d5:	55                   	push   %rbp
    77d6:	48 89 e5             	mov    %rsp,%rbp
    77d9:	41 55                	push   %r13
    77db:	49 89 d5             	mov    %rdx,%r13
    77de:	41 54                	push   %r12
    77e0:	41 89 f4             	mov    %esi,%r12d
    77e3:	53                   	push   %rbx
    77e4:	e8 00 00 00 00       	call   77e9 <kern_path+0x19>
    77e9:	4c 89 e9             	mov    %r13,%rcx
    77ec:	44 89 e2             	mov    %r12d,%edx
    77ef:	45 31 c0             	xor    %r8d,%r8d
    77f2:	48 89 c6             	mov    %rax,%rsi
    77f5:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    77fa:	48 89 c3             	mov    %rax,%rbx
    77fd:	e8 00 00 00 00       	call   7802 <kern_path+0x32>
    7802:	48 89 df             	mov    %rbx,%rdi
    7805:	41 89 c4             	mov    %eax,%r12d
    7808:	e8 00 00 00 00       	call   780d <kern_path+0x3d>
    780d:	44 89 e0             	mov    %r12d,%eax
    7810:	5b                   	pop    %rbx
    7811:	41 5c                	pop    %r12
    7813:	41 5d                	pop    %r13
    7815:	5d                   	pop    %rbp
    7816:	31 d2                	xor    %edx,%edx
    7818:	31 c9                	xor    %ecx,%ecx
    781a:	31 f6                	xor    %esi,%esi
    781c:	31 ff                	xor    %edi,%edi
    781e:	45 31 c0             	xor    %r8d,%r8d
    7821:	e9 00 00 00 00       	jmp    7826 <kern_path+0x56>
    7826:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    782d:	00 00 00 

0000000000007830 <__pfx_vfs_path_lookup>:
    7830:	90                   	nop
    7831:	90                   	nop
    7832:	90                   	nop
    7833:	90                   	nop
    7834:	90                   	nop
    7835:	90                   	nop
    7836:	90                   	nop
    7837:	90                   	nop
    7838:	90                   	nop
    7839:	90                   	nop
    783a:	90                   	nop
    783b:	90                   	nop
    783c:	90                   	nop
    783d:	90                   	nop
    783e:	90                   	nop
    783f:	90                   	nop

0000000000007840 <vfs_path_lookup>:
    7840:	e8 00 00 00 00       	call   7845 <vfs_path_lookup+0x5>
    7845:	55                   	push   %rbp
    7846:	48 89 f8             	mov    %rdi,%rax
    7849:	48 89 d7             	mov    %rdx,%rdi
    784c:	48 89 e5             	mov    %rsp,%rbp
    784f:	41 55                	push   %r13
    7851:	4d 89 c5             	mov    %r8,%r13
    7854:	41 54                	push   %r12
    7856:	41 89 cc             	mov    %ecx,%r12d
    7859:	53                   	push   %rbx
    785a:	48 83 ec 18          	sub    $0x18,%rsp
    785e:	65 48 8b 15 00 00 00 	mov    %gs:0x0(%rip),%rdx        # 7866 <vfs_path_lookup+0x26>
    7865:	00 
    7866:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
    786a:	31 d2                	xor    %edx,%edx
    786c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    7870:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    7874:	e8 00 00 00 00       	call   7879 <vfs_path_lookup+0x39>
    7879:	44 89 e2             	mov    %r12d,%edx
    787c:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    7881:	4c 89 e9             	mov    %r13,%rcx
    7884:	48 89 c3             	mov    %rax,%rbx
    7887:	4c 8d 45 d0          	lea    -0x30(%rbp),%r8
    788b:	48 89 c6             	mov    %rax,%rsi
    788e:	e8 00 00 00 00       	call   7893 <vfs_path_lookup+0x53>
    7893:	48 89 df             	mov    %rbx,%rdi
    7896:	41 89 c4             	mov    %eax,%r12d
    7899:	e8 00 00 00 00       	call   789e <vfs_path_lookup+0x5e>
    789e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    78a2:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 78aa <vfs_path_lookup+0x6a>
    78a9:	00 
    78aa:	75 1d                	jne    78c9 <vfs_path_lookup+0x89>
    78ac:	48 83 c4 18          	add    $0x18,%rsp
    78b0:	44 89 e0             	mov    %r12d,%eax
    78b3:	5b                   	pop    %rbx
    78b4:	41 5c                	pop    %r12
    78b6:	41 5d                	pop    %r13
    78b8:	5d                   	pop    %rbp
    78b9:	31 d2                	xor    %edx,%edx
    78bb:	31 c9                	xor    %ecx,%ecx
    78bd:	31 f6                	xor    %esi,%esi
    78bf:	31 ff                	xor    %edi,%edi
    78c1:	45 31 c0             	xor    %r8d,%r8d
    78c4:	e9 00 00 00 00       	jmp    78c9 <vfs_path_lookup+0x89>
    78c9:	e8 00 00 00 00       	call   78ce <vfs_path_lookup+0x8e>
    78ce:	66 90                	xchg   %ax,%ax

00000000000078d0 <__pfx_user_path_at>:
    78d0:	90                   	nop
    78d1:	90                   	nop
    78d2:	90                   	nop
    78d3:	90                   	nop
    78d4:	90                   	nop
    78d5:	90                   	nop
    78d6:	90                   	nop
    78d7:	90                   	nop
    78d8:	90                   	nop
    78d9:	90                   	nop
    78da:	90                   	nop
    78db:	90                   	nop
    78dc:	90                   	nop
    78dd:	90                   	nop
    78de:	90                   	nop
    78df:	90                   	nop

00000000000078e0 <user_path_at>:
    78e0:	e8 00 00 00 00       	call   78e5 <user_path_at+0x5>
    78e5:	55                   	push   %rbp
    78e6:	48 89 e5             	mov    %rsp,%rbp
    78e9:	41 56                	push   %r14
    78eb:	49 89 ce             	mov    %rcx,%r14
    78ee:	41 55                	push   %r13
    78f0:	41 89 fd             	mov    %edi,%r13d
    78f3:	48 89 f7             	mov    %rsi,%rdi
    78f6:	89 d6                	mov    %edx,%esi
    78f8:	41 54                	push   %r12
    78fa:	41 89 d4             	mov    %edx,%r12d
    78fd:	53                   	push   %rbx
    78fe:	e8 00 00 00 00       	call   7903 <user_path_at+0x23>
    7903:	4c 89 f1             	mov    %r14,%rcx
    7906:	44 89 e2             	mov    %r12d,%edx
    7909:	44 89 ef             	mov    %r13d,%edi
    790c:	45 31 c0             	xor    %r8d,%r8d
    790f:	48 89 c6             	mov    %rax,%rsi
    7912:	48 89 c3             	mov    %rax,%rbx
    7915:	e8 00 00 00 00       	call   791a <user_path_at+0x3a>
    791a:	48 89 df             	mov    %rbx,%rdi
    791d:	41 89 c4             	mov    %eax,%r12d
    7920:	e8 00 00 00 00       	call   7925 <user_path_at+0x45>
    7925:	44 89 e0             	mov    %r12d,%eax
    7928:	5b                   	pop    %rbx
    7929:	41 5c                	pop    %r12
    792b:	41 5d                	pop    %r13
    792d:	41 5e                	pop    %r14
    792f:	5d                   	pop    %rbp
    7930:	31 d2                	xor    %edx,%edx
    7932:	31 c9                	xor    %ecx,%ecx
    7934:	31 f6                	xor    %esi,%esi
    7936:	31 ff                	xor    %edi,%edi
    7938:	45 31 c0             	xor    %r8d,%r8d
    793b:	e9 00 00 00 00       	jmp    7940 <__pfx_kern_path_locked_negative>

0000000000007940 <__pfx_kern_path_locked_negative>:
    7940:	90                   	nop
    7941:	90                   	nop
    7942:	90                   	nop
    7943:	90                   	nop
    7944:	90                   	nop
    7945:	90                   	nop
    7946:	90                   	nop
    7947:	90                   	nop
    7948:	90                   	nop
    7949:	90                   	nop
    794a:	90                   	nop
    794b:	90                   	nop
    794c:	90                   	nop
    794d:	90                   	nop
    794e:	90                   	nop
    794f:	90                   	nop

0000000000007950 <kern_path_locked_negative>:
    7950:	e8 00 00 00 00       	call   7955 <kern_path_locked_negative+0x5>
    7955:	55                   	push   %rbp
    7956:	48 89 e5             	mov    %rsp,%rbp
    7959:	41 57                	push   %r15
    795b:	41 56                	push   %r14
    795d:	41 55                	push   %r13
    795f:	49 89 f5             	mov    %rsi,%r13
    7962:	41 54                	push   %r12
    7964:	53                   	push   %rbx
    7965:	48 83 ec 30          	sub    $0x30,%rsp
    7969:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 7971 <kern_path_locked_negative+0x21>
    7970:	00 
    7971:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    7975:	31 c0                	xor    %eax,%eax
    7977:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    797e:	00 
    797f:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
    7986:	00 
    7987:	e8 00 00 00 00       	call   798c <kern_path_locked_negative+0x3c>
    798c:	31 d2                	xor    %edx,%edx
    798e:	4c 8d 4d ac          	lea    -0x54(%rbp),%r9
    7992:	4c 8d 45 c0          	lea    -0x40(%rbp),%r8
    7996:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    799a:	48 89 c6             	mov    %rax,%rsi
    799d:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    79a2:	49 89 c4             	mov    %rax,%r12
    79a5:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    79ac:	00 
    79ad:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    79b4:	00 
    79b5:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%rbp)
    79bc:	6a 00                	push   $0x0
    79be:	e8 3d ec ff ff       	call   6600 <__filename_parentat>
    79c3:	5a                   	pop    %rdx
    79c4:	85 c0                	test   %eax,%eax
    79c6:	0f 85 a5 00 00 00    	jne    7a71 <kern_path_locked_negative+0x121>
    79cc:	8b 45 ac             	mov    -0x54(%rbp),%eax
    79cf:	4c 8b 75 b8          	mov    -0x48(%rbp),%r14
    79d3:	4c 8b 7d b0          	mov    -0x50(%rbp),%r15
    79d7:	85 c0                	test   %eax,%eax
    79d9:	0f 85 9f 00 00 00    	jne    7a7e <kern_path_locked_negative+0x12e>
    79df:	49 8b 46 30          	mov    0x30(%r14),%rax
    79e3:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    79ea:	e8 00 00 00 00       	call   79ef <kern_path_locked_negative+0x9f>
    79ef:	ba 00 00 02 00       	mov    $0x20000,%edx
    79f4:	4c 89 f6             	mov    %r14,%rsi
    79f7:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
    79fb:	e8 00 00 00 00       	call   7a00 <kern_path_locked_negative+0xb0>
    7a00:	48 89 c3             	mov    %rax,%rbx
    7a03:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    7a09:	77 7c                	ja     7a87 <kern_path_locked_negative+0x137>
    7a0b:	4d 89 75 08          	mov    %r14,0x8(%r13)
    7a0f:	45 31 f6             	xor    %r14d,%r14d
    7a12:	4d 89 7d 00          	mov    %r15,0x0(%r13)
    7a16:	45 31 ff             	xor    %r15d,%r15d
    7a19:	4d 85 e4             	test   %r12,%r12
    7a1c:	74 11                	je     7a2f <kern_path_locked_negative+0xdf>
    7a1e:	49 81 fc 00 f0 ff ff 	cmp    $0xfffffffffffff000,%r12
    7a25:	77 08                	ja     7a2f <kern_path_locked_negative+0xdf>
    7a27:	4c 89 e7             	mov    %r12,%rdi
    7a2a:	e8 00 00 00 00       	call   7a2f <kern_path_locked_negative+0xdf>
    7a2f:	4c 89 f7             	mov    %r14,%rdi
    7a32:	e8 00 00 00 00       	call   7a37 <kern_path_locked_negative+0xe7>
    7a37:	4c 89 ff             	mov    %r15,%rdi
    7a3a:	e8 00 00 00 00       	call   7a3f <kern_path_locked_negative+0xef>
    7a3f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    7a43:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 7a4b <kern_path_locked_negative+0xfb>
    7a4a:	00 
    7a4b:	75 4c                	jne    7a99 <kern_path_locked_negative+0x149>
    7a4d:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    7a51:	48 89 d8             	mov    %rbx,%rax
    7a54:	5b                   	pop    %rbx
    7a55:	41 5c                	pop    %r12
    7a57:	41 5d                	pop    %r13
    7a59:	41 5e                	pop    %r14
    7a5b:	41 5f                	pop    %r15
    7a5d:	5d                   	pop    %rbp
    7a5e:	31 d2                	xor    %edx,%edx
    7a60:	31 c9                	xor    %ecx,%ecx
    7a62:	31 f6                	xor    %esi,%esi
    7a64:	31 ff                	xor    %edi,%edi
    7a66:	45 31 c0             	xor    %r8d,%r8d
    7a69:	45 31 c9             	xor    %r9d,%r9d
    7a6c:	e9 00 00 00 00       	jmp    7a71 <kern_path_locked_negative+0x121>
    7a71:	4c 8b 75 b8          	mov    -0x48(%rbp),%r14
    7a75:	4c 8b 7d b0          	mov    -0x50(%rbp),%r15
    7a79:	48 63 d8             	movslq %eax,%rbx
    7a7c:	eb 9b                	jmp    7a19 <kern_path_locked_negative+0xc9>
    7a7e:	48 c7 c3 ea ff ff ff 	mov    $0xffffffffffffffea,%rbx
    7a85:	eb 92                	jmp    7a19 <kern_path_locked_negative+0xc9>
    7a87:	49 8b 46 30          	mov    0x30(%r14),%rax
    7a8b:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    7a92:	e8 00 00 00 00       	call   7a97 <kern_path_locked_negative+0x147>
    7a97:	eb 80                	jmp    7a19 <kern_path_locked_negative+0xc9>
    7a99:	e8 00 00 00 00       	call   7a9e <kern_path_locked_negative+0x14e>
    7a9e:	66 90                	xchg   %ax,%ax

0000000000007aa0 <__pfx_kern_path_locked>:
    7aa0:	90                   	nop
    7aa1:	90                   	nop
    7aa2:	90                   	nop
    7aa3:	90                   	nop
    7aa4:	90                   	nop
    7aa5:	90                   	nop
    7aa6:	90                   	nop
    7aa7:	90                   	nop
    7aa8:	90                   	nop
    7aa9:	90                   	nop
    7aaa:	90                   	nop
    7aab:	90                   	nop
    7aac:	90                   	nop
    7aad:	90                   	nop
    7aae:	90                   	nop
    7aaf:	90                   	nop

0000000000007ab0 <kern_path_locked>:
    7ab0:	e8 00 00 00 00       	call   7ab5 <kern_path_locked+0x5>
    7ab5:	55                   	push   %rbp
    7ab6:	48 89 e5             	mov    %rsp,%rbp
    7ab9:	41 54                	push   %r12
    7abb:	49 89 f4             	mov    %rsi,%r12
    7abe:	53                   	push   %rbx
    7abf:	e8 00 00 00 00       	call   7ac4 <kern_path_locked+0x14>
    7ac4:	4c 89 e2             	mov    %r12,%rdx
    7ac7:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    7acc:	48 89 c6             	mov    %rax,%rsi
    7acf:	48 89 c3             	mov    %rax,%rbx
    7ad2:	e8 79 ed ff ff       	call   6850 <__kern_path_locked>
    7ad7:	48 89 df             	mov    %rbx,%rdi
    7ada:	49 89 c4             	mov    %rax,%r12
    7add:	e8 00 00 00 00       	call   7ae2 <kern_path_locked+0x32>
    7ae2:	4c 89 e0             	mov    %r12,%rax
    7ae5:	5b                   	pop    %rbx
    7ae6:	41 5c                	pop    %r12
    7ae8:	5d                   	pop    %rbp
    7ae9:	31 d2                	xor    %edx,%edx
    7aeb:	31 f6                	xor    %esi,%esi
    7aed:	31 ff                	xor    %edi,%edi
    7aef:	e9 00 00 00 00       	jmp    7af4 <kern_path_locked+0x44>
    7af4:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7afb:	00 00 00 00 
    7aff:	90                   	nop

0000000000007b00 <__pfx_path_pts>:
    7b00:	90                   	nop
    7b01:	90                   	nop
    7b02:	90                   	nop
    7b03:	90                   	nop
    7b04:	90                   	nop
    7b05:	90                   	nop
    7b06:	90                   	nop
    7b07:	90                   	nop
    7b08:	90                   	nop
    7b09:	90                   	nop
    7b0a:	90                   	nop
    7b0b:	90                   	nop
    7b0c:	90                   	nop
    7b0d:	90                   	nop
    7b0e:	90                   	nop
    7b0f:	90                   	nop

0000000000007b10 <path_pts>:
    7b10:	e8 00 00 00 00       	call   7b15 <path_pts+0x5>
    7b15:	55                   	push   %rbp
    7b16:	48 89 e5             	mov    %rsp,%rbp
    7b19:	41 54                	push   %r12
    7b1b:	53                   	push   %rbx
    7b1c:	48 89 fb             	mov    %rdi,%rbx
    7b1f:	48 83 ec 18          	sub    $0x18,%rsp
    7b23:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    7b27:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 7b2f <path_pts+0x1f>
    7b2e:	00 
    7b2f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    7b33:	31 c0                	xor    %eax,%eax
    7b35:	e8 00 00 00 00       	call   7b3a <path_pts+0x2a>
    7b3a:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
    7b41:	00 
    7b42:	49 89 c4             	mov    %rax,%r12
    7b45:	48 b8 00 00 00 00 03 	movabs $0x300000000,%rax
    7b4c:	00 00 00 
    7b4f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    7b53:	48 8b 03             	mov    (%rbx),%rax
    7b56:	48 8b 30             	mov    (%rax),%rsi
    7b59:	48 8b 40 08          	mov    0x8(%rax),%rax
    7b5d:	48 3b 70 68          	cmp    0x68(%rax),%rsi
    7b61:	74 0c                	je     7b6f <path_pts+0x5f>
    7b63:	4c 89 e7             	mov    %r12,%rdi
    7b66:	e8 00 00 00 00       	call   7b6b <path_pts+0x5b>
    7b6b:	84 c0                	test   %al,%al
    7b6d:	74 5f                	je     7bce <path_pts+0xbe>
    7b6f:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    7b73:	e8 00 00 00 00       	call   7b78 <path_pts+0x68>
    7b78:	4c 89 63 08          	mov    %r12,0x8(%rbx)
    7b7c:	48 8d 75 d8          	lea    -0x28(%rbp),%rsi
    7b80:	4c 89 e7             	mov    %r12,%rdi
    7b83:	e8 00 00 00 00       	call   7b88 <path_pts+0x78>
    7b88:	48 85 c0             	test   %rax,%rax
    7b8b:	74 49                	je     7bd6 <path_pts+0xc6>
    7b8d:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    7b93:	77 41                	ja     7bd6 <path_pts+0xc6>
    7b95:	48 89 43 08          	mov    %rax,0x8(%rbx)
    7b99:	4c 89 e7             	mov    %r12,%rdi
    7b9c:	e8 00 00 00 00       	call   7ba1 <path_pts+0x91>
    7ba1:	31 f6                	xor    %esi,%esi
    7ba3:	48 89 df             	mov    %rbx,%rdi
    7ba6:	e8 00 00 00 00       	call   7bab <path_pts+0x9b>
    7bab:	31 c0                	xor    %eax,%eax
    7bad:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    7bb1:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # 7bb9 <path_pts+0xa9>
    7bb8:	00 
    7bb9:	75 22                	jne    7bdd <path_pts+0xcd>
    7bbb:	48 83 c4 18          	add    $0x18,%rsp
    7bbf:	5b                   	pop    %rbx
    7bc0:	41 5c                	pop    %r12
    7bc2:	5d                   	pop    %rbp
    7bc3:	31 d2                	xor    %edx,%edx
    7bc5:	31 f6                	xor    %esi,%esi
    7bc7:	31 ff                	xor    %edi,%edi
    7bc9:	e9 00 00 00 00       	jmp    7bce <path_pts+0xbe>
    7bce:	4c 89 e7             	mov    %r12,%rdi
    7bd1:	e8 00 00 00 00       	call   7bd6 <path_pts+0xc6>
    7bd6:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    7bdb:	eb d0                	jmp    7bad <path_pts+0x9d>
    7bdd:	e8 00 00 00 00       	call   7be2 <path_pts+0xd2>
    7be2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7be9:	00 00 00 00 
    7bed:	0f 1f 00             	nopl   (%rax)

0000000000007bf0 <__pfx_may_open_dev>:
    7bf0:	90                   	nop
    7bf1:	90                   	nop
    7bf2:	90                   	nop
    7bf3:	90                   	nop
    7bf4:	90                   	nop
    7bf5:	90                   	nop
    7bf6:	90                   	nop
    7bf7:	90                   	nop
    7bf8:	90                   	nop
    7bf9:	90                   	nop
    7bfa:	90                   	nop
    7bfb:	90                   	nop
    7bfc:	90                   	nop
    7bfd:	90                   	nop
    7bfe:	90                   	nop
    7bff:	90                   	nop

0000000000007c00 <may_open_dev>:
    7c00:	e8 00 00 00 00       	call   7c05 <may_open_dev+0x5>
    7c05:	55                   	push   %rbp
    7c06:	48 8b 17             	mov    (%rdi),%rdx
    7c09:	31 c0                	xor    %eax,%eax
    7c0b:	48 89 e5             	mov    %rsp,%rbp
    7c0e:	f6 42 10 02          	testb  $0x2,0x10(%rdx)
    7c12:	75 13                	jne    7c27 <may_open_dev+0x27>
    7c14:	48 8b 42 08          	mov    0x8(%rdx),%rax
    7c18:	48 8b 40 58          	mov    0x58(%rax),%rax
    7c1c:	48 c1 e8 02          	shr    $0x2,%rax
    7c20:	48 83 f0 01          	xor    $0x1,%rax
    7c24:	83 e0 01             	and    $0x1,%eax
    7c27:	5d                   	pop    %rbp
    7c28:	31 d2                	xor    %edx,%edx
    7c2a:	31 ff                	xor    %edi,%edi
    7c2c:	e9 00 00 00 00       	jmp    7c31 <may_open_dev+0x31>
    7c31:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7c38:	00 00 00 00 
    7c3c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007c40 <__pfx_vfs_tmpfile>:
    7c40:	90                   	nop
    7c41:	90                   	nop
    7c42:	90                   	nop
    7c43:	90                   	nop
    7c44:	90                   	nop
    7c45:	90                   	nop
    7c46:	90                   	nop
    7c47:	90                   	nop
    7c48:	90                   	nop
    7c49:	90                   	nop
    7c4a:	90                   	nop
    7c4b:	90                   	nop
    7c4c:	90                   	nop
    7c4d:	90                   	nop
    7c4e:	90                   	nop
    7c4f:	90                   	nop

0000000000007c50 <vfs_tmpfile>:
    7c50:	e8 00 00 00 00       	call   7c55 <vfs_tmpfile+0x5>
    7c55:	55                   	push   %rbp
    7c56:	48 89 e5             	mov    %rsp,%rbp
    7c59:	41 57                	push   %r15
    7c5b:	41 56                	push   %r14
    7c5d:	49 89 f6             	mov    %rsi,%r14
    7c60:	41 55                	push   %r13
    7c62:	41 54                	push   %r12
    7c64:	49 89 fc             	mov    %rdi,%r12
    7c67:	53                   	push   %rbx
    7c68:	48 89 d3             	mov    %rdx,%rbx
    7c6b:	48 83 ec 18          	sub    $0x18,%rsp
    7c6f:	48 8b 46 08          	mov    0x8(%rsi),%rax
    7c73:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
    7c76:	4c 8b 68 30          	mov    0x30(%rax),%r13
    7c7a:	8b 42 28             	mov    0x28(%rdx),%eax
    7c7d:	ba 03 00 00 00       	mov    $0x3,%edx
    7c82:	4c 89 ee             	mov    %r13,%rsi
    7c85:	89 45 d0             	mov    %eax,-0x30(%rbp)
    7c88:	e8 00 00 00 00       	call   7c8d <vfs_tmpfile+0x3d>
    7c8d:	41 89 c7             	mov    %eax,%r15d
    7c90:	85 c0                	test   %eax,%eax
    7c92:	0f 85 a2 00 00 00    	jne    7d3a <vfs_tmpfile+0xea>
    7c98:	49 8b 45 20          	mov    0x20(%r13),%rax
    7c9c:	48 83 b8 98 00 00 00 	cmpq   $0x0,0x98(%rax)
    7ca3:	00 
    7ca4:	0f 84 ce 01 00 00    	je     7e78 <vfs_tmpfile+0x228>
    7caa:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    7cae:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
    7cb5:	e8 00 00 00 00       	call   7cba <vfs_tmpfile+0x6a>
    7cba:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    7cbe:	48 89 c6             	mov    %rax,%rsi
    7cc1:	48 85 c0             	test   %rax,%rax
    7cc4:	0f 84 58 01 00 00    	je     7e22 <vfs_tmpfile+0x1d2>
    7cca:	49 8b 06             	mov    (%r14),%rax
    7ccd:	0f b7 55 d4          	movzwl -0x2c(%rbp),%edx
    7cd1:	48 89 73 48          	mov    %rsi,0x48(%rbx)
    7cd5:	4c 89 e7             	mov    %r12,%rdi
    7cd8:	4c 89 ee             	mov    %r13,%rsi
    7cdb:	48 89 43 40          	mov    %rax,0x40(%rbx)
    7cdf:	e8 00 00 00 00       	call   7ce4 <vfs_tmpfile+0x94>
    7ce4:	89 c1                	mov    %eax,%ecx
    7ce6:	49 8b 45 28          	mov    0x28(%r13),%rax
    7cea:	f6 40 52 01          	testb  $0x1,0x52(%rax)
    7cee:	75 0a                	jne    7cfa <vfs_tmpfile+0xaa>
    7cf0:	f6 40 59 10          	testb  $0x10,0x59(%rax)
    7cf4:	0f 84 14 01 00 00    	je     7e0e <vfs_tmpfile+0x1be>
    7cfa:	49 8b 45 20          	mov    0x20(%r13),%rax
    7cfe:	66 81 c9 00 f0       	or     $0xf000,%cx
    7d03:	66 23 4d d4          	and    -0x2c(%rbp),%cx
    7d07:	48 89 da             	mov    %rbx,%rdx
    7d0a:	0f b7 c9             	movzwl %cx,%ecx
    7d0d:	4c 89 ee             	mov    %r13,%rsi
    7d10:	4c 89 e7             	mov    %r12,%rdi
    7d13:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
    7d1a:	e8 00 00 00 00       	call   7d1f <vfs_tmpfile+0xcf>
    7d1f:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    7d23:	41 89 c7             	mov    %eax,%r15d
    7d26:	e8 00 00 00 00       	call   7d2b <vfs_tmpfile+0xdb>
    7d2b:	8b 43 04             	mov    0x4(%rbx),%eax
    7d2e:	a9 00 00 08 00       	test   $0x80000,%eax
    7d33:	75 5c                	jne    7d91 <vfs_tmpfile+0x141>
    7d35:	45 85 ff             	test   %r15d,%r15d
    7d38:	74 24                	je     7d5e <vfs_tmpfile+0x10e>
    7d3a:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    7d3e:	44 89 f8             	mov    %r15d,%eax
    7d41:	5b                   	pop    %rbx
    7d42:	41 5c                	pop    %r12
    7d44:	41 5d                	pop    %r13
    7d46:	41 5e                	pop    %r14
    7d48:	41 5f                	pop    %r15
    7d4a:	5d                   	pop    %rbp
    7d4b:	31 d2                	xor    %edx,%edx
    7d4d:	31 c9                	xor    %ecx,%ecx
    7d4f:	31 f6                	xor    %esi,%esi
    7d51:	31 ff                	xor    %edi,%edi
    7d53:	45 31 c0             	xor    %r8d,%r8d
    7d56:	45 31 c9             	xor    %r9d,%r9d
    7d59:	e9 00 00 00 00       	jmp    7d5e <vfs_tmpfile+0x10e>
    7d5e:	8b 4b 28             	mov    0x28(%rbx),%ecx
    7d61:	48 8d 73 40          	lea    0x40(%rbx),%rsi
    7d65:	31 d2                	xor    %edx,%edx
    7d67:	4c 89 e7             	mov    %r12,%rdi
    7d6a:	e8 31 a2 ff ff       	call   1fa0 <may_open>
    7d6f:	41 89 c7             	mov    %eax,%r15d
    7d72:	85 c0                	test   %eax,%eax
    7d74:	75 c4                	jne    7d3a <vfs_tmpfile+0xea>
    7d76:	48 8b 5b 20          	mov    0x20(%rbx),%rbx
    7d7a:	f6 45 d0 80          	testb  $0x80,-0x30(%rbp)
    7d7e:	0f 84 a9 00 00 00    	je     7e2d <vfs_tmpfile+0x1dd>
    7d84:	48 89 de             	mov    %rbx,%rsi
    7d87:	4c 89 e7             	mov    %r12,%rdi
    7d8a:	e8 00 00 00 00       	call   7d8f <vfs_tmpfile+0x13f>
    7d8f:	eb a9                	jmp    7d3a <vfs_tmpfile+0xea>
    7d91:	8b 53 28             	mov    0x28(%rbx),%edx
    7d94:	83 e2 20             	and    $0x20,%edx
    7d97:	83 fa 01             	cmp    $0x1,%edx
    7d9a:	19 ff                	sbb    %edi,%edi
    7d9c:	25 00 00 00 06       	and    $0x6000000,%eax
    7da1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    7da7:	81 c7 20 10 00 00    	add    $0x1020,%edi
    7dad:	3d 00 00 00 02       	cmp    $0x2000000,%eax
    7db2:	74 81                	je     7d35 <vfs_tmpfile+0xe5>
    7db4:	48 8b 43 48          	mov    0x48(%rbx),%rax
    7db8:	4c 8b 48 30          	mov    0x30(%rax),%r9
    7dbc:	49 8b 51 28          	mov    0x28(%r9),%rdx
    7dc0:	48 8b 92 c0 03 00 00 	mov    0x3c0(%rdx),%rdx
    7dc7:	48 85 d2             	test   %rdx,%rdx
    7dca:	0f 84 65 ff ff ff    	je     7d35 <vfs_tmpfile+0xe5>
    7dd0:	48 8b 52 08          	mov    0x8(%rdx),%rdx
    7dd4:	48 85 d2             	test   %rdx,%rdx
    7dd7:	0f 84 58 ff ff ff    	je     7d35 <vfs_tmpfile+0xe5>
    7ddd:	41 0f b7 11          	movzwl (%r9),%edx
    7de1:	48 8d 73 40          	lea    0x40(%rbx),%rsi
    7de5:	66 81 e2 00 f0       	and    $0xf000,%dx
    7dea:	66 81 fa 00 40       	cmp    $0x4000,%dx
    7def:	74 62                	je     7e53 <vfs_tmpfile+0x203>
    7df1:	48 3b 40 18          	cmp    0x18(%rax),%rax
    7df5:	74 6a                	je     7e61 <vfs_tmpfile+0x211>
    7df7:	48 89 f2             	mov    %rsi,%rdx
    7dfa:	b9 02 00 00 00       	mov    $0x2,%ecx
    7dff:	89 fe                	mov    %edi,%esi
    7e01:	48 89 c7             	mov    %rax,%rdi
    7e04:	e8 00 00 00 00       	call   7e09 <vfs_tmpfile+0x1b9>
    7e09:	e9 27 ff ff ff       	jmp    7d35 <vfs_tmpfile+0xe5>
    7e0e:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
    7e11:	e8 00 00 00 00       	call   7e16 <vfs_tmpfile+0x1c6>
    7e16:	8b 4d c4             	mov    -0x3c(%rbp),%ecx
    7e19:	f7 d0                	not    %eax
    7e1b:	21 c1                	and    %eax,%ecx
    7e1d:	e9 d8 fe ff ff       	jmp    7cfa <vfs_tmpfile+0xaa>
    7e22:	41 bf f4 ff ff ff    	mov    $0xfffffff4,%r15d
    7e28:	e9 0d ff ff ff       	jmp    7d3a <vfs_tmpfile+0xea>
    7e2d:	4c 8d ab 80 00 00 00 	lea    0x80(%rbx),%r13
    7e34:	4c 89 ef             	mov    %r13,%rdi
    7e37:	e8 00 00 00 00       	call   7e3c <vfs_tmpfile+0x1ec>
    7e3c:	4c 89 ef             	mov    %r13,%rdi
    7e3f:	81 8b 90 00 00 00 00 	orl    $0x400,0x90(%rbx)
    7e46:	04 00 00 
    7e49:	e8 00 00 00 00       	call   7e4e <vfs_tmpfile+0x1fe>
    7e4e:	e9 31 ff ff ff       	jmp    7d84 <vfs_tmpfile+0x134>
    7e53:	81 cf 00 00 00 40    	or     $0x40000000,%edi
    7e59:	f7 00 00 20 00 00    	testl  $0x2000,(%rax)
    7e5f:	75 90                	jne    7df1 <vfs_tmpfile+0x1a1>
    7e61:	6a 00                	push   $0x0
    7e63:	45 31 c0             	xor    %r8d,%r8d
    7e66:	31 c9                	xor    %ecx,%ecx
    7e68:	ba 02 00 00 00       	mov    $0x2,%edx
    7e6d:	e8 00 00 00 00       	call   7e72 <vfs_tmpfile+0x222>
    7e72:	58                   	pop    %rax
    7e73:	e9 bd fe ff ff       	jmp    7d35 <vfs_tmpfile+0xe5>
    7e78:	41 bf a1 ff ff ff    	mov    $0xffffffa1,%r15d
    7e7e:	e9 b7 fe ff ff       	jmp    7d3a <vfs_tmpfile+0xea>
    7e83:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7e8a:	00 00 00 00 
    7e8e:	66 90                	xchg   %ax,%ax

0000000000007e90 <__pfx_kernel_tmpfile_open>:
    7e90:	90                   	nop
    7e91:	90                   	nop
    7e92:	90                   	nop
    7e93:	90                   	nop
    7e94:	90                   	nop
    7e95:	90                   	nop
    7e96:	90                   	nop
    7e97:	90                   	nop
    7e98:	90                   	nop
    7e99:	90                   	nop
    7e9a:	90                   	nop
    7e9b:	90                   	nop
    7e9c:	90                   	nop
    7e9d:	90                   	nop
    7e9e:	90                   	nop
    7e9f:	90                   	nop

0000000000007ea0 <kernel_tmpfile_open>:
    7ea0:	e8 00 00 00 00       	call   7ea5 <kernel_tmpfile_open+0x5>
    7ea5:	55                   	push   %rbp
    7ea6:	48 89 e5             	mov    %rsp,%rbp
    7ea9:	41 56                	push   %r14
    7eab:	49 89 f6             	mov    %rsi,%r14
    7eae:	4c 89 c6             	mov    %r8,%rsi
    7eb1:	41 55                	push   %r13
    7eb3:	49 89 fd             	mov    %rdi,%r13
    7eb6:	89 cf                	mov    %ecx,%edi
    7eb8:	41 54                	push   %r12
    7eba:	41 89 d4             	mov    %edx,%r12d
    7ebd:	53                   	push   %rbx
    7ebe:	e8 00 00 00 00       	call   7ec3 <kernel_tmpfile_open+0x23>
    7ec3:	48 89 c3             	mov    %rax,%rbx
    7ec6:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    7ecc:	77 19                	ja     7ee7 <kernel_tmpfile_open+0x47>
    7ece:	41 0f b7 cc          	movzwl %r12w,%ecx
    7ed2:	48 89 c2             	mov    %rax,%rdx
    7ed5:	4c 89 f6             	mov    %r14,%rsi
    7ed8:	4c 89 ef             	mov    %r13,%rdi
    7edb:	e8 00 00 00 00       	call   7ee0 <kernel_tmpfile_open+0x40>
    7ee0:	41 89 c4             	mov    %eax,%r12d
    7ee3:	85 c0                	test   %eax,%eax
    7ee5:	75 1b                	jne    7f02 <kernel_tmpfile_open+0x62>
    7ee7:	48 89 d8             	mov    %rbx,%rax
    7eea:	5b                   	pop    %rbx
    7eeb:	41 5c                	pop    %r12
    7eed:	41 5d                	pop    %r13
    7eef:	41 5e                	pop    %r14
    7ef1:	5d                   	pop    %rbp
    7ef2:	31 d2                	xor    %edx,%edx
    7ef4:	31 c9                	xor    %ecx,%ecx
    7ef6:	31 f6                	xor    %esi,%esi
    7ef8:	31 ff                	xor    %edi,%edi
    7efa:	45 31 c0             	xor    %r8d,%r8d
    7efd:	e9 00 00 00 00       	jmp    7f02 <kernel_tmpfile_open+0x62>
    7f02:	48 89 df             	mov    %rbx,%rdi
    7f05:	49 63 dc             	movslq %r12d,%rbx
    7f08:	e8 00 00 00 00       	call   7f0d <kernel_tmpfile_open+0x6d>
    7f0d:	48 89 d8             	mov    %rbx,%rax
    7f10:	5b                   	pop    %rbx
    7f11:	41 5c                	pop    %r12
    7f13:	41 5d                	pop    %r13
    7f15:	41 5e                	pop    %r14
    7f17:	5d                   	pop    %rbp
    7f18:	31 d2                	xor    %edx,%edx
    7f1a:	31 c9                	xor    %ecx,%ecx
    7f1c:	31 f6                	xor    %esi,%esi
    7f1e:	31 ff                	xor    %edi,%edi
    7f20:	45 31 c0             	xor    %r8d,%r8d
    7f23:	e9 00 00 00 00       	jmp    7f28 <kernel_tmpfile_open+0x88>
    7f28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    7f2f:	00 

0000000000007f30 <__pfx_path_openat>:
    7f30:	90                   	nop
    7f31:	90                   	nop
    7f32:	90                   	nop
    7f33:	90                   	nop
    7f34:	90                   	nop
    7f35:	90                   	nop
    7f36:	90                   	nop
    7f37:	90                   	nop
    7f38:	90                   	nop
    7f39:	90                   	nop
    7f3a:	90                   	nop
    7f3b:	90                   	nop
    7f3c:	90                   	nop
    7f3d:	90                   	nop
    7f3e:	90                   	nop
    7f3f:	90                   	nop

0000000000007f40 <path_openat>:
    7f40:	e8 00 00 00 00       	call   7f45 <path_openat+0x5>
    7f45:	55                   	push   %rbp
    7f46:	48 89 e5             	mov    %rsp,%rbp
    7f49:	41 57                	push   %r15
    7f4b:	49 89 f7             	mov    %rsi,%r15
    7f4e:	41 56                	push   %r14
    7f50:	49 89 fe             	mov    %rdi,%r14
    7f53:	41 55                	push   %r13
    7f55:	41 54                	push   %r12
    7f57:	53                   	push   %rbx
    7f58:	48 83 ec 70          	sub    $0x70,%rsp
    7f5c:	89 55 a4             	mov    %edx,-0x5c(%rbp)
    7f5f:	41 8b 3f             	mov    (%r15),%edi
    7f62:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 7f6a <path_openat+0x2a>
    7f69:	00 
    7f6a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    7f6e:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 7f76 <path_openat+0x36>
    7f75:	00 
    7f76:	48 8b b0 a0 0c 00 00 	mov    0xca0(%rax),%rsi
    7f7d:	e8 00 00 00 00       	call   7f82 <path_openat+0x42>
    7f82:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    7f86:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    7f8c:	0f 87 a1 01 00 00    	ja     8133 <path_openat+0x1f3>
    7f92:	8b 40 28             	mov    0x28(%rax),%eax
    7f95:	a9 00 00 40 00       	test   $0x400000,%eax
    7f9a:	0f 85 6c 07 00 00    	jne    870c <path_openat+0x7cc>
    7fa0:	a9 00 00 20 00       	test   $0x200000,%eax
    7fa5:	0f 85 e3 07 00 00    	jne    878e <path_openat+0x84e>
    7fab:	8b 75 a4             	mov    -0x5c(%rbp),%esi
    7fae:	4c 89 f7             	mov    %r14,%rdi
    7fb1:	e8 5a c4 ff ff       	call   4410 <path_init>
    7fb6:	49 89 c2             	mov    %rax,%r10
    7fb9:	4c 89 f6             	mov    %r14,%rsi
    7fbc:	4c 89 d7             	mov    %r10,%rdi
    7fbf:	e8 cc e1 ff ff       	call   6190 <link_path_walk>
    7fc4:	41 89 c5             	mov    %eax,%r13d
    7fc7:	85 c0                	test   %eax,%eax
    7fc9:	0f 85 cb 02 00 00    	jne    829a <path_openat+0x35a>
    7fcf:	41 8b 76 50          	mov    0x50(%r14),%esi
    7fd3:	41 8b 46 38          	mov    0x38(%r14),%eax
    7fd7:	41 0b 47 0c          	or     0xc(%r15),%eax
    7fdb:	45 8b 27             	mov    (%r15),%r12d
    7fde:	49 8b 5e 08          	mov    0x8(%r14),%rbx
    7fe2:	41 89 46 38          	mov    %eax,0x38(%r14)
    7fe6:	85 f6                	test   %esi,%esi
    7fe8:	74 21                	je     800b <path_openat+0xcb>
    7fea:	41 8b 56 54          	mov    0x54(%r14),%edx
    7fee:	85 d2                	test   %edx,%edx
    7ff0:	0f 85 08 02 00 00    	jne    81fe <path_openat+0x2be>
    7ff6:	4c 89 f7             	mov    %r14,%rdi
    7ff9:	e8 22 dc ff ff       	call   5c20 <handle_dots>
    7ffe:	49 89 c2             	mov    %rax,%r10
    8001:	48 85 c0             	test   %rax,%rax
    8004:	75 b3                	jne    7fb9 <path_openat+0x79>
    8006:	e9 81 00 00 00       	jmp    808c <path_openat+0x14c>
    800b:	49 8b 4e 18          	mov    0x18(%r14),%rcx
    800f:	41 8b 56 14          	mov    0x14(%r14),%edx
    8013:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    8017:	44 89 e1             	mov    %r12d,%ecx
    801a:	83 e1 40             	and    $0x40,%ecx
    801d:	89 4d a8             	mov    %ecx,-0x58(%rbp)
    8020:	0f 84 4a 01 00 00    	je     8170 <path_openat+0x230>
    8026:	84 d2                	test   %dl,%dl
    8028:	0f 85 a9 02 00 00    	jne    82d7 <path_openat+0x397>
    802e:	41 f6 c4 80          	test   $0x80,%r12b
    8032:	0f 85 c6 06 00 00    	jne    86fe <path_openat+0x7be>
    8038:	4c 89 f7             	mov    %r14,%rdi
    803b:	e8 b0 a4 ff ff       	call   24f0 <lookup_fast>
    8040:	49 89 c2             	mov    %rax,%r10
    8043:	48 85 c0             	test   %rax,%rax
    8046:	0f 84 a8 11 00 00    	je     91f4 <path_openat+0x12b4>
    804c:	49 81 fa 00 f0 ff ff 	cmp    $0xfffffffffffff000,%r10
    8053:	0f 87 60 ff ff ff    	ja     7fb9 <path_openat+0x79>
    8059:	49 83 7a 30 00       	cmpq   $0x0,0x30(%r10)
    805e:	0f 84 11 04 00 00    	je     8475 <path_openat+0x535>
    8064:	41 8b 46 54          	mov    0x54(%r14),%eax
    8068:	85 c0                	test   %eax,%eax
    806a:	0f 85 38 01 00 00    	jne    81a8 <path_openat+0x268>
    8070:	4c 89 d2             	mov    %r10,%rdx
    8073:	be 01 00 00 00       	mov    $0x1,%esi
    8078:	4c 89 f7             	mov    %r14,%rdi
    807b:	e8 30 d4 ff ff       	call   54b0 <step_into>
    8080:	49 89 c2             	mov    %rax,%r10
    8083:	48 85 c0             	test   %rax,%rax
    8086:	0f 85 6d 02 00 00    	jne    82f9 <path_openat+0x3b9>
    808c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8090:	41 8b 0f             	mov    (%r15),%ecx
    8093:	8b 40 04             	mov    0x4(%rax),%eax
    8096:	a9 00 00 18 00       	test   $0x180000,%eax
    809b:	0f 84 a3 02 00 00    	je     8344 <path_openat+0x404>
    80a1:	a9 00 00 10 00       	test   $0x100000,%eax
    80a6:	0f 84 bc 02 00 00    	je     8368 <path_openat+0x428>
    80ac:	49 8b 06             	mov    (%r14),%rax
    80af:	48 8b 58 18          	mov    0x18(%rax),%rbx
    80b3:	f6 c1 40             	test   $0x40,%cl
    80b6:	0f 84 4a 02 00 00    	je     8306 <path_openat+0x3c6>
    80bc:	f6 c1 80             	test   $0x80,%cl
    80bf:	74 0e                	je     80cf <path_openat+0x18f>
    80c1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    80c5:	f6 40 06 10          	testb  $0x10,0x6(%rax)
    80c9:	0f 84 07 11 00 00    	je     91d6 <path_openat+0x1296>
    80cf:	49 8b 56 08          	mov    0x8(%r14),%rdx
    80d3:	8b 02                	mov    (%rdx),%eax
    80d5:	25 00 00 38 00       	and    $0x380000,%eax
    80da:	3d 00 00 10 00       	cmp    $0x100000,%eax
    80df:	0f 84 72 03 00 00    	je     8457 <path_openat+0x517>
    80e5:	3d 00 00 18 00       	cmp    $0x180000,%eax
    80ea:	0f 84 67 03 00 00    	je     8457 <path_openat+0x517>
    80f0:	45 0f b7 a6 ec 00 00 	movzwl 0xec(%r14),%r12d
    80f7:	00 
    80f8:	4c 8b 42 30          	mov    0x30(%rdx),%r8
    80fc:	45 8b 8e e8 00 00 00 	mov    0xe8(%r14),%r9d
    8103:	66 41 f7 c4 00 02    	test   $0x200,%r12w
    8109:	0f 85 2a 0f 00 00    	jne    9039 <path_openat+0x10f9>
    810f:	41 f6 46 38 02       	testb  $0x2,0x38(%r14)
    8114:	0f 84 1f 01 00 00    	je     8239 <path_openat+0x2f9>
    811a:	4c 89 f7             	mov    %r14,%rdi
    811d:	e8 de b1 ff ff       	call   3300 <terminate_walk>
    8122:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    8126:	e8 00 00 00 00       	call   812b <path_openat+0x1eb>
    812b:	48 c7 45 b0 ec ff ff 	movq   $0xffffffffffffffec,-0x50(%rbp)
    8132:	ff 
    8133:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    8137:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 813f <path_openat+0x1ff>
    813e:	00 
    813f:	0f 85 8c 10 00 00    	jne    91d1 <path_openat+0x1291>
    8145:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8149:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    814d:	5b                   	pop    %rbx
    814e:	41 5c                	pop    %r12
    8150:	41 5d                	pop    %r13
    8152:	41 5e                	pop    %r14
    8154:	41 5f                	pop    %r15
    8156:	5d                   	pop    %rbp
    8157:	31 d2                	xor    %edx,%edx
    8159:	31 c9                	xor    %ecx,%ecx
    815b:	31 f6                	xor    %esi,%esi
    815d:	31 ff                	xor    %edi,%edi
    815f:	45 31 c0             	xor    %r8d,%r8d
    8162:	45 31 c9             	xor    %r9d,%r9d
    8165:	45 31 d2             	xor    %r10d,%r10d
    8168:	45 31 db             	xor    %r11d,%r11d
    816b:	e9 00 00 00 00       	jmp    8170 <path_openat+0x230>
    8170:	84 d2                	test   %dl,%dl
    8172:	74 07                	je     817b <path_openat+0x23b>
    8174:	83 c8 03             	or     $0x3,%eax
    8177:	41 89 46 38          	mov    %eax,0x38(%r14)
    817b:	4c 89 f7             	mov    %r14,%rdi
    817e:	e8 6d a3 ff ff       	call   24f0 <lookup_fast>
    8183:	49 89 c2             	mov    %rax,%r10
    8186:	48 85 c0             	test   %rax,%rax
    8189:	0f 84 2f 04 00 00    	je     85be <path_openat+0x67e>
    818f:	49 81 fa 00 f0 ff ff 	cmp    $0xfffffffffffff000,%r10
    8196:	0f 87 1d fe ff ff    	ja     7fb9 <path_openat+0x79>
    819c:	41 8b 46 54          	mov    0x54(%r14),%eax
    81a0:	85 c0                	test   %eax,%eax
    81a2:	0f 84 c8 fe ff ff    	je     8070 <path_openat+0x130>
    81a8:	83 e8 01             	sub    $0x1,%eax
    81ab:	48 8d 1c 40          	lea    (%rax,%rax,2),%rbx
    81af:	41 89 46 54          	mov    %eax,0x54(%r14)
    81b3:	48 c1 e3 04          	shl    $0x4,%rbx
    81b7:	49 03 5e 60          	add    0x60(%r14),%rbx
    81bb:	48 8b 43 10          	mov    0x10(%rbx),%rax
    81bf:	48 85 c0             	test   %rax,%rax
    81c2:	74 11                	je     81d5 <path_openat+0x295>
    81c4:	4c 89 55 a8          	mov    %r10,-0x58(%rbp)
    81c8:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    81cc:	e8 00 00 00 00       	call   81d1 <path_openat+0x291>
    81d1:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    81d5:	41 f6 46 39 01       	testb  $0x1,0x39(%r14)
    81da:	0f 85 90 fe ff ff    	jne    8070 <path_openat+0x130>
    81e0:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    81e4:	4c 89 55 a8          	mov    %r10,-0x58(%rbp)
    81e8:	e8 00 00 00 00       	call   81ed <path_openat+0x2ad>
    81ed:	48 8b 3b             	mov    (%rbx),%rdi
    81f0:	e8 00 00 00 00       	call   81f5 <path_openat+0x2b5>
    81f5:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    81f9:	e9 72 fe ff ff       	jmp    8070 <path_openat+0x130>
    81fe:	83 ea 01             	sub    $0x1,%edx
    8201:	48 8d 1c 52          	lea    (%rdx,%rdx,2),%rbx
    8205:	41 89 56 54          	mov    %edx,0x54(%r14)
    8209:	48 c1 e3 04          	shl    $0x4,%rbx
    820d:	49 03 5e 60          	add    0x60(%r14),%rbx
    8211:	48 8b 53 10          	mov    0x10(%rbx),%rdx
    8215:	48 85 d2             	test   %rdx,%rdx
    8218:	74 0d                	je     8227 <path_openat+0x2e7>
    821a:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    821e:	e8 00 00 00 00       	call   8223 <path_openat+0x2e3>
    8223:	41 8b 46 38          	mov    0x38(%r14),%eax
    8227:	f6 c4 01             	test   $0x1,%ah
    822a:	0f 84 b3 00 00 00    	je     82e3 <path_openat+0x3a3>
    8230:	41 8b 76 50          	mov    0x50(%r14),%esi
    8234:	e9 bd fd ff ff       	jmp    7ff6 <path_openat+0xb6>
    8239:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    823d:	41 8b 57 08          	mov    0x8(%r15),%edx
    8241:	f6 40 06 10          	testb  $0x10,0x6(%rax)
    8245:	0f 84 d5 06 00 00    	je     8920 <path_openat+0x9e0>
    824b:	80 e5 fd             	and    $0xfd,%ch
    824e:	45 31 e4             	xor    %r12d,%r12d
    8251:	44 89 ea             	mov    %r13d,%edx
    8254:	4c 89 f6             	mov    %r14,%rsi
    8257:	48 89 df             	mov    %rbx,%rdi
    825a:	e8 41 9d ff ff       	call   1fa0 <may_open>
    825f:	41 89 c5             	mov    %eax,%r13d
    8262:	85 c0                	test   %eax,%eax
    8264:	75 25                	jne    828b <path_openat+0x34b>
    8266:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    826a:	f6 40 06 08          	testb  $0x8,0x6(%rax)
    826e:	0f 85 33 01 00 00    	jne    83a7 <path_openat+0x467>
    8274:	48 8b 75 b0          	mov    -0x50(%rbp),%rsi
    8278:	4c 89 f7             	mov    %r14,%rdi
    827b:	e8 00 00 00 00       	call   8280 <path_openat+0x340>
    8280:	41 89 c5             	mov    %eax,%r13d
    8283:	85 c0                	test   %eax,%eax
    8285:	0f 84 1c 01 00 00    	je     83a7 <path_openat+0x467>
    828b:	0f 8f 24 0c 00 00    	jg     8eb5 <path_openat+0xf75>
    8291:	45 84 e4             	test   %r12b,%r12b
    8294:	0f 85 3e 08 00 00    	jne    8ad8 <path_openat+0xb98>
    829a:	4c 89 f7             	mov    %r14,%rdi
    829d:	e8 5e b0 ff ff       	call   3300 <terminate_walk>
    82a2:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    82a6:	e8 00 00 00 00       	call   82ab <path_openat+0x36b>
    82ab:	41 81 fd fa fd ff ff 	cmp    $0xfffffdfa,%r13d
    82b2:	0f 85 14 08 00 00    	jne    8acc <path_openat+0xb8c>
    82b8:	8b 45 a4             	mov    -0x5c(%rbp),%eax
    82bb:	25 00 01 00 00       	and    $0x100,%eax
    82c0:	83 f8 01             	cmp    $0x1,%eax
    82c3:	48 19 c0             	sbb    %rax,%rax
    82c6:	48 83 e0 96          	and    $0xffffffffffffff96,%rax
    82ca:	48 83 e8 0a          	sub    $0xa,%rax
    82ce:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    82d2:	e9 5c fe ff ff       	jmp    8133 <path_openat+0x1f3>
    82d7:	49 c7 c2 eb ff ff ff 	mov    $0xffffffffffffffeb,%r10
    82de:	e9 d6 fc ff ff       	jmp    7fb9 <path_openat+0x79>
    82e3:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    82e7:	e8 00 00 00 00       	call   82ec <path_openat+0x3ac>
    82ec:	48 8b 3b             	mov    (%rbx),%rdi
    82ef:	e8 00 00 00 00       	call   82f4 <path_openat+0x3b4>
    82f4:	e9 37 ff ff ff       	jmp    8230 <path_openat+0x2f0>
    82f9:	41 81 66 38 ff ff f8 	andl   $0xfff8ffff,0x38(%r14)
    8300:	ff 
    8301:	e9 b3 fc ff ff       	jmp    7fb9 <path_openat+0x79>
    8306:	41 f6 46 38 02       	testb  $0x2,0x38(%r14)
    830b:	0f 84 28 ff ff ff    	je     8239 <path_openat+0x2f9>
    8311:	49 8b 46 08          	mov    0x8(%r14),%rax
    8315:	8b 00                	mov    (%rax),%eax
    8317:	25 00 00 38 00       	and    $0x380000,%eax
    831c:	3d 00 00 10 00       	cmp    $0x100000,%eax
    8321:	0f 85 f3 fd ff ff    	jne    811a <path_openat+0x1da>
    8327:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    832b:	41 8b 47 08          	mov    0x8(%r15),%eax
    832f:	f6 47 06 10          	testb  $0x10,0x6(%rdi)
    8333:	0f 85 12 ff ff ff    	jne    824b <path_openat+0x30b>
    8339:	41 89 c5             	mov    %eax,%r13d
    833c:	45 31 e4             	xor    %r12d,%r12d
    833f:	e9 0d ff ff ff       	jmp    8251 <path_openat+0x311>
    8344:	4c 89 f7             	mov    %r14,%rdi
    8347:	89 4d a8             	mov    %ecx,-0x58(%rbp)
    834a:	e8 d1 a2 ff ff       	call   2620 <complete_walk>
    834f:	89 c3                	mov    %eax,%ebx
    8351:	85 c0                	test   %eax,%eax
    8353:	0f 85 9c 0a 00 00    	jne    8df5 <path_openat+0xeb5>
    8359:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    835d:	8b 4d a8             	mov    -0x58(%rbp),%ecx
    8360:	8b 40 04             	mov    0x4(%rax),%eax
    8363:	e9 39 fd ff ff       	jmp    80a1 <path_openat+0x161>
    8368:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 8370 <path_openat+0x430>
    836f:	00 
    8370:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    8377:	48 85 c0             	test   %rax,%rax
    837a:	0f 84 2c fd ff ff    	je     80ac <path_openat+0x16c>
    8380:	8b 30                	mov    (%rax),%esi
    8382:	85 f6                	test   %esi,%esi
    8384:	0f 85 22 fd ff ff    	jne    80ac <path_openat+0x16c>
    838a:	49 8b 76 08          	mov    0x8(%r14),%rsi
    838e:	49 8b be c8 00 00 00 	mov    0xc8(%r14),%rdi
    8395:	31 d2                	xor    %edx,%edx
    8397:	89 4d a8             	mov    %ecx,-0x58(%rbp)
    839a:	e8 00 00 00 00       	call   839f <path_openat+0x45f>
    839f:	8b 4d a8             	mov    -0x58(%rbp),%ecx
    83a2:	e9 05 fd ff ff       	jmp    80ac <path_openat+0x16c>
    83a7:	41 8b 77 08          	mov    0x8(%r15),%esi
    83ab:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    83af:	e8 00 00 00 00       	call   83b4 <path_openat+0x474>
    83b4:	41 89 c5             	mov    %eax,%r13d
    83b7:	85 c0                	test   %eax,%eax
    83b9:	0f 85 2e 07 00 00    	jne    8aed <path_openat+0xbad>
    83bf:	45 84 e4             	test   %r12b,%r12b
    83c2:	0f 84 25 07 00 00    	je     8aed <path_openat+0xbad>
    83c8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    83cc:	48 8b 40 48          	mov    0x48(%rax),%rax
    83d0:	4c 8b 60 30          	mov    0x30(%rax),%r12
    83d4:	41 8b 84 24 58 01 00 	mov    0x158(%r12),%eax
    83db:	00 
    83dc:	85 c0                	test   %eax,%eax
    83de:	0f 88 d1 0d 00 00    	js     91b5 <path_openat+0x1275>
    83e4:	8d 50 01             	lea    0x1(%rax),%edx
    83e7:	f0 41 0f b1 94 24 58 	lock cmpxchg %edx,0x158(%r12)
    83ee:	01 00 00 
    83f1:	75 e9                	jne    83dc <path_openat+0x49c>
    83f3:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    83f7:	e8 00 00 00 00       	call   83fc <path_openat+0x4bc>
    83fc:	41 89 c5             	mov    %eax,%r13d
    83ff:	85 c0                	test   %eax,%eax
    8401:	0f 84 18 0b 00 00    	je     8f1f <path_openat+0xfdf>
    8407:	f0 41 ff 8c 24 58 01 	lock decl 0x158(%r12)
    840e:	00 00 
    8410:	45 85 ed             	test   %r13d,%r13d
    8413:	0f 8f f5 0b 00 00    	jg     900e <path_openat+0x10ce>
    8419:	49 8b 3e             	mov    (%r14),%rdi
    841c:	e8 00 00 00 00       	call   8421 <path_openat+0x4e1>
    8421:	4c 89 f7             	mov    %r14,%rdi
    8424:	e8 d7 ae ff ff       	call   3300 <terminate_walk>
    8429:	45 85 ed             	test   %r13d,%r13d
    842c:	0f 85 70 fe ff ff    	jne    82a2 <path_openat+0x362>
    8432:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8436:	f6 40 06 08          	testb  $0x8,0x6(%rax)
    843a:	0f 85 f3 fc ff ff    	jne    8133 <path_openat+0x1f3>
    8440:	0f 0b                	ud2
    8442:	48 89 c7             	mov    %rax,%rdi
    8445:	e8 00 00 00 00       	call   844a <path_openat+0x50a>
    844a:	48 c7 45 b0 ea ff ff 	movq   $0xffffffffffffffea,-0x50(%rbp)
    8451:	ff 
    8452:	e9 dc fc ff ff       	jmp    8133 <path_openat+0x1f3>
    8457:	4c 89 f7             	mov    %r14,%rdi
    845a:	e8 a1 ae ff ff       	call   3300 <terminate_walk>
    845f:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    8463:	e8 00 00 00 00       	call   8468 <path_openat+0x528>
    8468:	48 c7 45 b0 eb ff ff 	movq   $0xffffffffffffffeb,-0x50(%rbp)
    846f:	ff 
    8470:	e9 be fc ff ff       	jmp    8133 <path_openat+0x1f3>
    8475:	41 f6 46 39 01       	testb  $0x1,0x39(%r14)
    847a:	0f 84 72 02 00 00    	je     86f2 <path_openat+0x7b2>
    8480:	4c 89 f7             	mov    %r14,%rdi
    8483:	e8 78 9f ff ff       	call   2400 <try_to_unlazy>
    8488:	84 c0                	test   %al,%al
    848a:	0f 84 56 07 00 00    	je     8be6 <path_openat+0xca6>
    8490:	41 81 e4 43 02 00 00 	and    $0x243,%r12d
    8497:	0f 85 7a 06 00 00    	jne    8b17 <path_openat+0xbd7>
    849d:	c6 45 a0 00          	movb   $0x0,-0x60(%rbp)
    84a1:	48 8b 43 30          	mov    0x30(%rbx),%rax
    84a5:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    84ac:	e8 00 00 00 00       	call   84b1 <path_openat+0x571>
    84b1:	4d 8b 46 08          	mov    0x8(%r14),%r8
    84b5:	41 0f b7 47 04       	movzwl 0x4(%r15),%eax
    84ba:	45 8b 27             	mov    (%r15),%r12d
    84bd:	49 8b 48 30          	mov    0x30(%r8),%rcx
    84c1:	66 89 45 90          	mov    %ax,-0x70(%rbp)
    84c5:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
    84c9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    84cd:	48 89 4d 88          	mov    %rcx,-0x78(%rbp)
    84d1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    84d5:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
    84dc:	00 
    84dd:	f6 41 0c 10          	testb  $0x10,0xc(%rcx)
    84e1:	0f 85 6b 09 00 00    	jne    8e52 <path_openat+0xf12>
    84e7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    84eb:	4c 89 c7             	mov    %r8,%rdi
    84ee:	4c 89 45 98          	mov    %r8,-0x68(%rbp)
    84f2:	81 60 04 ff ff ef ff 	andl   $0xffefffff,0x4(%rax)
    84f9:	49 8d 46 10          	lea    0x10(%r14),%rax
    84fd:	48 89 c6             	mov    %rax,%rsi
    8500:	48 89 45 80          	mov    %rax,-0x80(%rbp)
    8504:	e8 00 00 00 00       	call   8509 <path_openat+0x5c9>
    8509:	4c 8b 45 98          	mov    -0x68(%rbp),%r8
    850d:	48 85 c0             	test   %rax,%rax
    8510:	49 89 c2             	mov    %rax,%r10
    8513:	0f 84 4a 05 00 00    	je     8a63 <path_openat+0xb23>
    8519:	41 8b 02             	mov    (%r10),%eax
    851c:	a9 00 00 00 01       	test   $0x1000000,%eax
    8521:	75 0c                	jne    852f <path_openat+0x5ef>
    8523:	41 8b 4e 38          	mov    0x38(%r14),%ecx
    8527:	a8 04                	test   $0x4,%al
    8529:	0f 85 e1 04 00 00    	jne    8a10 <path_openat+0xad0>
    852f:	49 83 7a 30 00       	cmpq   $0x0,0x30(%r10)
    8534:	0f 84 b5 00 00 00    	je     85ef <path_openat+0x6af>
    853a:	49 81 fa 00 f0 ff ff 	cmp    $0xfffffffffffff000,%r10
    8541:	0f 87 43 05 00 00    	ja     8a8a <path_openat+0xb4a>
    8547:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    854b:	8b 40 04             	mov    0x4(%rax),%eax
    854e:	a9 00 00 10 00       	test   $0x100000,%eax
    8553:	0f 85 b2 02 00 00    	jne    880b <path_openat+0x8cb>
    8559:	a9 00 00 08 00       	test   $0x80000,%eax
    855e:	0f 85 f3 02 00 00    	jne    8857 <path_openat+0x917>
    8564:	44 8b 45 a8          	mov    -0x58(%rbp),%r8d
    8568:	48 8b 43 30          	mov    0x30(%rbx),%rax
    856c:	4c 89 55 a8          	mov    %r10,-0x58(%rbp)
    8570:	45 85 c0             	test   %r8d,%r8d
    8573:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    857a:	0f 84 4a 01 00 00    	je     86ca <path_openat+0x78a>
    8580:	e8 00 00 00 00       	call   8585 <path_openat+0x645>
    8585:	80 7d a0 00          	cmpb   $0x0,-0x60(%rbp)
    8589:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    858d:	0f 85 4a 01 00 00    	jne    86dd <path_openat+0x79d>
    8593:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8597:	f7 40 04 00 00 18 00 	testl  $0x180000,0x4(%rax)
    859e:	0f 84 c0 fa ff ff    	je     8064 <path_openat+0x124>
    85a4:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    85a8:	4c 89 55 a8          	mov    %r10,-0x58(%rbp)
    85ac:	e8 00 00 00 00       	call   85b1 <path_openat+0x671>
    85b1:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    85b5:	4d 89 56 08          	mov    %r10,0x8(%r14)
    85b9:	e9 ce fa ff ff       	jmp    808c <path_openat+0x14c>
    85be:	41 f6 46 39 01       	testb  $0x1,0x39(%r14)
    85c3:	0f 85 1b 06 00 00    	jne    8be4 <path_openat+0xca4>
    85c9:	41 81 e4 43 02 00 00 	and    $0x243,%r12d
    85d0:	0f 85 2e 05 00 00    	jne    8b04 <path_openat+0xbc4>
    85d6:	c6 45 a0 00          	movb   $0x0,-0x60(%rbp)
    85da:	48 8b 43 30          	mov    0x30(%rbx),%rax
    85de:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    85e5:	e8 00 00 00 00       	call   85ea <path_openat+0x6aa>
    85ea:	e9 c2 fe ff ff       	jmp    84b1 <path_openat+0x571>
    85ef:	45 89 e1             	mov    %r12d,%r9d
    85f2:	41 83 e1 40          	and    $0x40,%r9d
    85f6:	0f 85 f6 05 00 00    	jne    8bf2 <path_openat+0xcb2>
    85fc:	80 7d a0 00          	cmpb   $0x0,-0x60(%rbp)
    8600:	49 8b 06             	mov    (%r14),%rax
    8603:	0f 84 35 09 00 00    	je     8f3e <path_openat+0xffe>
    8609:	48 8b 40 18          	mov    0x18(%rax),%rax
    860d:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    8611:	48 8b 45 88          	mov    -0x78(%rbp),%rax
    8615:	48 8b 40 20          	mov    0x20(%rax),%rax
    8619:	48 83 b8 90 00 00 00 	cmpq   $0x0,0x90(%rax)
    8620:	00 
    8621:	0f 85 03 05 00 00    	jne    8b2a <path_openat+0xbea>
    8627:	41 f7 02 00 00 00 01 	testl  $0x1000000,(%r10)
    862e:	74 65                	je     8695 <path_openat+0x755>
    8630:	4c 89 d6             	mov    %r10,%rsi
    8633:	41 8b 56 38          	mov    0x38(%r14),%edx
    8637:	48 8b 00             	mov    (%rax),%rax
    863a:	4c 89 55 80          	mov    %r10,-0x80(%rbp)
    863e:	44 89 8d 78 ff ff ff 	mov    %r9d,-0x88(%rbp)
    8645:	48 8b 7d 88          	mov    -0x78(%rbp),%rdi
    8649:	e8 00 00 00 00       	call   864e <path_openat+0x70e>
    864e:	4c 8b 55 80          	mov    -0x80(%rbp),%r10
    8652:	44 8b 8d 78 ff ff ff 	mov    -0x88(%rbp),%r9d
    8659:	41 f7 02 00 00 00 01 	testl  $0x1000000,(%r10)
    8660:	0f 85 9e 0a 00 00    	jne    9104 <path_openat+0x11c4>
    8666:	48 85 c0             	test   %rax,%rax
    8669:	74 2a                	je     8695 <path_openat+0x755>
    866b:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    8671:	0f 87 dc 0b 00 00    	ja     9253 <path_openat+0x1313>
    8677:	4c 89 d7             	mov    %r10,%rdi
    867a:	44 89 4d 80          	mov    %r9d,-0x80(%rbp)
    867e:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    8685:	e8 00 00 00 00       	call   868a <path_openat+0x74a>
    868a:	4c 8b 95 78 ff ff ff 	mov    -0x88(%rbp),%r10
    8691:	44 8b 4d 80          	mov    -0x80(%rbp),%r9d
    8695:	49 83 7a 30 00       	cmpq   $0x0,0x30(%r10)
    869a:	0f 85 9a fe ff ff    	jne    853a <path_openat+0x5fa>
    86a0:	41 f6 c4 40          	test   $0x40,%r12b
    86a4:	0f 85 a8 08 00 00    	jne    8f52 <path_openat+0x1012>
    86aa:	45 85 c9             	test   %r9d,%r9d
    86ad:	0f 84 87 fe ff ff    	je     853a <path_openat+0x5fa>
    86b3:	44 89 c8             	mov    %r9d,%eax
    86b6:	4c 89 d7             	mov    %r10,%rdi
    86b9:	89 45 98             	mov    %eax,-0x68(%rbp)
    86bc:	e8 00 00 00 00       	call   86c1 <path_openat+0x781>
    86c1:	4c 63 55 98          	movslq -0x68(%rbp),%r10
    86c5:	e9 70 fe ff ff       	jmp    853a <path_openat+0x5fa>
    86ca:	e8 00 00 00 00       	call   86cf <path_openat+0x78f>
    86cf:	80 7d a0 00          	cmpb   $0x0,-0x60(%rbp)
    86d3:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    86d7:	0f 84 b6 fe ff ff    	je     8593 <path_openat+0x653>
    86dd:	49 8b 3e             	mov    (%r14),%rdi
    86e0:	4c 89 55 a8          	mov    %r10,-0x58(%rbp)
    86e4:	e8 00 00 00 00       	call   86e9 <path_openat+0x7a9>
    86e9:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    86ed:	e9 a1 fe ff ff       	jmp    8593 <path_openat+0x653>
    86f2:	4c 89 d7             	mov    %r10,%rdi
    86f5:	e8 00 00 00 00       	call   86fa <path_openat+0x7ba>
    86fa:	41 8b 46 38          	mov    0x38(%r14),%eax
    86fe:	f6 c4 01             	test   $0x1,%ah
    8701:	0f 84 89 fd ff ff    	je     8490 <path_openat+0x550>
    8707:	e9 74 fd ff ff       	jmp    8480 <path_openat+0x540>
    870c:	8b 75 a4             	mov    -0x5c(%rbp),%esi
    870f:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
    8713:	4c 89 f7             	mov    %r14,%rdi
    8716:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
    871d:	00 
    871e:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    8725:	00 
    8726:	83 ce 02             	or     $0x2,%esi
    8729:	e8 82 e7 ff ff       	call   6eb0 <path_lookupat>
    872e:	41 89 c5             	mov    %eax,%r13d
    8731:	85 c0                	test   %eax,%eax
    8733:	0f 85 69 fb ff ff    	jne    82a2 <path_openat+0x362>
    8739:	48 8b 5d b8          	mov    -0x48(%rbp),%rbx
    873d:	48 89 df             	mov    %rbx,%rdi
    8740:	e8 00 00 00 00       	call   8745 <path_openat+0x805>
    8745:	4c 8b 65 c0          	mov    -0x40(%rbp),%r12
    8749:	41 89 c5             	mov    %eax,%r13d
    874c:	85 c0                	test   %eax,%eax
    874e:	75 29                	jne    8779 <path_openat+0x839>
    8750:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    8754:	41 0f b7 4f 04       	movzwl 0x4(%r15),%ecx
    8759:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    875d:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
    8761:	e8 00 00 00 00       	call   8766 <path_openat+0x826>
    8766:	41 89 c5             	mov    %eax,%r13d
    8769:	85 c0                	test   %eax,%eax
    876b:	0f 84 01 02 00 00    	je     8972 <path_openat+0xa32>
    8771:	48 89 df             	mov    %rbx,%rdi
    8774:	e8 00 00 00 00       	call   8779 <path_openat+0x839>
    8779:	4c 89 e7             	mov    %r12,%rdi
    877c:	e8 00 00 00 00       	call   8781 <path_openat+0x841>
    8781:	48 89 df             	mov    %rbx,%rdi
    8784:	e8 00 00 00 00       	call   8789 <path_openat+0x849>
    8789:	e9 14 fb ff ff       	jmp    82a2 <path_openat+0x362>
    878e:	8b 75 a4             	mov    -0x5c(%rbp),%esi
    8791:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
    8795:	4c 89 f7             	mov    %r14,%rdi
    8798:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
    879f:	00 
    87a0:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    87a7:	00 
    87a8:	e8 03 e7 ff ff       	call   6eb0 <path_lookupat>
    87ad:	41 89 c5             	mov    %eax,%r13d
    87b0:	85 c0                	test   %eax,%eax
    87b2:	0f 85 ea fa ff ff    	jne    82a2 <path_openat+0x362>
    87b8:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 87c0 <path_openat+0x880>
    87bf:	00 
    87c0:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    87c7:	48 85 c0             	test   %rax,%rax
    87ca:	74 18                	je     87e4 <path_openat+0x8a4>
    87cc:	8b 00                	mov    (%rax),%eax
    87ce:	85 c0                	test   %eax,%eax
    87d0:	75 12                	jne    87e4 <path_openat+0x8a4>
    87d2:	49 8b be c8 00 00 00 	mov    0xc8(%r14),%rdi
    87d9:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
    87dd:	31 d2                	xor    %edx,%edx
    87df:	e8 00 00 00 00       	call   87e4 <path_openat+0x8a4>
    87e4:	48 8b 75 b0          	mov    -0x50(%rbp),%rsi
    87e8:	48 8d 7d b8          	lea    -0x48(%rbp),%rdi
    87ec:	e8 00 00 00 00       	call   87f1 <path_openat+0x8b1>
    87f1:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    87f5:	41 89 c5             	mov    %eax,%r13d
    87f8:	e8 00 00 00 00       	call   87fd <path_openat+0x8bd>
    87fd:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    8801:	e8 00 00 00 00       	call   8806 <path_openat+0x8c6>
    8806:	e9 1e fc ff ff       	jmp    8429 <path_openat+0x4e9>
    880b:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 8813 <path_openat+0x8d3>
    8812:	00 
    8813:	4c 8b 63 30          	mov    0x30(%rbx),%r12
    8817:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    881e:	48 85 c0             	test   %rax,%rax
    8821:	74 0a                	je     882d <path_openat+0x8ed>
    8823:	8b 00                	mov    (%rax),%eax
    8825:	85 c0                	test   %eax,%eax
    8827:	0f 84 c6 01 00 00    	je     89f3 <path_openat+0xab3>
    882d:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    8832:	48 8b 80 c0 03 00 00 	mov    0x3c0(%rax),%rax
    8839:	48 85 c0             	test   %rax,%rax
    883c:	74 0d                	je     884b <path_openat+0x90b>
    883e:	48 8b 40 08          	mov    0x8(%rax),%rax
    8842:	48 85 c0             	test   %rax,%rax
    8845:	0f 85 74 01 00 00    	jne    89bf <path_openat+0xa7f>
    884b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    884f:	8b 40 04             	mov    0x4(%rax),%eax
    8852:	e9 02 fd ff ff       	jmp    8559 <path_openat+0x619>
    8857:	48 8b 4d b0          	mov    -0x50(%rbp),%rcx
    885b:	8b 79 28             	mov    0x28(%rcx),%edi
    885e:	89 fa                	mov    %edi,%edx
    8860:	89 7d 98             	mov    %edi,-0x68(%rbp)
    8863:	83 e2 20             	and    $0x20,%edx
    8866:	83 fa 01             	cmp    $0x1,%edx
    8869:	19 ff                	sbb    %edi,%edi
    886b:	25 00 00 00 06       	and    $0x6000000,%eax
    8870:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    8876:	81 c7 20 10 00 00    	add    $0x1020,%edi
    887c:	3d 00 00 00 02       	cmp    $0x2000000,%eax
    8881:	0f 84 dd fc ff ff    	je     8564 <path_openat+0x624>
    8887:	48 8b 41 48          	mov    0x48(%rcx),%rax
    888b:	4c 8b 48 30          	mov    0x30(%rax),%r9
    888f:	49 8b 51 28          	mov    0x28(%r9),%rdx
    8893:	48 8b 92 c0 03 00 00 	mov    0x3c0(%rdx),%rdx
    889a:	48 85 d2             	test   %rdx,%rdx
    889d:	0f 84 c1 fc ff ff    	je     8564 <path_openat+0x624>
    88a3:	48 8b 52 08          	mov    0x8(%rdx),%rdx
    88a7:	48 85 d2             	test   %rdx,%rdx
    88aa:	0f 84 b4 fc ff ff    	je     8564 <path_openat+0x624>
    88b0:	41 0f b7 11          	movzwl (%r9),%edx
    88b4:	48 8d 71 40          	lea    0x40(%rcx),%rsi
    88b8:	66 81 e2 00 f0       	and    $0xf000,%dx
    88bd:	66 81 fa 00 40       	cmp    $0x4000,%dx
    88c2:	0f 84 0e 06 00 00    	je     8ed6 <path_openat+0xf96>
    88c8:	48 3b 40 18          	cmp    0x18(%rax),%rax
    88cc:	0f 84 16 06 00 00    	je     8ee8 <path_openat+0xfa8>
    88d2:	48 89 f2             	mov    %rsi,%rdx
    88d5:	b9 02 00 00 00       	mov    $0x2,%ecx
    88da:	89 fe                	mov    %edi,%esi
    88dc:	48 89 c7             	mov    %rax,%rdi
    88df:	4c 89 55 98          	mov    %r10,-0x68(%rbp)
    88e3:	e8 00 00 00 00       	call   88e8 <path_openat+0x9a8>
    88e8:	44 8b 4d a8          	mov    -0x58(%rbp),%r9d
    88ec:	4c 8b 55 98          	mov    -0x68(%rbp),%r10
    88f0:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    88f4:	45 85 c9             	test   %r9d,%r9d
    88f7:	4c 89 55 a8          	mov    %r10,-0x58(%rbp)
    88fb:	0f 84 7d 05 00 00    	je     8e7e <path_openat+0xf3e>
    8901:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    8908:	e8 00 00 00 00       	call   890d <path_openat+0x9cd>
    890d:	80 7d a0 00          	cmpb   $0x0,-0x60(%rbp)
    8911:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    8915:	0f 84 78 fc ff ff    	je     8593 <path_openat+0x653>
    891b:	e9 bd fd ff ff       	jmp    86dd <path_openat+0x79d>
    8920:	49 8b 46 08          	mov    0x8(%r14),%rax
    8924:	41 89 d5             	mov    %edx,%r13d
    8927:	45 31 e4             	xor    %r12d,%r12d
    892a:	8b 00                	mov    (%rax),%eax
    892c:	25 00 00 38 00       	and    $0x380000,%eax
    8931:	3d 00 00 20 00       	cmp    $0x200000,%eax
    8936:	0f 85 15 f9 ff ff    	jne    8251 <path_openat+0x311>
    893c:	f6 c5 02             	test   $0x2,%ch
    893f:	0f 84 0c f9 ff ff    	je     8251 <path_openat+0x311>
    8945:	49 8b 3e             	mov    (%r14),%rdi
    8948:	89 55 a0             	mov    %edx,-0x60(%rbp)
    894b:	89 4d a8             	mov    %ecx,-0x58(%rbp)
    894e:	e8 00 00 00 00       	call   8953 <path_openat+0xa13>
    8953:	8b 4d a8             	mov    -0x58(%rbp),%ecx
    8956:	8b 55 a0             	mov    -0x60(%rbp),%edx
    8959:	85 c0                	test   %eax,%eax
    895b:	41 89 c5             	mov    %eax,%r13d
    895e:	0f 85 36 f9 ff ff    	jne    829a <path_openat+0x35a>
    8964:	41 89 d5             	mov    %edx,%r13d
    8967:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    896d:	e9 df f8 ff ff       	jmp    8251 <path_openat+0x311>
    8972:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 897a <path_openat+0xa3a>
    8979:	00 
    897a:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    8981:	48 85 c0             	test   %rax,%rax
    8984:	74 1c                	je     89a2 <path_openat+0xa62>
    8986:	8b 00                	mov    (%rax),%eax
    8988:	85 c0                	test   %eax,%eax
    898a:	75 16                	jne    89a2 <path_openat+0xa62>
    898c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8990:	49 8b be c8 00 00 00 	mov    0xc8(%r14),%rdi
    8997:	31 d2                	xor    %edx,%edx
    8999:	48 8b 70 48          	mov    0x48(%rax),%rsi
    899d:	e8 00 00 00 00       	call   89a2 <path_openat+0xa62>
    89a2:	48 89 df             	mov    %rbx,%rdi
    89a5:	e8 00 00 00 00       	call   89aa <path_openat+0xa6a>
    89aa:	4c 89 e7             	mov    %r12,%rdi
    89ad:	e8 00 00 00 00       	call   89b2 <path_openat+0xa72>
    89b2:	48 89 df             	mov    %rbx,%rdi
    89b5:	e8 00 00 00 00       	call   89ba <path_openat+0xa7a>
    89ba:	e9 73 fa ff ff       	jmp    8432 <path_openat+0x4f2>
    89bf:	6a 00                	push   $0x0
    89c1:	4d 8d 42 20          	lea    0x20(%r10),%r8
    89c5:	4c 89 d6             	mov    %r10,%rsi
    89c8:	45 31 c9             	xor    %r9d,%r9d
    89cb:	4c 89 e1             	mov    %r12,%rcx
    89ce:	ba 04 00 00 00       	mov    $0x4,%edx
    89d3:	bf 00 01 00 00       	mov    $0x100,%edi
    89d8:	4c 89 55 98          	mov    %r10,-0x68(%rbp)
    89dc:	e8 00 00 00 00       	call   89e1 <path_openat+0xaa1>
    89e1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    89e5:	4c 8b 55 98          	mov    -0x68(%rbp),%r10
    89e9:	41 5b                	pop    %r11
    89eb:	8b 40 04             	mov    0x4(%rax),%eax
    89ee:	e9 66 fb ff ff       	jmp    8559 <path_openat+0x619>
    89f3:	4c 89 d6             	mov    %r10,%rsi
    89f6:	ba 04 00 00 00       	mov    $0x4,%edx
    89fb:	4c 89 e7             	mov    %r12,%rdi
    89fe:	4c 89 55 98          	mov    %r10,-0x68(%rbp)
    8a02:	e8 00 00 00 00       	call   8a07 <path_openat+0xac7>
    8a07:	4c 8b 55 98          	mov    -0x68(%rbp),%r10
    8a0b:	e9 1d fe ff ff       	jmp    882d <path_openat+0x8ed>
    8a10:	49 8b 42 60          	mov    0x60(%r10),%rax
    8a14:	4c 89 d2             	mov    %r10,%rdx
    8a17:	48 8b 75 80          	mov    -0x80(%rbp),%rsi
    8a1b:	4c 89 55 98          	mov    %r10,-0x68(%rbp)
    8a1f:	4c 89 85 78 ff ff ff 	mov    %r8,-0x88(%rbp)
    8a26:	48 8b 7d 88          	mov    -0x78(%rbp),%rdi
    8a2a:	48 8b 00             	mov    (%rax),%rax
    8a2d:	e8 00 00 00 00       	call   8a32 <path_openat+0xaf2>
    8a32:	4c 8b 55 98          	mov    -0x68(%rbp),%r10
    8a36:	4c 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%r8
    8a3d:	85 c0                	test   %eax,%eax
    8a3f:	0f 8f ea fa ff ff    	jg     852f <path_openat+0x5ef>
    8a45:	0f 85 6b fc ff ff    	jne    86b6 <path_openat+0x776>
    8a4b:	4c 89 d7             	mov    %r10,%rdi
    8a4e:	e8 00 00 00 00       	call   8a53 <path_openat+0xb13>
    8a53:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
    8a57:	e8 00 00 00 00       	call   8a5c <path_openat+0xb1c>
    8a5c:	4c 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%r8
    8a63:	48 8b 75 80          	mov    -0x80(%rbp),%rsi
    8a67:	4c 89 c7             	mov    %r8,%rdi
    8a6a:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
    8a6e:	4c 89 45 98          	mov    %r8,-0x68(%rbp)
    8a72:	e8 00 00 00 00       	call   8a77 <path_openat+0xb37>
    8a77:	4c 8b 45 98          	mov    -0x68(%rbp),%r8
    8a7b:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    8a81:	49 89 c2             	mov    %rax,%r10
    8a84:	0f 86 8f fa ff ff    	jbe    8519 <path_openat+0x5d9>
    8a8a:	8b 7d a8             	mov    -0x58(%rbp),%edi
    8a8d:	48 8b 43 30          	mov    0x30(%rbx),%rax
    8a91:	4c 89 55 a8          	mov    %r10,-0x58(%rbp)
    8a95:	85 ff                	test   %edi,%edi
    8a97:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    8a9e:	0f 84 c2 03 00 00    	je     8e66 <path_openat+0xf26>
    8aa4:	e8 00 00 00 00       	call   8aa9 <path_openat+0xb69>
    8aa9:	80 7d a0 00          	cmpb   $0x0,-0x60(%rbp)
    8aad:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    8ab1:	0f 84 02 f5 ff ff    	je     7fb9 <path_openat+0x79>
    8ab7:	49 8b 3e             	mov    (%r14),%rdi
    8aba:	4c 89 55 a8          	mov    %r10,-0x58(%rbp)
    8abe:	e8 00 00 00 00       	call   8ac3 <path_openat+0xb83>
    8ac3:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    8ac7:	e9 ed f4 ff ff       	jmp    7fb9 <path_openat+0x79>
    8acc:	49 63 c5             	movslq %r13d,%rax
    8acf:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    8ad3:	e9 5b f6 ff ff       	jmp    8133 <path_openat+0x1f3>
    8ad8:	49 8b 3e             	mov    (%r14),%rdi
    8adb:	e8 00 00 00 00       	call   8ae0 <path_openat+0xba0>
    8ae0:	4c 89 f7             	mov    %r14,%rdi
    8ae3:	e8 18 a8 ff ff       	call   3300 <terminate_walk>
    8ae8:	e9 b5 f7 ff ff       	jmp    82a2 <path_openat+0x362>
    8aed:	45 85 ed             	test   %r13d,%r13d
    8af0:	0f 8f bf 03 00 00    	jg     8eb5 <path_openat+0xf75>
    8af6:	45 84 e4             	test   %r12b,%r12b
    8af9:	0f 84 22 f9 ff ff    	je     8421 <path_openat+0x4e1>
    8aff:	e9 15 f9 ff ff       	jmp    8419 <path_openat+0x4d9>
    8b04:	49 8b 3e             	mov    (%r14),%rdi
    8b07:	e8 00 00 00 00       	call   8b0c <path_openat+0xbcc>
    8b0c:	85 c0                	test   %eax,%eax
    8b0e:	0f 94 45 a0          	sete   -0x60(%rbp)
    8b12:	e9 c3 fa ff ff       	jmp    85da <path_openat+0x69a>
    8b17:	49 8b 3e             	mov    (%r14),%rdi
    8b1a:	e8 00 00 00 00       	call   8b1f <path_openat+0xbdf>
    8b1f:	85 c0                	test   %eax,%eax
    8b21:	0f 94 45 a0          	sete   -0x60(%rbp)
    8b25:	e9 77 f9 ff ff       	jmp    84a1 <path_openat+0x561>
    8b2a:	49 8b 46 08          	mov    0x8(%r14),%rax
    8b2e:	48 8b 75 b0          	mov    -0x50(%rbp),%rsi
    8b32:	44 89 4d 88          	mov    %r9d,-0x78(%rbp)
    8b36:	4c 89 55 98          	mov    %r10,-0x68(%rbp)
    8b3a:	44 0f b7 45 90       	movzwl -0x70(%rbp),%r8d
    8b3f:	48 8b 78 30          	mov    0x30(%rax),%rdi
    8b43:	44 89 e0             	mov    %r12d,%eax
    8b46:	0d 00 00 01 00       	or     $0x10000,%eax
    8b4b:	41 f6 46 38 02       	testb  $0x2,0x38(%r14)
    8b50:	48 c7 46 48 ff ff ff 	movq   $0xffffffffffffffff,0x48(%rsi)
    8b57:	ff 
    8b58:	44 0f 45 e0          	cmovne %eax,%r12d
    8b5c:	49 8b 06             	mov    (%r14),%rax
    8b5f:	44 89 e2             	mov    %r12d,%edx
    8b62:	48 89 46 40          	mov    %rax,0x40(%rsi)
    8b66:	48 8b 47 20          	mov    0x20(%rdi),%rax
    8b6a:	f7 d2                	not    %edx
    8b6c:	83 e2 03             	and    $0x3,%edx
    8b6f:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
    8b76:	0f 94 c2             	sete   %dl
    8b79:	0f b6 d2             	movzbl %dl,%edx
    8b7c:	41 29 d4             	sub    %edx,%r12d
    8b7f:	48 89 f2             	mov    %rsi,%rdx
    8b82:	4c 89 d6             	mov    %r10,%rsi
    8b85:	44 89 e1             	mov    %r12d,%ecx
    8b88:	e8 00 00 00 00       	call   8b8d <path_openat+0xc4d>
    8b8d:	4c 8b 55 98          	mov    -0x68(%rbp),%r10
    8b91:	44 8b 4d 88          	mov    -0x78(%rbp),%r9d
    8b95:	41 89 c4             	mov    %eax,%r12d
    8b98:	41 f7 02 00 00 00 01 	testl  $0x1000000,(%r10)
    8b9f:	0f 85 46 05 00 00    	jne    90eb <path_openat+0x11ab>
    8ba5:	45 85 e4             	test   %r12d,%r12d
    8ba8:	0f 85 ef 02 00 00    	jne    8e9d <path_openat+0xf5d>
    8bae:	48 8b 4d b0          	mov    -0x50(%rbp),%rcx
    8bb2:	48 8b 41 48          	mov    0x48(%rcx),%rax
    8bb6:	f6 41 06 08          	testb  $0x8,0x6(%rcx)
    8bba:	0f 84 45 02 00 00    	je     8e05 <path_openat+0xec5>
    8bc0:	4c 39 d0             	cmp    %r10,%rax
    8bc3:	0f 85 89 05 00 00    	jne    9152 <path_openat+0x1212>
    8bc9:	49 83 fa fe          	cmp    $0xfffffffffffffffe,%r10
    8bcd:	0f 85 67 f9 ff ff    	jne    853a <path_openat+0x5fa>
    8bd3:	45 85 c9             	test   %r9d,%r9d
    8bd6:	0f 84 5e f9 ff ff    	je     853a <path_openat+0x5fa>
    8bdc:	4d 63 d1             	movslq %r9d,%r10
    8bdf:	e9 56 f9 ff ff       	jmp    853a <path_openat+0x5fa>
    8be4:	0f 0b                	ud2
    8be6:	49 c7 c2 f6 ff ff ff 	mov    $0xfffffffffffffff6,%r10
    8bed:	e9 c7 f3 ff ff       	jmp    7fb9 <path_openat+0x79>
    8bf2:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 8bfa <path_openat+0xcba>
    8bf9:	00 
    8bfa:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    8c01:	48 85 c0             	test   %rax,%rax
    8c04:	74 2a                	je     8c30 <path_openat+0xcf0>
    8c06:	8b 00                	mov    (%rax),%eax
    8c08:	85 c0                	test   %eax,%eax
    8c0a:	75 24                	jne    8c30 <path_openat+0xcf0>
    8c0c:	49 8b be c8 00 00 00 	mov    0xc8(%r14),%rdi
    8c13:	4c 89 c6             	mov    %r8,%rsi
    8c16:	ba 01 00 00 00       	mov    $0x1,%edx
    8c1b:	4c 89 55 80          	mov    %r10,-0x80(%rbp)
    8c1f:	4c 89 45 98          	mov    %r8,-0x68(%rbp)
    8c23:	e8 00 00 00 00       	call   8c28 <path_openat+0xce8>
    8c28:	4c 8b 55 80          	mov    -0x80(%rbp),%r10
    8c2c:	4c 8b 45 98          	mov    -0x68(%rbp),%r8
    8c30:	80 7d a0 00          	cmpb   $0x0,-0x60(%rbp)
    8c34:	49 8b 06             	mov    (%r14),%rax
    8c37:	0f 84 ed 04 00 00    	je     912a <path_openat+0x11ea>
    8c3d:	48 8b 40 18          	mov    0x18(%rax),%rax
    8c41:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    8c45:	49 8b 48 30          	mov    0x30(%r8),%rcx
    8c49:	0f b7 55 90          	movzwl -0x70(%rbp),%edx
    8c4d:	44 89 e0             	mov    %r12d,%eax
    8c50:	4c 89 95 78 ff ff ff 	mov    %r10,-0x88(%rbp)
    8c57:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
    8c5b:	80 e4 fd             	and    $0xfd,%ah
    8c5e:	41 f6 c4 80          	test   $0x80,%r12b
    8c62:	48 89 ce             	mov    %rcx,%rsi
    8c65:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    8c69:	44 0f 45 e0          	cmovne %eax,%r12d
    8c6d:	e8 00 00 00 00       	call   8c72 <path_openat+0xd32>
    8c72:	48 8b 4d 80          	mov    -0x80(%rbp),%rcx
    8c76:	4c 8b 95 78 ff ff ff 	mov    -0x88(%rbp),%r10
    8c7d:	89 c2                	mov    %eax,%edx
    8c7f:	48 8b 41 28          	mov    0x28(%rcx),%rax
    8c83:	f6 40 52 01          	testb  $0x1,0x52(%rax)
    8c87:	75 0a                	jne    8c93 <path_openat+0xd53>
    8c89:	f6 40 59 10          	testb  $0x10,0x59(%rax)
    8c8d:	0f 84 71 02 00 00    	je     8f04 <path_openat+0xfc4>
    8c93:	0f b7 45 90          	movzwl -0x70(%rbp),%eax
    8c97:	21 c2                	and    %eax,%edx
    8c99:	66 25 00 f0          	and    $0xf000,%ax
    8c9d:	66 81 e2 ff 0f       	and    $0xfff,%dx
    8ca2:	09 c2                	or     %eax,%edx
    8ca4:	80 7d a0 00          	cmpb   $0x0,-0x60(%rbp)
    8ca8:	66 89 55 90          	mov    %dx,-0x70(%rbp)
    8cac:	0f 84 51 03 00 00    	je     9003 <path_openat+0x10c3>
    8cb2:	0f b7 c2             	movzwl %dx,%eax
    8cb5:	31 c9                	xor    %ecx,%ecx
    8cb7:	4c 89 d6             	mov    %r10,%rsi
    8cba:	4c 89 f7             	mov    %r14,%rdi
    8cbd:	89 c2                	mov    %eax,%edx
    8cbf:	4c 89 55 80          	mov    %r10,-0x80(%rbp)
    8cc3:	89 85 78 ff ff ff    	mov    %eax,-0x88(%rbp)
    8cc9:	e8 00 00 00 00       	call   8cce <path_openat+0xd8e>
    8cce:	4c 8b 55 80          	mov    -0x80(%rbp),%r10
    8cd2:	85 c0                	test   %eax,%eax
    8cd4:	41 89 c1             	mov    %eax,%r9d
    8cd7:	0f 85 0f 01 00 00    	jne    8dec <path_openat+0xeac>
    8cdd:	49 8b 46 08          	mov    0x8(%r14),%rax
    8ce1:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
    8ce5:	4c 89 95 70 ff ff ff 	mov    %r10,-0x90(%rbp)
    8cec:	48 8b 40 68          	mov    0x68(%rax),%rax
    8cf0:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    8cf7:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 8cff <path_openat+0xdbf>
    8cfe:	00 
    8cff:	48 8b 80 a0 0c 00 00 	mov    0xca0(%rax),%rax
    8d06:	48 89 75 80          	mov    %rsi,-0x80(%rbp)
    8d0a:	8b 50 20             	mov    0x20(%rax),%edx
    8d0d:	e8 00 00 00 00       	call   8d12 <path_openat+0xdd2>
    8d12:	4c 8b 95 70 ff ff ff 	mov    -0x90(%rbp),%r10
    8d19:	83 f8 ff             	cmp    $0xffffffff,%eax
    8d1c:	0f 84 3c 01 00 00    	je     8e5e <path_openat+0xf1e>
    8d22:	48 8b 75 80          	mov    -0x80(%rbp),%rsi
    8d26:	89 85 68 ff ff ff    	mov    %eax,-0x98(%rbp)
    8d2c:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 8d34 <path_openat+0xdf4>
    8d33:	00 
    8d34:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
    8d38:	4c 89 95 70 ff ff ff 	mov    %r10,-0x90(%rbp)
    8d3f:	48 8b 80 a0 0c 00 00 	mov    0xca0(%rax),%rax
    8d46:	8b 50 24             	mov    0x24(%rax),%edx
    8d49:	e8 00 00 00 00       	call   8d4e <path_openat+0xe0e>
    8d4e:	4c 8b 95 70 ff ff ff 	mov    -0x90(%rbp),%r10
    8d55:	83 f8 ff             	cmp    $0xffffffff,%eax
    8d58:	89 85 6c ff ff ff    	mov    %eax,-0x94(%rbp)
    8d5e:	0f 84 fa 00 00 00    	je     8e5e <path_openat+0xf1e>
    8d64:	8b b5 68 ff ff ff    	mov    -0x98(%rbp),%esi
    8d6a:	48 8b 7d 80          	mov    -0x80(%rbp),%rdi
    8d6e:	e8 00 00 00 00       	call   8d73 <path_openat+0xe33>
    8d73:	4c 8b 95 70 ff ff ff 	mov    -0x90(%rbp),%r10
    8d7a:	83 f8 ff             	cmp    $0xffffffff,%eax
    8d7d:	0f 84 db 00 00 00    	je     8e5e <path_openat+0xf1e>
    8d83:	8b b5 6c ff ff ff    	mov    -0x94(%rbp),%esi
    8d89:	48 8b 7d 80          	mov    -0x80(%rbp),%rdi
    8d8d:	e8 00 00 00 00       	call   8d92 <path_openat+0xe52>
    8d92:	4c 8b 95 70 ff ff ff 	mov    -0x90(%rbp),%r10
    8d99:	83 f8 ff             	cmp    $0xffffffff,%eax
    8d9c:	0f 84 bc 00 00 00    	je     8e5e <path_openat+0xf1e>
    8da2:	49 8b 46 08          	mov    0x8(%r14),%rax
    8da6:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
    8daa:	ba 03 00 00 00       	mov    $0x3,%edx
    8daf:	4c 89 55 80          	mov    %r10,-0x80(%rbp)
    8db3:	48 8b 70 30          	mov    0x30(%rax),%rsi
    8db7:	e8 00 00 00 00       	call   8dbc <path_openat+0xe7c>
    8dbc:	4c 8b 55 80          	mov    -0x80(%rbp),%r10
    8dc0:	85 c0                	test   %eax,%eax
    8dc2:	41 89 c1             	mov    %eax,%r9d
    8dc5:	75 25                	jne    8dec <path_openat+0xeac>
    8dc7:	49 8b 46 08          	mov    0x8(%r14),%rax
    8dcb:	8b 95 78 ff ff ff    	mov    -0x88(%rbp),%edx
    8dd1:	4c 89 d6             	mov    %r10,%rsi
    8dd4:	48 8b 78 30          	mov    0x30(%rax),%rdi
    8dd8:	e8 00 00 00 00       	call   8ddd <path_openat+0xe9d>
    8ddd:	4c 8b 55 80          	mov    -0x80(%rbp),%r10
    8de1:	85 c0                	test   %eax,%eax
    8de3:	41 89 c1             	mov    %eax,%r9d
    8de6:	0f 84 25 f8 ff ff    	je     8611 <path_openat+0x6d1>
    8dec:	41 83 e4 bf          	and    $0xffffffbf,%r12d
    8df0:	e9 1c f8 ff ff       	jmp    8611 <path_openat+0x6d1>
    8df5:	4c 89 f7             	mov    %r14,%rdi
    8df8:	41 89 dd             	mov    %ebx,%r13d
    8dfb:	e8 00 a5 ff ff       	call   3300 <terminate_walk>
    8e00:	e9 9d f4 ff ff       	jmp    82a2 <path_openat+0x362>
    8e05:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8e09:	0f 84 7d 03 00 00    	je     918c <path_openat+0x124c>
    8e0f:	48 85 c0             	test   %rax,%rax
    8e12:	74 18                	je     8e2c <path_openat+0xeec>
    8e14:	4c 89 d7             	mov    %r10,%rdi
    8e17:	44 89 4d 98          	mov    %r9d,-0x68(%rbp)
    8e1b:	e8 00 00 00 00       	call   8e20 <path_openat+0xee0>
    8e20:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8e24:	44 8b 4d 98          	mov    -0x68(%rbp),%r9d
    8e28:	4c 8b 50 48          	mov    0x48(%rax),%r10
    8e2c:	41 f7 02 00 00 38 00 	testl  $0x380000,(%r10)
    8e33:	0f 85 90 fd ff ff    	jne    8bc9 <path_openat+0xc89>
    8e39:	4c 89 d7             	mov    %r10,%rdi
    8e3c:	44 89 4d 98          	mov    %r9d,-0x68(%rbp)
    8e40:	e8 00 00 00 00       	call   8e45 <path_openat+0xf05>
    8e45:	44 8b 4d 98          	mov    -0x68(%rbp),%r9d
    8e49:	45 85 c9             	test   %r9d,%r9d
    8e4c:	0f 85 8a fd ff ff    	jne    8bdc <path_openat+0xc9c>
    8e52:	49 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%r10
    8e59:	e9 2c fc ff ff       	jmp    8a8a <path_openat+0xb4a>
    8e5e:	41 b9 b5 ff ff ff    	mov    $0xffffffb5,%r9d
    8e64:	eb 86                	jmp    8dec <path_openat+0xeac>
    8e66:	e8 00 00 00 00       	call   8e6b <path_openat+0xf2b>
    8e6b:	80 7d a0 00          	cmpb   $0x0,-0x60(%rbp)
    8e6f:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    8e73:	0f 84 40 f1 ff ff    	je     7fb9 <path_openat+0x79>
    8e79:	e9 39 fc ff ff       	jmp    8ab7 <path_openat+0xb77>
    8e7e:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    8e85:	e8 00 00 00 00       	call   8e8a <path_openat+0xf4a>
    8e8a:	80 7d a0 00          	cmpb   $0x0,-0x60(%rbp)
    8e8e:	4c 8b 55 a8          	mov    -0x58(%rbp),%r10
    8e92:	0f 84 fb f6 ff ff    	je     8593 <path_openat+0x653>
    8e98:	e9 40 f8 ff ff       	jmp    86dd <path_openat+0x79d>
    8e9d:	4c 89 d7             	mov    %r10,%rdi
    8ea0:	44 89 4d 98          	mov    %r9d,-0x68(%rbp)
    8ea4:	e8 00 00 00 00       	call   8ea9 <path_openat+0xf69>
    8ea9:	44 8b 4d 98          	mov    -0x68(%rbp),%r9d
    8ead:	4d 63 d4             	movslq %r12d,%r10
    8eb0:	e9 14 fd ff ff       	jmp    8bc9 <path_openat+0xc89>
    8eb5:	0f 0b                	ud2
    8eb7:	45 84 e4             	test   %r12b,%r12b
    8eba:	0f 85 50 01 00 00    	jne    9010 <path_openat+0x10d0>
    8ec0:	4c 89 f7             	mov    %r14,%rdi
    8ec3:	e8 38 a4 ff ff       	call   3300 <terminate_walk>
    8ec8:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    8ecc:	e8 00 00 00 00       	call   8ed1 <path_openat+0xf91>
    8ed1:	e9 74 f5 ff ff       	jmp    844a <path_openat+0x50a>
    8ed6:	81 cf 00 00 00 40    	or     $0x40000000,%edi
    8edc:	f7 00 00 20 00 00    	testl  $0x2000,(%rax)
    8ee2:	0f 85 e0 f9 ff ff    	jne    88c8 <path_openat+0x988>
    8ee8:	4c 89 55 98          	mov    %r10,-0x68(%rbp)
    8eec:	45 31 c0             	xor    %r8d,%r8d
    8eef:	31 c9                	xor    %ecx,%ecx
    8ef1:	ba 02 00 00 00       	mov    $0x2,%edx
    8ef6:	6a 00                	push   $0x0
    8ef8:	e8 00 00 00 00       	call   8efd <path_openat+0xfbd>
    8efd:	41 5a                	pop    %r10
    8eff:	e9 e4 f9 ff ff       	jmp    88e8 <path_openat+0x9a8>
    8f04:	89 55 80             	mov    %edx,-0x80(%rbp)
    8f07:	e8 00 00 00 00       	call   8f0c <path_openat+0xfcc>
    8f0c:	8b 55 80             	mov    -0x80(%rbp),%edx
    8f0f:	4c 8b 95 78 ff ff ff 	mov    -0x88(%rbp),%r10
    8f16:	f7 d0                	not    %eax
    8f18:	21 c2                	and    %eax,%edx
    8f1a:	e9 74 fd ff ff       	jmp    8c93 <path_openat+0xd53>
    8f1f:	4c 8b 45 b0          	mov    -0x50(%rbp),%r8
    8f23:	b9 60 80 00 00       	mov    $0x8060,%ecx
    8f28:	31 d2                	xor    %edx,%edx
    8f2a:	48 89 df             	mov    %rbx,%rdi
    8f2d:	49 8b 70 48          	mov    0x48(%r8),%rsi
    8f31:	e8 00 00 00 00       	call   8f36 <path_openat+0xff6>
    8f36:	41 89 c5             	mov    %eax,%r13d
    8f39:	e9 c9 f4 ff ff       	jmp    8407 <path_openat+0x4c7>
    8f3e:	48 8b 40 18          	mov    0x18(%rax),%rax
    8f42:	41 81 e4 ff fd ff ff 	and    $0xfffffdff,%r12d
    8f49:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    8f4d:	e9 bf f6 ff ff       	jmp    8611 <path_openat+0x6d1>
    8f52:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8f56:	81 48 04 00 00 10 00 	orl    $0x100000,0x4(%rax)
    8f5d:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 8f65 <path_openat+0x1025>
    8f64:	00 
    8f65:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    8f6c:	48 85 c0             	test   %rax,%rax
    8f6f:	74 2d                	je     8f9e <path_openat+0x105e>
    8f71:	8b 00                	mov    (%rax),%eax
    8f73:	85 c0                	test   %eax,%eax
    8f75:	75 27                	jne    8f9e <path_openat+0x105e>
    8f77:	48 8b 7d 88          	mov    -0x78(%rbp),%rdi
    8f7b:	4c 89 d6             	mov    %r10,%rsi
    8f7e:	ba 04 00 00 00       	mov    $0x4,%edx
    8f83:	4c 89 55 80          	mov    %r10,-0x80(%rbp)
    8f87:	44 89 8d 78 ff ff ff 	mov    %r9d,-0x88(%rbp)
    8f8e:	e8 00 00 00 00       	call   8f93 <path_openat+0x1053>
    8f93:	44 8b 8d 78 ff ff ff 	mov    -0x88(%rbp),%r9d
    8f9a:	4c 8b 55 80          	mov    -0x80(%rbp),%r10
    8f9e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
    8fa2:	48 8b 40 20          	mov    0x20(%rax),%rax
    8fa6:	48 8b 40 28          	mov    0x28(%rax),%rax
    8faa:	48 85 c0             	test   %rax,%rax
    8fad:	0f 84 8b 01 00 00    	je     913e <path_openat+0x11fe>
    8fb3:	45 89 e0             	mov    %r12d,%r8d
    8fb6:	0f b7 4d 90          	movzwl -0x70(%rbp),%ecx
    8fba:	4c 89 d2             	mov    %r10,%rdx
    8fbd:	4c 89 55 90          	mov    %r10,-0x70(%rbp)
    8fc1:	41 c1 e8 07          	shr    $0x7,%r8d
    8fc5:	48 8b 75 88          	mov    -0x78(%rbp),%rsi
    8fc9:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
    8fcd:	44 89 4d 80          	mov    %r9d,-0x80(%rbp)
    8fd1:	41 83 e0 01          	and    $0x1,%r8d
    8fd5:	e8 00 00 00 00       	call   8fda <path_openat+0x109a>
    8fda:	4c 8b 55 90          	mov    -0x70(%rbp),%r10
    8fde:	85 c0                	test   %eax,%eax
    8fe0:	0f 85 d0 f6 ff ff    	jne    86b6 <path_openat+0x776>
    8fe6:	44 8b 4d 80          	mov    -0x80(%rbp),%r9d
    8fea:	45 85 c9             	test   %r9d,%r9d
    8fed:	0f 84 47 f5 ff ff    	je     853a <path_openat+0x5fa>
    8ff3:	49 83 7a 30 00       	cmpq   $0x0,0x30(%r10)
    8ff8:	0f 85 3c f5 ff ff    	jne    853a <path_openat+0x5fa>
    8ffe:	e9 b0 f6 ff ff       	jmp    86b3 <path_openat+0x773>
    9003:	41 b9 e2 ff ff ff    	mov    $0xffffffe2,%r9d
    9009:	e9 de fd ff ff       	jmp    8dec <path_openat+0xeac>
    900e:	0f 0b                	ud2
    9010:	49 8b 3e             	mov    (%r14),%rdi
    9013:	48 c7 c3 ea ff ff ff 	mov    $0xffffffffffffffea,%rbx
    901a:	e8 00 00 00 00       	call   901f <path_openat+0x10df>
    901f:	4c 89 f7             	mov    %r14,%rdi
    9022:	e8 d9 a2 ff ff       	call   3300 <terminate_walk>
    9027:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    902b:	e8 00 00 00 00       	call   9030 <path_openat+0x10f0>
    9030:	48 89 5d b0          	mov    %rbx,-0x50(%rbp)
    9034:	e9 fa f0 ff ff       	jmp    8133 <path_openat+0x1f3>
    9039:	41 0f b7 00          	movzwl (%r8),%eax
    903d:	66 25 00 f0          	and    $0xf000,%ax
    9041:	66 3d 00 80          	cmp    $0x8000,%ax
    9045:	0f 84 57 01 00 00    	je     91a2 <path_openat+0x1262>
    904b:	66 3d 00 10          	cmp    $0x1000,%ax
    904f:	75 0e                	jne    905f <path_openat+0x111f>
    9051:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 9057 <path_openat+0x1117>
    9057:	85 c0                	test   %eax,%eax
    9059:	0f 84 b0 f0 ff ff    	je     810f <path_openat+0x1cf>
    905f:	49 8b 40 28          	mov    0x28(%r8),%rax
    9063:	41 8b 50 04          	mov    0x4(%r8),%edx
    9067:	48 89 df             	mov    %rbx,%rdi
    906a:	89 4d a0             	mov    %ecx,-0x60(%rbp)
    906d:	4c 89 45 a8          	mov    %r8,-0x58(%rbp)
    9071:	48 8b b0 80 04 00 00 	mov    0x480(%rax),%rsi
    9078:	44 89 4d 98          	mov    %r9d,-0x68(%rbp)
    907c:	e8 00 00 00 00       	call   9081 <path_openat+0x1141>
    9081:	4c 8b 45 a8          	mov    -0x58(%rbp),%r8
    9085:	8b 4d a0             	mov    -0x60(%rbp),%ecx
    9088:	83 f8 ff             	cmp    $0xffffffff,%eax
    908b:	74 25                	je     90b2 <path_openat+0x1172>
    908d:	44 8b 4d 98          	mov    -0x68(%rbp),%r9d
    9091:	41 39 c1             	cmp    %eax,%r9d
    9094:	0f 84 6c f2 ff ff    	je     8306 <path_openat+0x3c6>
    909a:	65 48 8b 3d 00 00 00 	mov    %gs:0x0(%rip),%rdi        # 90a2 <path_openat+0x1162>
    90a1:	00 
    90a2:	48 8b 97 a0 0c 00 00 	mov    0xca0(%rdi),%rdx
    90a9:	3b 42 20             	cmp    0x20(%rdx),%eax
    90ac:	0f 84 54 f2 ff ff    	je     8306 <path_openat+0x3c6>
    90b2:	41 f6 c4 02          	test   $0x2,%r12b
    90b6:	0f 84 41 01 00 00    	je     91fd <path_openat+0x12bd>
    90bc:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
    90c3:	bf a7 06 00 00       	mov    $0x6a7,%edi
    90c8:	e8 00 00 00 00       	call   90cd <path_openat+0x118d>
    90cd:	4c 89 f7             	mov    %r14,%rdi
    90d0:	e8 2b a2 ff ff       	call   3300 <terminate_walk>
    90d5:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    90d9:	e8 00 00 00 00       	call   90de <path_openat+0x119e>
    90de:	48 c7 45 b0 f3 ff ff 	movq   $0xfffffffffffffff3,-0x50(%rbp)
    90e5:	ff 
    90e6:	e9 48 f0 ff ff       	jmp    8133 <path_openat+0x1f3>
    90eb:	4c 89 d7             	mov    %r10,%rdi
    90ee:	44 89 4d 90          	mov    %r9d,-0x70(%rbp)
    90f2:	e8 00 00 00 00       	call   90f7 <path_openat+0x11b7>
    90f7:	44 8b 4d 90          	mov    -0x70(%rbp),%r9d
    90fb:	4c 8b 55 98          	mov    -0x68(%rbp),%r10
    90ff:	e9 a1 fa ff ff       	jmp    8ba5 <path_openat+0xc65>
    9104:	4c 89 d7             	mov    %r10,%rdi
    9107:	48 89 85 70 ff ff ff 	mov    %rax,-0x90(%rbp)
    910e:	e8 00 00 00 00       	call   9113 <path_openat+0x11d3>
    9113:	48 8b 85 70 ff ff ff 	mov    -0x90(%rbp),%rax
    911a:	44 8b 8d 78 ff ff ff 	mov    -0x88(%rbp),%r9d
    9121:	4c 8b 55 80          	mov    -0x80(%rbp),%r10
    9125:	e9 3c f5 ff ff       	jmp    8666 <path_openat+0x726>
    912a:	48 8b 40 18          	mov    0x18(%rax),%rax
    912e:	41 81 e4 ff fd ff ff 	and    $0xfffffdff,%r12d
    9135:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    9139:	e9 07 fb ff ff       	jmp    8c45 <path_openat+0xd05>
    913e:	4c 89 d7             	mov    %r10,%rdi
    9141:	e8 00 00 00 00       	call   9146 <path_openat+0x1206>
    9146:	49 c7 c2 f3 ff ff ff 	mov    $0xfffffffffffffff3,%r10
    914d:	e9 38 f9 ff ff       	jmp    8a8a <path_openat+0xb4a>
    9152:	4c 89 d7             	mov    %r10,%rdi
    9155:	44 89 4d 90          	mov    %r9d,-0x70(%rbp)
    9159:	e8 00 00 00 00       	call   915e <path_openat+0x121e>
    915e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    9162:	4c 8b 50 48          	mov    0x48(%rax),%r10
    9166:	4d 85 d2             	test   %r10,%r10
    9169:	0f 84 d8 f3 ff ff    	je     8547 <path_openat+0x607>
    916f:	49 8d ba 80 00 00 00 	lea    0x80(%r10),%rdi
    9176:	4c 89 55 98          	mov    %r10,-0x68(%rbp)
    917a:	e8 00 00 00 00       	call   917f <path_openat+0x123f>
    917f:	4c 8b 55 98          	mov    -0x68(%rbp),%r10
    9183:	44 8b 4d 90          	mov    -0x70(%rbp),%r9d
    9187:	e9 3d fa ff ff       	jmp    8bc9 <path_openat+0xc89>
    918c:	0f 0b                	ud2
    918e:	4c 89 d7             	mov    %r10,%rdi
    9191:	e8 00 00 00 00       	call   9196 <path_openat+0x1256>
    9196:	49 c7 c2 fb ff ff ff 	mov    $0xfffffffffffffffb,%r10
    919d:	e9 e8 f8 ff ff       	jmp    8a8a <path_openat+0xb4a>
    91a2:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 91a8 <path_openat+0x1268>
    91a8:	85 d2                	test   %edx,%edx
    91aa:	0f 85 af fe ff ff    	jne    905f <path_openat+0x111f>
    91b0:	e9 5a ef ff ff       	jmp    810f <path_openat+0x1cf>
    91b5:	49 8b 3e             	mov    (%r14),%rdi
    91b8:	48 c7 c3 e6 ff ff ff 	mov    $0xffffffffffffffe6,%rbx
    91bf:	e8 00 00 00 00       	call   91c4 <path_openat+0x1284>
    91c4:	4c 89 f7             	mov    %r14,%rdi
    91c7:	e8 34 a1 ff ff       	call   3300 <terminate_walk>
    91cc:	e9 56 fe ff ff       	jmp    9027 <path_openat+0x10e7>
    91d1:	e8 00 00 00 00       	call   91d6 <path_openat+0x1296>
    91d6:	4c 89 f7             	mov    %r14,%rdi
    91d9:	e8 22 a1 ff ff       	call   3300 <terminate_walk>
    91de:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    91e2:	e8 00 00 00 00       	call   91e7 <path_openat+0x12a7>
    91e7:	48 c7 45 b0 ef ff ff 	movq   $0xffffffffffffffef,-0x50(%rbp)
    91ee:	ff 
    91ef:	e9 3f ef ff ff       	jmp    8133 <path_openat+0x1f3>
    91f4:	41 8b 46 38          	mov    0x38(%r14),%eax
    91f8:	e9 01 f5 ff ff       	jmp    86fe <path_openat+0x7be>
    91fd:	41 80 e4 10          	and    $0x10,%r12b
    9201:	0f 84 ff f0 ff ff    	je     8306 <path_openat+0x3c6>
    9207:	83 3d 00 00 00 00 01 	cmpl   $0x1,0x0(%rip)        # 920e <path_openat+0x12ce>
    920e:	7e 0e                	jle    921e <path_openat+0x12de>
    9210:	41 0f b7 00          	movzwl (%r8),%eax
    9214:	66 25 00 f0          	and    $0xf000,%ax
    9218:	66 3d 00 10          	cmp    $0x1000,%ax
    921c:	74 4a                	je     9268 <path_openat+0x1328>
    921e:	83 3d 00 00 00 00 01 	cmpl   $0x1,0x0(%rip)        # 9225 <path_openat+0x12e5>
    9225:	0f 8e db f0 ff ff    	jle    8306 <path_openat+0x3c6>
    922b:	41 0f b7 00          	movzwl (%r8),%eax
    922f:	66 25 00 f0          	and    $0xf000,%ax
    9233:	66 3d 00 80          	cmp    $0x8000,%ax
    9237:	0f 85 c9 f0 ff ff    	jne    8306 <path_openat+0x3c6>
    923d:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
    9244:	bf a7 06 00 00       	mov    $0x6a7,%edi
    9249:	e8 00 00 00 00       	call   924e <path_openat+0x130e>
    924e:	e9 7a fe ff ff       	jmp    90cd <path_openat+0x118d>
    9253:	4c 89 d7             	mov    %r10,%rdi
    9256:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    925a:	e8 00 00 00 00       	call   925f <path_openat+0x131f>
    925f:	4c 8b 55 98          	mov    -0x68(%rbp),%r10
    9263:	e9 22 f8 ff ff       	jmp    8a8a <path_openat+0xb4a>
    9268:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
    926f:	bf a7 06 00 00       	mov    $0x6a7,%edi
    9274:	e8 00 00 00 00       	call   9279 <path_openat+0x1339>
    9279:	e9 4f fe ff ff       	jmp    90cd <path_openat+0x118d>
    927e:	66 90                	xchg   %ax,%ax

0000000000009280 <__pfx_do_filp_open>:
    9280:	90                   	nop
    9281:	90                   	nop
    9282:	90                   	nop
    9283:	90                   	nop
    9284:	90                   	nop
    9285:	90                   	nop
    9286:	90                   	nop
    9287:	90                   	nop
    9288:	90                   	nop
    9289:	90                   	nop
    928a:	90                   	nop
    928b:	90                   	nop
    928c:	90                   	nop
    928d:	90                   	nop
    928e:	90                   	nop
    928f:	90                   	nop

0000000000009290 <do_filp_open>:
    9290:	e8 00 00 00 00       	call   9295 <do_filp_open+0x5>
    9295:	55                   	push   %rbp
    9296:	41 89 f8             	mov    %edi,%r8d
    9299:	b9 1e 00 00 00       	mov    $0x1e,%ecx
    929e:	48 89 e5             	mov    %rsp,%rbp
    92a1:	41 57                	push   %r15
    92a3:	41 56                	push   %r14
    92a5:	49 89 d6             	mov    %rdx,%r14
    92a8:	41 55                	push   %r13
    92aa:	41 54                	push   %r12
    92ac:	53                   	push   %rbx
    92ad:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    92b1:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    92b8:	65 4c 8b 3d 00 00 00 	mov    %gs:0x0(%rip),%r15        # 92c0 <do_filp_open+0x30>
    92bf:	00 
    92c0:	44 8b 62 10          	mov    0x10(%rdx),%r12d
    92c4:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 92cc <do_filp_open+0x3c>
    92cb:	00 
    92cc:	48 89 84 24 f8 00 00 	mov    %rax,0xf8(%rsp)
    92d3:	00 
    92d4:	31 c0                	xor    %eax,%eax
    92d6:	49 89 e5             	mov    %rsp,%r13
    92d9:	48 8d 54 24 68       	lea    0x68(%rsp),%rdx
    92de:	4c 89 ef             	mov    %r13,%rdi
    92e1:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    92e4:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
    92e9:	49 8b 87 c0 0c 00 00 	mov    0xcc0(%r15),%rax
    92f0:	c7 44 24 54 00 00 00 	movl   $0x0,0x54(%rsp)
    92f7:	00 
    92f8:	44 89 84 24 e4 00 00 	mov    %r8d,0xe4(%rsp)
    92ff:	00 
    9300:	48 89 b4 24 c8 00 00 	mov    %rsi,0xc8(%rsp)
    9307:	00 
    9308:	48 85 f6             	test   %rsi,%rsi
    930b:	0f 84 ca 00 00 00    	je     93db <do_filp_open+0x14b>
    9311:	48 8b 16             	mov    (%rsi),%rdx
    9314:	48 89 94 24 d0 00 00 	mov    %rdx,0xd0(%rsp)
    931b:	00 
    931c:	31 d2                	xor    %edx,%edx
    931e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    9325:	00 
    9326:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    932d:	00 00 
    932f:	48 85 c0             	test   %rax,%rax
    9332:	74 03                	je     9337 <do_filp_open+0xa7>
    9334:	8b 50 58             	mov    0x58(%rax),%edx
    9337:	4d 89 af c0 0c 00 00 	mov    %r13,0xcc0(%r15)
    933e:	4c 89 f6             	mov    %r14,%rsi
    9341:	4c 89 ef             	mov    %r13,%rdi
    9344:	89 54 24 58          	mov    %edx,0x58(%rsp)
    9348:	44 89 e2             	mov    %r12d,%edx
    934b:	80 ce 01             	or     $0x1,%dh
    934e:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
    9355:	00 
    9356:	c7 44 24 3c 00 00 00 	movl   $0x0,0x3c(%rsp)
    935d:	00 
    935e:	e8 dd eb ff ff       	call   7f40 <path_openat>
    9363:	48 89 c3             	mov    %rax,%rbx
    9366:	48 83 f8 f6          	cmp    $0xfffffffffffffff6,%rax
    936a:	74 7b                	je     93e7 <do_filp_open+0x157>
    936c:	48 83 fb 8c          	cmp    $0xffffffffffffff8c,%rbx
    9370:	0f 84 8c 00 00 00    	je     9402 <do_filp_open+0x172>
    9376:	49 8b 97 c0 0c 00 00 	mov    0xcc0(%r15),%rdx
    937d:	48 8b 82 d8 00 00 00 	mov    0xd8(%rdx),%rax
    9384:	49 89 87 c0 0c 00 00 	mov    %rax,0xcc0(%r15)
    938b:	48 85 c0             	test   %rax,%rax
    938e:	74 06                	je     9396 <do_filp_open+0x106>
    9390:	8b 4a 58             	mov    0x58(%rdx),%ecx
    9393:	89 48 58             	mov    %ecx,0x58(%rax)
    9396:	48 8b 7a 60          	mov    0x60(%rdx),%rdi
    939a:	48 83 c2 68          	add    $0x68,%rdx
    939e:	48 39 d7             	cmp    %rdx,%rdi
    93a1:	74 05                	je     93a8 <do_filp_open+0x118>
    93a3:	e8 00 00 00 00       	call   93a8 <do_filp_open+0x118>
    93a8:	48 8b 84 24 f8 00 00 	mov    0xf8(%rsp),%rax
    93af:	00 
    93b0:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 93b8 <do_filp_open+0x128>
    93b7:	00 
    93b8:	75 61                	jne    941b <do_filp_open+0x18b>
    93ba:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    93be:	48 89 d8             	mov    %rbx,%rax
    93c1:	5b                   	pop    %rbx
    93c2:	41 5c                	pop    %r12
    93c4:	41 5d                	pop    %r13
    93c6:	41 5e                	pop    %r14
    93c8:	41 5f                	pop    %r15
    93ca:	5d                   	pop    %rbp
    93cb:	31 d2                	xor    %edx,%edx
    93cd:	31 c9                	xor    %ecx,%ecx
    93cf:	31 f6                	xor    %esi,%esi
    93d1:	31 ff                	xor    %edi,%edi
    93d3:	45 31 c0             	xor    %r8d,%r8d
    93d6:	e9 00 00 00 00       	jmp    93db <do_filp_open+0x14b>
    93db:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
    93e2:	e9 2d ff ff ff       	jmp    9314 <do_filp_open+0x84>
    93e7:	44 89 e2             	mov    %r12d,%edx
    93ea:	4c 89 f6             	mov    %r14,%rsi
    93ed:	4c 89 ef             	mov    %r13,%rdi
    93f0:	e8 4b eb ff ff       	call   7f40 <path_openat>
    93f5:	48 89 c3             	mov    %rax,%rbx
    93f8:	48 83 fb 8c          	cmp    $0xffffffffffffff8c,%rbx
    93fc:	0f 85 74 ff ff ff    	jne    9376 <do_filp_open+0xe6>
    9402:	44 89 e2             	mov    %r12d,%edx
    9405:	4c 89 f6             	mov    %r14,%rsi
    9408:	4c 89 ef             	mov    %r13,%rdi
    940b:	80 ca 80             	or     $0x80,%dl
    940e:	e8 2d eb ff ff       	call   7f40 <path_openat>
    9413:	48 89 c3             	mov    %rax,%rbx
    9416:	e9 5b ff ff ff       	jmp    9376 <do_filp_open+0xe6>
    941b:	e8 00 00 00 00       	call   9420 <__pfx_do_file_open_root>

0000000000009420 <__pfx_do_file_open_root>:
    9420:	90                   	nop
    9421:	90                   	nop
    9422:	90                   	nop
    9423:	90                   	nop
    9424:	90                   	nop
    9425:	90                   	nop
    9426:	90                   	nop
    9427:	90                   	nop
    9428:	90                   	nop
    9429:	90                   	nop
    942a:	90                   	nop
    942b:	90                   	nop
    942c:	90                   	nop
    942d:	90                   	nop
    942e:	90                   	nop
    942f:	90                   	nop

0000000000009430 <do_file_open_root>:
    9430:	e8 00 00 00 00       	call   9435 <do_file_open_root+0x5>
    9435:	55                   	push   %rbp
    9436:	49 89 f8             	mov    %rdi,%r8
    9439:	b9 1e 00 00 00       	mov    $0x1e,%ecx
    943e:	48 89 e5             	mov    %rsp,%rbp
    9441:	41 57                	push   %r15
    9443:	41 56                	push   %r14
    9445:	41 55                	push   %r13
    9447:	49 89 d5             	mov    %rdx,%r13
    944a:	41 54                	push   %r12
    944c:	53                   	push   %rbx
    944d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    9451:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
    9458:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 9460 <do_file_open_root+0x30>
    945f:	00 
    9460:	48 89 84 24 08 01 00 	mov    %rax,0x108(%rsp)
    9467:	00 
    9468:	31 c0                	xor    %eax,%eax
    946a:	4c 8d 74 24 10       	lea    0x10(%rsp),%r14
    946f:	4c 89 f7             	mov    %r14,%rdi
    9472:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    9475:	8b 42 10             	mov    0x10(%rdx),%eax
    9478:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    947c:	49 8b 40 08          	mov    0x8(%r8),%rax
    9480:	8b 00                	mov    (%rax),%eax
    9482:	25 00 00 38 00       	and    $0x380000,%eax
    9487:	3d 00 00 30 00       	cmp    $0x300000,%eax
    948c:	75 11                	jne    949f <do_file_open_root+0x6f>
    948e:	49 c7 c4 d8 ff ff ff 	mov    $0xffffffffffffffd8,%r12
    9495:	f6 42 0e 01          	testb  $0x1,0xe(%rdx)
    9499:	0f 85 0a 01 00 00    	jne    95a9 <do_file_open_root+0x179>
    949f:	48 89 f7             	mov    %rsi,%rdi
    94a2:	4c 89 04 24          	mov    %r8,(%rsp)
    94a6:	e8 00 00 00 00       	call   94ab <do_file_open_root+0x7b>
    94ab:	48 89 c3             	mov    %rax,%rbx
    94ae:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    94b4:	0f 87 26 01 00 00    	ja     95e0 <do_file_open_root+0x1b0>
    94ba:	65 4c 8b 3d 00 00 00 	mov    %gs:0x0(%rip),%r15        # 94c2 <do_file_open_root+0x92>
    94c1:	00 
    94c2:	48 8d 54 24 78       	lea    0x78(%rsp),%rdx
    94c7:	48 85 db             	test   %rbx,%rbx
    94ca:	c7 44 24 64 00 00 00 	movl   $0x0,0x64(%rsp)
    94d1:	00 
    94d2:	48 89 54 24 70       	mov    %rdx,0x70(%rsp)
    94d7:	4c 8b 04 24          	mov    (%rsp),%r8
    94db:	48 89 9c 24 d8 00 00 	mov    %rbx,0xd8(%rsp)
    94e2:	00 
    94e3:	49 8b 87 c0 0c 00 00 	mov    0xcc0(%r15),%rax
    94ea:	c7 84 24 f4 00 00 00 	movl   $0xffffffff,0xf4(%rsp)
    94f1:	ff ff ff ff 
    94f5:	0f 84 ea 00 00 00    	je     95e5 <do_file_open_root+0x1b5>
    94fb:	48 8b 13             	mov    (%rbx),%rdx
    94fe:	48 89 94 24 e0 00 00 	mov    %rdx,0xe0(%rsp)
    9505:	00 
    9506:	31 d2                	xor    %edx,%edx
    9508:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    950f:	00 00 
    9511:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    9518:	00 00 
    951a:	48 85 c0             	test   %rax,%rax
    951d:	74 03                	je     9522 <do_file_open_root+0xf2>
    951f:	8b 50 58             	mov    0x58(%rax),%edx
    9522:	89 54 24 68          	mov    %edx,0x68(%rsp)
    9526:	48 89 84 24 e8 00 00 	mov    %rax,0xe8(%rsp)
    952d:	00 
    952e:	4d 89 b7 c0 0c 00 00 	mov    %r14,0xcc0(%r15)
    9535:	c7 44 24 4c 00 00 00 	movl   $0x0,0x4c(%rsp)
    953c:	00 
    953d:	4d 85 c0             	test   %r8,%r8
    9540:	0f 85 ab 00 00 00    	jne    95f1 <do_file_open_root+0x1c1>
    9546:	8b 54 24 0c          	mov    0xc(%rsp),%edx
    954a:	4c 89 ee             	mov    %r13,%rsi
    954d:	4c 89 f7             	mov    %r14,%rdi
    9550:	80 ce 01             	or     $0x1,%dh
    9553:	e8 e8 e9 ff ff       	call   7f40 <path_openat>
    9558:	49 89 c4             	mov    %rax,%r12
    955b:	48 83 f8 f6          	cmp    $0xfffffffffffffff6,%rax
    955f:	0f 84 aa 00 00 00    	je     960f <do_file_open_root+0x1df>
    9565:	49 83 fc 8c          	cmp    $0xffffffffffffff8c,%r12
    9569:	0f 84 b7 00 00 00    	je     9626 <do_file_open_root+0x1f6>
    956f:	49 8b 87 c0 0c 00 00 	mov    0xcc0(%r15),%rax
    9576:	48 8b 90 d8 00 00 00 	mov    0xd8(%rax),%rdx
    957d:	49 89 97 c0 0c 00 00 	mov    %rdx,0xcc0(%r15)
    9584:	48 85 d2             	test   %rdx,%rdx
    9587:	74 06                	je     958f <do_file_open_root+0x15f>
    9589:	8b 48 58             	mov    0x58(%rax),%ecx
    958c:	89 4a 58             	mov    %ecx,0x58(%rdx)
    958f:	48 8b 78 60          	mov    0x60(%rax),%rdi
    9593:	48 83 c0 68          	add    $0x68,%rax
    9597:	48 39 c7             	cmp    %rax,%rdi
    959a:	74 05                	je     95a1 <do_file_open_root+0x171>
    959c:	e8 00 00 00 00       	call   95a1 <do_file_open_root+0x171>
    95a1:	48 89 df             	mov    %rbx,%rdi
    95a4:	e8 00 00 00 00       	call   95a9 <do_file_open_root+0x179>
    95a9:	48 8b 84 24 08 01 00 	mov    0x108(%rsp),%rax
    95b0:	00 
    95b1:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 95b9 <do_file_open_root+0x189>
    95b8:	00 
    95b9:	0f 85 81 00 00 00    	jne    9640 <do_file_open_root+0x210>
    95bf:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    95c3:	4c 89 e0             	mov    %r12,%rax
    95c6:	5b                   	pop    %rbx
    95c7:	41 5c                	pop    %r12
    95c9:	41 5d                	pop    %r13
    95cb:	41 5e                	pop    %r14
    95cd:	41 5f                	pop    %r15
    95cf:	5d                   	pop    %rbp
    95d0:	31 d2                	xor    %edx,%edx
    95d2:	31 c9                	xor    %ecx,%ecx
    95d4:	31 f6                	xor    %esi,%esi
    95d6:	31 ff                	xor    %edi,%edi
    95d8:	45 31 c0             	xor    %r8d,%r8d
    95db:	e9 00 00 00 00       	jmp    95e0 <do_file_open_root+0x1b0>
    95e0:	49 89 c4             	mov    %rax,%r12
    95e3:	eb c4                	jmp    95a9 <do_file_open_root+0x179>
    95e5:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
    95ec:	e9 0d ff ff ff       	jmp    94fe <do_file_open_root+0xce>
    95f1:	49 8b 00             	mov    (%r8),%rax
    95f4:	49 8b 50 08          	mov    0x8(%r8),%rdx
    95f8:	c7 44 24 4c 01 00 00 	movl   $0x1,0x4c(%rsp)
    95ff:	00 
    9600:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    9605:	48 89 54 24 38       	mov    %rdx,0x38(%rsp)
    960a:	e9 37 ff ff ff       	jmp    9546 <do_file_open_root+0x116>
    960f:	8b 54 24 0c          	mov    0xc(%rsp),%edx
    9613:	4c 89 ee             	mov    %r13,%rsi
    9616:	4c 89 f7             	mov    %r14,%rdi
    9619:	e8 22 e9 ff ff       	call   7f40 <path_openat>
    961e:	49 89 c4             	mov    %rax,%r12
    9621:	e9 3f ff ff ff       	jmp    9565 <do_file_open_root+0x135>
    9626:	8b 54 24 0c          	mov    0xc(%rsp),%edx
    962a:	4c 89 ee             	mov    %r13,%rsi
    962d:	4c 89 f7             	mov    %r14,%rdi
    9630:	80 ca 80             	or     $0x80,%dl
    9633:	e8 08 e9 ff ff       	call   7f40 <path_openat>
    9638:	49 89 c4             	mov    %rax,%r12
    963b:	e9 2f ff ff ff       	jmp    956f <do_file_open_root+0x13f>
    9640:	e8 00 00 00 00       	call   9645 <do_file_open_root+0x215>
    9645:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    964c:	00 00 00 00 

0000000000009650 <__pfx_do_mkdirat>:
    9650:	90                   	nop
    9651:	90                   	nop
    9652:	90                   	nop
    9653:	90                   	nop
    9654:	90                   	nop
    9655:	90                   	nop
    9656:	90                   	nop
    9657:	90                   	nop
    9658:	90                   	nop
    9659:	90                   	nop
    965a:	90                   	nop
    965b:	90                   	nop
    965c:	90                   	nop
    965d:	90                   	nop
    965e:	90                   	nop
    965f:	90                   	nop

0000000000009660 <do_mkdirat>:
    9660:	e8 00 00 00 00       	call   9665 <do_mkdirat+0x5>
    9665:	55                   	push   %rbp
    9666:	b9 02 00 00 00       	mov    $0x2,%ecx
    966b:	48 89 e5             	mov    %rsp,%rbp
    966e:	41 57                	push   %r15
    9670:	41 56                	push   %r14
    9672:	41 55                	push   %r13
    9674:	41 89 d5             	mov    %edx,%r13d
    9677:	41 54                	push   %r12
    9679:	49 89 f4             	mov    %rsi,%r12
    967c:	53                   	push   %rbx
    967d:	48 83 ec 20          	sub    $0x20,%rsp
    9681:	89 7d bc             	mov    %edi,-0x44(%rbp)
    9684:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 968c <do_mkdirat+0x2c>
    968b:	00 
    968c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    9690:	31 c0                	xor    %eax,%eax
    9692:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    9699:	00 
    969a:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    96a1:	00 
    96a2:	c7 45 b8 02 00 00 00 	movl   $0x2,-0x48(%rbp)
    96a9:	8b 7d bc             	mov    -0x44(%rbp),%edi
    96ac:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
    96b0:	4c 89 e6             	mov    %r12,%rsi
    96b3:	e8 d8 d2 ff ff       	call   6990 <filename_create>
    96b8:	49 89 c6             	mov    %rax,%r14
    96bb:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    96c1:	0f 87 f9 00 00 00    	ja     97c0 <do_mkdirat+0x160>
    96c7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    96cb:	45 0f b7 fd          	movzwl %r13w,%r15d
    96cf:	44 89 fa             	mov    %r15d,%edx
    96d2:	48 8b 40 30          	mov    0x30(%rax),%rax
    96d6:	48 8b 40 28          	mov    0x28(%rax),%rax
    96da:	f6 40 52 01          	testb  $0x1,0x52(%rax)
    96de:	0f 84 8d 00 00 00    	je     9771 <do_mkdirat+0x111>
    96e4:	4c 89 f6             	mov    %r14,%rsi
    96e7:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
    96eb:	e8 00 00 00 00       	call   96f0 <do_mkdirat+0x90>
    96f0:	89 c3                	mov    %eax,%ebx
    96f2:	85 c0                	test   %eax,%eax
    96f4:	0f 84 95 00 00 00    	je     978f <do_mkdirat+0x12f>
    96fa:	4c 89 f7             	mov    %r14,%rdi
    96fd:	e8 00 00 00 00       	call   9702 <do_mkdirat+0xa2>
    9702:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    9706:	48 8b 78 30          	mov    0x30(%rax),%rdi
    970a:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    9711:	e8 00 00 00 00       	call   9716 <do_mkdirat+0xb6>
    9716:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    971a:	e8 00 00 00 00       	call   971f <do_mkdirat+0xbf>
    971f:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    9723:	e8 00 00 00 00       	call   9728 <do_mkdirat+0xc8>
    9728:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    972c:	e8 00 00 00 00       	call   9731 <do_mkdirat+0xd1>
    9731:	83 fb 8c             	cmp    $0xffffff8c,%ebx
    9734:	0f 84 8d 00 00 00    	je     97c7 <do_mkdirat+0x167>
    973a:	4c 89 e7             	mov    %r12,%rdi
    973d:	e8 00 00 00 00       	call   9742 <do_mkdirat+0xe2>
    9742:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    9746:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 974e <do_mkdirat+0xee>
    974d:	00 
    974e:	0f 85 8e 00 00 00    	jne    97e2 <do_mkdirat+0x182>
    9754:	48 83 c4 20          	add    $0x20,%rsp
    9758:	89 d8                	mov    %ebx,%eax
    975a:	5b                   	pop    %rbx
    975b:	41 5c                	pop    %r12
    975d:	41 5d                	pop    %r13
    975f:	41 5e                	pop    %r14
    9761:	41 5f                	pop    %r15
    9763:	5d                   	pop    %rbp
    9764:	31 d2                	xor    %edx,%edx
    9766:	31 c9                	xor    %ecx,%ecx
    9768:	31 f6                	xor    %esi,%esi
    976a:	31 ff                	xor    %edi,%edi
    976c:	e9 00 00 00 00       	jmp    9771 <do_mkdirat+0x111>
    9771:	f6 40 59 10          	testb  $0x10,0x59(%rax)
    9775:	0f 85 69 ff ff ff    	jne    96e4 <do_mkdirat+0x84>
    977b:	e8 00 00 00 00       	call   9780 <do_mkdirat+0x120>
    9780:	f7 d0                	not    %eax
    9782:	89 c2                	mov    %eax,%edx
    9784:	44 21 ea             	and    %r13d,%edx
    9787:	0f b7 d2             	movzwl %dx,%edx
    978a:	e9 55 ff ff ff       	jmp    96e4 <do_mkdirat+0x84>
    978f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    9793:	4c 89 f2             	mov    %r14,%rdx
    9796:	44 89 f9             	mov    %r15d,%ecx
    9799:	48 8b 78 18          	mov    0x18(%rax),%rdi
    979d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    97a1:	48 8b 70 30          	mov    0x30(%rax),%rsi
    97a5:	e8 00 00 00 00       	call   97aa <do_mkdirat+0x14a>
    97aa:	49 89 c6             	mov    %rax,%r14
    97ad:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    97b3:	0f 86 41 ff ff ff    	jbe    96fa <do_mkdirat+0x9a>
    97b9:	89 c3                	mov    %eax,%ebx
    97bb:	e9 42 ff ff ff       	jmp    9702 <do_mkdirat+0xa2>
    97c0:	89 c3                	mov    %eax,%ebx
    97c2:	e9 73 ff ff ff       	jmp    973a <do_mkdirat+0xda>
    97c7:	83 7d b8 01          	cmpl   $0x1,-0x48(%rbp)
    97cb:	b9 82 00 00 00       	mov    $0x82,%ecx
    97d0:	0f 84 64 ff ff ff    	je     973a <do_mkdirat+0xda>
    97d6:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%rbp)
    97dd:	e9 c7 fe ff ff       	jmp    96a9 <do_mkdirat+0x49>
    97e2:	e8 00 00 00 00       	call   97e7 <do_mkdirat+0x187>
    97e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    97ee:	00 00 

00000000000097f0 <__pfx___ia32_sys_mkdirat>:
    97f0:	90                   	nop
    97f1:	90                   	nop
    97f2:	90                   	nop
    97f3:	90                   	nop
    97f4:	90                   	nop
    97f5:	90                   	nop
    97f6:	90                   	nop
    97f7:	90                   	nop
    97f8:	90                   	nop
    97f9:	90                   	nop
    97fa:	90                   	nop
    97fb:	90                   	nop
    97fc:	90                   	nop
    97fd:	90                   	nop
    97fe:	90                   	nop
    97ff:	90                   	nop

0000000000009800 <__ia32_sys_mkdirat>:
    9800:	e8 00 00 00 00       	call   9805 <__ia32_sys_mkdirat+0x5>
    9805:	55                   	push   %rbp
    9806:	31 f6                	xor    %esi,%esi
    9808:	48 89 e5             	mov    %rsp,%rbp
    980b:	41 54                	push   %r12
    980d:	53                   	push   %rbx
    980e:	8b 5f 28             	mov    0x28(%rdi),%ebx
    9811:	44 0f b7 67 60       	movzwl 0x60(%rdi),%r12d
    9816:	8b 7f 58             	mov    0x58(%rdi),%edi
    9819:	e8 00 00 00 00       	call   981e <__ia32_sys_mkdirat+0x1e>
    981e:	44 89 e2             	mov    %r12d,%edx
    9821:	89 df                	mov    %ebx,%edi
    9823:	48 89 c6             	mov    %rax,%rsi
    9826:	e8 00 00 00 00       	call   982b <__ia32_sys_mkdirat+0x2b>
    982b:	5b                   	pop    %rbx
    982c:	41 5c                	pop    %r12
    982e:	48 98                	cltq
    9830:	5d                   	pop    %rbp
    9831:	31 d2                	xor    %edx,%edx
    9833:	31 f6                	xor    %esi,%esi
    9835:	31 ff                	xor    %edi,%edi
    9837:	e9 00 00 00 00       	jmp    983c <__ia32_sys_mkdirat+0x3c>
    983c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000009840 <__pfx___ia32_sys_mkdir>:
    9840:	90                   	nop
    9841:	90                   	nop
    9842:	90                   	nop
    9843:	90                   	nop
    9844:	90                   	nop
    9845:	90                   	nop
    9846:	90                   	nop
    9847:	90                   	nop
    9848:	90                   	nop
    9849:	90                   	nop
    984a:	90                   	nop
    984b:	90                   	nop
    984c:	90                   	nop
    984d:	90                   	nop
    984e:	90                   	nop
    984f:	90                   	nop

0000000000009850 <__ia32_sys_mkdir>:
    9850:	e8 00 00 00 00       	call   9855 <__ia32_sys_mkdir+0x5>
    9855:	55                   	push   %rbp
    9856:	31 f6                	xor    %esi,%esi
    9858:	48 89 e5             	mov    %rsp,%rbp
    985b:	53                   	push   %rbx
    985c:	0f b7 5f 58          	movzwl 0x58(%rdi),%ebx
    9860:	8b 7f 28             	mov    0x28(%rdi),%edi
    9863:	e8 00 00 00 00       	call   9868 <__ia32_sys_mkdir+0x18>
    9868:	89 da                	mov    %ebx,%edx
    986a:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    986f:	48 89 c6             	mov    %rax,%rsi
    9872:	e8 00 00 00 00       	call   9877 <__ia32_sys_mkdir+0x27>
    9877:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    987b:	c9                   	leave
    987c:	48 98                	cltq
    987e:	31 d2                	xor    %edx,%edx
    9880:	31 f6                	xor    %esi,%esi
    9882:	31 ff                	xor    %edi,%edi
    9884:	e9 00 00 00 00       	jmp    9889 <__ia32_sys_mkdir+0x39>
    9889:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009890 <__pfx___x64_sys_mkdirat>:
    9890:	90                   	nop
    9891:	90                   	nop
    9892:	90                   	nop
    9893:	90                   	nop
    9894:	90                   	nop
    9895:	90                   	nop
    9896:	90                   	nop
    9897:	90                   	nop
    9898:	90                   	nop
    9899:	90                   	nop
    989a:	90                   	nop
    989b:	90                   	nop
    989c:	90                   	nop
    989d:	90                   	nop
    989e:	90                   	nop
    989f:	90                   	nop

00000000000098a0 <__x64_sys_mkdirat>:
    98a0:	e8 00 00 00 00       	call   98a5 <__x64_sys_mkdirat+0x5>
    98a5:	55                   	push   %rbp
    98a6:	31 f6                	xor    %esi,%esi
    98a8:	48 89 e5             	mov    %rsp,%rbp
    98ab:	41 54                	push   %r12
    98ad:	53                   	push   %rbx
    98ae:	8b 5f 70             	mov    0x70(%rdi),%ebx
    98b1:	44 0f b7 67 60       	movzwl 0x60(%rdi),%r12d
    98b6:	48 8b 7f 68          	mov    0x68(%rdi),%rdi
    98ba:	e8 00 00 00 00       	call   98bf <__x64_sys_mkdirat+0x1f>
    98bf:	44 89 e2             	mov    %r12d,%edx
    98c2:	89 df                	mov    %ebx,%edi
    98c4:	48 89 c6             	mov    %rax,%rsi
    98c7:	e8 00 00 00 00       	call   98cc <__x64_sys_mkdirat+0x2c>
    98cc:	5b                   	pop    %rbx
    98cd:	41 5c                	pop    %r12
    98cf:	48 98                	cltq
    98d1:	5d                   	pop    %rbp
    98d2:	31 d2                	xor    %edx,%edx
    98d4:	31 f6                	xor    %esi,%esi
    98d6:	31 ff                	xor    %edi,%edi
    98d8:	e9 00 00 00 00       	jmp    98dd <__x64_sys_mkdirat+0x3d>
    98dd:	0f 1f 00             	nopl   (%rax)

00000000000098e0 <__pfx___x64_sys_mkdir>:
    98e0:	90                   	nop
    98e1:	90                   	nop
    98e2:	90                   	nop
    98e3:	90                   	nop
    98e4:	90                   	nop
    98e5:	90                   	nop
    98e6:	90                   	nop
    98e7:	90                   	nop
    98e8:	90                   	nop
    98e9:	90                   	nop
    98ea:	90                   	nop
    98eb:	90                   	nop
    98ec:	90                   	nop
    98ed:	90                   	nop
    98ee:	90                   	nop
    98ef:	90                   	nop

00000000000098f0 <__x64_sys_mkdir>:
    98f0:	e8 00 00 00 00       	call   98f5 <__x64_sys_mkdir+0x5>
    98f5:	55                   	push   %rbp
    98f6:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 98fe <__x64_sys_mkdir+0xe>
    98fd:	00 
    98fe:	48 89 e5             	mov    %rsp,%rbp
    9901:	41 54                	push   %r12
    9903:	53                   	push   %rbx
    9904:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    990b:	48 8b 5f 70          	mov    0x70(%rdi),%rbx
    990f:	44 0f b7 67 68       	movzwl 0x68(%rdi),%r12d
    9914:	48 85 c0             	test   %rax,%rax
    9917:	74 06                	je     991f <__x64_sys_mkdir+0x2f>
    9919:	8b 00                	mov    (%rax),%eax
    991b:	85 c0                	test   %eax,%eax
    991d:	74 2b                	je     994a <__x64_sys_mkdir+0x5a>
    991f:	31 f6                	xor    %esi,%esi
    9921:	48 89 df             	mov    %rbx,%rdi
    9924:	e8 37 7e ff ff       	call   1760 <getname_flags.part.0>
    9929:	48 89 c6             	mov    %rax,%rsi
    992c:	44 89 e2             	mov    %r12d,%edx
    992f:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    9934:	e8 00 00 00 00       	call   9939 <__x64_sys_mkdir+0x49>
    9939:	5b                   	pop    %rbx
    993a:	41 5c                	pop    %r12
    993c:	48 98                	cltq
    993e:	5d                   	pop    %rbp
    993f:	31 d2                	xor    %edx,%edx
    9941:	31 f6                	xor    %esi,%esi
    9943:	31 ff                	xor    %edi,%edi
    9945:	e9 00 00 00 00       	jmp    994a <__x64_sys_mkdir+0x5a>
    994a:	48 89 df             	mov    %rbx,%rdi
    994d:	e8 00 00 00 00       	call   9952 <__x64_sys_mkdir+0x62>
    9952:	48 89 c6             	mov    %rax,%rsi
    9955:	48 85 c0             	test   %rax,%rax
    9958:	75 d2                	jne    992c <__x64_sys_mkdir+0x3c>
    995a:	eb c3                	jmp    991f <__x64_sys_mkdir+0x2f>
    995c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000009960 <__pfx_do_rmdir>:
    9960:	90                   	nop
    9961:	90                   	nop
    9962:	90                   	nop
    9963:	90                   	nop
    9964:	90                   	nop
    9965:	90                   	nop
    9966:	90                   	nop
    9967:	90                   	nop
    9968:	90                   	nop
    9969:	90                   	nop
    996a:	90                   	nop
    996b:	90                   	nop
    996c:	90                   	nop
    996d:	90                   	nop
    996e:	90                   	nop
    996f:	90                   	nop

0000000000009970 <do_rmdir>:
    9970:	e8 00 00 00 00       	call   9975 <do_rmdir+0x5>
    9975:	55                   	push   %rbp
    9976:	48 89 e5             	mov    %rsp,%rbp
    9979:	41 57                	push   %r15
    997b:	41 bf 02 00 00 00    	mov    $0x2,%r15d
    9981:	41 56                	push   %r14
    9983:	45 31 f6             	xor    %r14d,%r14d
    9986:	41 55                	push   %r13
    9988:	41 89 fd             	mov    %edi,%r13d
    998b:	41 54                	push   %r12
    998d:	49 89 f4             	mov    %rsi,%r12
    9990:	53                   	push   %rbx
    9991:	48 83 ec 30          	sub    $0x30,%rsp
    9995:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 999d <do_rmdir+0x2d>
    999c:	00 
    999d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    99a1:	31 c0                	xor    %eax,%eax
    99a3:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    99aa:	00 
    99ab:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
    99b2:	00 
    99b3:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    99ba:	00 
    99bb:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    99c2:	00 
    99c3:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%rbp)
    99ca:	6a 00                	push   $0x0
    99cc:	4c 8d 4d ac          	lea    -0x54(%rbp),%r9
    99d0:	4c 8d 45 c0          	lea    -0x40(%rbp),%r8
    99d4:	44 89 f2             	mov    %r14d,%edx
    99d7:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    99db:	4c 89 e6             	mov    %r12,%rsi
    99de:	44 89 ef             	mov    %r13d,%edi
    99e1:	e8 1a cc ff ff       	call   6600 <__filename_parentat>
    99e6:	89 c3                	mov    %eax,%ebx
    99e8:	58                   	pop    %rax
    99e9:	85 db                	test   %ebx,%ebx
    99eb:	75 2d                	jne    9a1a <do_rmdir+0xaa>
    99ed:	8b 45 ac             	mov    -0x54(%rbp),%eax
    99f0:	83 e8 01             	sub    $0x1,%eax
    99f3:	83 f8 02             	cmp    $0x2,%eax
    99f6:	77 5f                	ja     9a57 <do_rmdir+0xe7>
    99f8:	8b 1c 85 00 00 00 00 	mov    0x0(,%rax,4),%ebx
    99ff:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    9a03:	e8 00 00 00 00       	call   9a08 <do_rmdir+0x98>
    9a08:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    9a0c:	e8 00 00 00 00       	call   9a11 <do_rmdir+0xa1>
    9a11:	83 fb 8c             	cmp    $0xffffff8c,%ebx
    9a14:	0f 84 d3 00 00 00    	je     9aed <do_rmdir+0x17d>
    9a1a:	4c 89 e7             	mov    %r12,%rdi
    9a1d:	e8 00 00 00 00       	call   9a22 <do_rmdir+0xb2>
    9a22:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    9a26:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 9a2e <do_rmdir+0xbe>
    9a2d:	00 
    9a2e:	0f 85 d4 00 00 00    	jne    9b08 <do_rmdir+0x198>
    9a34:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    9a38:	89 d8                	mov    %ebx,%eax
    9a3a:	5b                   	pop    %rbx
    9a3b:	41 5c                	pop    %r12
    9a3d:	41 5d                	pop    %r13
    9a3f:	41 5e                	pop    %r14
    9a41:	41 5f                	pop    %r15
    9a43:	5d                   	pop    %rbp
    9a44:	31 d2                	xor    %edx,%edx
    9a46:	31 c9                	xor    %ecx,%ecx
    9a48:	31 f6                	xor    %esi,%esi
    9a4a:	31 ff                	xor    %edi,%edi
    9a4c:	45 31 c0             	xor    %r8d,%r8d
    9a4f:	45 31 c9             	xor    %r9d,%r9d
    9a52:	e9 00 00 00 00       	jmp    9a57 <do_rmdir+0xe7>
    9a57:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    9a5b:	e8 00 00 00 00       	call   9a60 <do_rmdir+0xf0>
    9a60:	89 c3                	mov    %eax,%ebx
    9a62:	85 c0                	test   %eax,%eax
    9a64:	75 99                	jne    99ff <do_rmdir+0x8f>
    9a66:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    9a6a:	48 8b 78 30          	mov    0x30(%rax),%rdi
    9a6e:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    9a75:	e8 00 00 00 00       	call   9a7a <do_rmdir+0x10a>
    9a7a:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
    9a7e:	44 89 f2             	mov    %r14d,%edx
    9a81:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
    9a85:	e8 00 00 00 00       	call   9a8a <do_rmdir+0x11a>
    9a8a:	49 89 c6             	mov    %rax,%r14
    9a8d:	89 c3                	mov    %eax,%ebx
    9a8f:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    9a95:	77 34                	ja     9acb <do_rmdir+0x15b>
    9a97:	48 89 c6             	mov    %rax,%rsi
    9a9a:	48 8d 7d b0          	lea    -0x50(%rbp),%rdi
    9a9e:	e8 00 00 00 00       	call   9aa3 <do_rmdir+0x133>
    9aa3:	89 c3                	mov    %eax,%ebx
    9aa5:	85 c0                	test   %eax,%eax
    9aa7:	75 1a                	jne    9ac3 <do_rmdir+0x153>
    9aa9:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    9aad:	4c 89 f2             	mov    %r14,%rdx
    9ab0:	48 8b 78 18          	mov    0x18(%rax),%rdi
    9ab4:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    9ab8:	48 8b 70 30          	mov    0x30(%rax),%rsi
    9abc:	e8 00 00 00 00       	call   9ac1 <do_rmdir+0x151>
    9ac1:	89 c3                	mov    %eax,%ebx
    9ac3:	4c 89 f7             	mov    %r14,%rdi
    9ac6:	e8 00 00 00 00       	call   9acb <do_rmdir+0x15b>
    9acb:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    9acf:	48 8b 78 30          	mov    0x30(%rax),%rdi
    9ad3:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    9ada:	e8 00 00 00 00       	call   9adf <do_rmdir+0x16f>
    9adf:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    9ae3:	e8 00 00 00 00       	call   9ae8 <do_rmdir+0x178>
    9ae8:	e9 12 ff ff ff       	jmp    99ff <do_rmdir+0x8f>
    9aed:	41 be 80 00 00 00    	mov    $0x80,%r14d
    9af3:	41 83 ff 01          	cmp    $0x1,%r15d
    9af7:	0f 84 1d ff ff ff    	je     9a1a <do_rmdir+0xaa>
    9afd:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    9b03:	e9 c2 fe ff ff       	jmp    99ca <do_rmdir+0x5a>
    9b08:	e8 00 00 00 00       	call   9b0d <do_rmdir+0x19d>
    9b0d:	0f 1f 00             	nopl   (%rax)

0000000000009b10 <__pfx___ia32_sys_rmdir>:
    9b10:	90                   	nop
    9b11:	90                   	nop
    9b12:	90                   	nop
    9b13:	90                   	nop
    9b14:	90                   	nop
    9b15:	90                   	nop
    9b16:	90                   	nop
    9b17:	90                   	nop
    9b18:	90                   	nop
    9b19:	90                   	nop
    9b1a:	90                   	nop
    9b1b:	90                   	nop
    9b1c:	90                   	nop
    9b1d:	90                   	nop
    9b1e:	90                   	nop
    9b1f:	90                   	nop

0000000000009b20 <__ia32_sys_rmdir>:
    9b20:	e8 00 00 00 00       	call   9b25 <__ia32_sys_rmdir+0x5>
    9b25:	55                   	push   %rbp
    9b26:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 9b2e <__ia32_sys_rmdir+0xe>
    9b2d:	00 
    9b2e:	48 89 e5             	mov    %rsp,%rbp
    9b31:	53                   	push   %rbx
    9b32:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    9b39:	8b 5f 28             	mov    0x28(%rdi),%ebx
    9b3c:	48 85 c0             	test   %rax,%rax
    9b3f:	74 06                	je     9b47 <__ia32_sys_rmdir+0x27>
    9b41:	8b 00                	mov    (%rax),%eax
    9b43:	85 c0                	test   %eax,%eax
    9b45:	74 27                	je     9b6e <__ia32_sys_rmdir+0x4e>
    9b47:	31 f6                	xor    %esi,%esi
    9b49:	48 89 df             	mov    %rbx,%rdi
    9b4c:	e8 0f 7c ff ff       	call   1760 <getname_flags.part.0>
    9b51:	48 89 c6             	mov    %rax,%rsi
    9b54:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    9b59:	e8 00 00 00 00       	call   9b5e <__ia32_sys_rmdir+0x3e>
    9b5e:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    9b62:	c9                   	leave
    9b63:	48 98                	cltq
    9b65:	31 f6                	xor    %esi,%esi
    9b67:	31 ff                	xor    %edi,%edi
    9b69:	e9 00 00 00 00       	jmp    9b6e <__ia32_sys_rmdir+0x4e>
    9b6e:	48 89 df             	mov    %rbx,%rdi
    9b71:	e8 00 00 00 00       	call   9b76 <__ia32_sys_rmdir+0x56>
    9b76:	48 89 c6             	mov    %rax,%rsi
    9b79:	48 85 c0             	test   %rax,%rax
    9b7c:	75 d6                	jne    9b54 <__ia32_sys_rmdir+0x34>
    9b7e:	eb c7                	jmp    9b47 <__ia32_sys_rmdir+0x27>

0000000000009b80 <__pfx___x64_sys_rmdir>:
    9b80:	90                   	nop
    9b81:	90                   	nop
    9b82:	90                   	nop
    9b83:	90                   	nop
    9b84:	90                   	nop
    9b85:	90                   	nop
    9b86:	90                   	nop
    9b87:	90                   	nop
    9b88:	90                   	nop
    9b89:	90                   	nop
    9b8a:	90                   	nop
    9b8b:	90                   	nop
    9b8c:	90                   	nop
    9b8d:	90                   	nop
    9b8e:	90                   	nop
    9b8f:	90                   	nop

0000000000009b90 <__x64_sys_rmdir>:
    9b90:	e8 00 00 00 00       	call   9b95 <__x64_sys_rmdir+0x5>
    9b95:	55                   	push   %rbp
    9b96:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 9b9e <__x64_sys_rmdir+0xe>
    9b9d:	00 
    9b9e:	48 89 e5             	mov    %rsp,%rbp
    9ba1:	53                   	push   %rbx
    9ba2:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    9ba9:	48 8b 5f 70          	mov    0x70(%rdi),%rbx
    9bad:	48 85 c0             	test   %rax,%rax
    9bb0:	74 06                	je     9bb8 <__x64_sys_rmdir+0x28>
    9bb2:	8b 00                	mov    (%rax),%eax
    9bb4:	85 c0                	test   %eax,%eax
    9bb6:	74 27                	je     9bdf <__x64_sys_rmdir+0x4f>
    9bb8:	31 f6                	xor    %esi,%esi
    9bba:	48 89 df             	mov    %rbx,%rdi
    9bbd:	e8 9e 7b ff ff       	call   1760 <getname_flags.part.0>
    9bc2:	48 89 c6             	mov    %rax,%rsi
    9bc5:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    9bca:	e8 00 00 00 00       	call   9bcf <__x64_sys_rmdir+0x3f>
    9bcf:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    9bd3:	c9                   	leave
    9bd4:	48 98                	cltq
    9bd6:	31 f6                	xor    %esi,%esi
    9bd8:	31 ff                	xor    %edi,%edi
    9bda:	e9 00 00 00 00       	jmp    9bdf <__x64_sys_rmdir+0x4f>
    9bdf:	48 89 df             	mov    %rbx,%rdi
    9be2:	e8 00 00 00 00       	call   9be7 <__x64_sys_rmdir+0x57>
    9be7:	48 89 c6             	mov    %rax,%rsi
    9bea:	48 85 c0             	test   %rax,%rax
    9bed:	75 d6                	jne    9bc5 <__x64_sys_rmdir+0x35>
    9bef:	eb c7                	jmp    9bb8 <__x64_sys_rmdir+0x28>
    9bf1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9bf8:	00 00 00 00 
    9bfc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000009c00 <__pfx_do_unlinkat>:
    9c00:	90                   	nop
    9c01:	90                   	nop
    9c02:	90                   	nop
    9c03:	90                   	nop
    9c04:	90                   	nop
    9c05:	90                   	nop
    9c06:	90                   	nop
    9c07:	90                   	nop
    9c08:	90                   	nop
    9c09:	90                   	nop
    9c0a:	90                   	nop
    9c0b:	90                   	nop
    9c0c:	90                   	nop
    9c0d:	90                   	nop
    9c0e:	90                   	nop
    9c0f:	90                   	nop

0000000000009c10 <do_unlinkat>:
    9c10:	e8 00 00 00 00       	call   9c15 <do_unlinkat+0x5>
    9c15:	55                   	push   %rbp
    9c16:	48 89 e5             	mov    %rsp,%rbp
    9c19:	41 57                	push   %r15
    9c1b:	41 56                	push   %r14
    9c1d:	41 55                	push   %r13
    9c1f:	45 31 ed             	xor    %r13d,%r13d
    9c22:	41 54                	push   %r12
    9c24:	53                   	push   %rbx
    9c25:	48 89 f3             	mov    %rsi,%rbx
    9c28:	48 83 ec 40          	sub    $0x40,%rsp
    9c2c:	89 7d 9c             	mov    %edi,-0x64(%rbp)
    9c2f:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 9c37 <do_unlinkat+0x27>
    9c36:	00 
    9c37:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    9c3b:	31 c0                	xor    %eax,%eax
    9c3d:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    9c44:	00 
    9c45:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
    9c4c:	00 
    9c4d:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    9c54:	00 
    9c55:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    9c5c:	00 
    9c5d:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%rbp)
    9c64:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
    9c6b:	00 
    9c6c:	c7 45 98 02 00 00 00 	movl   $0x2,-0x68(%rbp)
    9c73:	6a 00                	push   $0x0
    9c75:	8b 7d 9c             	mov    -0x64(%rbp),%edi
    9c78:	44 89 ea             	mov    %r13d,%edx
    9c7b:	4c 8d 4d a4          	lea    -0x5c(%rbp),%r9
    9c7f:	4c 8d 45 c0          	lea    -0x40(%rbp),%r8
    9c83:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    9c87:	48 89 de             	mov    %rbx,%rsi
    9c8a:	e8 71 c9 ff ff       	call   6600 <__filename_parentat>
    9c8f:	5a                   	pop    %rdx
    9c90:	41 89 c7             	mov    %eax,%r15d
    9c93:	85 c0                	test   %eax,%eax
    9c95:	75 1f                	jne    9cb6 <do_unlinkat+0xa6>
    9c97:	8b 45 a4             	mov    -0x5c(%rbp),%eax
    9c9a:	85 c0                	test   %eax,%eax
    9c9c:	74 56                	je     9cf4 <do_unlinkat+0xe4>
    9c9e:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    9ca2:	41 bf eb ff ff ff    	mov    $0xffffffeb,%r15d
    9ca8:	e8 00 00 00 00       	call   9cad <do_unlinkat+0x9d>
    9cad:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    9cb1:	e8 00 00 00 00       	call   9cb6 <do_unlinkat+0xa6>
    9cb6:	48 89 df             	mov    %rbx,%rdi
    9cb9:	e8 00 00 00 00       	call   9cbe <do_unlinkat+0xae>
    9cbe:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
    9cc2:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # 9cca <do_unlinkat+0xba>
    9cc9:	00 
    9cca:	0f 85 17 02 00 00    	jne    9ee7 <do_unlinkat+0x2d7>
    9cd0:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    9cd4:	44 89 f8             	mov    %r15d,%eax
    9cd7:	5b                   	pop    %rbx
    9cd8:	41 5c                	pop    %r12
    9cda:	41 5d                	pop    %r13
    9cdc:	41 5e                	pop    %r14
    9cde:	41 5f                	pop    %r15
    9ce0:	5d                   	pop    %rbp
    9ce1:	31 d2                	xor    %edx,%edx
    9ce3:	31 c9                	xor    %ecx,%ecx
    9ce5:	31 f6                	xor    %esi,%esi
    9ce7:	31 ff                	xor    %edi,%edi
    9ce9:	45 31 c0             	xor    %r8d,%r8d
    9cec:	45 31 c9             	xor    %r9d,%r9d
    9cef:	e9 00 00 00 00       	jmp    9cf4 <do_unlinkat+0xe4>
    9cf4:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    9cf8:	e8 00 00 00 00       	call   9cfd <do_unlinkat+0xed>
    9cfd:	41 89 c7             	mov    %eax,%r15d
    9d00:	85 c0                	test   %eax,%eax
    9d02:	74 4e                	je     9d52 <do_unlinkat+0x142>
    9d04:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    9d08:	e8 00 00 00 00       	call   9d0d <do_unlinkat+0xfd>
    9d0d:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    9d11:	e8 00 00 00 00       	call   9d16 <do_unlinkat+0x106>
    9d16:	41 83 ff 8c          	cmp    $0xffffff8c,%r15d
    9d1a:	75 9a                	jne    9cb6 <do_unlinkat+0xa6>
    9d1c:	83 7d 98 01          	cmpl   $0x1,-0x68(%rbp)
    9d20:	41 bd 80 00 00 00    	mov    $0x80,%r13d
    9d26:	74 8e                	je     9cb6 <do_unlinkat+0xa6>
    9d28:	c7 45 98 01 00 00 00 	movl   $0x1,-0x68(%rbp)
    9d2f:	e9 3f ff ff ff       	jmp    9c73 <do_unlinkat+0x63>
    9d34:	48 8b 40 30          	mov    0x30(%rax),%rax
    9d38:	48 39 c2             	cmp    %rax,%rdx
    9d3b:	0f 85 bb 00 00 00    	jne    9dfc <do_unlinkat+0x1ec>
    9d41:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
    9d45:	e8 00 00 00 00       	call   9d4a <do_unlinkat+0x13a>
    9d4a:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
    9d51:	00 
    9d52:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    9d56:	48 8b 78 30          	mov    0x30(%rax),%rdi
    9d5a:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    9d61:	e8 00 00 00 00       	call   9d66 <do_unlinkat+0x156>
    9d66:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
    9d6a:	44 89 ea             	mov    %r13d,%edx
    9d6d:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
    9d71:	e8 00 00 00 00       	call   9d76 <do_unlinkat+0x166>
    9d76:	49 89 c4             	mov    %rax,%r12
    9d79:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    9d7f:	0f 87 46 01 00 00    	ja     9ecb <do_unlinkat+0x2bb>
    9d85:	8b 45 c4             	mov    -0x3c(%rbp),%eax
    9d88:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
    9d8c:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
    9d90:	0f 84 a0 00 00 00    	je     9e36 <do_unlinkat+0x226>
    9d96:	41 8b 04 24          	mov    (%r12),%eax
    9d9a:	4c 89 e7             	mov    %r12,%rdi
    9d9d:	25 00 00 30 00       	and    $0x300000,%eax
    9da2:	3d 00 00 10 00       	cmp    $0x100000,%eax
    9da7:	0f 85 fa 00 00 00    	jne    9ea7 <do_unlinkat+0x297>
    9dad:	e8 00 00 00 00       	call   9db2 <do_unlinkat+0x1a2>
    9db2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    9db6:	41 bf eb ff ff ff    	mov    $0xffffffeb,%r15d
    9dbc:	48 8b 78 30          	mov    0x30(%rax),%rdi
    9dc0:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    9dc7:	e8 00 00 00 00       	call   9dcc <do_unlinkat+0x1bc>
    9dcc:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
    9dd0:	48 85 ff             	test   %rdi,%rdi
    9dd3:	74 53                	je     9e28 <do_unlinkat+0x218>
    9dd5:	48 8b 87 68 01 00 00 	mov    0x168(%rdi),%rax
    9ddc:	48 85 c0             	test   %rax,%rax
    9ddf:	0f 84 60 ff ff ff    	je     9d45 <do_unlinkat+0x135>
    9de5:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
    9deb:	48 8b 50 28          	mov    0x28(%rax),%rdx
    9def:	48 8d 48 28          	lea    0x28(%rax),%rcx
    9df3:	48 39 ca             	cmp    %rcx,%rdx
    9df6:	0f 84 38 ff ff ff    	je     9d34 <do_unlinkat+0x124>
    9dfc:	ba 04 00 00 00       	mov    $0x4,%edx
    9e01:	be 01 00 00 00       	mov    $0x1,%esi
    9e06:	e8 00 00 00 00       	call   9e0b <do_unlinkat+0x1fb>
    9e0b:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
    9e0f:	41 89 c7             	mov    %eax,%r15d
    9e12:	e8 00 00 00 00       	call   9e17 <do_unlinkat+0x207>
    9e17:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
    9e1e:	00 
    9e1f:	45 85 ff             	test   %r15d,%r15d
    9e22:	0f 84 2a ff ff ff    	je     9d52 <do_unlinkat+0x142>
    9e28:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
    9e2c:	e8 00 00 00 00       	call   9e31 <do_unlinkat+0x221>
    9e31:	e9 ce fe ff ff       	jmp    9d04 <do_unlinkat+0xf4>
    9e36:	4d 8b 74 24 30       	mov    0x30(%r12),%r14
    9e3b:	4c 89 f7             	mov    %r14,%rdi
    9e3e:	e8 00 00 00 00       	call   9e43 <do_unlinkat+0x233>
    9e43:	4c 89 e6             	mov    %r12,%rsi
    9e46:	48 8d 7d b0          	lea    -0x50(%rbp),%rdi
    9e4a:	e8 00 00 00 00       	call   9e4f <do_unlinkat+0x23f>
    9e4f:	41 89 c7             	mov    %eax,%r15d
    9e52:	85 c0                	test   %eax,%eax
    9e54:	75 1f                	jne    9e75 <do_unlinkat+0x265>
    9e56:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    9e5a:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
    9e5e:	4c 89 e2             	mov    %r12,%rdx
    9e61:	48 8b 78 18          	mov    0x18(%rax),%rdi
    9e65:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    9e69:	48 8b 70 30          	mov    0x30(%rax),%rsi
    9e6d:	e8 00 00 00 00       	call   9e72 <do_unlinkat+0x262>
    9e72:	41 89 c7             	mov    %eax,%r15d
    9e75:	4c 89 e7             	mov    %r12,%rdi
    9e78:	e8 00 00 00 00       	call   9e7d <do_unlinkat+0x26d>
    9e7d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
    9e81:	48 8b 7a 30          	mov    0x30(%rdx),%rdi
    9e85:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    9e8c:	e8 00 00 00 00       	call   9e91 <do_unlinkat+0x281>
    9e91:	4d 85 f6             	test   %r14,%r14
    9e94:	0f 84 32 ff ff ff    	je     9dcc <do_unlinkat+0x1bc>
    9e9a:	4c 89 f7             	mov    %r14,%rdi
    9e9d:	e8 00 00 00 00       	call   9ea2 <do_unlinkat+0x292>
    9ea2:	e9 25 ff ff ff       	jmp    9dcc <do_unlinkat+0x1bc>
    9ea7:	e8 00 00 00 00       	call   9eac <do_unlinkat+0x29c>
    9eac:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    9eb0:	41 bf ec ff ff ff    	mov    $0xffffffec,%r15d
    9eb6:	48 8b 78 30          	mov    0x30(%rax),%rdi
    9eba:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    9ec1:	e8 00 00 00 00       	call   9ec6 <do_unlinkat+0x2b6>
    9ec6:	e9 01 ff ff ff       	jmp    9dcc <do_unlinkat+0x1bc>
    9ecb:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
    9ecf:	41 89 c7             	mov    %eax,%r15d
    9ed2:	48 8b 7a 30          	mov    0x30(%rdx),%rdi
    9ed6:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    9edd:	e8 00 00 00 00       	call   9ee2 <do_unlinkat+0x2d2>
    9ee2:	e9 e5 fe ff ff       	jmp    9dcc <do_unlinkat+0x1bc>
    9ee7:	e8 00 00 00 00       	call   9eec <do_unlinkat+0x2dc>
    9eec:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000009ef0 <__pfx___ia32_sys_unlinkat>:
    9ef0:	90                   	nop
    9ef1:	90                   	nop
    9ef2:	90                   	nop
    9ef3:	90                   	nop
    9ef4:	90                   	nop
    9ef5:	90                   	nop
    9ef6:	90                   	nop
    9ef7:	90                   	nop
    9ef8:	90                   	nop
    9ef9:	90                   	nop
    9efa:	90                   	nop
    9efb:	90                   	nop
    9efc:	90                   	nop
    9efd:	90                   	nop
    9efe:	90                   	nop
    9eff:	90                   	nop

0000000000009f00 <__ia32_sys_unlinkat>:
    9f00:	e8 00 00 00 00       	call   9f05 <__ia32_sys_unlinkat+0x5>
    9f05:	55                   	push   %rbp
    9f06:	48 89 e5             	mov    %rsp,%rbp
    9f09:	53                   	push   %rbx
    9f0a:	48 8b 47 60          	mov    0x60(%rdi),%rax
    9f0e:	8b 57 58             	mov    0x58(%rdi),%edx
    9f11:	8b 5f 28             	mov    0x28(%rdi),%ebx
    9f14:	a9 ff fd ff ff       	test   $0xfffffdff,%eax
    9f19:	75 4c                	jne    9f67 <__ia32_sys_unlinkat+0x67>
    9f1b:	31 f6                	xor    %esi,%esi
    9f1d:	48 89 d7             	mov    %rdx,%rdi
    9f20:	f6 c4 02             	test   $0x2,%ah
    9f23:	75 21                	jne    9f46 <__ia32_sys_unlinkat+0x46>
    9f25:	e8 00 00 00 00       	call   9f2a <__ia32_sys_unlinkat+0x2a>
    9f2a:	89 df                	mov    %ebx,%edi
    9f2c:	48 89 c6             	mov    %rax,%rsi
    9f2f:	e8 00 00 00 00       	call   9f34 <__ia32_sys_unlinkat+0x34>
    9f34:	48 98                	cltq
    9f36:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    9f3a:	c9                   	leave
    9f3b:	31 d2                	xor    %edx,%edx
    9f3d:	31 f6                	xor    %esi,%esi
    9f3f:	31 ff                	xor    %edi,%edi
    9f41:	e9 00 00 00 00       	jmp    9f46 <__ia32_sys_unlinkat+0x46>
    9f46:	e8 00 00 00 00       	call   9f4b <__ia32_sys_unlinkat+0x4b>
    9f4b:	89 df                	mov    %ebx,%edi
    9f4d:	48 89 c6             	mov    %rax,%rsi
    9f50:	e8 00 00 00 00       	call   9f55 <__ia32_sys_unlinkat+0x55>
    9f55:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    9f59:	c9                   	leave
    9f5a:	48 98                	cltq
    9f5c:	31 d2                	xor    %edx,%edx
    9f5e:	31 f6                	xor    %esi,%esi
    9f60:	31 ff                	xor    %edi,%edi
    9f62:	e9 00 00 00 00       	jmp    9f67 <__ia32_sys_unlinkat+0x67>
    9f67:	48 c7 c0 ea ff ff ff 	mov    $0xffffffffffffffea,%rax
    9f6e:	eb c6                	jmp    9f36 <__ia32_sys_unlinkat+0x36>

0000000000009f70 <__pfx___ia32_sys_unlink>:
    9f70:	90                   	nop
    9f71:	90                   	nop
    9f72:	90                   	nop
    9f73:	90                   	nop
    9f74:	90                   	nop
    9f75:	90                   	nop
    9f76:	90                   	nop
    9f77:	90                   	nop
    9f78:	90                   	nop
    9f79:	90                   	nop
    9f7a:	90                   	nop
    9f7b:	90                   	nop
    9f7c:	90                   	nop
    9f7d:	90                   	nop
    9f7e:	90                   	nop
    9f7f:	90                   	nop

0000000000009f80 <__ia32_sys_unlink>:
    9f80:	e8 00 00 00 00       	call   9f85 <__ia32_sys_unlink+0x5>
    9f85:	55                   	push   %rbp
    9f86:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 9f8e <__ia32_sys_unlink+0xe>
    9f8d:	00 
    9f8e:	48 89 e5             	mov    %rsp,%rbp
    9f91:	53                   	push   %rbx
    9f92:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    9f99:	8b 5f 28             	mov    0x28(%rdi),%ebx
    9f9c:	48 85 c0             	test   %rax,%rax
    9f9f:	74 06                	je     9fa7 <__ia32_sys_unlink+0x27>
    9fa1:	8b 00                	mov    (%rax),%eax
    9fa3:	85 c0                	test   %eax,%eax
    9fa5:	74 27                	je     9fce <__ia32_sys_unlink+0x4e>
    9fa7:	31 f6                	xor    %esi,%esi
    9fa9:	48 89 df             	mov    %rbx,%rdi
    9fac:	e8 af 77 ff ff       	call   1760 <getname_flags.part.0>
    9fb1:	48 89 c6             	mov    %rax,%rsi
    9fb4:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    9fb9:	e8 00 00 00 00       	call   9fbe <__ia32_sys_unlink+0x3e>
    9fbe:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    9fc2:	c9                   	leave
    9fc3:	48 98                	cltq
    9fc5:	31 f6                	xor    %esi,%esi
    9fc7:	31 ff                	xor    %edi,%edi
    9fc9:	e9 00 00 00 00       	jmp    9fce <__ia32_sys_unlink+0x4e>
    9fce:	48 89 df             	mov    %rbx,%rdi
    9fd1:	e8 00 00 00 00       	call   9fd6 <__ia32_sys_unlink+0x56>
    9fd6:	48 89 c6             	mov    %rax,%rsi
    9fd9:	48 85 c0             	test   %rax,%rax
    9fdc:	75 d6                	jne    9fb4 <__ia32_sys_unlink+0x34>
    9fde:	eb c7                	jmp    9fa7 <__ia32_sys_unlink+0x27>

0000000000009fe0 <__pfx___x64_sys_unlink>:
    9fe0:	90                   	nop
    9fe1:	90                   	nop
    9fe2:	90                   	nop
    9fe3:	90                   	nop
    9fe4:	90                   	nop
    9fe5:	90                   	nop
    9fe6:	90                   	nop
    9fe7:	90                   	nop
    9fe8:	90                   	nop
    9fe9:	90                   	nop
    9fea:	90                   	nop
    9feb:	90                   	nop
    9fec:	90                   	nop
    9fed:	90                   	nop
    9fee:	90                   	nop
    9fef:	90                   	nop

0000000000009ff0 <__x64_sys_unlink>:
    9ff0:	e8 00 00 00 00       	call   9ff5 <__x64_sys_unlink+0x5>
    9ff5:	55                   	push   %rbp
    9ff6:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 9ffe <__x64_sys_unlink+0xe>
    9ffd:	00 
    9ffe:	48 89 e5             	mov    %rsp,%rbp
    a001:	53                   	push   %rbx
    a002:	48 8b 80 70 0d 00 00 	mov    0xd70(%rax),%rax
    a009:	48 8b 5f 70          	mov    0x70(%rdi),%rbx
    a00d:	48 85 c0             	test   %rax,%rax
    a010:	74 06                	je     a018 <__x64_sys_unlink+0x28>
    a012:	8b 00                	mov    (%rax),%eax
    a014:	85 c0                	test   %eax,%eax
    a016:	74 27                	je     a03f <__x64_sys_unlink+0x4f>
    a018:	31 f6                	xor    %esi,%esi
    a01a:	48 89 df             	mov    %rbx,%rdi
    a01d:	e8 3e 77 ff ff       	call   1760 <getname_flags.part.0>
    a022:	48 89 c6             	mov    %rax,%rsi
    a025:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    a02a:	e8 00 00 00 00       	call   a02f <__x64_sys_unlink+0x3f>
    a02f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    a033:	c9                   	leave
    a034:	48 98                	cltq
    a036:	31 f6                	xor    %esi,%esi
    a038:	31 ff                	xor    %edi,%edi
    a03a:	e9 00 00 00 00       	jmp    a03f <__x64_sys_unlink+0x4f>
    a03f:	48 89 df             	mov    %rbx,%rdi
    a042:	e8 00 00 00 00       	call   a047 <__x64_sys_unlink+0x57>
    a047:	48 89 c6             	mov    %rax,%rsi
    a04a:	48 85 c0             	test   %rax,%rax
    a04d:	75 d6                	jne    a025 <__x64_sys_unlink+0x35>
    a04f:	eb c7                	jmp    a018 <__x64_sys_unlink+0x28>
    a051:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a058:	00 00 00 00 
    a05c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000a060 <__pfx___x64_sys_unlinkat>:
    a060:	90                   	nop
    a061:	90                   	nop
    a062:	90                   	nop
    a063:	90                   	nop
    a064:	90                   	nop
    a065:	90                   	nop
    a066:	90                   	nop
    a067:	90                   	nop
    a068:	90                   	nop
    a069:	90                   	nop
    a06a:	90                   	nop
    a06b:	90                   	nop
    a06c:	90                   	nop
    a06d:	90                   	nop
    a06e:	90                   	nop
    a06f:	90                   	nop

000000000000a070 <__x64_sys_unlinkat>:
    a070:	e8 00 00 00 00       	call   a075 <__x64_sys_unlinkat+0x5>
    a075:	55                   	push   %rbp
    a076:	48 89 e5             	mov    %rsp,%rbp
    a079:	53                   	push   %rbx
    a07a:	48 8b 47 60          	mov    0x60(%rdi),%rax
    a07e:	48 8b 57 68          	mov    0x68(%rdi),%rdx
    a082:	8b 5f 70             	mov    0x70(%rdi),%ebx
    a085:	a9 ff fd ff ff       	test   $0xfffffdff,%eax
    a08a:	75 4c                	jne    a0d8 <__x64_sys_unlinkat+0x68>
    a08c:	31 f6                	xor    %esi,%esi
    a08e:	48 89 d7             	mov    %rdx,%rdi
    a091:	f6 c4 02             	test   $0x2,%ah
    a094:	75 21                	jne    a0b7 <__x64_sys_unlinkat+0x47>
    a096:	e8 00 00 00 00       	call   a09b <__x64_sys_unlinkat+0x2b>
    a09b:	89 df                	mov    %ebx,%edi
    a09d:	48 89 c6             	mov    %rax,%rsi
    a0a0:	e8 00 00 00 00       	call   a0a5 <__x64_sys_unlinkat+0x35>
    a0a5:	48 98                	cltq
    a0a7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    a0ab:	c9                   	leave
    a0ac:	31 d2                	xor    %edx,%edx
    a0ae:	31 f6                	xor    %esi,%esi
    a0b0:	31 ff                	xor    %edi,%edi
    a0b2:	e9 00 00 00 00       	jmp    a0b7 <__x64_sys_unlinkat+0x47>
    a0b7:	e8 00 00 00 00       	call   a0bc <__x64_sys_unlinkat+0x4c>
    a0bc:	89 df                	mov    %ebx,%edi
    a0be:	48 89 c6             	mov    %rax,%rsi
    a0c1:	e8 00 00 00 00       	call   a0c6 <__x64_sys_unlinkat+0x56>
    a0c6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    a0ca:	c9                   	leave
    a0cb:	48 98                	cltq
    a0cd:	31 d2                	xor    %edx,%edx
    a0cf:	31 f6                	xor    %esi,%esi
    a0d1:	31 ff                	xor    %edi,%edi
    a0d3:	e9 00 00 00 00       	jmp    a0d8 <__x64_sys_unlinkat+0x68>
    a0d8:	48 c7 c0 ea ff ff ff 	mov    $0xffffffffffffffea,%rax
    a0df:	eb c6                	jmp    a0a7 <__x64_sys_unlinkat+0x37>
    a0e1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a0e8:	00 00 00 00 
    a0ec:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000a0f0 <__pfx_do_symlinkat>:
    a0f0:	90                   	nop
    a0f1:	90                   	nop
    a0f2:	90                   	nop
    a0f3:	90                   	nop
    a0f4:	90                   	nop
    a0f5:	90                   	nop
    a0f6:	90                   	nop
    a0f7:	90                   	nop
    a0f8:	90                   	nop
    a0f9:	90                   	nop
    a0fa:	90                   	nop
    a0fb:	90                   	nop
    a0fc:	90                   	nop
    a0fd:	90                   	nop
    a0fe:	90                   	nop
    a0ff:	90                   	nop

000000000000a100 <do_symlinkat>:
    a100:	e8 00 00 00 00       	call   a105 <do_symlinkat+0x5>
    a105:	55                   	push   %rbp
    a106:	48 89 e5             	mov    %rsp,%rbp
    a109:	41 57                	push   %r15
    a10b:	41 56                	push   %r14
    a10d:	41 55                	push   %r13
    a10f:	49 89 d5             	mov    %rdx,%r13
    a112:	41 54                	push   %r12
    a114:	41 89 fc             	mov    %edi,%r12d
    a117:	53                   	push   %rbx
    a118:	48 89 fb             	mov    %rdi,%rbx
    a11b:	48 83 ec 20          	sub    $0x20,%rsp
    a11f:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # a127 <do_symlinkat+0x27>
    a126:	00 
    a127:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    a12b:	31 c0                	xor    %eax,%eax
    a12d:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    a134:	00 
    a135:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    a13c:	00 
    a13d:	c7 45 bc 02 00 00 00 	movl   $0x2,-0x44(%rbp)
    a144:	48 81 ff 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rdi
    a14b:	77 76                	ja     a1c3 <do_symlinkat+0xc3>
    a14d:	41 89 f6             	mov    %esi,%r14d
    a150:	31 c9                	xor    %ecx,%ecx
    a152:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
    a156:	4c 89 ee             	mov    %r13,%rsi
    a159:	44 89 f7             	mov    %r14d,%edi
    a15c:	e8 2f c8 ff ff       	call   6990 <filename_create>
    a161:	49 89 c7             	mov    %rax,%r15
    a164:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    a16a:	0f 87 b2 00 00 00    	ja     a222 <do_symlinkat+0x122>
    a170:	48 8b 13             	mov    (%rbx),%rdx
    a173:	48 89 c6             	mov    %rax,%rsi
    a176:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
    a17a:	e8 00 00 00 00       	call   a17f <do_symlinkat+0x7f>
    a17f:	41 89 c4             	mov    %eax,%r12d
    a182:	85 c0                	test   %eax,%eax
    a184:	74 79                	je     a1ff <do_symlinkat+0xff>
    a186:	4c 89 ff             	mov    %r15,%rdi
    a189:	e8 00 00 00 00       	call   a18e <do_symlinkat+0x8e>
    a18e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    a192:	48 8b 78 30          	mov    0x30(%rax),%rdi
    a196:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    a19d:	e8 00 00 00 00       	call   a1a2 <do_symlinkat+0xa2>
    a1a2:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    a1a6:	e8 00 00 00 00       	call   a1ab <do_symlinkat+0xab>
    a1ab:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    a1af:	e8 00 00 00 00       	call   a1b4 <do_symlinkat+0xb4>
    a1b4:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    a1b8:	e8 00 00 00 00       	call   a1bd <do_symlinkat+0xbd>
    a1bd:	41 83 fc 8c          	cmp    $0xffffff8c,%r12d
    a1c1:	74 64                	je     a227 <do_symlinkat+0x127>
    a1c3:	4c 89 ef             	mov    %r13,%rdi
    a1c6:	e8 00 00 00 00       	call   a1cb <do_symlinkat+0xcb>
    a1cb:	48 89 df             	mov    %rbx,%rdi
    a1ce:	e8 00 00 00 00       	call   a1d3 <do_symlinkat+0xd3>
    a1d3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    a1d7:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # a1df <do_symlinkat+0xdf>
    a1de:	00 
    a1df:	75 5d                	jne    a23e <do_symlinkat+0x13e>
    a1e1:	48 83 c4 20          	add    $0x20,%rsp
    a1e5:	44 89 e0             	mov    %r12d,%eax
    a1e8:	5b                   	pop    %rbx
    a1e9:	41 5c                	pop    %r12
    a1eb:	41 5d                	pop    %r13
    a1ed:	41 5e                	pop    %r14
    a1ef:	41 5f                	pop    %r15
    a1f1:	5d                   	pop    %rbp
    a1f2:	31 d2                	xor    %edx,%edx
    a1f4:	31 c9                	xor    %ecx,%ecx
    a1f6:	31 f6                	xor    %esi,%esi
    a1f8:	31 ff                	xor    %edi,%edi
    a1fa:	e9 00 00 00 00       	jmp    a1ff <do_symlinkat+0xff>
    a1ff:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    a203:	48 8b 0b             	mov    (%rbx),%rcx
    a206:	4c 89 fa             	mov    %r15,%rdx
    a209:	48 8b 78 18          	mov    0x18(%rax),%rdi
    a20d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    a211:	48 8b 70 30          	mov    0x30(%rax),%rsi
    a215:	e8 00 00 00 00       	call   a21a <do_symlinkat+0x11a>
    a21a:	41 89 c4             	mov    %eax,%r12d
    a21d:	e9 64 ff ff ff       	jmp    a186 <do_symlinkat+0x86>
    a222:	41 89 c4             	mov    %eax,%r12d
    a225:	eb 9c                	jmp    a1c3 <do_symlinkat+0xc3>
    a227:	83 7d bc 01          	cmpl   $0x1,-0x44(%rbp)
    a22b:	b9 80 00 00 00       	mov    $0x80,%ecx
    a230:	74 91                	je     a1c3 <do_symlinkat+0xc3>
    a232:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%rbp)
    a239:	e9 14 ff ff ff       	jmp    a152 <do_symlinkat+0x52>
    a23e:	e8 00 00 00 00       	call   a243 <do_symlinkat+0x143>
    a243:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a24a:	00 00 00 00 
    a24e:	66 90                	xchg   %ax,%ax

000000000000a250 <__pfx___ia32_sys_symlinkat>:
    a250:	90                   	nop
    a251:	90                   	nop
    a252:	90                   	nop
    a253:	90                   	nop
    a254:	90                   	nop
    a255:	90                   	nop
    a256:	90                   	nop
    a257:	90                   	nop
    a258:	90                   	nop
    a259:	90                   	nop
    a25a:	90                   	nop
    a25b:	90                   	nop
    a25c:	90                   	nop
    a25d:	90                   	nop
    a25e:	90                   	nop
    a25f:	90                   	nop

000000000000a260 <__ia32_sys_symlinkat>:
    a260:	e8 00 00 00 00       	call   a265 <__ia32_sys_symlinkat+0x5>
    a265:	55                   	push   %rbp
    a266:	31 f6                	xor    %esi,%esi
    a268:	48 89 e5             	mov    %rsp,%rbp
    a26b:	41 55                	push   %r13
    a26d:	41 54                	push   %r12
    a26f:	53                   	push   %rbx
    a270:	44 8b 67 58          	mov    0x58(%rdi),%r12d
    a274:	44 8b 6f 28          	mov    0x28(%rdi),%r13d
    a278:	8b 7f 60             	mov    0x60(%rdi),%edi
    a27b:	e8 00 00 00 00       	call   a280 <__ia32_sys_symlinkat+0x20>
    a280:	4c 89 ef             	mov    %r13,%rdi
    a283:	31 f6                	xor    %esi,%esi
    a285:	48 89 c3             	mov    %rax,%rbx
    a288:	e8 00 00 00 00       	call   a28d <__ia32_sys_symlinkat+0x2d>
    a28d:	48 89 da             	mov    %rbx,%rdx
    a290:	44 89 e6             	mov    %r12d,%esi
    a293:	48 89 c7             	mov    %rax,%rdi
    a296:	e8 00 00 00 00       	call   a29b <__ia32_sys_symlinkat+0x3b>
    a29b:	5b                   	pop    %rbx
    a29c:	41 5c                	pop    %r12
    a29e:	48 98                	cltq
    a2a0:	41 5d                	pop    %r13
    a2a2:	5d                   	pop    %rbp
    a2a3:	31 d2                	xor    %edx,%edx
    a2a5:	31 f6                	xor    %esi,%esi
    a2a7:	31 ff                	xor    %edi,%edi
    a2a9:	e9 00 00 00 00       	jmp    a2ae <__ia32_sys_symlinkat+0x4e>
    a2ae:	66 90                	xchg   %ax,%ax

000000000000a2b0 <__pfx___ia32_sys_symlink>:
    a2b0:	90                   	nop
    a2b1:	90                   	nop
    a2b2:	90                   	nop
    a2b3:	90                   	nop
    a2b4:	90                   	nop
    a2b5:	90                   	nop
    a2b6:	90                   	nop
    a2b7:	90                   	nop
    a2b8:	90                   	nop
    a2b9:	90                   	nop
    a2ba:	90                   	nop
    a2bb:	90                   	nop
    a2bc:	90                   	nop
    a2bd:	90                   	nop
    a2be:	90                   	nop
    a2bf:	90                   	nop

000000000000a2c0 <__ia32_sys_symlink>:
    a2c0:	e8 00 00 00 00       	call   a2c5 <__ia32_sys_symlink+0x5>
    a2c5:	55                   	push   %rbp
    a2c6:	31 f6                	xor    %esi,%esi
    a2c8:	48 89 e5             	mov    %rsp,%rbp
    a2cb:	41 54                	push   %r12
    a2cd:	53                   	push   %rbx
    a2ce:	44 8b 67 28          	mov    0x28(%rdi),%r12d
    a2d2:	8b 7f 58             	mov    0x58(%rdi),%edi
    a2d5:	e8 00 00 00 00       	call   a2da <__ia32_sys_symlink+0x1a>
    a2da:	4c 89 e7             	mov    %r12,%rdi
    a2dd:	31 f6                	xor    %esi,%esi
    a2df:	48 89 c3             	mov    %rax,%rbx
    a2e2:	e8 00 00 00 00       	call   a2e7 <__ia32_sys_symlink+0x27>
    a2e7:	48 89 da             	mov    %rbx,%rdx
    a2ea:	be 9c ff ff ff       	mov    $0xffffff9c,%esi
    a2ef:	48 89 c7             	mov    %rax,%rdi
    a2f2:	e8 00 00 00 00       	call   a2f7 <__ia32_sys_symlink+0x37>
    a2f7:	5b                   	pop    %rbx
    a2f8:	41 5c                	pop    %r12
    a2fa:	48 98                	cltq
    a2fc:	5d                   	pop    %rbp
    a2fd:	31 d2                	xor    %edx,%edx
    a2ff:	31 f6                	xor    %esi,%esi
    a301:	31 ff                	xor    %edi,%edi
    a303:	e9 00 00 00 00       	jmp    a308 <__ia32_sys_symlink+0x48>
    a308:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a30f:	00 

000000000000a310 <__pfx___x64_sys_symlinkat>:
    a310:	90                   	nop
    a311:	90                   	nop
    a312:	90                   	nop
    a313:	90                   	nop
    a314:	90                   	nop
    a315:	90                   	nop
    a316:	90                   	nop
    a317:	90                   	nop
    a318:	90                   	nop
    a319:	90                   	nop
    a31a:	90                   	nop
    a31b:	90                   	nop
    a31c:	90                   	nop
    a31d:	90                   	nop
    a31e:	90                   	nop
    a31f:	90                   	nop

000000000000a320 <__x64_sys_symlinkat>:
    a320:	e8 00 00 00 00       	call   a325 <__x64_sys_symlinkat+0x5>
    a325:	55                   	push   %rbp
    a326:	31 f6                	xor    %esi,%esi
    a328:	48 89 e5             	mov    %rsp,%rbp
    a32b:	41 55                	push   %r13
    a32d:	41 54                	push   %r12
    a32f:	53                   	push   %rbx
    a330:	44 8b 67 68          	mov    0x68(%rdi),%r12d
    a334:	4c 8b 6f 70          	mov    0x70(%rdi),%r13
    a338:	48 8b 7f 60          	mov    0x60(%rdi),%rdi
    a33c:	e8 00 00 00 00       	call   a341 <__x64_sys_symlinkat+0x21>
    a341:	4c 89 ef             	mov    %r13,%rdi
    a344:	31 f6                	xor    %esi,%esi
    a346:	48 89 c3             	mov    %rax,%rbx
    a349:	e8 00 00 00 00       	call   a34e <__x64_sys_symlinkat+0x2e>
    a34e:	48 89 da             	mov    %rbx,%rdx
    a351:	44 89 e6             	mov    %r12d,%esi
    a354:	48 89 c7             	mov    %rax,%rdi
    a357:	e8 00 00 00 00       	call   a35c <__x64_sys_symlinkat+0x3c>
    a35c:	5b                   	pop    %rbx
    a35d:	41 5c                	pop    %r12
    a35f:	48 98                	cltq
    a361:	41 5d                	pop    %r13
    a363:	5d                   	pop    %rbp
    a364:	31 d2                	xor    %edx,%edx
    a366:	31 f6                	xor    %esi,%esi
    a368:	31 ff                	xor    %edi,%edi
    a36a:	e9 00 00 00 00       	jmp    a36f <__x64_sys_symlinkat+0x4f>
    a36f:	90                   	nop

000000000000a370 <__pfx___x64_sys_symlink>:
    a370:	90                   	nop
    a371:	90                   	nop
    a372:	90                   	nop
    a373:	90                   	nop
    a374:	90                   	nop
    a375:	90                   	nop
    a376:	90                   	nop
    a377:	90                   	nop
    a378:	90                   	nop
    a379:	90                   	nop
    a37a:	90                   	nop
    a37b:	90                   	nop
    a37c:	90                   	nop
    a37d:	90                   	nop
    a37e:	90                   	nop
    a37f:	90                   	nop

000000000000a380 <__x64_sys_symlink>:
    a380:	e8 00 00 00 00       	call   a385 <__x64_sys_symlink+0x5>
    a385:	55                   	push   %rbp
    a386:	31 f6                	xor    %esi,%esi
    a388:	48 89 e5             	mov    %rsp,%rbp
    a38b:	41 54                	push   %r12
    a38d:	53                   	push   %rbx
    a38e:	4c 8b 67 70          	mov    0x70(%rdi),%r12
    a392:	48 8b 7f 68          	mov    0x68(%rdi),%rdi
    a396:	e8 00 00 00 00       	call   a39b <__x64_sys_symlink+0x1b>
    a39b:	4c 89 e7             	mov    %r12,%rdi
    a39e:	31 f6                	xor    %esi,%esi
    a3a0:	48 89 c3             	mov    %rax,%rbx
    a3a3:	e8 00 00 00 00       	call   a3a8 <__x64_sys_symlink+0x28>
    a3a8:	48 89 da             	mov    %rbx,%rdx
    a3ab:	be 9c ff ff ff       	mov    $0xffffff9c,%esi
    a3b0:	48 89 c7             	mov    %rax,%rdi
    a3b3:	e8 00 00 00 00       	call   a3b8 <__x64_sys_symlink+0x38>
    a3b8:	5b                   	pop    %rbx
    a3b9:	41 5c                	pop    %r12
    a3bb:	48 98                	cltq
    a3bd:	5d                   	pop    %rbp
    a3be:	31 d2                	xor    %edx,%edx
    a3c0:	31 f6                	xor    %esi,%esi
    a3c2:	31 ff                	xor    %edi,%edi
    a3c4:	e9 00 00 00 00       	jmp    a3c9 <__x64_sys_symlink+0x49>
    a3c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000a3d0 <__pfx_do_linkat>:
    a3d0:	90                   	nop
    a3d1:	90                   	nop
    a3d2:	90                   	nop
    a3d3:	90                   	nop
    a3d4:	90                   	nop
    a3d5:	90                   	nop
    a3d6:	90                   	nop
    a3d7:	90                   	nop
    a3d8:	90                   	nop
    a3d9:	90                   	nop
    a3da:	90                   	nop
    a3db:	90                   	nop
    a3dc:	90                   	nop
    a3dd:	90                   	nop
    a3de:	90                   	nop
    a3df:	90                   	nop

000000000000a3e0 <do_linkat>:
    a3e0:	e8 00 00 00 00       	call   a3e5 <do_linkat+0x5>
    a3e5:	55                   	push   %rbp
    a3e6:	48 89 e5             	mov    %rsp,%rbp
    a3e9:	41 57                	push   %r15
    a3eb:	41 56                	push   %r14
    a3ed:	41 55                	push   %r13
    a3ef:	49 89 cd             	mov    %rcx,%r13
    a3f2:	41 54                	push   %r12
    a3f4:	49 89 f4             	mov    %rsi,%r12
    a3f7:	53                   	push   %rbx
    a3f8:	48 83 ec 58          	sub    $0x58,%rsp
    a3fc:	89 7d a4             	mov    %edi,-0x5c(%rbp)
    a3ff:	89 55 a0             	mov    %edx,-0x60(%rbp)
    a402:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # a40a <do_linkat+0x2a>
    a409:	00 
    a40a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    a40e:	31 c0                	xor    %eax,%eax
    a410:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    a417:	00 
    a418:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
    a41f:	00 
    a420:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    a427:	00 
    a428:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    a42f:	00 
    a430:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
    a437:	00 
    a438:	41 f7 c0 ff eb ff ff 	test   $0xffffebff,%r8d
    a43f:	0f 85 4c 02 00 00    	jne    a691 <do_linkat+0x2b1>
    a445:	44 89 c3             	mov    %r8d,%ebx
    a448:	c1 eb 08             	shr    $0x8,%ebx
    a44b:	83 e3 10             	and    $0x10,%ebx
    a44e:	89 d8                	mov    %ebx,%eax
    a450:	83 c8 01             	or     $0x1,%eax
    a453:	41 81 e0 00 04 00 00 	and    $0x400,%r8d
    a45a:	0f 45 d8             	cmovne %eax,%ebx
    a45d:	8b 7d a4             	mov    -0x5c(%rbp),%edi
    a460:	45 31 c0             	xor    %r8d,%r8d
    a463:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    a467:	89 da                	mov    %ebx,%edx
    a469:	4c 89 e6             	mov    %r12,%rsi
    a46c:	e8 00 00 00 00       	call   a471 <do_linkat+0x91>
    a471:	41 89 c6             	mov    %eax,%r14d
    a474:	85 c0                	test   %eax,%eax
    a476:	0f 85 f0 00 00 00    	jne    a56c <do_linkat+0x18c>
    a47c:	89 d8                	mov    %ebx,%eax
    a47e:	8b 7d a0             	mov    -0x60(%rbp),%edi
    a481:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
    a485:	4c 89 ee             	mov    %r13,%rsi
    a488:	25 80 00 00 00       	and    $0x80,%eax
    a48d:	89 c1                	mov    %eax,%ecx
    a48f:	89 45 9c             	mov    %eax,-0x64(%rbp)
    a492:	e8 f9 c4 ff ff       	call   6990 <filename_create>
    a497:	4c 8b 7d b0          	mov    -0x50(%rbp),%r15
    a49b:	48 89 c1             	mov    %rax,%rcx
    a49e:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    a4a4:	0f 87 bb 01 00 00    	ja     a665 <do_linkat+0x285>
    a4aa:	41 be ee ff ff ff    	mov    $0xffffffee,%r14d
    a4b0:	4c 39 7d c0          	cmp    %r15,-0x40(%rbp)
    a4b4:	0f 84 f5 00 00 00    	je     a5af <do_linkat+0x1cf>
    a4ba:	48 89 cf             	mov    %rcx,%rdi
    a4bd:	e8 00 00 00 00       	call   a4c2 <do_linkat+0xe2>
    a4c2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
    a4c6:	48 8b 7a 30          	mov    0x30(%rdx),%rdi
    a4ca:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    a4d1:	e8 00 00 00 00       	call   a4d6 <do_linkat+0xf6>
    a4d6:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    a4da:	e8 00 00 00 00       	call   a4df <do_linkat+0xff>
    a4df:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    a4e3:	e8 00 00 00 00       	call   a4e8 <do_linkat+0x108>
    a4e8:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    a4ec:	e8 00 00 00 00       	call   a4f1 <do_linkat+0x111>
    a4f1:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
    a4f5:	48 85 ff             	test   %rdi,%rdi
    a4f8:	74 57                	je     a551 <do_linkat+0x171>
    a4fa:	48 8b 87 68 01 00 00 	mov    0x168(%rdi),%rax
    a501:	48 85 c0             	test   %rax,%rax
    a504:	0f 84 14 01 00 00    	je     a61e <do_linkat+0x23e>
    a50a:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
    a510:	48 8b 50 28          	mov    0x28(%rax),%rdx
    a514:	48 8d 48 28          	lea    0x28(%rax),%rcx
    a518:	48 39 ca             	cmp    %rcx,%rdx
    a51b:	0f 84 20 01 00 00    	je     a641 <do_linkat+0x261>
    a521:	ba 04 00 00 00       	mov    $0x4,%edx
    a526:	be 01 00 00 00       	mov    $0x1,%esi
    a52b:	e8 00 00 00 00       	call   a530 <do_linkat+0x150>
    a530:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
    a534:	41 89 c6             	mov    %eax,%r14d
    a537:	e8 00 00 00 00       	call   a53c <do_linkat+0x15c>
    a53c:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
    a543:	00 
    a544:	4c 8b 7d b0          	mov    -0x50(%rbp),%r15
    a548:	45 85 f6             	test   %r14d,%r14d
    a54b:	0f 84 da 00 00 00    	je     a62b <do_linkat+0x24b>
    a551:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    a555:	41 83 fe 8c          	cmp    $0xffffff8c,%r14d
    a559:	0f 84 12 01 00 00    	je     a671 <do_linkat+0x291>
    a55f:	e8 00 00 00 00       	call   a564 <do_linkat+0x184>
    a564:	4c 89 ff             	mov    %r15,%rdi
    a567:	e8 00 00 00 00       	call   a56c <do_linkat+0x18c>
    a56c:	4c 89 e7             	mov    %r12,%rdi
    a56f:	e8 00 00 00 00       	call   a574 <do_linkat+0x194>
    a574:	4c 89 ef             	mov    %r13,%rdi
    a577:	e8 00 00 00 00       	call   a57c <do_linkat+0x19c>
    a57c:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
    a580:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # a588 <do_linkat+0x1a8>
    a587:	00 
    a588:	0f 85 0e 01 00 00    	jne    a69c <do_linkat+0x2bc>
    a58e:	48 83 c4 58          	add    $0x58,%rsp
    a592:	44 89 f0             	mov    %r14d,%eax
    a595:	5b                   	pop    %rbx
    a596:	41 5c                	pop    %r12
    a598:	41 5d                	pop    %r13
    a59a:	41 5e                	pop    %r14
    a59c:	41 5f                	pop    %r15
    a59e:	5d                   	pop    %rbp
    a59f:	31 d2                	xor    %edx,%edx
    a5a1:	31 c9                	xor    %ecx,%ecx
    a5a3:	31 f6                	xor    %esi,%esi
    a5a5:	31 ff                	xor    %edi,%edi
    a5a7:	45 31 c0             	xor    %r8d,%r8d
    a5aa:	e9 00 00 00 00       	jmp    a5af <do_linkat+0x1cf>
    a5af:	48 89 45 90          	mov    %rax,-0x70(%rbp)
    a5b3:	49 8b 47 18          	mov    0x18(%r15),%rax
    a5b7:	48 8d 75 b0          	lea    -0x50(%rbp),%rsi
    a5bb:	48 89 c7             	mov    %rax,%rdi
    a5be:	48 89 45 88          	mov    %rax,-0x78(%rbp)
    a5c2:	e8 00 00 00 00       	call   a5c7 <do_linkat+0x1e7>
    a5c7:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
    a5cb:	85 c0                	test   %eax,%eax
    a5cd:	41 89 c6             	mov    %eax,%r14d
    a5d0:	0f 85 e4 fe ff ff    	jne    a4ba <do_linkat+0xda>
    a5d6:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    a5da:	48 89 ca             	mov    %rcx,%rdx
    a5dd:	48 8d 75 c0          	lea    -0x40(%rbp),%rsi
    a5e1:	48 89 7d 80          	mov    %rdi,-0x80(%rbp)
    a5e5:	e8 00 00 00 00       	call   a5ea <do_linkat+0x20a>
    a5ea:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
    a5ee:	85 c0                	test   %eax,%eax
    a5f0:	41 89 c6             	mov    %eax,%r14d
    a5f3:	0f 85 c1 fe ff ff    	jne    a4ba <do_linkat+0xda>
    a5f9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    a5fd:	48 8b 75 88          	mov    -0x78(%rbp),%rsi
    a601:	4c 8d 45 a8          	lea    -0x58(%rbp),%r8
    a605:	48 8b 7d 80          	mov    -0x80(%rbp),%rdi
    a609:	48 8b 50 30          	mov    0x30(%rax),%rdx
    a60d:	e8 00 00 00 00       	call   a612 <do_linkat+0x232>
    a612:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
    a616:	41 89 c6             	mov    %eax,%r14d
    a619:	e9 9c fe ff ff       	jmp    a4ba <do_linkat+0xda>
    a61e:	e8 00 00 00 00       	call   a623 <do_linkat+0x243>
    a623:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
    a62a:	00 
    a62b:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    a62f:	e8 00 00 00 00       	call   a634 <do_linkat+0x254>
    a634:	4c 89 ff             	mov    %r15,%rdi
    a637:	e8 00 00 00 00       	call   a63c <do_linkat+0x25c>
    a63c:	e9 1c fe ff ff       	jmp    a45d <do_linkat+0x7d>
    a641:	48 8b 40 30          	mov    0x30(%rax),%rax
    a645:	48 39 c2             	cmp    %rax,%rdx
    a648:	0f 85 d3 fe ff ff    	jne    a521 <do_linkat+0x141>
    a64e:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
    a652:	e8 00 00 00 00       	call   a657 <do_linkat+0x277>
    a657:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
    a65e:	00 
    a65f:	4c 8b 7d b0          	mov    -0x50(%rbp),%r15
    a663:	eb c6                	jmp    a62b <do_linkat+0x24b>
    a665:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    a669:	41 89 c6             	mov    %eax,%r14d
    a66c:	e9 ee fe ff ff       	jmp    a55f <do_linkat+0x17f>
    a671:	8b 45 9c             	mov    -0x64(%rbp),%eax
    a674:	85 c0                	test   %eax,%eax
    a676:	0f 85 e3 fe ff ff    	jne    a55f <do_linkat+0x17f>
    a67c:	e8 00 00 00 00       	call   a681 <do_linkat+0x2a1>
    a681:	4c 89 ff             	mov    %r15,%rdi
    a684:	80 cb 80             	or     $0x80,%bl
    a687:	e8 00 00 00 00       	call   a68c <do_linkat+0x2ac>
    a68c:	e9 cc fd ff ff       	jmp    a45d <do_linkat+0x7d>
    a691:	41 be ea ff ff ff    	mov    $0xffffffea,%r14d
    a697:	e9 d0 fe ff ff       	jmp    a56c <do_linkat+0x18c>
    a69c:	e8 00 00 00 00       	call   a6a1 <do_linkat+0x2c1>
    a6a1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a6a8:	00 00 00 00 
    a6ac:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000a6b0 <__pfx___ia32_sys_linkat>:
    a6b0:	90                   	nop
    a6b1:	90                   	nop
    a6b2:	90                   	nop
    a6b3:	90                   	nop
    a6b4:	90                   	nop
    a6b5:	90                   	nop
    a6b6:	90                   	nop
    a6b7:	90                   	nop
    a6b8:	90                   	nop
    a6b9:	90                   	nop
    a6ba:	90                   	nop
    a6bb:	90                   	nop
    a6bc:	90                   	nop
    a6bd:	90                   	nop
    a6be:	90                   	nop
    a6bf:	90                   	nop

000000000000a6c0 <__ia32_sys_linkat>:
    a6c0:	e8 00 00 00 00       	call   a6c5 <__ia32_sys_linkat+0x5>
    a6c5:	55                   	push   %rbp
    a6c6:	31 f6                	xor    %esi,%esi
    a6c8:	48 89 e5             	mov    %rsp,%rbp
    a6cb:	41 57                	push   %r15
    a6cd:	41 56                	push   %r14
    a6cf:	41 55                	push   %r13
    a6d1:	41 54                	push   %r12
    a6d3:	53                   	push   %rbx
    a6d4:	48 8b 5f 70          	mov    0x70(%rdi),%rbx
    a6d8:	44 8b 6f 60          	mov    0x60(%rdi),%r13d
    a6dc:	44 8b 77 58          	mov    0x58(%rdi),%r14d
    a6e0:	44 8b 67 28          	mov    0x28(%rdi),%r12d
    a6e4:	8b 7f 68             	mov    0x68(%rdi),%edi
    a6e7:	e8 00 00 00 00       	call   a6ec <__ia32_sys_linkat+0x2c>
    a6ec:	89 de                	mov    %ebx,%esi
    a6ee:	4c 89 f7             	mov    %r14,%rdi
    a6f1:	c1 fe 09             	sar    $0x9,%esi
    a6f4:	49 89 c7             	mov    %rax,%r15
    a6f7:	83 e6 08             	and    $0x8,%esi
    a6fa:	e8 00 00 00 00       	call   a6ff <__ia32_sys_linkat+0x3f>
    a6ff:	41 89 d8             	mov    %ebx,%r8d
    a702:	4c 89 f9             	mov    %r15,%rcx
    a705:	44 89 ea             	mov    %r13d,%edx
    a708:	44 89 e7             	mov    %r12d,%edi
    a70b:	48 89 c6             	mov    %rax,%rsi
    a70e:	e8 00 00 00 00       	call   a713 <__ia32_sys_linkat+0x53>
    a713:	5b                   	pop    %rbx
    a714:	41 5c                	pop    %r12
    a716:	48 98                	cltq
    a718:	41 5d                	pop    %r13
    a71a:	41 5e                	pop    %r14
    a71c:	41 5f                	pop    %r15
    a71e:	5d                   	pop    %rbp
    a71f:	31 d2                	xor    %edx,%edx
    a721:	31 c9                	xor    %ecx,%ecx
    a723:	31 f6                	xor    %esi,%esi
    a725:	31 ff                	xor    %edi,%edi
    a727:	45 31 c0             	xor    %r8d,%r8d
    a72a:	e9 00 00 00 00       	jmp    a72f <__ia32_sys_linkat+0x6f>
    a72f:	90                   	nop

000000000000a730 <__pfx___ia32_sys_link>:
    a730:	90                   	nop
    a731:	90                   	nop
    a732:	90                   	nop
    a733:	90                   	nop
    a734:	90                   	nop
    a735:	90                   	nop
    a736:	90                   	nop
    a737:	90                   	nop
    a738:	90                   	nop
    a739:	90                   	nop
    a73a:	90                   	nop
    a73b:	90                   	nop
    a73c:	90                   	nop
    a73d:	90                   	nop
    a73e:	90                   	nop
    a73f:	90                   	nop

000000000000a740 <__ia32_sys_link>:
    a740:	e8 00 00 00 00       	call   a745 <__ia32_sys_link+0x5>
    a745:	55                   	push   %rbp
    a746:	31 f6                	xor    %esi,%esi
    a748:	48 89 e5             	mov    %rsp,%rbp
    a74b:	41 54                	push   %r12
    a74d:	53                   	push   %rbx
    a74e:	44 8b 67 28          	mov    0x28(%rdi),%r12d
    a752:	8b 7f 58             	mov    0x58(%rdi),%edi
    a755:	e8 00 00 00 00       	call   a75a <__ia32_sys_link+0x1a>
    a75a:	4c 89 e7             	mov    %r12,%rdi
    a75d:	31 f6                	xor    %esi,%esi
    a75f:	48 89 c3             	mov    %rax,%rbx
    a762:	e8 00 00 00 00       	call   a767 <__ia32_sys_link+0x27>
    a767:	48 89 d9             	mov    %rbx,%rcx
    a76a:	45 31 c0             	xor    %r8d,%r8d
    a76d:	ba 9c ff ff ff       	mov    $0xffffff9c,%edx
    a772:	48 89 c6             	mov    %rax,%rsi
    a775:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    a77a:	e8 00 00 00 00       	call   a77f <__ia32_sys_link+0x3f>
    a77f:	5b                   	pop    %rbx
    a780:	41 5c                	pop    %r12
    a782:	48 98                	cltq
    a784:	5d                   	pop    %rbp
    a785:	31 d2                	xor    %edx,%edx
    a787:	31 c9                	xor    %ecx,%ecx
    a789:	31 f6                	xor    %esi,%esi
    a78b:	31 ff                	xor    %edi,%edi
    a78d:	45 31 c0             	xor    %r8d,%r8d
    a790:	e9 00 00 00 00       	jmp    a795 <__ia32_sys_link+0x55>
    a795:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a79c:	00 00 00 00 

000000000000a7a0 <__pfx___x64_sys_linkat>:
    a7a0:	90                   	nop
    a7a1:	90                   	nop
    a7a2:	90                   	nop
    a7a3:	90                   	nop
    a7a4:	90                   	nop
    a7a5:	90                   	nop
    a7a6:	90                   	nop
    a7a7:	90                   	nop
    a7a8:	90                   	nop
    a7a9:	90                   	nop
    a7aa:	90                   	nop
    a7ab:	90                   	nop
    a7ac:	90                   	nop
    a7ad:	90                   	nop
    a7ae:	90                   	nop
    a7af:	90                   	nop

000000000000a7b0 <__x64_sys_linkat>:
    a7b0:	e8 00 00 00 00       	call   a7b5 <__x64_sys_linkat+0x5>
    a7b5:	55                   	push   %rbp
    a7b6:	31 f6                	xor    %esi,%esi
    a7b8:	48 89 e5             	mov    %rsp,%rbp
    a7bb:	41 57                	push   %r15
    a7bd:	41 56                	push   %r14
    a7bf:	41 55                	push   %r13
    a7c1:	41 54                	push   %r12
    a7c3:	53                   	push   %rbx
    a7c4:	48 8b 5f 48          	mov    0x48(%rdi),%rbx
    a7c8:	44 8b 6f 60          	mov    0x60(%rdi),%r13d
    a7cc:	4c 8b 77 68          	mov    0x68(%rdi),%r14
    a7d0:	44 8b 67 70          	mov    0x70(%rdi),%r12d
    a7d4:	48 8b 7f 38          	mov    0x38(%rdi),%rdi
    a7d8:	e8 00 00 00 00       	call   a7dd <__x64_sys_linkat+0x2d>
    a7dd:	89 de                	mov    %ebx,%esi
    a7df:	4c 89 f7             	mov    %r14,%rdi
    a7e2:	c1 fe 09             	sar    $0x9,%esi
    a7e5:	49 89 c7             	mov    %rax,%r15
    a7e8:	83 e6 08             	and    $0x8,%esi
    a7eb:	e8 00 00 00 00       	call   a7f0 <__x64_sys_linkat+0x40>
    a7f0:	41 89 d8             	mov    %ebx,%r8d
    a7f3:	4c 89 f9             	mov    %r15,%rcx
    a7f6:	44 89 ea             	mov    %r13d,%edx
    a7f9:	44 89 e7             	mov    %r12d,%edi
    a7fc:	48 89 c6             	mov    %rax,%rsi
    a7ff:	e8 00 00 00 00       	call   a804 <__x64_sys_linkat+0x54>
    a804:	5b                   	pop    %rbx
    a805:	41 5c                	pop    %r12
    a807:	48 98                	cltq
    a809:	41 5d                	pop    %r13
    a80b:	41 5e                	pop    %r14
    a80d:	41 5f                	pop    %r15
    a80f:	5d                   	pop    %rbp
    a810:	31 d2                	xor    %edx,%edx
    a812:	31 c9                	xor    %ecx,%ecx
    a814:	31 f6                	xor    %esi,%esi
    a816:	31 ff                	xor    %edi,%edi
    a818:	45 31 c0             	xor    %r8d,%r8d
    a81b:	e9 00 00 00 00       	jmp    a820 <__pfx___x64_sys_link>

000000000000a820 <__pfx___x64_sys_link>:
    a820:	90                   	nop
    a821:	90                   	nop
    a822:	90                   	nop
    a823:	90                   	nop
    a824:	90                   	nop
    a825:	90                   	nop
    a826:	90                   	nop
    a827:	90                   	nop
    a828:	90                   	nop
    a829:	90                   	nop
    a82a:	90                   	nop
    a82b:	90                   	nop
    a82c:	90                   	nop
    a82d:	90                   	nop
    a82e:	90                   	nop
    a82f:	90                   	nop

000000000000a830 <__x64_sys_link>:
    a830:	e8 00 00 00 00       	call   a835 <__x64_sys_link+0x5>
    a835:	55                   	push   %rbp
    a836:	31 f6                	xor    %esi,%esi
    a838:	48 89 e5             	mov    %rsp,%rbp
    a83b:	41 54                	push   %r12
    a83d:	53                   	push   %rbx
    a83e:	4c 8b 67 70          	mov    0x70(%rdi),%r12
    a842:	48 8b 7f 68          	mov    0x68(%rdi),%rdi
    a846:	e8 00 00 00 00       	call   a84b <__x64_sys_link+0x1b>
    a84b:	4c 89 e7             	mov    %r12,%rdi
    a84e:	31 f6                	xor    %esi,%esi
    a850:	48 89 c3             	mov    %rax,%rbx
    a853:	e8 00 00 00 00       	call   a858 <__x64_sys_link+0x28>
    a858:	48 89 d9             	mov    %rbx,%rcx
    a85b:	45 31 c0             	xor    %r8d,%r8d
    a85e:	ba 9c ff ff ff       	mov    $0xffffff9c,%edx
    a863:	48 89 c6             	mov    %rax,%rsi
    a866:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    a86b:	e8 00 00 00 00       	call   a870 <__x64_sys_link+0x40>
    a870:	5b                   	pop    %rbx
    a871:	41 5c                	pop    %r12
    a873:	48 98                	cltq
    a875:	5d                   	pop    %rbp
    a876:	31 d2                	xor    %edx,%edx
    a878:	31 c9                	xor    %ecx,%ecx
    a87a:	31 f6                	xor    %esi,%esi
    a87c:	31 ff                	xor    %edi,%edi
    a87e:	45 31 c0             	xor    %r8d,%r8d
    a881:	e9 00 00 00 00       	jmp    a886 <__x64_sys_link+0x56>
    a886:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a88d:	00 00 00 

000000000000a890 <__pfx_do_renameat2>:
    a890:	90                   	nop
    a891:	90                   	nop
    a892:	90                   	nop
    a893:	90                   	nop
    a894:	90                   	nop
    a895:	90                   	nop
    a896:	90                   	nop
    a897:	90                   	nop
    a898:	90                   	nop
    a899:	90                   	nop
    a89a:	90                   	nop
    a89b:	90                   	nop
    a89c:	90                   	nop
    a89d:	90                   	nop
    a89e:	90                   	nop
    a89f:	90                   	nop

000000000000a8a0 <do_renameat2>:
    a8a0:	e8 00 00 00 00       	call   a8a5 <do_renameat2+0x5>
    a8a5:	55                   	push   %rbp
    a8a6:	41 89 f9             	mov    %edi,%r9d
    a8a9:	48 89 e5             	mov    %rsp,%rbp
    a8ac:	41 57                	push   %r15
    a8ae:	41 56                	push   %r14
    a8b0:	48 8d 7d 90          	lea    -0x70(%rbp),%rdi
    a8b4:	41 55                	push   %r13
    a8b6:	49 89 f5             	mov    %rsi,%r13
    a8b9:	41 54                	push   %r12
    a8bb:	49 89 cc             	mov    %rcx,%r12
    a8be:	b9 08 00 00 00       	mov    $0x8,%ecx
    a8c3:	53                   	push   %rbx
    a8c4:	48 81 ec c8 00 00 00 	sub    $0xc8,%rsp
    a8cb:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # a8d3 <do_renameat2+0x33>
    a8d2:	00 
    a8d3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    a8d7:	31 c0                	xor    %eax,%eax
    a8d9:	48 c7 45 80 00 00 00 	movq   $0x0,-0x80(%rbp)
    a8e0:	00 
    a8e1:	48 c7 85 50 ff ff ff 	movq   $0x0,-0xb0(%rbp)
    a8e8:	00 00 00 00 
    a8ec:	48 c7 85 58 ff ff ff 	movq   $0x0,-0xa8(%rbp)
    a8f3:	00 00 00 00 
    a8f7:	48 c7 85 60 ff ff ff 	movq   $0x0,-0xa0(%rbp)
    a8fe:	00 00 00 00 
    a902:	48 c7 85 68 ff ff ff 	movq   $0x0,-0x98(%rbp)
    a909:	00 00 00 00 
    a90d:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
    a914:	00 00 00 00 
    a918:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    a91b:	48 c7 85 78 ff ff ff 	movq   $0x0,-0x88(%rbp)
    a922:	00 00 00 00 
    a926:	48 c7 45 88 00 00 00 	movq   $0x0,-0x78(%rbp)
    a92d:	00 
    a92e:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    a935:	00 00 00 
    a938:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
    a93f:	00 00 00 
    a942:	48 c7 85 48 ff ff ff 	movq   $0x0,-0xb8(%rbp)
    a949:	00 00 00 00 
    a94d:	41 83 f8 07          	cmp    $0x7,%r8d
    a951:	0f 87 5b 05 00 00    	ja     aeb2 <do_renameat2+0x612>
    a957:	44 89 c6             	mov    %r8d,%esi
    a95a:	44 89 c1             	mov    %r8d,%ecx
    a95d:	83 e6 02             	and    $0x2,%esi
    a960:	83 e1 05             	and    $0x5,%ecx
    a963:	0f 85 2a 01 00 00    	jne    aa93 <do_renameat2+0x1f3>
    a969:	45 31 d2             	xor    %r10d,%r10d
    a96c:	b8 00 00 0a 00       	mov    $0xa0000,%eax
    a971:	85 f6                	test   %esi,%esi
    a973:	0f 44 c8             	cmove  %eax,%ecx
    a976:	89 8d 1c ff ff ff    	mov    %ecx,-0xe4(%rbp)
    a97c:	41 be 02 00 00 00    	mov    $0x2,%r14d
    a982:	31 db                	xor    %ebx,%ebx
    a984:	44 89 95 28 ff ff ff 	mov    %r10d,-0xd8(%rbp)
    a98b:	89 b5 34 ff ff ff    	mov    %esi,-0xcc(%rbp)
    a991:	89 95 38 ff ff ff    	mov    %edx,-0xc8(%rbp)
    a997:	44 89 85 2c ff ff ff 	mov    %r8d,-0xd4(%rbp)
    a99e:	44 89 b5 3c ff ff ff 	mov    %r14d,-0xc4(%rbp)
    a9a5:	45 89 ce             	mov    %r9d,%r14d
    a9a8:	6a 00                	push   $0x0
    a9aa:	44 89 f7             	mov    %r14d,%edi
    a9ad:	4c 8d 8d 40 ff ff ff 	lea    -0xc0(%rbp),%r9
    a9b4:	89 da                	mov    %ebx,%edx
    a9b6:	4c 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%r8
    a9bd:	48 8d 8d 50 ff ff ff 	lea    -0xb0(%rbp),%rcx
    a9c4:	4c 89 ee             	mov    %r13,%rsi
    a9c7:	e8 34 bc ff ff       	call   6600 <__filename_parentat>
    a9cc:	5f                   	pop    %rdi
    a9cd:	41 89 c7             	mov    %eax,%r15d
    a9d0:	85 c0                	test   %eax,%eax
    a9d2:	75 76                	jne    aa4a <do_renameat2+0x1aa>
    a9d4:	6a 00                	push   $0x0
    a9d6:	8b bd 38 ff ff ff    	mov    -0xc8(%rbp),%edi
    a9dc:	4c 89 e6             	mov    %r12,%rsi
    a9df:	4c 8d 45 80          	lea    -0x80(%rbp),%r8
    a9e3:	4c 8d 8d 44 ff ff ff 	lea    -0xbc(%rbp),%r9
    a9ea:	48 8d 8d 60 ff ff ff 	lea    -0xa0(%rbp),%rcx
    a9f1:	89 da                	mov    %ebx,%edx
    a9f3:	e8 08 bc ff ff       	call   6600 <__filename_parentat>
    a9f8:	5e                   	pop    %rsi
    a9f9:	41 89 c7             	mov    %eax,%r15d
    a9fc:	85 c0                	test   %eax,%eax
    a9fe:	75 32                	jne    aa32 <do_renameat2+0x192>
    aa00:	48 8b bd 50 ff ff ff 	mov    -0xb0(%rbp),%rdi
    aa07:	48 3b bd 60 ff ff ff 	cmp    -0xa0(%rbp),%rdi
    aa0e:	0f 84 a5 00 00 00    	je     aab9 <do_renameat2+0x219>
    aa14:	48 8b bd 68 ff ff ff 	mov    -0x98(%rbp),%rdi
    aa1b:	41 bf ee ff ff ff    	mov    $0xffffffee,%r15d
    aa21:	e8 00 00 00 00       	call   aa26 <do_renameat2+0x186>
    aa26:	48 8b bd 60 ff ff ff 	mov    -0xa0(%rbp),%rdi
    aa2d:	e8 00 00 00 00       	call   aa32 <do_renameat2+0x192>
    aa32:	48 8b bd 58 ff ff ff 	mov    -0xa8(%rbp),%rdi
    aa39:	e8 00 00 00 00       	call   aa3e <do_renameat2+0x19e>
    aa3e:	48 8b bd 50 ff ff ff 	mov    -0xb0(%rbp),%rdi
    aa45:	e8 00 00 00 00       	call   aa4a <do_renameat2+0x1aa>
    aa4a:	4c 89 ef             	mov    %r13,%rdi
    aa4d:	e8 00 00 00 00       	call   aa52 <do_renameat2+0x1b2>
    aa52:	4c 89 e7             	mov    %r12,%rdi
    aa55:	e8 00 00 00 00       	call   aa5a <do_renameat2+0x1ba>
    aa5a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
    aa5e:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # aa66 <do_renameat2+0x1c6>
    aa65:	00 
    aa66:	0f 85 51 04 00 00    	jne    aebd <do_renameat2+0x61d>
    aa6c:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    aa70:	44 89 f8             	mov    %r15d,%eax
    aa73:	5b                   	pop    %rbx
    aa74:	41 5c                	pop    %r12
    aa76:	41 5d                	pop    %r13
    aa78:	41 5e                	pop    %r14
    aa7a:	41 5f                	pop    %r15
    aa7c:	5d                   	pop    %rbp
    aa7d:	31 d2                	xor    %edx,%edx
    aa7f:	31 c9                	xor    %ecx,%ecx
    aa81:	31 f6                	xor    %esi,%esi
    aa83:	31 ff                	xor    %edi,%edi
    aa85:	45 31 c0             	xor    %r8d,%r8d
    aa88:	45 31 c9             	xor    %r9d,%r9d
    aa8b:	45 31 d2             	xor    %r10d,%r10d
    aa8e:	e9 00 00 00 00       	jmp    aa93 <do_renameat2+0x1f3>
    aa93:	85 f6                	test   %esi,%esi
    aa95:	0f 85 17 04 00 00    	jne    aeb2 <do_renameat2+0x612>
    aa9b:	45 89 c2             	mov    %r8d,%r10d
    aa9e:	41 83 e2 01          	and    $0x1,%r10d
    aaa2:	41 83 fa 01          	cmp    $0x1,%r10d
    aaa6:	19 c9                	sbb    %ecx,%ecx
    aaa8:	81 e1 00 00 fc ff    	and    $0xfffc0000,%ecx
    aaae:	81 c1 00 00 0e 00    	add    $0xe0000,%ecx
    aab4:	e9 bd fe ff ff       	jmp    a976 <do_renameat2+0xd6>
    aab9:	8b 8d 40 ff ff ff    	mov    -0xc0(%rbp),%ecx
    aabf:	85 c9                	test   %ecx,%ecx
    aac1:	75 28                	jne    aaeb <do_renameat2+0x24b>
    aac3:	8b 95 44 ff ff ff    	mov    -0xbc(%rbp),%edx
    aac9:	85 d2                	test   %edx,%edx
    aacb:	74 30                	je     aafd <do_renameat2+0x25d>
    aacd:	44 8b 95 28 ff ff ff 	mov    -0xd8(%rbp),%r10d
    aad4:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
    aad9:	48 8b bd 68 ff ff ff 	mov    -0x98(%rbp),%rdi
    aae0:	44 29 d0             	sub    %r10d,%eax
    aae3:	41 89 c7             	mov    %eax,%r15d
    aae6:	e9 36 ff ff ff       	jmp    aa21 <do_renameat2+0x181>
    aaeb:	48 8b bd 68 ff ff ff 	mov    -0x98(%rbp),%rdi
    aaf2:	41 bf f0 ff ff ff    	mov    $0xfffffff0,%r15d
    aaf8:	e9 24 ff ff ff       	jmp    aa21 <do_renameat2+0x181>
    aafd:	e8 00 00 00 00       	call   ab02 <do_renameat2+0x262>
    ab02:	41 89 c7             	mov    %eax,%r15d
    ab05:	85 c0                	test   %eax,%eax
    ab07:	74 5b                	je     ab64 <do_renameat2+0x2c4>
    ab09:	48 8b bd 68 ff ff ff 	mov    -0x98(%rbp),%rdi
    ab10:	41 83 ff 8c          	cmp    $0xffffff8c,%r15d
    ab14:	0f 85 07 ff ff ff    	jne    aa21 <do_renameat2+0x181>
    ab1a:	e8 00 00 00 00       	call   ab1f <do_renameat2+0x27f>
    ab1f:	48 8b bd 60 ff ff ff 	mov    -0xa0(%rbp),%rdi
    ab26:	bb 80 00 00 00       	mov    $0x80,%ebx
    ab2b:	e8 00 00 00 00       	call   ab30 <do_renameat2+0x290>
    ab30:	48 8b bd 58 ff ff ff 	mov    -0xa8(%rbp),%rdi
    ab37:	e8 00 00 00 00       	call   ab3c <do_renameat2+0x29c>
    ab3c:	48 8b bd 50 ff ff ff 	mov    -0xb0(%rbp),%rdi
    ab43:	e8 00 00 00 00       	call   ab48 <do_renameat2+0x2a8>
    ab48:	83 bd 3c ff ff ff 01 	cmpl   $0x1,-0xc4(%rbp)
    ab4f:	0f 84 f5 fe ff ff    	je     aa4a <do_renameat2+0x1aa>
    ab55:	c7 85 3c ff ff ff 01 	movl   $0x1,-0xc4(%rbp)
    ab5c:	00 00 00 
    ab5f:	e9 44 fe ff ff       	jmp    a9a8 <do_renameat2+0x108>
    ab64:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    ab6a:	44 89 b5 18 ff ff ff 	mov    %r14d,-0xe8(%rbp)
    ab71:	4c 89 a5 10 ff ff ff 	mov    %r12,-0xf0(%rbp)
    ab78:	09 d8                	or     %ebx,%eax
    ab7a:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%rbp)
    ab80:	4c 8b bd 58 ff ff ff 	mov    -0xa8(%rbp),%r15
    ab87:	4c 8b b5 68 ff ff ff 	mov    -0x98(%rbp),%r14
    ab8e:	4d 39 f7             	cmp    %r14,%r15
    ab91:	0f 84 03 03 00 00    	je     ae9a <do_renameat2+0x5fa>
    ab97:	49 8b 46 68          	mov    0x68(%r14),%rax
    ab9b:	48 8d b8 28 04 00 00 	lea    0x428(%rax),%rdi
    aba2:	e8 00 00 00 00       	call   aba7 <do_renameat2+0x307>
    aba7:	4c 89 fe             	mov    %r15,%rsi
    abaa:	4c 89 f7             	mov    %r14,%rdi
    abad:	e8 ee 5c ff ff       	call   8a0 <lock_two_directories>
    abb2:	49 89 c6             	mov    %rax,%r14
    abb5:	41 89 c7             	mov    %eax,%r15d
    abb8:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    abbe:	0f 87 70 01 00 00    	ja     ad34 <do_renameat2+0x494>
    abc4:	48 8b b5 58 ff ff ff 	mov    -0xa8(%rbp),%rsi
    abcb:	89 da                	mov    %ebx,%edx
    abcd:	48 8d bd 70 ff ff ff 	lea    -0x90(%rbp),%rdi
    abd4:	e8 00 00 00 00       	call   abd9 <do_renameat2+0x339>
    abd9:	49 89 c4             	mov    %rax,%r12
    abdc:	41 89 c7             	mov    %eax,%r15d
    abdf:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    abe5:	0f 87 05 01 00 00    	ja     acf0 <do_renameat2+0x450>
    abeb:	8b 95 30 ff ff ff    	mov    -0xd0(%rbp),%edx
    abf1:	48 8b b5 68 ff ff ff 	mov    -0x98(%rbp),%rsi
    abf8:	48 8d 7d 80          	lea    -0x80(%rbp),%rdi
    abfc:	e8 00 00 00 00       	call   ac01 <do_renameat2+0x361>
    ac01:	48 89 c1             	mov    %rax,%rcx
    ac04:	41 89 c7             	mov    %eax,%r15d
    ac07:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    ac0d:	0f 87 d5 00 00 00    	ja     ace8 <do_renameat2+0x448>
    ac13:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
    ac19:	85 c0                	test   %eax,%eax
    ac1b:	0f 85 97 01 00 00    	jne    adb8 <do_renameat2+0x518>
    ac21:	41 8b 04 24          	mov    (%r12),%eax
    ac25:	25 00 00 30 00       	and    $0x300000,%eax
    ac2a:	3d 00 00 10 00       	cmp    $0x100000,%eax
    ac2f:	0f 85 23 02 00 00    	jne    ae58 <do_renameat2+0x5b8>
    ac35:	4d 39 f4             	cmp    %r14,%r12
    ac38:	0f 84 51 02 00 00    	je     ae8f <do_renameat2+0x5ef>
    ac3e:	41 bf d9 ff ff ff    	mov    $0xffffffd9,%r15d
    ac44:	4c 39 f1             	cmp    %r14,%rcx
    ac47:	0f 84 93 00 00 00    	je     ace0 <do_renameat2+0x440>
    ac4d:	44 8b b5 2c ff ff ff 	mov    -0xd4(%rbp),%r14d
    ac54:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
    ac5b:	4c 89 e6             	mov    %r12,%rsi
    ac5e:	48 8d bd 50 ff ff ff 	lea    -0xb0(%rbp),%rdi
    ac65:	48 89 8d 20 ff ff ff 	mov    %rcx,-0xe0(%rbp)
    ac6c:	45 89 f0             	mov    %r14d,%r8d
    ac6f:	e8 00 00 00 00       	call   ac74 <do_renameat2+0x3d4>
    ac74:	48 8b 8d 20 ff ff ff 	mov    -0xe0(%rbp),%rcx
    ac7b:	85 c0                	test   %eax,%eax
    ac7d:	41 89 c7             	mov    %eax,%r15d
    ac80:	75 5e                	jne    ace0 <do_renameat2+0x440>
    ac82:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
    ac89:	48 8d 7d 90          	lea    -0x70(%rbp),%rdi
    ac8d:	48 89 4d b8          	mov    %rcx,-0x48(%rbp)
    ac91:	4c 89 65 a0          	mov    %r12,-0x60(%rbp)
    ac95:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    ac99:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    aca0:	44 89 75 c8          	mov    %r14d,-0x38(%rbp)
    aca4:	48 8b 40 18          	mov    0x18(%rax),%rax
    aca8:	48 89 45 90          	mov    %rax,-0x70(%rbp)
    acac:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
    acb3:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    acb7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
    acbe:	48 8b 40 18          	mov    0x18(%rax),%rax
    acc2:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    acc6:	48 8d 85 48 ff ff ff 	lea    -0xb8(%rbp),%rax
    accd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    acd1:	e8 00 00 00 00       	call   acd6 <do_renameat2+0x436>
    acd6:	48 8b 8d 20 ff ff ff 	mov    -0xe0(%rbp),%rcx
    acdd:	41 89 c7             	mov    %eax,%r15d
    ace0:	48 89 cf             	mov    %rcx,%rdi
    ace3:	e8 00 00 00 00       	call   ace8 <do_renameat2+0x448>
    ace8:	4c 89 e7             	mov    %r12,%rdi
    aceb:	e8 00 00 00 00       	call   acf0 <do_renameat2+0x450>
    acf0:	4c 8b b5 68 ff ff ff 	mov    -0x98(%rbp),%r14
    acf7:	4c 8b a5 58 ff ff ff 	mov    -0xa8(%rbp),%r12
    acfe:	49 8b 46 30          	mov    0x30(%r14),%rax
    ad02:	48 8d b8 98 00 00 00 	lea    0x98(%rax),%rdi
    ad09:	e8 00 00 00 00       	call   ad0e <do_renameat2+0x46e>
    ad0e:	4d 39 f4             	cmp    %r14,%r12
    ad11:	74 21                	je     ad34 <do_renameat2+0x494>
    ad13:	49 8b 7c 24 30       	mov    0x30(%r12),%rdi
    ad18:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    ad1f:	e8 00 00 00 00       	call   ad24 <do_renameat2+0x484>
    ad24:	49 8b 7e 68          	mov    0x68(%r14),%rdi
    ad28:	48 81 c7 28 04 00 00 	add    $0x428,%rdi
    ad2f:	e8 00 00 00 00       	call   ad34 <do_renameat2+0x494>
    ad34:	48 8b bd 48 ff ff ff 	mov    -0xb8(%rbp),%rdi
    ad3b:	48 85 ff             	test   %rdi,%rdi
    ad3e:	74 59                	je     ad99 <do_renameat2+0x4f9>
    ad40:	48 8b 87 68 01 00 00 	mov    0x168(%rdi),%rax
    ad47:	48 85 c0             	test   %rax,%rax
    ad4a:	0f 84 ae 00 00 00    	je     adfe <do_renameat2+0x55e>
    ad50:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
    ad56:	48 8b 50 28          	mov    0x28(%rax),%rdx
    ad5a:	48 8d 48 28          	lea    0x28(%rax),%rcx
    ad5e:	48 39 ca             	cmp    %rcx,%rdx
    ad61:	0f 84 83 00 00 00    	je     adea <do_renameat2+0x54a>
    ad67:	ba 04 00 00 00       	mov    $0x4,%edx
    ad6c:	be 01 00 00 00       	mov    $0x1,%esi
    ad71:	e8 00 00 00 00       	call   ad76 <do_renameat2+0x4d6>
    ad76:	48 8b bd 48 ff ff ff 	mov    -0xb8(%rbp),%rdi
    ad7d:	41 89 c7             	mov    %eax,%r15d
    ad80:	e8 00 00 00 00       	call   ad85 <do_renameat2+0x4e5>
    ad85:	48 c7 85 48 ff ff ff 	movq   $0x0,-0xb8(%rbp)
    ad8c:	00 00 00 00 
    ad90:	45 85 ff             	test   %r15d,%r15d
    ad93:	0f 84 e7 fd ff ff    	je     ab80 <do_renameat2+0x2e0>
    ad99:	48 8b bd 50 ff ff ff 	mov    -0xb0(%rbp),%rdi
    ada0:	44 8b b5 18 ff ff ff 	mov    -0xe8(%rbp),%r14d
    ada7:	4c 8b a5 10 ff ff ff 	mov    -0xf0(%rbp),%r12
    adae:	e8 00 00 00 00       	call   adb3 <do_renameat2+0x513>
    adb3:	e9 51 fd ff ff       	jmp    ab09 <do_renameat2+0x269>
    adb8:	8b 01                	mov    (%rcx),%eax
    adba:	25 00 00 30 00       	and    $0x300000,%eax
    adbf:	3d 00 00 10 00       	cmp    $0x100000,%eax
    adc4:	75 4d                	jne    ae13 <do_renameat2+0x573>
    adc6:	41 8b 04 24          	mov    (%r12),%eax
    adca:	25 00 00 30 00       	and    $0x300000,%eax
    adcf:	3d 00 00 10 00       	cmp    $0x100000,%eax
    add4:	75 64                	jne    ae3a <do_renameat2+0x59a>
    add6:	41 bf ea ff ff ff    	mov    $0xffffffea,%r15d
    addc:	4d 39 f4             	cmp    %r14,%r12
    addf:	0f 85 5f fe ff ff    	jne    ac44 <do_renameat2+0x3a4>
    ade5:	e9 f6 fe ff ff       	jmp    ace0 <do_renameat2+0x440>
    adea:	48 8b 40 30          	mov    0x30(%rax),%rax
    adee:	48 39 c2             	cmp    %rax,%rdx
    adf1:	0f 85 70 ff ff ff    	jne    ad67 <do_renameat2+0x4c7>
    adf7:	48 8b bd 48 ff ff ff 	mov    -0xb8(%rbp),%rdi
    adfe:	e8 00 00 00 00       	call   ae03 <do_renameat2+0x563>
    ae03:	48 c7 85 48 ff ff ff 	movq   $0x0,-0xb8(%rbp)
    ae0a:	00 00 00 00 
    ae0e:	e9 6d fd ff ff       	jmp    ab80 <do_renameat2+0x2e0>
    ae13:	8b 45 84             	mov    -0x7c(%rbp),%eax
    ae16:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
    ae1a:	41 bf ec ff ff ff    	mov    $0xffffffec,%r15d
    ae20:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
    ae24:	0f 85 b6 fe ff ff    	jne    ace0 <do_renameat2+0x440>
    ae2a:	41 8b 04 24          	mov    (%r12),%eax
    ae2e:	25 00 00 30 00       	and    $0x300000,%eax
    ae33:	3d 00 00 10 00       	cmp    $0x100000,%eax
    ae38:	74 9c                	je     add6 <do_renameat2+0x536>
    ae3a:	8b 85 74 ff ff ff    	mov    -0x8c(%rbp),%eax
    ae40:	48 8b 95 78 ff ff ff 	mov    -0x88(%rbp),%rdx
    ae47:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
    ae4b:	74 89                	je     add6 <do_renameat2+0x536>
    ae4d:	41 bf ec ff ff ff    	mov    $0xffffffec,%r15d
    ae53:	e9 88 fe ff ff       	jmp    ace0 <do_renameat2+0x440>
    ae58:	8b 85 74 ff ff ff    	mov    -0x8c(%rbp),%eax
    ae5e:	48 8b 95 78 ff ff ff 	mov    -0x88(%rbp),%rdx
    ae65:	41 bf ec ff ff ff    	mov    $0xffffffec,%r15d
    ae6b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
    ae6f:	0f 85 6b fe ff ff    	jne    ace0 <do_renameat2+0x440>
    ae75:	8b 45 84             	mov    -0x7c(%rbp),%eax
    ae78:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
    ae7c:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
    ae80:	0f 85 5a fe ff ff    	jne    ace0 <do_renameat2+0x440>
    ae86:	4d 39 f4             	cmp    %r14,%r12
    ae89:	0f 85 af fd ff ff    	jne    ac3e <do_renameat2+0x39e>
    ae8f:	41 bf ea ff ff ff    	mov    $0xffffffea,%r15d
    ae95:	e9 46 fe ff ff       	jmp    ace0 <do_renameat2+0x440>
    ae9a:	49 8b 7f 30          	mov    0x30(%r15),%rdi
    ae9e:	45 31 f6             	xor    %r14d,%r14d
    aea1:	48 81 c7 98 00 00 00 	add    $0x98,%rdi
    aea8:	e8 00 00 00 00       	call   aead <do_renameat2+0x60d>
    aead:	e9 12 fd ff ff       	jmp    abc4 <do_renameat2+0x324>
    aeb2:	41 bf ea ff ff ff    	mov    $0xffffffea,%r15d
    aeb8:	e9 8d fb ff ff       	jmp    aa4a <do_renameat2+0x1aa>
    aebd:	e8 00 00 00 00       	call   aec2 <do_renameat2+0x622>
    aec2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    aec9:	00 00 00 00 
    aecd:	0f 1f 00             	nopl   (%rax)

000000000000aed0 <__pfx___ia32_sys_renameat2>:
    aed0:	90                   	nop
    aed1:	90                   	nop
    aed2:	90                   	nop
    aed3:	90                   	nop
    aed4:	90                   	nop
    aed5:	90                   	nop
    aed6:	90                   	nop
    aed7:	90                   	nop
    aed8:	90                   	nop
    aed9:	90                   	nop
    aeda:	90                   	nop
    aedb:	90                   	nop
    aedc:	90                   	nop
    aedd:	90                   	nop
    aede:	90                   	nop
    aedf:	90                   	nop

000000000000aee0 <__ia32_sys_renameat2>:
    aee0:	e8 00 00 00 00       	call   aee5 <__ia32_sys_renameat2+0x5>
    aee5:	55                   	push   %rbp
    aee6:	31 f6                	xor    %esi,%esi
    aee8:	48 89 e5             	mov    %rsp,%rbp
    aeeb:	41 57                	push   %r15
    aeed:	41 56                	push   %r14
    aeef:	41 55                	push   %r13
    aef1:	41 54                	push   %r12
    aef3:	53                   	push   %rbx
    aef4:	4c 8b 6f 70          	mov    0x70(%rdi),%r13
    aef8:	44 8b 67 60          	mov    0x60(%rdi),%r12d
    aefc:	44 8b 77 58          	mov    0x58(%rdi),%r14d
    af00:	8b 5f 28             	mov    0x28(%rdi),%ebx
    af03:	8b 7f 68             	mov    0x68(%rdi),%edi
    af06:	e8 00 00 00 00       	call   af0b <__ia32_sys_renameat2+0x2b>
    af0b:	4c 89 f7             	mov    %r14,%rdi
    af0e:	31 f6                	xor    %esi,%esi
    af10:	49 89 c7             	mov    %rax,%r15
    af13:	e8 00 00 00 00       	call   af18 <__ia32_sys_renameat2+0x38>
    af18:	45 89 e8             	mov    %r13d,%r8d
    af1b:	4c 89 f9             	mov    %r15,%rcx
    af1e:	44 89 e2             	mov    %r12d,%edx
    af21:	89 df                	mov    %ebx,%edi
    af23:	48 89 c6             	mov    %rax,%rsi
    af26:	e8 00 00 00 00       	call   af2b <__ia32_sys_renameat2+0x4b>
    af2b:	5b                   	pop    %rbx
    af2c:	41 5c                	pop    %r12
    af2e:	48 98                	cltq
    af30:	41 5d                	pop    %r13
    af32:	41 5e                	pop    %r14
    af34:	41 5f                	pop    %r15
    af36:	5d                   	pop    %rbp
    af37:	31 d2                	xor    %edx,%edx
    af39:	31 c9                	xor    %ecx,%ecx
    af3b:	31 f6                	xor    %esi,%esi
    af3d:	31 ff                	xor    %edi,%edi
    af3f:	45 31 c0             	xor    %r8d,%r8d
    af42:	e9 00 00 00 00       	jmp    af47 <__ia32_sys_renameat2+0x67>
    af47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    af4e:	00 00 

000000000000af50 <__pfx___ia32_sys_renameat>:
    af50:	90                   	nop
    af51:	90                   	nop
    af52:	90                   	nop
    af53:	90                   	nop
    af54:	90                   	nop
    af55:	90                   	nop
    af56:	90                   	nop
    af57:	90                   	nop
    af58:	90                   	nop
    af59:	90                   	nop
    af5a:	90                   	nop
    af5b:	90                   	nop
    af5c:	90                   	nop
    af5d:	90                   	nop
    af5e:	90                   	nop
    af5f:	90                   	nop

000000000000af60 <__ia32_sys_renameat>:
    af60:	e8 00 00 00 00       	call   af65 <__ia32_sys_renameat+0x5>
    af65:	55                   	push   %rbp
    af66:	31 f6                	xor    %esi,%esi
    af68:	48 89 e5             	mov    %rsp,%rbp
    af6b:	41 56                	push   %r14
    af6d:	41 55                	push   %r13
    af6f:	41 54                	push   %r12
    af71:	53                   	push   %rbx
    af72:	44 8b 6f 60          	mov    0x60(%rdi),%r13d
    af76:	44 8b 77 58          	mov    0x58(%rdi),%r14d
    af7a:	44 8b 67 28          	mov    0x28(%rdi),%r12d
    af7e:	8b 7f 68             	mov    0x68(%rdi),%edi
    af81:	e8 00 00 00 00       	call   af86 <__ia32_sys_renameat+0x26>
    af86:	4c 89 f7             	mov    %r14,%rdi
    af89:	31 f6                	xor    %esi,%esi
    af8b:	48 89 c3             	mov    %rax,%rbx
    af8e:	e8 00 00 00 00       	call   af93 <__ia32_sys_renameat+0x33>
    af93:	48 89 d9             	mov    %rbx,%rcx
    af96:	44 89 ea             	mov    %r13d,%edx
    af99:	44 89 e7             	mov    %r12d,%edi
    af9c:	48 89 c6             	mov    %rax,%rsi
    af9f:	45 31 c0             	xor    %r8d,%r8d
    afa2:	e8 00 00 00 00       	call   afa7 <__ia32_sys_renameat+0x47>
    afa7:	5b                   	pop    %rbx
    afa8:	41 5c                	pop    %r12
    afaa:	48 98                	cltq
    afac:	41 5d                	pop    %r13
    afae:	41 5e                	pop    %r14
    afb0:	5d                   	pop    %rbp
    afb1:	31 d2                	xor    %edx,%edx
    afb3:	31 c9                	xor    %ecx,%ecx
    afb5:	31 f6                	xor    %esi,%esi
    afb7:	31 ff                	xor    %edi,%edi
    afb9:	45 31 c0             	xor    %r8d,%r8d
    afbc:	e9 00 00 00 00       	jmp    afc1 <__ia32_sys_renameat+0x61>
    afc1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    afc8:	00 00 00 00 
    afcc:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000afd0 <__pfx___ia32_sys_rename>:
    afd0:	90                   	nop
    afd1:	90                   	nop
    afd2:	90                   	nop
    afd3:	90                   	nop
    afd4:	90                   	nop
    afd5:	90                   	nop
    afd6:	90                   	nop
    afd7:	90                   	nop
    afd8:	90                   	nop
    afd9:	90                   	nop
    afda:	90                   	nop
    afdb:	90                   	nop
    afdc:	90                   	nop
    afdd:	90                   	nop
    afde:	90                   	nop
    afdf:	90                   	nop

000000000000afe0 <__ia32_sys_rename>:
    afe0:	e8 00 00 00 00       	call   afe5 <__ia32_sys_rename+0x5>
    afe5:	55                   	push   %rbp
    afe6:	31 f6                	xor    %esi,%esi
    afe8:	48 89 e5             	mov    %rsp,%rbp
    afeb:	41 54                	push   %r12
    afed:	53                   	push   %rbx
    afee:	44 8b 67 28          	mov    0x28(%rdi),%r12d
    aff2:	8b 7f 58             	mov    0x58(%rdi),%edi
    aff5:	e8 00 00 00 00       	call   affa <__ia32_sys_rename+0x1a>
    affa:	4c 89 e7             	mov    %r12,%rdi
    affd:	31 f6                	xor    %esi,%esi
    afff:	48 89 c3             	mov    %rax,%rbx
    b002:	e8 00 00 00 00       	call   b007 <__ia32_sys_rename+0x27>
    b007:	48 89 d9             	mov    %rbx,%rcx
    b00a:	45 31 c0             	xor    %r8d,%r8d
    b00d:	ba 9c ff ff ff       	mov    $0xffffff9c,%edx
    b012:	48 89 c6             	mov    %rax,%rsi
    b015:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    b01a:	e8 00 00 00 00       	call   b01f <__ia32_sys_rename+0x3f>
    b01f:	5b                   	pop    %rbx
    b020:	41 5c                	pop    %r12
    b022:	48 98                	cltq
    b024:	5d                   	pop    %rbp
    b025:	31 d2                	xor    %edx,%edx
    b027:	31 c9                	xor    %ecx,%ecx
    b029:	31 f6                	xor    %esi,%esi
    b02b:	31 ff                	xor    %edi,%edi
    b02d:	45 31 c0             	xor    %r8d,%r8d
    b030:	e9 00 00 00 00       	jmp    b035 <__ia32_sys_rename+0x55>
    b035:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b03c:	00 00 00 00 

000000000000b040 <__pfx___x64_sys_renameat2>:
    b040:	90                   	nop
    b041:	90                   	nop
    b042:	90                   	nop
    b043:	90                   	nop
    b044:	90                   	nop
    b045:	90                   	nop
    b046:	90                   	nop
    b047:	90                   	nop
    b048:	90                   	nop
    b049:	90                   	nop
    b04a:	90                   	nop
    b04b:	90                   	nop
    b04c:	90                   	nop
    b04d:	90                   	nop
    b04e:	90                   	nop
    b04f:	90                   	nop

000000000000b050 <__x64_sys_renameat2>:
    b050:	e8 00 00 00 00       	call   b055 <__x64_sys_renameat2+0x5>
    b055:	55                   	push   %rbp
    b056:	31 f6                	xor    %esi,%esi
    b058:	48 89 e5             	mov    %rsp,%rbp
    b05b:	41 57                	push   %r15
    b05d:	41 56                	push   %r14
    b05f:	41 55                	push   %r13
    b061:	41 54                	push   %r12
    b063:	53                   	push   %rbx
    b064:	4c 8b 6f 48          	mov    0x48(%rdi),%r13
    b068:	44 8b 67 60          	mov    0x60(%rdi),%r12d
    b06c:	4c 8b 77 68          	mov    0x68(%rdi),%r14
    b070:	8b 5f 70             	mov    0x70(%rdi),%ebx
    b073:	48 8b 7f 38          	mov    0x38(%rdi),%rdi
    b077:	e8 00 00 00 00       	call   b07c <__x64_sys_renameat2+0x2c>
    b07c:	4c 89 f7             	mov    %r14,%rdi
    b07f:	31 f6                	xor    %esi,%esi
    b081:	49 89 c7             	mov    %rax,%r15
    b084:	e8 00 00 00 00       	call   b089 <__x64_sys_renameat2+0x39>
    b089:	45 89 e8             	mov    %r13d,%r8d
    b08c:	4c 89 f9             	mov    %r15,%rcx
    b08f:	44 89 e2             	mov    %r12d,%edx
    b092:	89 df                	mov    %ebx,%edi
    b094:	48 89 c6             	mov    %rax,%rsi
    b097:	e8 00 00 00 00       	call   b09c <__x64_sys_renameat2+0x4c>
    b09c:	5b                   	pop    %rbx
    b09d:	41 5c                	pop    %r12
    b09f:	48 98                	cltq
    b0a1:	41 5d                	pop    %r13
    b0a3:	41 5e                	pop    %r14
    b0a5:	41 5f                	pop    %r15
    b0a7:	5d                   	pop    %rbp
    b0a8:	31 d2                	xor    %edx,%edx
    b0aa:	31 c9                	xor    %ecx,%ecx
    b0ac:	31 f6                	xor    %esi,%esi
    b0ae:	31 ff                	xor    %edi,%edi
    b0b0:	45 31 c0             	xor    %r8d,%r8d
    b0b3:	e9 00 00 00 00       	jmp    b0b8 <__x64_sys_renameat2+0x68>
    b0b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b0bf:	00 

000000000000b0c0 <__pfx___x64_sys_renameat>:
    b0c0:	90                   	nop
    b0c1:	90                   	nop
    b0c2:	90                   	nop
    b0c3:	90                   	nop
    b0c4:	90                   	nop
    b0c5:	90                   	nop
    b0c6:	90                   	nop
    b0c7:	90                   	nop
    b0c8:	90                   	nop
    b0c9:	90                   	nop
    b0ca:	90                   	nop
    b0cb:	90                   	nop
    b0cc:	90                   	nop
    b0cd:	90                   	nop
    b0ce:	90                   	nop
    b0cf:	90                   	nop

000000000000b0d0 <__x64_sys_renameat>:
    b0d0:	e8 00 00 00 00       	call   b0d5 <__x64_sys_renameat+0x5>
    b0d5:	55                   	push   %rbp
    b0d6:	31 f6                	xor    %esi,%esi
    b0d8:	48 89 e5             	mov    %rsp,%rbp
    b0db:	41 56                	push   %r14
    b0dd:	41 55                	push   %r13
    b0df:	41 54                	push   %r12
    b0e1:	53                   	push   %rbx
    b0e2:	44 8b 6f 60          	mov    0x60(%rdi),%r13d
    b0e6:	4c 8b 77 68          	mov    0x68(%rdi),%r14
    b0ea:	44 8b 67 70          	mov    0x70(%rdi),%r12d
    b0ee:	48 8b 7f 38          	mov    0x38(%rdi),%rdi
    b0f2:	e8 00 00 00 00       	call   b0f7 <__x64_sys_renameat+0x27>
    b0f7:	4c 89 f7             	mov    %r14,%rdi
    b0fa:	31 f6                	xor    %esi,%esi
    b0fc:	48 89 c3             	mov    %rax,%rbx
    b0ff:	e8 00 00 00 00       	call   b104 <__x64_sys_renameat+0x34>
    b104:	48 89 d9             	mov    %rbx,%rcx
    b107:	44 89 ea             	mov    %r13d,%edx
    b10a:	44 89 e7             	mov    %r12d,%edi
    b10d:	48 89 c6             	mov    %rax,%rsi
    b110:	45 31 c0             	xor    %r8d,%r8d
    b113:	e8 00 00 00 00       	call   b118 <__x64_sys_renameat+0x48>
    b118:	5b                   	pop    %rbx
    b119:	41 5c                	pop    %r12
    b11b:	48 98                	cltq
    b11d:	41 5d                	pop    %r13
    b11f:	41 5e                	pop    %r14
    b121:	5d                   	pop    %rbp
    b122:	31 d2                	xor    %edx,%edx
    b124:	31 c9                	xor    %ecx,%ecx
    b126:	31 f6                	xor    %esi,%esi
    b128:	31 ff                	xor    %edi,%edi
    b12a:	45 31 c0             	xor    %r8d,%r8d
    b12d:	e9 00 00 00 00       	jmp    b132 <__x64_sys_renameat+0x62>
    b132:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b139:	00 00 00 00 
    b13d:	0f 1f 00             	nopl   (%rax)

000000000000b140 <__pfx___x64_sys_rename>:
    b140:	90                   	nop
    b141:	90                   	nop
    b142:	90                   	nop
    b143:	90                   	nop
    b144:	90                   	nop
    b145:	90                   	nop
    b146:	90                   	nop
    b147:	90                   	nop
    b148:	90                   	nop
    b149:	90                   	nop
    b14a:	90                   	nop
    b14b:	90                   	nop
    b14c:	90                   	nop
    b14d:	90                   	nop
    b14e:	90                   	nop
    b14f:	90                   	nop

000000000000b150 <__x64_sys_rename>:
    b150:	e8 00 00 00 00       	call   b155 <__x64_sys_rename+0x5>
    b155:	55                   	push   %rbp
    b156:	31 f6                	xor    %esi,%esi
    b158:	48 89 e5             	mov    %rsp,%rbp
    b15b:	41 54                	push   %r12
    b15d:	53                   	push   %rbx
    b15e:	4c 8b 67 70          	mov    0x70(%rdi),%r12
    b162:	48 8b 7f 68          	mov    0x68(%rdi),%rdi
    b166:	e8 00 00 00 00       	call   b16b <__x64_sys_rename+0x1b>
    b16b:	4c 89 e7             	mov    %r12,%rdi
    b16e:	31 f6                	xor    %esi,%esi
    b170:	48 89 c3             	mov    %rax,%rbx
    b173:	e8 00 00 00 00       	call   b178 <__x64_sys_rename+0x28>
    b178:	48 89 d9             	mov    %rbx,%rcx
    b17b:	45 31 c0             	xor    %r8d,%r8d
    b17e:	ba 9c ff ff ff       	mov    $0xffffff9c,%edx
    b183:	48 89 c6             	mov    %rax,%rsi
    b186:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
    b18b:	e8 00 00 00 00       	call   b190 <__x64_sys_rename+0x40>
    b190:	5b                   	pop    %rbx
    b191:	41 5c                	pop    %r12
    b193:	48 98                	cltq
    b195:	5d                   	pop    %rbp
    b196:	31 d2                	xor    %edx,%edx
    b198:	31 c9                	xor    %ecx,%ecx
    b19a:	31 f6                	xor    %esi,%esi
    b19c:	31 ff                	xor    %edi,%edi
    b19e:	45 31 c0             	xor    %r8d,%r8d
    b1a1:	e9 00 00 00 00       	jmp    b1a6 <__x64_sys_rename+0x56>
    b1a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b1ad:	00 00 00 

000000000000b1b0 <__pfx_readlink_copy>:
    b1b0:	90                   	nop
    b1b1:	90                   	nop
    b1b2:	90                   	nop
    b1b3:	90                   	nop
    b1b4:	90                   	nop
    b1b5:	90                   	nop
    b1b6:	90                   	nop
    b1b7:	90                   	nop
    b1b8:	90                   	nop
    b1b9:	90                   	nop
    b1ba:	90                   	nop
    b1bb:	90                   	nop
    b1bc:	90                   	nop
    b1bd:	90                   	nop
    b1be:	90                   	nop
    b1bf:	90                   	nop

000000000000b1c0 <readlink_copy>:
    b1c0:	e8 00 00 00 00       	call   b1c5 <readlink_copy+0x5>
    b1c5:	55                   	push   %rbp
    b1c6:	39 f1                	cmp    %esi,%ecx
    b1c8:	48 89 e5             	mov    %rsp,%rbp
    b1cb:	41 56                	push   %r14
    b1cd:	41 55                	push   %r13
    b1cf:	41 54                	push   %r12
    b1d1:	53                   	push   %rbx
    b1d2:	89 f3                	mov    %esi,%ebx
    b1d4:	0f 46 d9             	cmovbe %ecx,%ebx
    b1d7:	4c 63 f3             	movslq %ebx,%r14
    b1da:	49 81 fe ff ff ff 7f 	cmp    $0x7fffffff,%r14
    b1e1:	77 42                	ja     b225 <readlink_copy+0x65>
    b1e3:	49 89 fd             	mov    %rdi,%r13
    b1e6:	49 89 d4             	mov    %rdx,%r12
    b1e9:	66 90                	xchg   %ax,%ax
    b1eb:	ba 01 00 00 00       	mov    $0x1,%edx
    b1f0:	4c 89 f6             	mov    %r14,%rsi
    b1f3:	4c 89 e7             	mov    %r12,%rdi
    b1f6:	e8 00 00 00 00       	call   b1fb <readlink_copy+0x3b>
    b1fb:	4c 89 f2             	mov    %r14,%rdx
    b1fe:	4c 89 e6             	mov    %r12,%rsi
    b201:	4c 89 ef             	mov    %r13,%rdi
    b204:	e8 00 00 00 00       	call   b209 <readlink_copy+0x49>
    b209:	48 85 c0             	test   %rax,%rax
    b20c:	75 19                	jne    b227 <readlink_copy+0x67>
    b20e:	89 d8                	mov    %ebx,%eax
    b210:	5b                   	pop    %rbx
    b211:	41 5c                	pop    %r12
    b213:	41 5d                	pop    %r13
    b215:	41 5e                	pop    %r14
    b217:	5d                   	pop    %rbp
    b218:	31 d2                	xor    %edx,%edx
    b21a:	31 c9                	xor    %ecx,%ecx
    b21c:	31 f6                	xor    %esi,%esi
    b21e:	31 ff                	xor    %edi,%edi
    b220:	e9 00 00 00 00       	jmp    b225 <readlink_copy+0x65>
    b225:	0f 0b                	ud2
    b227:	bb f2 ff ff ff       	mov    $0xfffffff2,%ebx
    b22c:	eb e0                	jmp    b20e <readlink_copy+0x4e>
    b22e:	66 90                	xchg   %ax,%ax

000000000000b230 <__pfx_vfs_readlink>:
    b230:	90                   	nop
    b231:	90                   	nop
    b232:	90                   	nop
    b233:	90                   	nop
    b234:	90                   	nop
    b235:	90                   	nop
    b236:	90                   	nop
    b237:	90                   	nop
    b238:	90                   	nop
    b239:	90                   	nop
    b23a:	90                   	nop
    b23b:	90                   	nop
    b23c:	90                   	nop
    b23d:	90                   	nop
    b23e:	90                   	nop
    b23f:	90                   	nop

000000000000b240 <vfs_readlink>:
    b240:	e8 00 00 00 00       	call   b245 <vfs_readlink+0x5>
    b245:	55                   	push   %rbp
    b246:	48 89 e5             	mov    %rsp,%rbp
    b249:	41 57                	push   %r15
    b24b:	41 56                	push   %r14
    b24d:	41 89 d6             	mov    %edx,%r14d
    b250:	41 55                	push   %r13
    b252:	49 89 f5             	mov    %rsi,%r13
    b255:	41 54                	push   %r12
    b257:	53                   	push   %rbx
    b258:	48 83 ec 18          	sub    $0x18,%rsp
    b25c:	4c 8b 7f 30          	mov    0x30(%rdi),%r15
    b260:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # b268 <vfs_readlink+0x28>
    b267:	00 
    b268:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    b26c:	31 c0                	xor    %eax,%eax
    b26e:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    b275:	00 
    b276:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    b27d:	00 
    b27e:	41 0f b7 47 02       	movzwl 0x2(%r15),%eax
    b283:	a8 40                	test   $0x40,%al
    b285:	0f 85 96 00 00 00    	jne    b321 <vfs_readlink+0xe1>
    b28b:	49 89 fc             	mov    %rdi,%r12
    b28e:	a8 10                	test   $0x10,%al
    b290:	0f 84 a8 00 00 00    	je     b33e <vfs_readlink+0xfe>
    b296:	49 8b 9f 40 02 00 00 	mov    0x240(%r15),%rbx
    b29d:	48 85 db             	test   %rbx,%rbx
    b2a0:	74 5b                	je     b2fd <vfs_readlink+0xbd>
    b2a2:	48 89 df             	mov    %rbx,%rdi
    b2a5:	e8 00 00 00 00       	call   b2aa <vfs_readlink+0x6a>
    b2aa:	48 89 da             	mov    %rbx,%rdx
    b2ad:	44 89 f6             	mov    %r14d,%esi
    b2b0:	4c 89 ef             	mov    %r13,%rdi
    b2b3:	89 c1                	mov    %eax,%ecx
    b2b5:	e8 00 00 00 00       	call   b2ba <vfs_readlink+0x7a>
    b2ba:	89 c3                	mov    %eax,%ebx
    b2bc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    b2c0:	48 85 c0             	test   %rax,%rax
    b2c3:	74 09                	je     b2ce <vfs_readlink+0x8e>
    b2c5:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    b2c9:	e8 00 00 00 00       	call   b2ce <vfs_readlink+0x8e>
    b2ce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    b2d2:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # b2da <vfs_readlink+0x9a>
    b2d9:	00 
    b2da:	0f 85 b1 00 00 00    	jne    b391 <vfs_readlink+0x151>
    b2e0:	48 83 c4 18          	add    $0x18,%rsp
    b2e4:	89 d8                	mov    %ebx,%eax
    b2e6:	5b                   	pop    %rbx
    b2e7:	41 5c                	pop    %r12
    b2e9:	41 5d                	pop    %r13
    b2eb:	41 5e                	pop    %r14
    b2ed:	41 5f                	pop    %r15
    b2ef:	5d                   	pop    %rbp
    b2f0:	31 d2                	xor    %edx,%edx
    b2f2:	31 c9                	xor    %ecx,%ecx
    b2f4:	31 f6                	xor    %esi,%esi
    b2f6:	31 ff                	xor    %edi,%edi
    b2f8:	e9 00 00 00 00       	jmp    b2fd <vfs_readlink+0xbd>
    b2fd:	49 8b 47 20          	mov    0x20(%r15),%rax
    b301:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
    b305:	4c 89 fe             	mov    %r15,%rsi
    b308:	4c 89 e7             	mov    %r12,%rdi
    b30b:	48 8b 40 08          	mov    0x8(%rax),%rax
    b30f:	e8 00 00 00 00       	call   b314 <vfs_readlink+0xd4>
    b314:	48 89 c3             	mov    %rax,%rbx
    b317:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    b31d:	76 83                	jbe    b2a2 <vfs_readlink+0x62>
    b31f:	eb ad                	jmp    b2ce <vfs_readlink+0x8e>
    b321:	41 8b 8f 30 02 00 00 	mov    0x230(%r15),%ecx
    b328:	49 8b 97 40 02 00 00 	mov    0x240(%r15),%rdx
    b32f:	44 89 f6             	mov    %r14d,%esi
    b332:	4c 89 ef             	mov    %r13,%rdi
    b335:	e8 00 00 00 00       	call   b33a <vfs_readlink+0xfa>
    b33a:	89 c3                	mov    %eax,%ebx
    b33c:	eb 90                	jmp    b2ce <vfs_readlink+0x8e>
    b33e:	49 8b 47 20          	mov    0x20(%r15),%rax
    b342:	48 8b 40 20          	mov    0x20(%rax),%rax
    b346:	48 85 c0             	test   %rax,%rax
    b349:	75 30                	jne    b37b <vfs_readlink+0x13b>
    b34b:	8b 07                	mov    (%rdi),%eax
    b34d:	25 00 00 38 00       	and    $0x380000,%eax
    b352:	3d 00 00 30 00       	cmp    $0x300000,%eax
    b357:	75 2e                	jne    b387 <vfs_readlink+0x147>
    b359:	49 8d 9f 80 00 00 00 	lea    0x80(%r15),%rbx
    b360:	48 89 df             	mov    %rbx,%rdi
    b363:	e8 00 00 00 00       	call   b368 <vfs_readlink+0x128>
    b368:	66 41 83 4f 02 10    	orw    $0x10,0x2(%r15)
    b36e:	48 89 df             	mov    %rbx,%rdi
    b371:	e8 00 00 00 00       	call   b376 <vfs_readlink+0x136>
    b376:	e9 1b ff ff ff       	jmp    b296 <vfs_readlink+0x56>
    b37b:	e8 00 00 00 00       	call   b380 <vfs_readlink+0x140>
    b380:	89 c3                	mov    %eax,%ebx
    b382:	e9 47 ff ff ff       	jmp    b2ce <vfs_readlink+0x8e>
    b387:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
    b38c:	e9 3d ff ff ff       	jmp    b2ce <vfs_readlink+0x8e>
    b391:	e8 00 00 00 00       	call   b396 <vfs_readlink+0x156>
    b396:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b39d:	00 00 00 

000000000000b3a0 <__pfx_page_readlink>:
    b3a0:	90                   	nop
    b3a1:	90                   	nop
    b3a2:	90                   	nop
    b3a3:	90                   	nop
    b3a4:	90                   	nop
    b3a5:	90                   	nop
    b3a6:	90                   	nop
    b3a7:	90                   	nop
    b3a8:	90                   	nop
    b3a9:	90                   	nop
    b3aa:	90                   	nop
    b3ab:	90                   	nop
    b3ac:	90                   	nop
    b3ad:	90                   	nop
    b3ae:	90                   	nop
    b3af:	90                   	nop

000000000000b3b0 <page_readlink>:
    b3b0:	e8 00 00 00 00       	call   b3b5 <page_readlink+0x5>
    b3b5:	55                   	push   %rbp
    b3b6:	48 89 e5             	mov    %rsp,%rbp
    b3b9:	41 56                	push   %r14
    b3bb:	41 55                	push   %r13
    b3bd:	41 89 d5             	mov    %edx,%r13d
    b3c0:	48 8d 55 c8          	lea    -0x38(%rbp),%rdx
    b3c4:	41 54                	push   %r12
    b3c6:	49 89 f4             	mov    %rsi,%r12
    b3c9:	53                   	push   %rbx
    b3ca:	48 83 ec 18          	sub    $0x18,%rsp
    b3ce:	4c 8b 77 30          	mov    0x30(%rdi),%r14
    b3d2:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # b3da <page_readlink+0x2a>
    b3d9:	00 
    b3da:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    b3de:	31 c0                	xor    %eax,%eax
    b3e0:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
    b3e7:	00 
    b3e8:	49 8b 76 30          	mov    0x30(%r14),%rsi
    b3ec:	48 c7 45 d0 00 00 00 	movq   $0x0,-0x30(%rbp)
    b3f3:	00 
    b3f4:	e8 67 61 ff ff       	call   1560 <__page_get_link.isra.0>
    b3f9:	48 89 c3             	mov    %rax,%rbx
    b3fc:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    b402:	77 2e                	ja     b432 <page_readlink+0x82>
    b404:	49 8b 46 50          	mov    0x50(%r14),%rax
    b408:	ba ff 0f 00 00       	mov    $0xfff,%edx
    b40d:	48 89 df             	mov    %rbx,%rdi
    b410:	48 39 d0             	cmp    %rdx,%rax
    b413:	48 0f 47 c2          	cmova  %rdx,%rax
    b417:	c6 04 03 00          	movb   $0x0,(%rbx,%rax,1)
    b41b:	e8 00 00 00 00       	call   b420 <page_readlink+0x70>
    b420:	48 89 da             	mov    %rbx,%rdx
    b423:	44 89 ee             	mov    %r13d,%esi
    b426:	4c 89 e7             	mov    %r12,%rdi
    b429:	89 c1                	mov    %eax,%ecx
    b42b:	e8 00 00 00 00       	call   b430 <page_readlink+0x80>
    b430:	89 c3                	mov    %eax,%ebx
    b432:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    b436:	48 85 c0             	test   %rax,%rax
    b439:	74 09                	je     b444 <page_readlink+0x94>
    b43b:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    b43f:	e8 00 00 00 00       	call   b444 <page_readlink+0x94>
    b444:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    b448:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # b450 <page_readlink+0xa0>
    b44f:	00 
    b450:	75 1b                	jne    b46d <page_readlink+0xbd>
    b452:	48 83 c4 18          	add    $0x18,%rsp
    b456:	89 d8                	mov    %ebx,%eax
    b458:	5b                   	pop    %rbx
    b459:	41 5c                	pop    %r12
    b45b:	41 5d                	pop    %r13
    b45d:	41 5e                	pop    %r14
    b45f:	5d                   	pop    %rbp
    b460:	31 d2                	xor    %edx,%edx
    b462:	31 c9                	xor    %ecx,%ecx
    b464:	31 f6                	xor    %esi,%esi
    b466:	31 ff                	xor    %edi,%edi
    b468:	e9 00 00 00 00       	jmp    b46d <page_readlink+0xbd>
    b46d:	e8 00 00 00 00       	call   b472 <page_readlink+0xc2>

Disassembly of section .init.text:

0000000000000000 <__pfx_init_fs_namei_sysctls>:
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop

0000000000000010 <init_fs_namei_sysctls>:
  10:	e8 00 00 00 00       	call   15 <init_fs_namei_sysctls+0x5>
  15:	55                   	push   %rbp
  16:	b9 04 00 00 00       	mov    $0x4,%ecx
  1b:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
  22:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
  29:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  30:	48 89 e5             	mov    %rsp,%rbp
  33:	e8 00 00 00 00       	call   38 <init_fs_namei_sysctls+0x28>
  38:	31 c0                	xor    %eax,%eax
  3a:	5d                   	pop    %rbp
  3b:	31 d2                	xor    %edx,%edx
  3d:	31 c9                	xor    %ecx,%ecx
  3f:	31 f6                	xor    %esi,%esi
  41:	31 ff                	xor    %edi,%edi
  43:	e9 00 00 00 00       	jmp    48 <__UNIQUE_ID___addressable_vfs_link826>

Disassembly of section .text.unlikely:

0000000000000000 <step_into.cold>:
   0:	41 0f b6 f4          	movzbl %r12b,%esi
   4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
   b:	e8 00 00 00 00       	call   10 <step_into.cold+0x10>
  10:	e9 00 00 00 00       	jmp    15 <.LC2+0x4>
