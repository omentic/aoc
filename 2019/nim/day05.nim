# Day Five: Sunny with a Chance of Asteroids
import os, strutils, sequtils

let input: string = paramStr(1)
var program: seq[int] = map(split(strip(readFile(input)), ','), parseInt)

var i: int = 0
while i < len(program):
  let opcode: int = program[i] mod 100

  var
    mode:  int = program[i] div 100
    one:   int = i+1
    two:   int = i+2
    three: int = i+3
  if len(program)-i > 1 and mode mod 10 == 0:
    one = program[one]
  if len(program)-i > 2 and mode div 10 mod 10 == 0:
    two = program[two]
  if len(program)-i > 3 and mode div 100 == 0:
    three = program[three]

  case opcode
  of 1:   # adds
    program[three] = program[one] + program[two]
    i += 4
  of 2:   # multiplies
    program[three] = program[one] * program[two]
    i += 4
  of 3:   # input
    write(stdout, "Input: ")
    program[one] = parseInt(readLine(stdin))
    i += 2
  of 4:   # output
    echo program[one]
    i += 2
  of 5:   # jump-if-true
    if program[one] != 0:
      i = program[two]
    else:
      i += 3
  of 6:   # jump-if-false
    if program[one] == 0:
      i = program[two]
    else:
      i += 3
  of 7:   # less than
    if program[one] < program[two]:
      program[three] = 1
    else:
      program[three] = 0
    i += 4
  of 8:   # equals
    if program[one] == program[two]:
      program[three] = 1
    else:
      program[three] = 0
    i += 4
  of 99:  # terminate
    break
  else:
    echo("Unsupported code ", program[i], " at ", i)
    quit(QuitFailure)
