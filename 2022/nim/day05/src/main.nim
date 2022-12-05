# Day 5: Supply Stacks
import std/[os, strutils, sequtils]

let input = paramStr(1).readFile().strip().split("\n\n")

func remove(a: string, chars: varargs[string]): string =
  result = a
  for c in chars:
    result = result.replace(c, "")

func transform(crates: string): seq[string] =
  var c = 0
  result = newSeq[string](9)
  for i, stack in crates.strip().replace("    ", " [ ]").replace("] [", "")
    .split("\n")[0..^2].mapIt(it.strip(chars = {'[', ']'})):
    for j, c in stack:
      result[j] = c & result[j]
  result.applyIt(it.strip())

let stacks = input[0].transform().mapIt(it.toSeq)
let rules = input[1].split("\n")
  .mapIt(it.remove("move ", "from ", "to ").split(" ").map(parseInt))

var stack = stacks
for rule in rules:
  for count in 0 ..< rule[0]:
    stack[rule[2]-1] &= stack[rule[1]-1].pop
echo stack.foldl(a & b[b.len-1], "")

stack = stacks
for rule in rules:
  var toAdd: seq[char]
  for count in 0 ..< rule[0]:
    toAdd = stack[rule[1]-1].pop & toAdd
  stack[rule[2]-1] &= toAdd
echo stack.foldl(a & b[b.len-1], "")
