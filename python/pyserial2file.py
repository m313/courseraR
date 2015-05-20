# pyserial2file.py
#
# Recording tmperature and humidity data from Arduino via serial.
# Saving data to file.
#
# On Ardunino, upload ThermoSerial.ino.
#
# From Terminal, call python pyserial2file.py to start recording.
#
# 2015-01-02
#

import time
import serial

# Settings
#fname = 'testfile2.txt'
fname = ('temperature log ' + time.strftime('%Y-%m-%dT%H_%M_%S') + '.txt') 
interval = 60		# time between measurements [s]

# open serial port
ser = serial.Serial('/dev/cu.usbmodemfd121', 9600)

# Open file (append or create)
f = open(fname,'a')
# Write first line
# f.write('year\tmonth\tday\thour\tminute\tsecond\ttemp\thumidity\n')

time.sleep(0.01)		# wait for serial port to initialize

print('### Recording temperature and humidity to ' + fname)
print('### Sampling every ' + str(interval) + ' seconds, starting at ' + time.strftime('%H:%M:%S'))
print('### Press Ctrl + c to interrupt')

# loop a couple of times
# for x in xrange(1,6):
while True:
	time.sleep(interval)
	
	# write loop number to serial
	# ser.write(str(x))

	# send something to Arduino as a trigger to request temperature data
	ser.write('A')

	# listen for available serial from Arduino
	if (ser.inWaiting() > 0):
		timeString = time.strftime('%Y\t%m\t%d\t%H\t%M\t%S')	# get current time
		serialInput = ser.readline() 							# get serial input
		f.write(timeString + '\t' + serialInput)				# write to file
		# print(time.strftime('%H:%M:%S') + '  ' + serialInput)

