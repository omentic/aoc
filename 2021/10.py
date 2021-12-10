# Day Ten: Syntax Scoring

file = open("input/10.txt").readlines()

score = 0
completions = []
for line in file:
    expected = ""
    for char in line:
        if char == "(":
            expected += ")"
        elif char == "[":
            expected += "]"
        elif char == "{":
            expected += "}"
        elif char == "<":
            expected += ">"
        elif char == expected[-1]:
            expected = expected[0:-1]
        else:
            if char == ")":
                score += 3
            elif char == "]":
                score += 57
            elif char == "}":
                score += 1197
            elif char == ">":
                score += 25137
            else:
                completions.append(expected[::-1])
            break
print(score)

scores = []
for seq in completions:
    score = 0
    for char in seq:
        score *= 5
        if char == ")":
            score += 1
        elif char == "]":
            score += 2
        elif char == "}":
            score += 3
        elif char == ">":
            score += 4
    scores.append(score)
print(sorted(scores)[len(scores)//2])
