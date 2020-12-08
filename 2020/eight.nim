# Day Eight: Handheld Halting
import os, strutils, sequtils

let input: string = paramStr(1)
var program: seq[string] = split(strip(readFile(input)), '\n')

proc execute(program: seq[string], executed: seq[int]) =
  var executed = executed
  var i, time, acc: int = 0
  while i < len(program) and time < 250:
    if executed[i] < 0:
      echo acc
      break
    dec(executed[i])
    var op: string = program[i][0..2]
    var arg: int = parseInt(program[i][4..^1])
    case op
    of "acc":
      inc(acc, arg)
      inc(i)
    of "jmp":
      inc(i, arg)
    of "nop":
      inc(i)
    else:
      discard
    inc(time)
  if i >= len(program):
    echo acc

execute(program, repeat(0, len(program)))

for i, instruction in program:
  var program = program
  program[i] =
    if contains(instruction, "jmp"):
      replace(instruction, "jmp", "nop")
    else:
      replace(instruction, "nop", "jmp")
  execute(program, repeat(100, len(program)))
