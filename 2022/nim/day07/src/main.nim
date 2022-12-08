# Day 7: No Space Left On Device
import std/[os, strutils]

let input = paramStr(1).readFile().strip().split("\n")

type File = object
  id: string
  size: int

type Dir = ref object
  id: string
  files: seq[File]
  dirs: seq[Dir]
  parent: Dir
  size: int

var root = Dir(id: "/")
var current = root
for line in input[1..^1]:
  let output = line.split(" ")
  if output.len == 2:
    if output[0] == "$":
      discard
    elif output[0] == "dir":
      current.dirs.add(Dir(id: output[1], parent: current))
    else:
      current.files.add(File(id: output[1], size: output[0].parseInt()))
  else:
    assert output[1] == "cd"
    if output[2] == "..":
      current = current.parent
    else:
      for i in current.dirs:
        if i.id == output[2]:
          current = i
          break

proc update_size(a: Dir) =
  for i in a.files:
    a.size += i.size
  for i in a.dirs:
    i.update_size()
    a.size += i.size
root.update_size()

const maximum_size = 100000

var sum = 0
proc calc_size(a: Dir) =
  if a.size <= maximum_size:
    sum += a.size
  for i in a.dirs:
    i.calc_size()
root.calc_size()
echo sum

const total_space = 70000000
const update_space = 30000000
let needed_space = update_space - (total_space - root.size)

var min = update_space
proc calc_min(a: Dir) =
  if a.size >= needed_space:
    min = min(a.size, min)
  for i in a.dirs:
    i.calc_min()
root.calc_min()
echo min
