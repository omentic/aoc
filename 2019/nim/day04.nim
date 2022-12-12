# Day Four: Secure Container
import os, strutils, sequtils

let input: string = paramStr(1)
let bounds: seq[int] = map(split(strip(readFile(input)), '-'), parseInt)
var valid, details: int = 0

proc criteria(password: int): bool =
  var password: string = $password
  for digit in 0 .. 4:
    if password[digit] > password[digit+1]:
      return false
  for digit in 0 .. 4:
    if password[digit] == password[digit+1]:
      return true
  return false

proc extracriteria(password: int): bool =
  var password: string = $password
  for digit in 0 .. 4:
    if password[digit] > password[digit+1]:
      return false
  for digit in 0 .. 4:
    if password[digit] == password[digit+1]:
      if digit == 0 or password[digit] != password[digit-1]:
        if digit == 4 or password[digit] != password[digit+2]:
          return true
  return false

for password in bounds[0] .. bounds[1]:
  if criteria(password): inc(valid)

for password in bounds[0] .. bounds[1]:
  if extracriteria(password): inc(details)

echo valid
echo details
