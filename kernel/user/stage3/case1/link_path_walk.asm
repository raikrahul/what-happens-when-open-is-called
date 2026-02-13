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
