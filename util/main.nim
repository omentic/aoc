# Day ???: ???
import std/[os, strutils, sequtils, sugar]
# import std/[algorithm, math, hashes, tables, sets]
# import std/[strformat, strscans, enumerate]

# useful functions and things to remember:
# - readFile, splitLines, split(""), strip({''})
# - map(func), filter(func), all(func), any(func)
# - foldl(func, init), string.repeat(count), zip(a, b)
# for i, chr in "string": assert "string"[i] == chr
# assert @[0, 1, 2, 3] == collect(for i in 0..3: i)

let input = paramStr(1).readFile().strip().split("\n")

for line in input:
  discard
