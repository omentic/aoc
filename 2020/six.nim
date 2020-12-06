# Day Six: Custom Customs
import os, strutils

let input: string = paramStr(1)
var sum, sumAll: int = 0

for group in split(readFile(input), "\n\n"):
  var count, countAll: int = 0
  for i, answer in replace(group, "\n"):
    if find(replace(group, "\n"), answer) == i:
      inc(count)
  for i, answer in split(group, "\n")[0]:
    if find(split(group, "\n")[0], answer) == i:
      block everyone:
        for person in split(group, "\n"):
          if not contains(person, answer):
            break everyone
        inc(countAll)
  sum += count
  sumAll += countAll
echo sum
echo sumAll
