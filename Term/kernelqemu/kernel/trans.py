import os
import sys
import struct

F_ZERO = "000000"
L_JALR = "001001"
L_JR = "001000"
F_J = "000010"
F_JAL = "000011"
F_BEQ = "000100"
F_BGEZBLTZ = "000001"
F_BGTZ = "000111"
F_BLEZ = "000110"
F_BNE = "000101"


def to_bitmap(h):
	bitstr = ""
	for i in range(0, 32):
		bitstr = chr(h%2 + ord('0')) + bitstr
		h /= 2
	return bitstr


def isJ(bitstr):
	if bitstr[0:6] in (F_J, F_JAL):
		return True
	else:
		return bitstr[0:6] == F_ZERO and bitstr[26:32] in (L_JALR, L_JR)


def isB(bitstr):
	return bitstr[0:6] in (F_BEQ, F_BGEZBLTZ, F_BGTZ, F_BLEZ, F_BNE)


if len(sys.argv) < 2:
	print "Usage python trans.py origin.bin modify.bin"
	exit()
fin = open(sys.argv[1], "rb")
fout = open(sys.argv[2], "wb")

while True:
	temp = fin.read(4)
	if len(temp) == 0:
		break
	elif len(temp) < 4:
		print "error"
		exit()
	h = struct.unpack("I", temp)[0]
	bitstr = to_bitmap(h)
	
	if isJ(bitstr) or isB(bitstr):
		nins = fin.read(4);
		if len(nins) == 0:
			fout.write(temp)
		elif len(temp) < 4:
			print "error"
			exit()
		else:
			if isB(bitstr):
				h -= 1
			fout.write(nins)
			fout.write(struct.pack('I', h))
	else:
		fout.write(temp)

print "over"
		
