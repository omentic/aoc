# Day Fourteen: Docking Data
import std/[os, strutils, sequtils, sugar, tables]

let input: string = paramStr(1)
let program: seq[tuple[address, value: string]] =
  input.readFile().strip().split('\n')
  .map(param => (param.split(" = ")[0], param.split(" = ")[1]))

var mask: string = 'X'.repeat(36)
var memory: seq[int] = newSeq[int](99999)
for line in program:
  if line.address == "mask":
    mask = line.value
  elif line.address[0..2] == "mem":
    var value: string = line.value.parseInt.toBin(36)
    for i, bit in mask:
      if bit != 'X':
        value[i] = bit
    memory[line.address[4..^2].parseInt()] = fromBin[int](value)

echo memory.foldl(a + b)

func genadds(addresses: seq[string]): seq[string] =
  for address in addresses:
    for i, c in address:
      if c == 'X':
        result.add(address[0..(i-1)] & '0' & address[(i+1)..^1])
        result.add(address[0..(i-1)] & '1' & address[(i+1)..^1])
        break
    if result.len == 0:
      return addresses
  return genadds(result)

mask = 'X'.repeat(36)
var memorii = initTable[int, int]()
for line in program:
  if line.address == "mask":
    mask = line.value
  elif line.address[0..2] == "mem":
    var address = line.address[4..^2].parseInt().toBin(36)
    var value = line.value.parseInt.toBin(36)
    for i, bit in mask:
      if bit == '1':
        address[i] = '1'
      elif bit == 'X':
        address[i] = 'X'
    for address in genadds(@[address]):
      memorii[fromBin[int](address)] = fromBin[int](value)

echo memorii.values.toSeq.foldl(a + b)
