import serial
import os
import sys
from util import *
command = {'R':show_regs,'D':show_mem,'A':edit_mem,'G':run_from,'Q':exit_term}
ser = serial.Serial(sys.argv[1], 9600, timeout = None)
print 'Waitting for connection...'
print ser.read(4)
ser.timeout = 0
flag = True
while flag:
	op = raw_input('>>>');
	oparr = op.split(' ')
	if len(oparr) == 0:
		continue
	if oparr[0] in command:
		flag = command[oparr[0]](oparr, ser)
	else:
		print 'Invalid Command'
