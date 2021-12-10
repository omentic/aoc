# Day Two: Dive!

file = open("input/02.txt").readlines()

hori = 0
depth = 0
for line in file:
    com = line.split()
    if com[0] == "forward":
        hori += int(com[1])
    if com[0] == "up":
        depth -= int(com[1])
    if com[0] == "down":
        depth += int(com[1])
print(hori * depth)

hori = 0
depth = 0
aim = 0
for line in file:
    com = line.split()
    if com[0] == "forward":
        hori += int(com[1])
        depth += aim * int(com[1])
    if com[0] == "up":
        aim -= int(com[1])
    if com[0] == "down":
        aim += int(com[1])
print(hori * depth)
