# Day Six: Custom Customs
import os, strutils

let input: string = paramStr(1)
var sum, sumAll: int = 0

for group in input.readFile().split("\n\n"):
  var count, countAll: int = 0
  for i, answer in group.replace("\n"):
    if group.replace("\n").find(answer) == i:
      inc(count)
  for i, answer in group.split("\n")[0]:
    if group.split("\n")[0].find(answer) == i:
      block everyone:
        for person in group.split("\n"):
          if not person.contains(answer):
            break everyone
        inc(countAll)
  sum += count
  sumAll += countAll
echo sum
echo sumAll
