# Day Thirteen: Transparent Origami

file = open("input/13.txt").readlines()

def fold(paper: set, axis: str, crease: int) -> set:
    result = set()
    for dot in paper:
        if axis == "x" and dot[0] >= crease:
            result.add((crease - (dot[0] - crease), dot[1]))
        elif axis == "y" and dot[1] >= crease:
            result.add((dot[0], crease - (dot[1] - crease)))
        else:
            result.add(dot)
    return result

paper = set()
for i, line in enumerate(file):
    if i < 1125: # Hardcoded for simplicity
        x, y = map(int, line.strip().split(","))
        dot = (x, y)
        paper.add(dot)
    elif i > 1125:
        ins = line.split()[2].split("=")
        paper = fold(paper, ins[0], int(ins[1]))
        if i == 1126: print(len(paper))

for i in range(6):
    for j in range(39):
        if (j, i) in paper:
            print("#", end="")
        else:
            print(" ", end="")
    print()
