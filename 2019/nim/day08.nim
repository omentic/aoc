# Day Eight: Space Image Format
import os, strutils, sequtils

let
  input: string = paramStr(1)
  digits: string = strip(readFile(input))
  width: int = 25
  height: int = 6
  depth: int = len(digits) div (width * height)

var min, product: int = width * height
for layer in distribute(@digits, depth):
  if count(layer, '0') < min:
    min = count(layer, '0')
    product = count(layer, '1') * count(layer, '2')
echo product

for column in 0 ..< height:
  for row in 0 ..< width:
    for layer in 0 ..< depth:
      case digits[(layer * height * width) + (column * width) + row]
      of '0':
        write(stdout, ' ')
        break
      of '1':
        write(stdout, 'X')
        break
      else:
        discard
  write(stdout, '\n')
