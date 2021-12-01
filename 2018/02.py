# Day Two: Inventory Management System

file = open("input/02.txt").readlines()

twice: int = 0
thrice: int = 0
for line in file:
	for char in "abcdefghijklmnopqrstuvwxyz":
		if line.count(char) == 2:
			twice += 1
			break
	for char in "abcdefghijklmnopqrstuvwxyz":
		if line.count(char) == 3:
			thrice += 1
			break
print(twice * thrice)

for one in file:
	for two in file:
		differing = 0
		for i in range(len(one)):
			if one[i] != two[i]:
				differing += 1
		if differing == 1:
			for i in range(len(one)):
				if one[i] == two[i]:
					print(one[i], end="")
			quit()
