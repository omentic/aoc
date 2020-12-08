# Day Eight: Handheld Halting
import os, strutils, sequtils

let input: string = paramStr(1)
var program: seq[tuple[op: string, arg: int]] =
  map(split(strip(readFile(input)), '\n'),
  func (instr: string): (string, int) = return (instr[0..2], parseInt(instr[4..^1])))

func execute(program: seq[tuple[op: string, arg: int]]): tuple[status: bool, acc: int] =
  var executed = newSeq[bool](len(program))
  var i, acc: int = 0
  while i < len(program):
    if executed[i]:
      return (false, acc)
    else:
      executed[i] = true
    case program[i].op
    of "acc":
      inc(acc, program[i].arg)
      inc(i)
    of "jmp":
      inc(i, program[i].arg)
    of "nop":
      inc(i)
    else:
      discard
  return (true, acc)

echo execute(program).acc

for i, instruction in program:
  var program = program
  program[i].op = if program[i].op == "nop": "jmp" else: "nop"
  if execute(program).status: echo execute(program).acc
