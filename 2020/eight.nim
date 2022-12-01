# Day Eight: Handheld Halting
import os, strutils, sequtils, sugar

let input: string = paramStr(1)
var program: seq[tuple[op: string, arg: int]] =
  input.readFile().strip().split('\n')
    .map(instruction => (instruction[0..2], parseInt(instruction[4..^1])))

func execute(program: seq[tuple[op: string, arg: int]]): (bool, int) =
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

let result: tuple[status: bool, acc: int] = execute(program)
echo result.acc

for i, instruction in program:
  var program = program
  program[i].op = if program[i].op == "nop": "jmp" else: "nop"
  let result: tuple[status: bool, acc: int] = execute(program)
  if result.status: echo result.acc
