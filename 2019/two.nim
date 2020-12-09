# Day Two: 1202 Program Alarm
import os, strutils, sequtils

let input: string = paramStr(1)
var program: seq[int] = map(split(strip(readFile(input)), ','), parseInt)
program[1] = 12
program[2] = 2

proc execute(program: seq[int]): int =
  var program: seq[int] = program
  var i: int = 0
  while i < len(program):
    case program[i]
    of 1:
      program[program[i+3]] = program[program[i+1]] + program[program[i+2]]
      i += 4
    of 2:
      program[program[i+3]] = program[program[i+1]] * program[program[i+2]]
      i += 4
    of 99:
      break
    else:
      echo("Unsupported code ", program[i], " at ", i)
      quit(QuitFailure)
  return program[0]

proc grammar(program: seq[int]): int =
  var program: seq[int] = program
  for noun in 0 ..< len(program):
    for verb in 0 ..< len(program):
      program[1] = noun
      program[2] = verb
      if execute(program) == 19690720:
        return 100 * noun + verb

echo execute(program)
echo grammar(program)
