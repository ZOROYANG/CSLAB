
k_modify.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
   0:	3c081fd0 	lui	t0,0x1fd0
   4:	250803fc 	addiu	t0,t0,1020
   8:	8d090000 	lw	t1,0(t0)
   c:	31290001 	andi	t1,t1,0x1
  10:	00000000 	nop
  14:	1120fffa 	beqz	t1,0x0
  18:	00000000 	nop
  1c:	03e00008 	jr	ra
  20:	00000000 	nop
  24:	3c081fd0 	lui	t0,0x1fd0
  28:	250803fc 	addiu	t0,t0,1020
  2c:	8d090000 	lw	t1,0(t0)
  30:	31290002 	andi	t1,t1,0x2
  34:	00000000 	nop
  38:	1120fffa 	beqz	t1,0x24
  3c:	00000000 	nop
  40:	03e00008 	jr	ra
  44:	00000000 	nop
  48:	3c08bfd0 	lui	t0,0xbfd0
  4c:	250803f8 	addiu	t0,t0,1016
  50:	81090005 	lb	t1,5(t0)
  54:	31290020 	andi	t1,t1,0x20
  58:	00000000 	nop
  5c:	1120fffa 	beqz	t1,0x48
  60:	00000000 	nop
  64:	03e00008 	jr	ra
  68:	00000000 	nop
  6c:	3c08bfd0 	lui	t0,0xbfd0
  70:	250803f8 	addiu	t0,t0,1016
  74:	81090005 	lb	t1,5(t0)
  78:	31290001 	andi	t1,t1,0x1
  7c:	00000000 	nop
  80:	1120fffa 	beqz	t1,0x6c
  84:	00000000 	nop
  88:	03e00008 	jr	ra
  8c:	00000000 	nop
  90:	27ec0000 	addiu	t4,ra,0
  94:	25ad0004 	addiu	t5,t5,4
  98:	8daf0000 	lw	t7,0(t5)
  9c:	0c000000 	jal	0x0
  a0:	000f0802 	srl	at,t7,0x0
  a4:	00000000 	nop
  a8:	3c081fd0 	lui	t0,0x1fd0
  ac:	250803f8 	addiu	t0,t0,1016
  b0:	302100ff 	andi	at,at,0xff
  b4:	ad010000 	sw	at,0(t0)
  b8:	0c000000 	jal	0x0
  bc:	000f0a02 	srl	at,t7,0x8
  c0:	00000000 	nop
  c4:	3c081fd0 	lui	t0,0x1fd0
  c8:	250803f8 	addiu	t0,t0,1016
  cc:	302100ff 	andi	at,at,0xff
  d0:	ad010000 	sw	at,0(t0)
  d4:	0c000000 	jal	0x0
  d8:	000f0c02 	srl	at,t7,0x10
  dc:	00000000 	nop
  e0:	3c081fd0 	lui	t0,0x1fd0
  e4:	250803f8 	addiu	t0,t0,1016
  e8:	302100ff 	andi	at,at,0xff
  ec:	ad010000 	sw	at,0(t0)
  f0:	0c000000 	jal	0x0
  f4:	000f0e02 	srl	at,t7,0x18
  f8:	00000000 	nop
  fc:	3c081fd0 	lui	t0,0x1fd0
 100:	250803f8 	addiu	t0,t0,1016
 104:	302100ff 	andi	at,at,0xff
 108:	ad010000 	sw	at,0(t0)
 10c:	15aeffe1 	bne	t5,t6,0x94
 110:	00000000 	nop
 114:	259f0000 	addiu	ra,t4,0
 118:	00000000 	nop
 11c:	03e00008 	jr	ra
 120:	00000000 	nop
 124:	0c000000 	jal	0x0
 128:	00000000 	nop
 12c:	00000000 	nop
 130:	3c081fd0 	lui	t0,0x1fd0
 134:	250803f8 	addiu	t0,t0,1016
 138:	2409004f 	li	t1,79
 13c:	0c000000 	jal	0x0
 140:	ad090000 	sw	t1,0(t0)
 144:	00000000 	nop
 148:	3c081fd0 	lui	t0,0x1fd0
 14c:	250803f8 	addiu	t0,t0,1016
 150:	2409004b 	li	t1,75
 154:	0c000000 	jal	0x0
 158:	ad090000 	sw	t1,0(t0)
 15c:	00000000 	nop
 160:	3c081fd0 	lui	t0,0x1fd0
 164:	250803f8 	addiu	t0,t0,1016
 168:	2409000a 	li	t1,10
 16c:	0c000000 	jal	0x0
 170:	ad090000 	sw	t1,0(t0)
 174:	00000000 	nop
 178:	3c081fd0 	lui	t0,0x1fd0
 17c:	250803f8 	addiu	t0,t0,1016
 180:	2409000d 	li	t1,13
 184:	ad090000 	sw	t1,0(t0)
 188:	3c088000 	lui	t0,0x8000
 18c:	25080000 	addiu	t0,t0,0
 190:	24090000 	li	t1,0
 194:	240a0020 	li	t2,32
 198:	240b0000 	li	t3,0
 19c:	010b6021 	addu	t4,t0,t3
 1a0:	ad000000 	sw	zero,0(t0)
 1a4:	25290001 	addiu	t1,t1,1
 1a8:	256b0004 	addiu	t3,t3,4
 1ac:	152afffb 	bne	t1,t2,0x19c
 1b0:	0c000009 	jal	0x24
 1b4:	00000000 	nop
 1b8:	00000000 	nop
 1bc:	3c081fd0 	lui	t0,0x1fd0
 1c0:	250803f8 	addiu	t0,t0,1016
 1c4:	8d020000 	lw	v0,0(t0)
 1c8:	240800ff 	li	t0,255
 1cc:	00481024 	and	v0,v0,t0
 1d0:	244b0000 	addiu	t3,v0,0
 1d4:	24080052 	li	t0,82
 1d8:	00000000 	nop
 1dc:	11680011 	beq	t3,t0,0x224
 1e0:	00000000 	nop
 1e4:	24080044 	li	t0,68
 1e8:	00000000 	nop
 1ec:	1168001a 	beq	t3,t0,0x258
 1f0:	00000000 	nop
 1f4:	24080041 	li	t0,65
 1f8:	00000000 	nop
 1fc:	1168006a 	beq	t3,t0,0x3a8
 200:	00000000 	nop
 204:	24080055 	li	t0,85
 208:	00000000 	nop
 20c:	24080047 	li	t0,71
 210:	00000000 	nop
 214:	116800c7 	beq	t3,t0,0x534
 218:	00000000 	nop
 21c:	1000ffe4 	b	0x1b0
 220:	00000000 	nop
 224:	3c0d8000 	lui	t5,0x8000
 228:	25ad0004 	addiu	t5,t5,4
 22c:	0c000024 	jal	0x90
 230:	25ae0074 	addiu	t6,t5,116
 234:	0c000000 	jal	0x0
 238:	00000000 	nop
 23c:	00000000 	nop
 240:	3c081fd0 	lui	t0,0x1fd0
 244:	250803f8 	addiu	t0,t0,1016
 248:	24090000 	li	t1,0
 24c:	ad090000 	sw	t1,0(t0)
 250:	1000ffd7 	b	0x1b0
 254:	00000000 	nop
 258:	0c000009 	jal	0x24
 25c:	240c0000 	li	t4,0
 260:	00000000 	nop
 264:	3c081fd0 	lui	t0,0x1fd0
 268:	250803f8 	addiu	t0,t0,1016
 26c:	8d020000 	lw	v0,0(t0)
 270:	240800ff 	li	t0,255
 274:	00481024 	and	v0,v0,t0
 278:	0c000009 	jal	0x24
 27c:	244c0000 	addiu	t4,v0,0
 280:	00000000 	nop
 284:	3c081fd0 	lui	t0,0x1fd0
 288:	250803f8 	addiu	t0,t0,1016
 28c:	8d020000 	lw	v0,0(t0)
 290:	240800ff 	li	t0,255
 294:	00481024 	and	v0,v0,t0
 298:	00021200 	sll	v0,v0,0x8
 29c:	0c000009 	jal	0x24
 2a0:	01826021 	addu	t4,t4,v0
 2a4:	00000000 	nop
 2a8:	3c081fd0 	lui	t0,0x1fd0
 2ac:	250803f8 	addiu	t0,t0,1016
 2b0:	8d020000 	lw	v0,0(t0)
 2b4:	240800ff 	li	t0,255
 2b8:	00481024 	and	v0,v0,t0
 2bc:	00021400 	sll	v0,v0,0x10
 2c0:	0c000009 	jal	0x24
 2c4:	01826021 	addu	t4,t4,v0
 2c8:	00000000 	nop
 2cc:	3c081fd0 	lui	t0,0x1fd0
 2d0:	250803f8 	addiu	t0,t0,1016
 2d4:	8d020000 	lw	v0,0(t0)
 2d8:	240800ff 	li	t0,255
 2dc:	00481024 	and	v0,v0,t0
 2e0:	00021600 	sll	v0,v0,0x18
 2e4:	01821021 	addu	v0,t4,v0
 2e8:	244dfffc 	addiu	t5,v0,-4
 2ec:	0c000009 	jal	0x24
 2f0:	240c0000 	li	t4,0
 2f4:	00000000 	nop
 2f8:	3c081fd0 	lui	t0,0x1fd0
 2fc:	250803f8 	addiu	t0,t0,1016
 300:	8d020000 	lw	v0,0(t0)
 304:	240800ff 	li	t0,255
 308:	00481024 	and	v0,v0,t0
 30c:	0c000009 	jal	0x24
 310:	244c0000 	addiu	t4,v0,0
 314:	00000000 	nop
 318:	3c081fd0 	lui	t0,0x1fd0
 31c:	250803f8 	addiu	t0,t0,1016
 320:	8d020000 	lw	v0,0(t0)
 324:	240800ff 	li	t0,255
 328:	00481024 	and	v0,v0,t0
 32c:	00021200 	sll	v0,v0,0x8
 330:	0c000009 	jal	0x24
 334:	01826021 	addu	t4,t4,v0
 338:	00000000 	nop
 33c:	3c081fd0 	lui	t0,0x1fd0
 340:	250803f8 	addiu	t0,t0,1016
 344:	8d020000 	lw	v0,0(t0)
 348:	240800ff 	li	t0,255
 34c:	00481024 	and	v0,v0,t0
 350:	00021400 	sll	v0,v0,0x10
 354:	0c000009 	jal	0x24
 358:	01826021 	addu	t4,t4,v0
 35c:	00000000 	nop
 360:	3c081fd0 	lui	t0,0x1fd0
 364:	250803f8 	addiu	t0,t0,1016
 368:	8d020000 	lw	v0,0(t0)
 36c:	240800ff 	li	t0,255
 370:	00481024 	and	v0,v0,t0
 374:	00021600 	sll	v0,v0,0x18
 378:	01821021 	addu	v0,t4,v0
 37c:	0c000024 	jal	0x90
 380:	244efffc 	addiu	t6,v0,-4
 384:	0c000000 	jal	0x0
 388:	00000000 	nop
 38c:	00000000 	nop
 390:	3c081fd0 	lui	t0,0x1fd0
 394:	250803f8 	addiu	t0,t0,1016
 398:	24090000 	li	t1,0
 39c:	ad090000 	sw	t1,0(t0)
 3a0:	1000ff83 	b	0x1b0
 3a4:	00000000 	nop
 3a8:	0c000009 	jal	0x24
 3ac:	240c0000 	li	t4,0
 3b0:	00000000 	nop
 3b4:	3c081fd0 	lui	t0,0x1fd0
 3b8:	250803f8 	addiu	t0,t0,1016
 3bc:	8d020000 	lw	v0,0(t0)
 3c0:	240800ff 	li	t0,255
 3c4:	00481024 	and	v0,v0,t0
 3c8:	0c000009 	jal	0x24
 3cc:	244c0000 	addiu	t4,v0,0
 3d0:	00000000 	nop
 3d4:	3c081fd0 	lui	t0,0x1fd0
 3d8:	250803f8 	addiu	t0,t0,1016
 3dc:	8d020000 	lw	v0,0(t0)
 3e0:	240800ff 	li	t0,255
 3e4:	00481024 	and	v0,v0,t0
 3e8:	00021200 	sll	v0,v0,0x8
 3ec:	0c000009 	jal	0x24
 3f0:	01826021 	addu	t4,t4,v0
 3f4:	00000000 	nop
 3f8:	3c081fd0 	lui	t0,0x1fd0
 3fc:	250803f8 	addiu	t0,t0,1016
 400:	8d020000 	lw	v0,0(t0)
 404:	240800ff 	li	t0,255
 408:	00481024 	and	v0,v0,t0
 40c:	00021400 	sll	v0,v0,0x10
 410:	0c000009 	jal	0x24
 414:	01826021 	addu	t4,t4,v0
 418:	00000000 	nop
 41c:	3c081fd0 	lui	t0,0x1fd0
 420:	250803f8 	addiu	t0,t0,1016
 424:	8d020000 	lw	v0,0(t0)
 428:	240800ff 	li	t0,255
 42c:	00481024 	and	v0,v0,t0
 430:	00021600 	sll	v0,v0,0x18
 434:	01821021 	addu	v0,t4,v0
 438:	244e0000 	addiu	t6,v0,0
 43c:	0c000009 	jal	0x24
 440:	240c0000 	li	t4,0
 444:	00000000 	nop
 448:	3c081fd0 	lui	t0,0x1fd0
 44c:	250803f8 	addiu	t0,t0,1016
 450:	8d020000 	lw	v0,0(t0)
 454:	240800ff 	li	t0,255
 458:	00481024 	and	v0,v0,t0
 45c:	0c000009 	jal	0x24
 460:	244c0000 	addiu	t4,v0,0
 464:	00000000 	nop
 468:	3c081fd0 	lui	t0,0x1fd0
 46c:	250803f8 	addiu	t0,t0,1016
 470:	8d020000 	lw	v0,0(t0)
 474:	240800ff 	li	t0,255
 478:	00481024 	and	v0,v0,t0
 47c:	00021200 	sll	v0,v0,0x8
 480:	0c000009 	jal	0x24
 484:	01826021 	addu	t4,t4,v0
 488:	00000000 	nop
 48c:	3c081fd0 	lui	t0,0x1fd0
 490:	250803f8 	addiu	t0,t0,1016
 494:	8d020000 	lw	v0,0(t0)
 498:	240800ff 	li	t0,255
 49c:	00481024 	and	v0,v0,t0
 4a0:	00021400 	sll	v0,v0,0x10
 4a4:	0c000009 	jal	0x24
 4a8:	01826021 	addu	t4,t4,v0
 4ac:	00000000 	nop
 4b0:	3c081fd0 	lui	t0,0x1fd0
 4b4:	250803f8 	addiu	t0,t0,1016
 4b8:	8d020000 	lw	v0,0(t0)
 4bc:	240800ff 	li	t0,255
 4c0:	00481024 	and	v0,v0,t0
 4c4:	00021600 	sll	v0,v0,0x18
 4c8:	01821021 	addu	v0,t4,v0
 4cc:	244d0000 	addiu	t5,v0,0
 4d0:	00000000 	nop
 4d4:	11ae000e 	beq	t5,t6,0x510
 4d8:	00000000 	nop
 4dc:	0c000009 	jal	0x24
 4e0:	00000000 	nop
 4e4:	00000000 	nop
 4e8:	3c081fd0 	lui	t0,0x1fd0
 4ec:	250803f8 	addiu	t0,t0,1016
 4f0:	8d020000 	lw	v0,0(t0)
 4f4:	240800ff 	li	t0,255
 4f8:	00481024 	and	v0,v0,t0
 4fc:	a1c20000 	sb	v0,0(t6)
 500:	25ce0001 	addiu	t6,t6,1
 504:	00000000 	nop
 508:	15aefff4 	bne	t5,t6,0x4dc
 50c:	00000000 	nop
 510:	0c000000 	jal	0x0
 514:	00000000 	nop
 518:	00000000 	nop
 51c:	3c081fd0 	lui	t0,0x1fd0
 520:	250803f8 	addiu	t0,t0,1016
 524:	24090000 	li	t1,0
 528:	ad090000 	sw	t1,0(t0)
 52c:	1000ff20 	b	0x1b0
 530:	00000000 	nop
 534:	0c000009 	jal	0x24
 538:	240c0000 	li	t4,0
 53c:	00000000 	nop
 540:	3c081fd0 	lui	t0,0x1fd0
 544:	250803f8 	addiu	t0,t0,1016
 548:	8d020000 	lw	v0,0(t0)
 54c:	240800ff 	li	t0,255
 550:	00481024 	and	v0,v0,t0
 554:	0c000009 	jal	0x24
 558:	244c0000 	addiu	t4,v0,0
 55c:	00000000 	nop
 560:	3c081fd0 	lui	t0,0x1fd0
 564:	250803f8 	addiu	t0,t0,1016
 568:	8d020000 	lw	v0,0(t0)
 56c:	240800ff 	li	t0,255
 570:	00481024 	and	v0,v0,t0
 574:	00021200 	sll	v0,v0,0x8
 578:	0c000009 	jal	0x24
 57c:	01826021 	addu	t4,t4,v0
 580:	00000000 	nop
 584:	3c081fd0 	lui	t0,0x1fd0
 588:	250803f8 	addiu	t0,t0,1016
 58c:	8d020000 	lw	v0,0(t0)
 590:	240800ff 	li	t0,255
 594:	00481024 	and	v0,v0,t0
 598:	00021400 	sll	v0,v0,0x10
 59c:	0c000009 	jal	0x24
 5a0:	01826021 	addu	t4,t4,v0
 5a4:	00000000 	nop
 5a8:	3c081fd0 	lui	t0,0x1fd0
 5ac:	250803f8 	addiu	t0,t0,1016
 5b0:	8d020000 	lw	v0,0(t0)
 5b4:	240800ff 	li	t0,255
 5b8:	00481024 	and	v0,v0,t0
 5bc:	00021600 	sll	v0,v0,0x18
 5c0:	01821021 	addu	v0,t4,v0
 5c4:	245f0000 	addiu	ra,v0,0
 5c8:	3c018000 	lui	at,0x8000
 5cc:	24210000 	addiu	at,at,0
 5d0:	8c220008 	lw	v0,8(at)
 5d4:	8c23000c 	lw	v1,12(at)
 5d8:	8c240010 	lw	a0,16(at)
 5dc:	8c250014 	lw	a1,20(at)
 5e0:	8c260018 	lw	a2,24(at)
 5e4:	8c27001c 	lw	a3,28(at)
 5e8:	8c280020 	lw	t0,32(at)
 5ec:	8c290024 	lw	t1,36(at)
 5f0:	8c2a0028 	lw	t2,40(at)
 5f4:	8c2b002c 	lw	t3,44(at)
 5f8:	8c2c0030 	lw	t4,48(at)
 5fc:	8c2d0034 	lw	t5,52(at)
 600:	8c2e0038 	lw	t6,56(at)
 604:	8c2f003c 	lw	t7,60(at)
 608:	8c300040 	lw	s0,64(at)
 60c:	8c310044 	lw	s1,68(at)
 610:	8c320048 	lw	s2,72(at)
 614:	8c33004c 	lw	s3,76(at)
 618:	8c340050 	lw	s4,80(at)
 61c:	8c350054 	lw	s5,84(at)
 620:	8c360058 	lw	s6,88(at)
 624:	8c37005c 	lw	s7,92(at)
 628:	8c380060 	lw	t8,96(at)
 62c:	8c390064 	lw	t9,100(at)
 630:	8c3a0068 	lw	k0,104(at)
 634:	8c3b006c 	lw	k1,108(at)
 638:	8c3c0070 	lw	gp,112(at)
 63c:	8c3d0074 	lw	sp,116(at)
 640:	8c3e0078 	lw	s8,120(at)
 644:	03e0f809 	jalr	ra
 648:	00000000 	nop
 64c:	3c018000 	lui	at,0x8000
 650:	24210000 	addiu	at,at,0
 654:	ac220008 	sw	v0,8(at)
 658:	ac23000c 	sw	v1,12(at)
 65c:	ac240010 	sw	a0,16(at)
 660:	ac250014 	sw	a1,20(at)
 664:	ac260018 	sw	a2,24(at)
 668:	ac27001c 	sw	a3,28(at)
 66c:	ac280020 	sw	t0,32(at)
 670:	ac290024 	sw	t1,36(at)
 674:	ac2a0028 	sw	t2,40(at)
 678:	ac2b002c 	sw	t3,44(at)
 67c:	ac2c0030 	sw	t4,48(at)
 680:	ac2d0034 	sw	t5,52(at)
 684:	ac2e0038 	sw	t6,56(at)
 688:	ac2f003c 	sw	t7,60(at)
 68c:	ac300040 	sw	s0,64(at)
 690:	ac310044 	sw	s1,68(at)
 694:	ac320048 	sw	s2,72(at)
 698:	ac33004c 	sw	s3,76(at)
 69c:	ac340050 	sw	s4,80(at)
 6a0:	ac350054 	sw	s5,84(at)
 6a4:	ac360058 	sw	s6,88(at)
 6a8:	ac37005c 	sw	s7,92(at)
 6ac:	ac380060 	sw	t8,96(at)
 6b0:	ac390064 	sw	t9,100(at)
 6b4:	ac3a0068 	sw	k0,104(at)
 6b8:	ac3b006c 	sw	k1,108(at)
 6bc:	ac3c0070 	sw	gp,112(at)
 6c0:	ac3d0074 	sw	sp,116(at)
 6c4:	0c000000 	jal	0x0
 6c8:	ac3e0078 	sw	s8,120(at)
 6cc:	00000000 	nop
 6d0:	3c081fd0 	lui	t0,0x1fd0
 6d4:	250803f8 	addiu	t0,t0,1016
 6d8:	24090000 	li	t1,0
 6dc:	ad090000 	sw	t1,0(t0)
 6e0:	1000feb3 	b	0x1b0
 6e4:	00000000 	nop
