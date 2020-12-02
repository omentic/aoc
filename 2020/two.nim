import os, strutils

let input = paramStr(1)
var valid: int = 0
var official: int = 0

for line in lines(input):
  var frequency: int = 0
  let
    entry: seq[string] = split(line, {'-', ' ', ':'})
    low: int = parseInt(entry[0])
    high: int = parseInt(entry[1])
    letter: char = entry[2][0]
    password: string = entry[4]
  for char in password:
    if char == letter:
      inc(frequency)
  if low <= frequency and frequency <= high:
    inc(valid)
  if password[low-1] == letter xor password[high-1] == letter:
    inc(official)

echo valid
echo official
