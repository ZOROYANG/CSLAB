.global __start
.global __ident

.text 

.include "util.s"

__start:
	.ifeq (SerialMode - UARTMode)
		InitUART
	.endif

	SendByte_Imm 0x004F
	SendByte_Imm 0x004B
	SendByte_Imm 0x000A
	SendByte_Imm 0x000D

# init users' registers
	lui $t0, RegDumpHAddr
	addiu $t0, $t0, RegDumpLAddr
	li $t1, 0
	li $t2, 32
	li $t3, 0
RegInitLoop:
	addu $t4, $t0, $t3
	sw  $zero, ($t0)
	addiu $t1, $t1, 1
	addiu $t3, $t3, 4
	bne $t1, $t2, RegInitLoop
	
BEGIN:
	# read an operation
	ReadByte
	
	addiu $t3, $v0, 0

	# check R operation
	li $t0, 0x52
	beq $t3, $t0, SHOWREGS
	nop
	
	# check D operation
	li $t0, 0x44
	beq $t3, $t0, SHOWMEM
	nop
	
	# check A operation
	li $t0, 0x41
	beq $t3, $t0, EDITMEM
	nop
	
	# check U operation
	li $t0, 0x55
	#beq $t3, $t0, SHOWREGS
	nop
	
	# check G operation
	li $t0, 0x47
	beq $t3, $t0, GOTOCOMPILE
	nop
	
	b BEGIN
	nop

# print all registers's value
SHOWREGS:
	lui $t5, RegDumpHAddr
	addiu $t5, $t5, RegDumpLAddr + 0x4
	addiu $t6, $t5, 0x74
	jal SENDMEM 
	nop
	SendByte_Imm Finish
	b BEGIN
	nop

SHOWMEM:
	ReadWord
	addiu $t5, $v0, -4
	ReadWord
	addiu $t6, $v0, -4
	jal SENDMEM
	nop
	SendByte_Imm Finish
	b BEGIN
	nop

EDITMEM:
	
	ReadWord
	addiu $t6, $v0, 0
	ReadWord
	addiu $t5, $v0, 0
	beq $t5, $t6, MEMLOAD_END
	nop
MEMLOAD_LOOP:
	ReadByte
	sb $v0, ($t6)
	addiu $t6, $t6, 1
	bne $t5, $t6, MEMLOAD_LOOP
	nop
MEMLOAD_END:
	# the procedure may take too long time, need sync
	SendByte_Imm Finish

	b BEGIN
	nop
	
GOTOCOMPILE:
	
	ReadWord
	addiu $ra, $v0, 0

	# recover register
	recover_reg

	jal $ra
	nop

	# dump register	
	restore_reg

	SendByte_Imm Finish

	b BEGIN
	nop
