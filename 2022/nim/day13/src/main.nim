# Day 13: Distress Signal
import std/[os, strutils, sequtils, sugar, algorithm]

let input = paramStr(1).readFile().strip().split("\n\n").mapIt(it.split("\n"))

type Kleenean {.pure.} = enum
  False = -1,
  Maybe = 0,
  True = 1

func partition(chunk: string): seq[string] =
  var depth = 0
  if chunk == "[]":
    return @[]
  if chunk.len == 0 or chunk[0] != '[':
    return @[chunk]
  result.add("")
  for c in chunk[1 ..< chunk.len-1]:
    if c == '[':
      depth += 1
    if c == ']':
      depth -= 1
    if c == ',' and depth == 0:
      result.add("")
    else:
      result[result.len - 1] &= c

func compare(a, b: string): Kleenean =
  let (a, b) = (a.partition(), b.partition())
  for (left, right) in zip(a, b):
    if left.contains("[") or right.contains("["):
      let value = compare(left, right)
      if value == Maybe:
        continue
      else:
        return value
    if parseInt(left) < parseInt(right):
      return True
    elif parseInt(left) > parseInt(right):
      return False
  if a.len < b.len:
    return True
  elif a.len > b.len:
    return False
  else:
    return Maybe

var sum = 0
for i, group in input:
  let value = compare(group[0], group[1])
  if value == True:
    sum += i+1
echo sum

var key = 1
for i, line in input.concat()
  .concat(@["[[2]]", "[[6]]"])
    .sorted((x, y) => (compare(x, y).ord), Descending):
  if line == "[[2]]" or line == "[[6]]":
    key *= i+1
echo key
