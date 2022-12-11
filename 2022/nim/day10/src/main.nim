# Day 10: Off-by-One Errors
import std/[os, strutils, sequtils]

let input = paramStr(1).readFile().strip().split("\n")
let instructions = input.mapIt((it.split(" ")))

var sum = 0
var clock = 1
var register = 1

proc tick() =
  inc clock

proc write(value: string) =
  register += value.parseInt()

proc compare() =
  if clock mod 40 == 20:
    sum += register * clock

proc render() =
  if abs(register - ((clock-1) mod 40)) < 2:
    stdout.write("#")
  else:
    stdout.write(".")
  if clock mod 40 == 0:
    stdout.write("\n")

for ins in instructions:
  render()
  tick()
  compare()
  if ins.len == 2:
    render()
    tick()
    write(ins[1])
    compare()

echo sum
