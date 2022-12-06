# Day 6: Tuning Trouble
import std/[os, strutils, sets]

let input = paramStr(1).readFile().strip().split("\n")[0]

iterator slide(input: string, num: int): string =
  for i in 0 ..< input.len - num:
    var result: string
    for j in 0 ..< num:
      result &= input[i+j]
    yield result

var i = 4
for window in input.slide(4):
  if window.toHashSet.len == 4:
    break
  inc i
echo i

i = 14
for window in input.slide(14):
  if window.toHashSet.len == 14:
    break
  inc i
echo i
