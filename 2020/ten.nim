# Day Ten: Adapter Array
import os, strutils, sequtils, algorithm, math

let input: string = paramStr(1)
var adapters: seq[int] = map(split(strip(readFile(input)), '\n'), parseInt)
adapters.add(0)
adapters = sorted(adapters)
adapters.add(adapters[^1] + 3)

var jolt, one, three: int = 0
for adapter in adapters:
  case adapter - jolt
  of 1:
    inc(one)
  of 3:
    inc(three)
  else:
    discard
  jolt = adapter

echo one * three

var paths: int = 0
proc recursive(adapters: seq[int]) =
  for i in 0 .. (len(adapters) - 4):
    if adapters[i+2] - adapters[i] <= 3:
      recursive(adapters[i+2..^1])
    if adapters[i+3] - adapters[i] <= 3:
      recursive(adapters[i+3..^1])
  inc(paths)

recursive(adapters)
echo paths
