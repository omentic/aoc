# Day Six: Lanternfish

file = open("input/06.txt").readlines()

ages = []
for num in file[0].split(","):
    ages.append(int(num))

for day in range(80):
    for i, fish in enumerate(ages):
        if fish == 0:
            ages[i] = 6
            ages.append(9)
        else:
            ages[i] = fish-1
print(len(ages))

# ages: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
ages = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
for num in file[0].split(","):
    ages[int(num)] += 1

for day in range(256):
    for i, age in enumerate(ages):
        if i == 0:
            ages[7] += ages[0]
            ages[9] += ages[0]
            ages[0] -= ages[0]
        else:
            ages[i-1] += ages[i]
            ages[i] -= ages[i]
print(sum(ages))
