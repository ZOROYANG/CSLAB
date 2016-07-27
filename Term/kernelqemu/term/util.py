import time
import serial
# Some declaration
# some definition

finish_signal = 0

# 1 means using little endian order
little_endian = 1

reg_name = ['$zero','$at','$v0','$v1','$a0','$a1',
'$a2','$a3','$t0','$t1','$t2','$t3','$t4','$t5','$t6',
'$t7','$s0','$s1','$s2','$s3','$s4','$s5','$s6','$s7',
'$t8','$t9','$k0','$k1','$gp','$sp','$fp', '$ra']

access_l_b = 0x00000000
access_r_b = 0xffffffff - 32 * 8 + 1

default_mem_load_length = 32

def hex_str(argv):  
	result = ''  
	hLen = len(argv)  
	for i in xrange(hLen):
		hvol = argv[i]
		hhex = '%02x'%hvol
		result += hhex
	return result

def read_a_word(ser):
	raw_data = ser.read(4)
	data = []
	print raw_data
	for i in xrange(4):
		data.append(ord(raw_data[i]))
	if little_endian:
		data.reverse()
	return data

def bytes_to_word(raw_data):
	return (raw_data[0] << 24) + (raw_data[1] << 16) + (raw_data[2] << 8) + raw_data[0]

def word_to_bytes(word):
	return [word & 0xff, (word >> 8) & 0xff, (word >> 16) & 0xff, (word >> 24) & 0xff]

def deal_with_signal(control_signal):
	print 'Recieve a signal %d' % control_signal 

# TODO: check oparr


# waiting for operation that takes long time, such as edit_mem
def read_wait(ser):
	ser.timeout = None
	ch = ser.read(1)
	ser.timeout = 0
	return ch

def show_regs(oparr, ser):
	ser.write('R')
	raw_input()
	for i in range(2, 31):
		raw_data = read_a_word(ser)
		hex_s = hex_str(raw_data)
		print '%s: 0x%s' % (reg_name[i], hex_s)
	read_wait(ser)
	return True

def show_mem(oparr, ser):
	address = 0
	mem_load_length = default_mem_load_length
	file_name = None
	try:
		address = int(oparr[1], 16)
		if address < access_l_b or address > access_r_b:
			raise Exception()
		if len(oparr) >= 3:
			mem_load_length = int(oparr[2])
		if len(oparr) >= 4:
			file_name = oparr[3]
	except Exception as e:
		print 'Invalid Arugment'
		return True
	if file_name:
		try:
			fout = open(file_name, 'w')
		except Exception as e:
			print 'Can not read file'
			return True
	ser.write('D')
	ser.write(serial.to_bytes(word_to_bytes(address)))
	ser.write(serial.to_bytes(word_to_bytes(address + mem_load_length * 4)))
	time.sleep(0.1)
	for i in range(0, mem_load_length):
		raw_data = read_a_word(ser)
		hex_s = hex_str(raw_data)
		if file_name:
			# TODO: check the endian of host
			raw_data.reverse()
			for i in raw_data:
				fout.write(chr(i))
		else:
			print '%s: 0x%s' % (hex(address + i * 4), hex_s)
	if file_name:
		fout.close()
	read_wait(ser)
	return True

def edit_mem(oparr, ser):
	address = None
	bin_data = None
	try:
		address = int(oparr[1], 16)
		if address < access_l_b or address > access_r_b:
			raise Exception()
	except Exception as e:
		print 'Invalid Arugment'
		return True
	try:
		fin = open(oparr[2])
		bin_data = fin.read()
		fin.close()
	except Exception as e:
		print 'Can not read file'
		return True
	ser.write('A')
	ser.write(serial.to_bytes(word_to_bytes(address)))
	ser.write(serial.to_bytes(word_to_bytes(address+len(bin_data))))
	ser.write(bin_data)
	time.sleep(0.1)
	read_wait(ser)
	return True

def run_from(oparr, ser):
	address = None
	try:
		address = int(oparr[1], 16)
		if address < access_l_b or address > access_r_b:
			raise Exception()
	except Exception as e:
		print 'Invalid Arugment'
		return True
	ser.write('G')
	ser.write(serial.to_bytes(word_to_bytes(address)))
	while True:
		cs = ord(read_wait(ser))
		if cs == finish_signal:
			break
		deal_with_signal(cs)
	return True

def exit_term(oparr, ser):
	ser.close()
	return False