# TODO: it is MMIO address of MARS simulator,
# so there need be changed when the code runs on THICO board.

.equ SerialMode, 1
.equ MMIOMode, 0
.equ UARTMode, 1

.equ MMIOWHAddr, 0x1fd0
.equ MMIOWLSAddr, 0x03fc
.equ MMIOWLCAddr, 0x03f8
.equ MMIORHAddr, 0x1fd0
.equ MMIORLSAddr, 0x03fc
.equ MMIORLCAddr, 0x03f8
# register dump address, takes 32 * 4 = 128 Bytes
# Reg2($v0) will store in 0xBF00008, Reg3($v1) will store in 0xBF00000C
# $zero, $at, $ra will not be stored
.equ RegDumpHAddr, 0x8000
.equ RegDumpLAddr, 0x0000

# UART address offset
.equ UARTHAddr, 0xbfd0
.equ UARTLAddr, 0x03f8

# magic char of Term protocol 
.equ Finish, 0x0000

# macro function define

# macro reg restore operation loop
# used $at register
.macro restore_reg
	.set noat
	lui $at, RegDumpHAddr
	addiu $at, $at, RegDumpLAddr
	sw $v0, 0x08($at)
	sw $v1, 0x0C($at)
	sw $a0, 0x10($at)
	sw $a1, 0x14($at)
	sw $a2, 0x18($at)
	sw $a3, 0x1C($at)
	sw $t0, 0x20($at)
	sw $t1, 0x24($at)
	sw $t2, 0x28($at)
	sw $t3, 0x2C($at)
	sw $t4, 0x30($at)
	sw $t5, 0x34($at)
	sw $t6, 0x38($at)
	sw $t7, 0x3C($at)
	sw $s0, 0x40($at)
	sw $s1, 0x44($at)
	sw $s2, 0x48($at)
	sw $s3, 0x4C($at)
	sw $s4, 0x50($at)
	sw $s5, 0x54($at)
	sw $s6, 0x58($at)
	sw $s7, 0x5C($at)
	sw $t8, 0x60($at)
	sw $t9, 0x64($at)
	sw $k0, 0x68($at)
	sw $k1, 0x6C($at)
	sw $gp, 0x70($at)
	sw $sp, 0x74($at)
	sw $fp, 0x78($at)
	.set at
.endm

# macro reg recover operation loop
# used $at register
.macro recover_reg
	.set noat
	lui $at, RegDumpHAddr
	addiu $at, $at, RegDumpLAddr
	lw $v0, 0x08($at)
	lw $v1, 0x0C($at)
	lw $a0, 0x10($at)
	lw $a1, 0x14($at)
	lw $a2, 0x18($at)
	lw $a3, 0x1C($at)
	lw $t0, 0x20($at)
	lw $t1, 0x24($at)
	lw $t2, 0x28($at)
	lw $t3, 0x2C($at)
	lw $t4, 0x30($at)
	lw $t5, 0x34($at)
	lw $t6, 0x38($at)
	lw $t7, 0x3C($at)
	lw $s0, 0x40($at)
	lw $s1, 0x44($at)
	lw $s2, 0x48($at)
	lw $s3, 0x4C($at)
	lw $s4, 0x50($at)
	lw $s5, 0x54($at)
	lw $s6, 0x58($at)
	lw $s7, 0x5C($at)
	lw $t8, 0x60($at)
	lw $t9, 0x64($at)
	lw $k0, 0x68($at)
	lw $k1, 0x6C($at)
	lw $gp, 0x70($at)
	lw $sp, 0x74($at)
	lw $fp, 0x78($at)
	.set at
.endm

.macro WriteMMIO_I byte_data
	jal TESTW
	nop
	lui $t0, MMIOWHAddr
	addiu $t0, $t0, MMIOWLCAddr
	li $t1, \byte_data
	sw $t1, ($t0)
.endm
.macro WriteMMIO_R register_name
	jal TESTW
	nop
	lui $t0, MMIOWHAddr
	addiu $t0, $t0, MMIOWLCAddr
	andi \register_name, \register_name, 0xff
	sw \register_name, ($t0)
.endm
.macro ReadMMIO 
	jal TESTR
	nop
	lui $t0, MMIORHAddr
	addiu $t0, $t0, MMIORLCAddr
	lw $v0, ($t0)
	li $t0, 0xff
	and $v0, $v0, $t0
.endm	

.macro InitUART
# init uart
# magic, don't modify it
	lui $t0, UARTHAddr
	addiu $t0, $t0, UARTLAddr
	li $t1, 0x00
	sb $t1, 0x2($t0)
	li $t1, 0x80
	sb $t1, 0x3($t0)
	li $t1, 0x0C
	sb $t1, 0($t0)
	li $t1, 0x00
	sb $t1, 0x1($t0)
	li $t1, 0x03
	sb $t1, 0x3($t0)
	li $t1, 0x00
	sb $t1, 0x4($t0)
	li $t1, 0x01
	sb $t1, 0x1($t0)
.endm

.macro WriteUART_I byte_data
	jal TESTW_UART
	nop
	li $t1, \byte_data
	sb $t1, ($t0)
.endm

.macro WriteUART_R register_name
	jal TESTW_UART
	nop
	andi \register_name, \register_name, 0xff
	sb \register_name, ($t0)
.endm

.macro ReadUART
	jal TESTR_UART
	nop
	lb $v0, ($t0)
	li $t0, 0xff
	and $v0, $v0, $t0
.endm

# Send byte data in register
.macro SendByte_Reg register_name
	.ifeq (SerialMode - UARTMode)
		WriteUART_R \register_name
	.endif
	.ifeq (SerialMode - MMIOMode)
		WriteMMIO_R \register_name
	.endif
.endm

# Send Immediate byte data
.macro SendByte_Imm byte_data
	.ifeq (SerialMode - UARTMode)
		WriteUART_I \byte_data
	.endif
	.ifeq (SerialMode - MMIOMode)
		WriteMMIO_I \byte_data
	.endif
.endm

# Send register data through $at, send by little endian order
.macro SendRegister register_name
	.set noat
	SRL $at, \register_name, 0
	SendByte_Reg $at
	SRL $at, \register_name, 8
	SendByte_Reg $at
	SRL $at, \register_name, 16
	SendByte_Reg $at
	SRL $at, \register_name, 24
	SendByte_Reg $at
	.set at
.endm

# Read byte, return to $v0
.macro ReadByte
	.ifeq (SerialMode - UARTMode)
		ReadUART
	.endif
	.ifeq (SerialMode - MMIOMode)
		ReadMMIO
	.endif
.endm

# Read a word, return to $v0
.macro ReadWord
	li $t4, 0
	ReadByte
	addiu $t4, $v0, 0
	ReadByte
	sll $v0, $v0, 8
	addu $t4, $t4, $v0
	ReadByte
	sll $v0, $v0, 16
	addu $t4, $t4, $v0
	ReadByte
	sll $v0, $v0, 24
	addu $v0, $t4, $v0
.endm

# Code function

TESTW:
	lui $t0, MMIOWHAddr
	addiu $t0, $t0, MMIOWLSAddr
	lw  $t1, ($t0)
	andi $t1, $t1, 1
	beqz $t1, TESTW
	nop
	jr $ra
	nop
	
TESTR:	
	lui $t0, MMIORHAddr
	addiu $t0, $t0, MMIORLSAddr
	lw  $t1, ($t0)
	andi $t1, $t1, 2
	beqz $t1, TESTR
	nop
	jr $ra
	nop
	
TESTW_UART:
	lui $t0, UARTHAddr
	addiu $t0, $t0, UARTLAddr
	lb $t1, 0x5($t0)
	andi $t1, $t1, 0x20
	beqz $t1, TESTW_UART
	nop
	jr $ra
	nop

TESTR_UART:
	lui $t0, UARTHAddr
	addiu $t0, $t0, UARTLAddr
	lb $t1, 0x5($t0)
	andi $t1, $t1, 0x01
	beqz $t1, TESTR_UART
	nop
	jr $ra
	nop

# send $t5 + 4 to $t6, return to $ra
SENDMEM:
	addiu $t4, $ra, 0
SENDMEM_Loop:
	addiu $t5, $t5, 0x4
	lw $t7, ($t5)
	SendRegister $t7
	bne $t5, $t6, SENDMEM_Loop
	nop
	addiu $ra, $t4, 0
	jr $ra
	nop

