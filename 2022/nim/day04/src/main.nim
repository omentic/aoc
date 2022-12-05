# Day 4: Camp Cleanup
import std/[os, strutils, sequtils, sugar]

let input = paramStr(1).readFile().strip().split("\n")

let assign = input.mapIt(it.split(","))
  .mapIt(it.mapIt(it.split("-").map(parseInt)))

func contains(a, b: seq[int]): bool =
  return a[0] in b[0] .. b[1] and
         a[1] in b[0] .. b[1] or
         b[0] in a[0] .. a[1] and
         b[1] in a[0] .. a[1]

echo assign.filterIt(contains(it[0], it[1])).len

func overlaps(a, b: seq[int]): bool =
  return a[0] in b[0] .. b[1] or
         a[1] in b[0] .. b[1] or
         b[0] in a[0] .. a[1] or
         b[1] in a[0] .. a[1]

echo assign.filterIt(overlaps(it[0], it[1])).len
