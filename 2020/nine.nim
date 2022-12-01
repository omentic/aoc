# Day Nine: Encoding Error
import os, strutils, sequtils

let input: string = paramStr(1)
let xmas: seq[int] = input.readFile().strip().split('\n').map(parseInt)
const preamble: int = 25
var encryption, weakness, smallest: int

for i in preamble ..< xmas.len:
  var valid: bool
  for j in 0 .. preamble:
    for k in 0 .. preamble:
      if xmas[i - k] + xmas[i - j] == xmas[i]:
        valid = true
  if not valid:
    encryption = xmas[i]
for largest in 0 ..< xmas.len:
  var sum: int = 0
  for val in smallest .. largest:
    inc(sum, xmas[val])
  while sum > encryption:
    dec(sum, xmas[smallest])
    inc(smallest)
  if sum == encryption:
    weakness = xmas[smallest] + xmas[largest]
    break

echo encryption
echo weakness
