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
