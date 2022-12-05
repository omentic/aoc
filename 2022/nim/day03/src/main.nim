# Day Three: Rucksack Reorganization
import std/[os, strutils, sequtils, sugar]

let input = paramStr(1).readFile().strip().split("\n")

func deascii(x: char): int =
  if x.ord > 96:
    x.ord - 96
  else:
    x.ord - 38

echo input.mapIt((it[0..(it.len div 2 - 1)], it[(it.len div 2)..(it.len - 1)]))
  .mapIt(it[0].filter(x => x in it[1])[0])
  .mapIt(it.deascii()).foldl(a+b, 0)

echo input.distribute(100)
  .mapIt(it[0].filter(x => x in it[1] and x in it[2])[0])
  .mapIt(it.deascii()).foldl(a+b, 0)
