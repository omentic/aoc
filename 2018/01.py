# Day One: Chronal Calibration

file = open("input/01.txt").readlines()

total = 0
for line in file:
	if line != '\n':
		total += int(line)
print(total)

total = {0}
current = 0
while True:
	for line in file:
		if line != '\n':
			current += int(line)
			if current not in total:
				total.add(current)
			else:
				print(current)
				quit()
