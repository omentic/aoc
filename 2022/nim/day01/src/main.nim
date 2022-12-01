# Day One: Calorie Counting
import std/[os, strutils, sequtils, algorithm]

let input: seq[seq[int]] = paramStr(1).readFile().strip().split("\n\n")
  .mapIt(it.strip().split("\n").map(parseInt))

let elves = input.mapIt(it.foldl(a+b, 0))
echo elves.foldl(max(a,b), 0)

let sorted = elves.sorted(cmp[int], Descending)
echo sorted[0] + sorted[1] + sorted[2]
