# Day ???: ???
import std/[os, strutils, sequtils, sugar, enumerate]
# import std/[algorithm, math, hashes, tables, sets]
# import std/[strformat, strscans]

# useful functions and things to remember:
# - readFile, splitLines, split(""), strip({''})
# - map(func), filter(func), all(func), any(func)
# - foldl(func, init), string.repeat(count), zip(a, b)
# for i, chr in "string": assert "string"[i] == chr

let input: string = paramStr(1).readFile()
