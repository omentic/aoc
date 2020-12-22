# Day Fourteen: Docking Data
import os, strutils, sequtils

let input: string = paramStr(1)
let program: seq[tuple[address, value: string]] = map(split(strip(readFile(input)), '\n'),
  func (param: string): (string, string) =
    (split(param, " = ")[0], split(param, " = ")[1]))

var mask: string = repeat('X', 36)
var memory: seq[int] = newSeq[int](99999)
for line in program:
  if line.address == "mask":
    mask = line.value
  elif line.address[0..2] == "mem":
    var value: string = toBin(parseInt(line.value), 36)
    for i, bit in mask:
      if bit != 'X':
        value[i] = bit
    memory[parseInt(line.address[4..^2])] = fromBin[int](value)

echo foldl(memory, a + b)
