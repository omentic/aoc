import os, strutils

let input: string = paramStr(1)
var unofficial, official: int = 0

for line in lines(input):
  var frequency: int = 0
  let
    entry: seq[string] = split(line, {'-', ' ', ':'})
    min: int = parseInt(entry[0])
    max: int = parseInt(entry[1])
    letter: char = entry[2][0]
    pass: string = entry[4]
  for char in pass:
    if char == letter:
      inc(frequency)
  if min <= frequency and frequency <= max:
    inc(unofficial)
  if pass[min-1] == letter xor pass[max-1] == letter:
    inc(official)

echo unofficial
echo official
