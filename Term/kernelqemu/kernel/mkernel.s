
mkernel.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
   0:	d01f083c 	lui	t0,0x1fd0
   4:	fc030825 	addiu	t0,t0,1020
   8:	0000098d 	lw	t1,0(t0)
   c:	01002931 	andi	t1,t1,0x1
  10:	fbff2011 	beqz	t1,0x0
  14:	00000000 	nop
  18:	0800e003 	jr	ra
  1c:	00000000 	nop
  20:	00000000 	nop
  24:	d01f083c 	lui	t0,0x1fd0
  28:	fc030825 	addiu	t0,t0,1020
  2c:	0000098d 	lw	t1,0(t0)
  30:	02002931 	andi	t1,t1,0x2
  34:	fbff2011 	beqz	t1,0x24
  38:	00000000 	nop
  3c:	0800e003 	jr	ra
  40:	00000000 	nop
  44:	00000000 	nop
  48:	d0bf083c 	lui	t0,0xbfd0
  4c:	f8030825 	addiu	t0,t0,1016
  50:	05000981 	lb	t1,5(t0)
  54:	20002931 	andi	t1,t1,0x20
  58:	fbff2011 	beqz	t1,0x48
  5c:	00000000 	nop
  60:	0800e003 	jr	ra
  64:	00000000 	nop
  68:	00000000 	nop
  6c:	d0bf083c 	lui	t0,0xbfd0
  70:	f8030825 	addiu	t0,t0,1016
  74:	05000981 	lb	t1,5(t0)
  78:	01002931 	andi	t1,t1,0x1
  7c:	fbff2011 	beqz	t1,0x6c
  80:	00000000 	nop
  84:	0800e003 	jr	ra
  88:	00000000 	nop
  8c:	00000000 	nop
  90:	0000ec27 	addiu	t4,ra,0
  94:	0400ad25 	addiu	t5,t5,4
  98:	0000af8d 	lw	t7,0(t5)
  9c:	0000000c 	jal	0x0
  a0:	02080f00 	srl	at,t7,0x0
  a4:	00000000 	nop
  a8:	d01f083c 	lui	t0,0x1fd0
  ac:	f8030825 	addiu	t0,t0,1016
  b0:	ff002130 	andi	at,at,0xff
  b4:	000001ad 	sw	at,0(t0)
  b8:	0000000c 	jal	0x0
  bc:	020a0f00 	srl	at,t7,0x8
  c0:	00000000 	nop
  c4:	d01f083c 	lui	t0,0x1fd0
  c8:	f8030825 	addiu	t0,t0,1016
  cc:	ff002130 	andi	at,at,0xff
  d0:	000001ad 	sw	at,0(t0)
  d4:	0000000c 	jal	0x0
  d8:	020c0f00 	srl	at,t7,0x10
  dc:	00000000 	nop
  e0:	d01f083c 	lui	t0,0x1fd0
  e4:	f8030825 	addiu	t0,t0,1016
  e8:	ff002130 	andi	at,at,0xff
  ec:	000001ad 	sw	at,0(t0)
  f0:	0000000c 	jal	0x0
  f4:	020e0f00 	srl	at,t7,0x18
  f8:	00000000 	nop
  fc:	d01f083c 	lui	t0,0x1fd0
 100:	f8030825 	addiu	t0,t0,1016
 104:	ff002130 	andi	at,at,0xff
 108:	e2ffae15 	bne	t5,t6,0x94
 10c:	000001ad 	sw	at,0(t0)
 110:	00000000 	nop
 114:	00009f25 	addiu	ra,t4,0
 118:	0800e003 	jr	ra
 11c:	00000000 	nop
 120:	00000000 	nop
 124:	0000000c 	jal	0x0
 128:	00000000 	nop
 12c:	00000000 	nop
 130:	d01f083c 	lui	t0,0x1fd0
 134:	f8030825 	addiu	t0,t0,1016
 138:	4f000924 	li	t1,79
 13c:	0000000c 	jal	0x0
 140:	000009ad 	sw	t1,0(t0)
 144:	00000000 	nop
 148:	d01f083c 	lui	t0,0x1fd0
 14c:	f8030825 	addiu	t0,t0,1016
 150:	4b000924 	li	t1,75
 154:	0000000c 	jal	0x0
 158:	000009ad 	sw	t1,0(t0)
 15c:	00000000 	nop
 160:	d01f083c 	lui	t0,0x1fd0
 164:	f8030825 	addiu	t0,t0,1016
 168:	0a000924 	li	t1,10
 16c:	0000000c 	jal	0x0
 170:	000009ad 	sw	t1,0(t0)
 174:	00000000 	nop
 178:	d01f083c 	lui	t0,0x1fd0
 17c:	f8030825 	addiu	t0,t0,1016
 180:	0d000924 	li	t1,13
 184:	000009ad 	sw	t1,0(t0)
 188:	0080083c 	lui	t0,0x8000
 18c:	00000825 	addiu	t0,t0,0
 190:	00000924 	li	t1,0
 194:	20000a24 	li	t2,32
 198:	00000b24 	li	t3,0
 19c:	21600b01 	addu	t4,t0,t3
 1a0:	000000ad 	sw	zero,0(t0)
 1a4:	01002925 	addiu	t1,t1,1
 1a8:	fcff2a15 	bne	t1,t2,0x19c
 1ac:	04006b25 	addiu	t3,t3,4
 1b0:	0900000c 	jal	0x24
 1b4:	00000000 	nop
 1b8:	00000000 	nop
 1bc:	d01f083c 	lui	t0,0x1fd0
 1c0:	f8030825 	addiu	t0,t0,1016
 1c4:	0000028d 	lw	v0,0(t0)
 1c8:	ff000824 	li	t0,255
 1cc:	24104800 	and	v0,v0,t0
 1d0:	00004b24 	addiu	t3,v0,0
 1d4:	52000824 	li	t0,82
 1d8:	12006811 	beq	t3,t0,0x224
 1dc:	00000000 	nop
 1e0:	00000000 	nop
 1e4:	44000824 	li	t0,68
 1e8:	1b006811 	beq	t3,t0,0x258
 1ec:	00000000 	nop
 1f0:	00000000 	nop
 1f4:	41000824 	li	t0,65
 1f8:	6b006811 	beq	t3,t0,0x3a8
 1fc:	00000000 	nop
 200:	00000000 	nop
 204:	55000824 	li	t0,85
 208:	00000000 	nop
 20c:	47000824 	li	t0,71
 210:	c8006811 	beq	t3,t0,0x534
 214:	00000000 	nop
 218:	e5ff0010 	b	0x1b0
 21c:	00000000 	nop
 220:	00000000 	nop
 224:	00800d3c 	lui	t5,0x8000
 228:	0400ad25 	addiu	t5,t5,4
 22c:	2400000c 	jal	0x90
 230:	7400ae25 	addiu	t6,t5,116
 234:	0000000c 	jal	0x0
 238:	00000000 	nop
 23c:	00000000 	nop
 240:	d01f083c 	lui	t0,0x1fd0
 244:	f8030825 	addiu	t0,t0,1016
 248:	00000924 	li	t1,0
 24c:	d8ff0010 	b	0x1b0
 250:	000009ad 	sw	t1,0(t0)
 254:	00000000 	nop
 258:	0900000c 	jal	0x24
 25c:	00000c24 	li	t4,0
 260:	00000000 	nop
 264:	d01f083c 	lui	t0,0x1fd0
 268:	f8030825 	addiu	t0,t0,1016
 26c:	0000028d 	lw	v0,0(t0)
 270:	ff000824 	li	t0,255
 274:	24104800 	and	v0,v0,t0
 278:	0900000c 	jal	0x24
 27c:	00004c24 	addiu	t4,v0,0
 280:	00000000 	nop
 284:	d01f083c 	lui	t0,0x1fd0
 288:	f8030825 	addiu	t0,t0,1016
 28c:	0000028d 	lw	v0,0(t0)
 290:	ff000824 	li	t0,255
 294:	24104800 	and	v0,v0,t0
 298:	00120200 	sll	v0,v0,0x8
 29c:	0900000c 	jal	0x24
 2a0:	21608201 	addu	t4,t4,v0
 2a4:	00000000 	nop
 2a8:	d01f083c 	lui	t0,0x1fd0
 2ac:	f8030825 	addiu	t0,t0,1016
 2b0:	0000028d 	lw	v0,0(t0)
 2b4:	ff000824 	li	t0,255
 2b8:	24104800 	and	v0,v0,t0
 2bc:	00140200 	sll	v0,v0,0x10
 2c0:	0900000c 	jal	0x24
 2c4:	21608201 	addu	t4,t4,v0
 2c8:	00000000 	nop
 2cc:	d01f083c 	lui	t0,0x1fd0
 2d0:	f8030825 	addiu	t0,t0,1016
 2d4:	0000028d 	lw	v0,0(t0)
 2d8:	ff000824 	li	t0,255
 2dc:	24104800 	and	v0,v0,t0
 2e0:	00160200 	sll	v0,v0,0x18
 2e4:	21108201 	addu	v0,t4,v0
 2e8:	fcff4d24 	addiu	t5,v0,-4
 2ec:	0900000c 	jal	0x24
 2f0:	00000c24 	li	t4,0
 2f4:	00000000 	nop
 2f8:	d01f083c 	lui	t0,0x1fd0
 2fc:	f8030825 	addiu	t0,t0,1016
 300:	0000028d 	lw	v0,0(t0)
 304:	ff000824 	li	t0,255
 308:	24104800 	and	v0,v0,t0
 30c:	0900000c 	jal	0x24
 310:	00004c24 	addiu	t4,v0,0
 314:	00000000 	nop
 318:	d01f083c 	lui	t0,0x1fd0
 31c:	f8030825 	addiu	t0,t0,1016
 320:	0000028d 	lw	v0,0(t0)
 324:	ff000824 	li	t0,255
 328:	24104800 	and	v0,v0,t0
 32c:	00120200 	sll	v0,v0,0x8
 330:	0900000c 	jal	0x24
 334:	21608201 	addu	t4,t4,v0
 338:	00000000 	nop
 33c:	d01f083c 	lui	t0,0x1fd0
 340:	f8030825 	addiu	t0,t0,1016
 344:	0000028d 	lw	v0,0(t0)
 348:	ff000824 	li	t0,255
 34c:	24104800 	and	v0,v0,t0
 350:	00140200 	sll	v0,v0,0x10
 354:	0900000c 	jal	0x24
 358:	21608201 	addu	t4,t4,v0
 35c:	00000000 	nop
 360:	d01f083c 	lui	t0,0x1fd0
 364:	f8030825 	addiu	t0,t0,1016
 368:	0000028d 	lw	v0,0(t0)
 36c:	ff000824 	li	t0,255
 370:	24104800 	and	v0,v0,t0
 374:	00160200 	sll	v0,v0,0x18
 378:	21108201 	addu	v0,t4,v0
 37c:	2400000c 	jal	0x90
 380:	fcff4e24 	addiu	t6,v0,-4
 384:	0000000c 	jal	0x0
 388:	00000000 	nop
 38c:	00000000 	nop
 390:	d01f083c 	lui	t0,0x1fd0
 394:	f8030825 	addiu	t0,t0,1016
 398:	00000924 	li	t1,0
 39c:	84ff0010 	b	0x1b0
 3a0:	000009ad 	sw	t1,0(t0)
 3a4:	00000000 	nop
 3a8:	0900000c 	jal	0x24
 3ac:	00000c24 	li	t4,0
 3b0:	00000000 	nop
 3b4:	d01f083c 	lui	t0,0x1fd0
 3b8:	f8030825 	addiu	t0,t0,1016
 3bc:	0000028d 	lw	v0,0(t0)
 3c0:	ff000824 	li	t0,255
 3c4:	24104800 	and	v0,v0,t0
 3c8:	0900000c 	jal	0x24
 3cc:	00004c24 	addiu	t4,v0,0
 3d0:	00000000 	nop
 3d4:	d01f083c 	lui	t0,0x1fd0
 3d8:	f8030825 	addiu	t0,t0,1016
 3dc:	0000028d 	lw	v0,0(t0)
 3e0:	ff000824 	li	t0,255
 3e4:	24104800 	and	v0,v0,t0
 3e8:	00120200 	sll	v0,v0,0x8
 3ec:	0900000c 	jal	0x24
 3f0:	21608201 	addu	t4,t4,v0
 3f4:	00000000 	nop
 3f8:	d01f083c 	lui	t0,0x1fd0
 3fc:	f8030825 	addiu	t0,t0,1016
 400:	0000028d 	lw	v0,0(t0)
 404:	ff000824 	li	t0,255
 408:	24104800 	and	v0,v0,t0
 40c:	00140200 	sll	v0,v0,0x10
 410:	0900000c 	jal	0x24
 414:	21608201 	addu	t4,t4,v0
 418:	00000000 	nop
 41c:	d01f083c 	lui	t0,0x1fd0
 420:	f8030825 	addiu	t0,t0,1016
 424:	0000028d 	lw	v0,0(t0)
 428:	ff000824 	li	t0,255
 42c:	24104800 	and	v0,v0,t0
 430:	00160200 	sll	v0,v0,0x18
 434:	21108201 	addu	v0,t4,v0
 438:	00004e24 	addiu	t6,v0,0
 43c:	0900000c 	jal	0x24
 440:	00000c24 	li	t4,0
 444:	00000000 	nop
 448:	d01f083c 	lui	t0,0x1fd0
 44c:	f8030825 	addiu	t0,t0,1016
 450:	0000028d 	lw	v0,0(t0)
 454:	ff000824 	li	t0,255
 458:	24104800 	and	v0,v0,t0
 45c:	0900000c 	jal	0x24
 460:	00004c24 	addiu	t4,v0,0
 464:	00000000 	nop
 468:	d01f083c 	lui	t0,0x1fd0
 46c:	f8030825 	addiu	t0,t0,1016
 470:	0000028d 	lw	v0,0(t0)
 474:	ff000824 	li	t0,255
 478:	24104800 	and	v0,v0,t0
 47c:	00120200 	sll	v0,v0,0x8
 480:	0900000c 	jal	0x24
 484:	21608201 	addu	t4,t4,v0
 488:	00000000 	nop
 48c:	d01f083c 	lui	t0,0x1fd0
 490:	f8030825 	addiu	t0,t0,1016
 494:	0000028d 	lw	v0,0(t0)
 498:	ff000824 	li	t0,255
 49c:	24104800 	and	v0,v0,t0
 4a0:	00140200 	sll	v0,v0,0x10
 4a4:	0900000c 	jal	0x24
 4a8:	21608201 	addu	t4,t4,v0
 4ac:	00000000 	nop
 4b0:	d01f083c 	lui	t0,0x1fd0
 4b4:	f8030825 	addiu	t0,t0,1016
 4b8:	0000028d 	lw	v0,0(t0)
 4bc:	ff000824 	li	t0,255
 4c0:	24104800 	and	v0,v0,t0
 4c4:	00160200 	sll	v0,v0,0x18
 4c8:	21108201 	addu	v0,t4,v0
 4cc:	00004d24 	addiu	t5,v0,0
 4d0:	0f00ae11 	beq	t5,t6,0x510
 4d4:	00000000 	nop
 4d8:	00000000 	nop
 4dc:	0900000c 	jal	0x24
 4e0:	00000000 	nop
 4e4:	00000000 	nop
 4e8:	d01f083c 	lui	t0,0x1fd0
 4ec:	f8030825 	addiu	t0,t0,1016
 4f0:	0000028d 	lw	v0,0(t0)
 4f4:	ff000824 	li	t0,255
 4f8:	24104800 	and	v0,v0,t0
 4fc:	0000c2a1 	sb	v0,0(t6)
 500:	0100ce25 	addiu	t6,t6,1
 504:	f5ffae15 	bne	t5,t6,0x4dc
 508:	00000000 	nop
 50c:	00000000 	nop
 510:	0000000c 	jal	0x0
 514:	00000000 	nop
 518:	00000000 	nop
 51c:	d01f083c 	lui	t0,0x1fd0
 520:	f8030825 	addiu	t0,t0,1016
 524:	00000924 	li	t1,0
 528:	21ff0010 	b	0x1b0
 52c:	000009ad 	sw	t1,0(t0)
 530:	00000000 	nop
 534:	0900000c 	jal	0x24
 538:	00000c24 	li	t4,0
 53c:	00000000 	nop
 540:	d01f083c 	lui	t0,0x1fd0
 544:	f8030825 	addiu	t0,t0,1016
 548:	0000028d 	lw	v0,0(t0)
 54c:	ff000824 	li	t0,255
 550:	24104800 	and	v0,v0,t0
 554:	0900000c 	jal	0x24
 558:	00004c24 	addiu	t4,v0,0
 55c:	00000000 	nop
 560:	d01f083c 	lui	t0,0x1fd0
 564:	f8030825 	addiu	t0,t0,1016
 568:	0000028d 	lw	v0,0(t0)
 56c:	ff000824 	li	t0,255
 570:	24104800 	and	v0,v0,t0
 574:	00120200 	sll	v0,v0,0x8
 578:	0900000c 	jal	0x24
 57c:	21608201 	addu	t4,t4,v0
 580:	00000000 	nop
 584:	d01f083c 	lui	t0,0x1fd0
 588:	f8030825 	addiu	t0,t0,1016
 58c:	0000028d 	lw	v0,0(t0)
 590:	ff000824 	li	t0,255
 594:	24104800 	and	v0,v0,t0
 598:	00140200 	sll	v0,v0,0x10
 59c:	0900000c 	jal	0x24
 5a0:	21608201 	addu	t4,t4,v0
 5a4:	00000000 	nop
 5a8:	d01f083c 	lui	t0,0x1fd0
 5ac:	f8030825 	addiu	t0,t0,1016
 5b0:	0000028d 	lw	v0,0(t0)
 5b4:	ff000824 	li	t0,255
 5b8:	24104800 	and	v0,v0,t0
 5bc:	00160200 	sll	v0,v0,0x18
 5c0:	21108201 	addu	v0,t4,v0
 5c4:	00005f24 	addiu	ra,v0,0
 5c8:	0080013c 	lui	at,0x8000
 5cc:	00002124 	addiu	at,at,0
 5d0:	0800228c 	lw	v0,8(at)
 5d4:	0c00238c 	lw	v1,12(at)
 5d8:	1000248c 	lw	a0,16(at)
 5dc:	1400258c 	lw	a1,20(at)
 5e0:	1800268c 	lw	a2,24(at)
 5e4:	1c00278c 	lw	a3,28(at)
 5e8:	2000288c 	lw	t0,32(at)
 5ec:	2400298c 	lw	t1,36(at)
 5f0:	28002a8c 	lw	t2,40(at)
 5f4:	2c002b8c 	lw	t3,44(at)
 5f8:	30002c8c 	lw	t4,48(at)
 5fc:	34002d8c 	lw	t5,52(at)
 600:	38002e8c 	lw	t6,56(at)
 604:	3c002f8c 	lw	t7,60(at)
 608:	4000308c 	lw	s0,64(at)
 60c:	4400318c 	lw	s1,68(at)
 610:	4800328c 	lw	s2,72(at)
 614:	4c00338c 	lw	s3,76(at)
 618:	5000348c 	lw	s4,80(at)
 61c:	5400358c 	lw	s5,84(at)
 620:	5800368c 	lw	s6,88(at)
 624:	5c00378c 	lw	s7,92(at)
 628:	6000388c 	lw	t8,96(at)
 62c:	6400398c 	lw	t9,100(at)
 630:	68003a8c 	lw	k0,104(at)
 634:	6c003b8c 	lw	k1,108(at)
 638:	70003c8c 	lw	gp,112(at)
 63c:	74003d8c 	lw	sp,116(at)
 640:	09f8e003 	jalr	ra
 644:	78003e8c 	lw	s8,120(at)
 648:	00000000 	nop
 64c:	0080013c 	lui	at,0x8000
 650:	00002124 	addiu	at,at,0
 654:	080022ac 	sw	v0,8(at)
 658:	0c0023ac 	sw	v1,12(at)
 65c:	100024ac 	sw	a0,16(at)
 660:	140025ac 	sw	a1,20(at)
 664:	180026ac 	sw	a2,24(at)
 668:	1c0027ac 	sw	a3,28(at)
 66c:	200028ac 	sw	t0,32(at)
 670:	240029ac 	sw	t1,36(at)
 674:	28002aac 	sw	t2,40(at)
 678:	2c002bac 	sw	t3,44(at)
 67c:	30002cac 	sw	t4,48(at)
 680:	34002dac 	sw	t5,52(at)
 684:	38002eac 	sw	t6,56(at)
 688:	3c002fac 	sw	t7,60(at)
 68c:	400030ac 	sw	s0,64(at)
 690:	440031ac 	sw	s1,68(at)
 694:	480032ac 	sw	s2,72(at)
 698:	4c0033ac 	sw	s3,76(at)
 69c:	500034ac 	sw	s4,80(at)
 6a0:	540035ac 	sw	s5,84(at)
 6a4:	580036ac 	sw	s6,88(at)
 6a8:	5c0037ac 	sw	s7,92(at)
 6ac:	600038ac 	sw	t8,96(at)
 6b0:	640039ac 	sw	t9,100(at)
 6b4:	68003aac 	sw	k0,104(at)
 6b8:	6c003bac 	sw	k1,108(at)
 6bc:	70003cac 	sw	gp,112(at)
 6c0:	74003dac 	sw	sp,116(at)
 6c4:	0000000c 	jal	0x0
 6c8:	78003eac 	sw	s8,120(at)
 6cc:	00000000 	nop
 6d0:	d01f083c 	lui	t0,0x1fd0
 6d4:	f8030825 	addiu	t0,t0,1016
 6d8:	00000924 	li	t1,0
 6dc:	b4fe0010 	b	0x1b0
 6e0:	000009ad 	sw	t1,0(t0)
 6e4:	00000000 	nop
