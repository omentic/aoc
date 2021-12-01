# Day One: Sonar Sweep

file = open("input/01.txt").readlines()

ssr = []
for line in file:
    ssr.append(int(line))

total = 0
prev = 10000
for i, _ in enumerate(ssr):
    if prev < ssr[i]:
        total += 1
    prev = ssr[i]
print(total)

total = 0
for i, _ in enumerate(ssr):
    prev = ssr[i] + ssr[i+1] + ssr[i+2]
    sum = ssr[i+1] + ssr[i+2] + ssr[i+3]
    if sum > prev:
        total += 1
    if i+4 == len(ssr): # fuck
        break
print(total)
