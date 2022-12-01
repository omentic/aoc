# Day Five: Binary Boarding
import os, math

let input: string = paramStr(1)

var
  min: int = 2^8
  max: int = 0
  flight: seq[int]
for seat in lines(input):
  var row, column, id: int = 0
  for i, char in seat[0..^4]:
    if char == 'B':
      row += 2^(7-i) div 2
  for i, char in seat[7..^1]:
    if char == 'R':
      column += 2^(3-i) div 2
  id = row * 8 + column
  max = max(max, id)
  min = min(min, id)
  flight.add(id)

echo max

for id in min .. max:
  if id notin flight:
    echo id
