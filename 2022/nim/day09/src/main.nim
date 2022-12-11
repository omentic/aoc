# Day 9: Rope Bridge
import std/[os, strutils, sequtils, sets]

let input = paramStr(1).readFile().strip().split("\n")
let directions = input.mapIt(it.split(" ")).mapIt((it[0][0], it[1].parseInt()))

type Pos = ref object # must be ref for mutation
  x: int
  y: int

type Knot = ref object
  pos: Pos
  prev: Knot

func init(_: typedesc[Knot], prev: Knot): Knot =
  return Knot(pos: Pos(x: 0, y: 0), prev: prev)

proc update(loc, knot: Knot) =
  let dx = loc.pos.x - knot.pos.x
  let dy = loc.pos.y - knot.pos.y

  if abs(dx) == 2:
    knot.pos.x += dx div 2
    if dy != 0:
      knot.pos.y += dy div abs(dy)
  elif abs(dy) == 2:
    knot.pos.y += dy div 2
    if dx != 0:
      knot.pos.x += dx div abs(dx)

proc update(knots: varargs[Knot]) =
  for i, knot in knots:
    update(knot.prev, knot)

var visited = initHashSet[(int, int)]()
var visitedAgain = initHashSet[(int, int)]()

var
  head = Knot.init(nil)
  tail = Knot.init(head)

var
  one = Knot.init(head)
  two = Knot.init(one)
  three = Knot.init(two)
  four = Knot.init(three)
  five = Knot.init(four)
  six = Knot.init(five)
  seven = Knot.init(six)
  eight = Knot.init(seven)
  nine = Knot.init(eight)

for dir in directions:
  for i in 0 ..< dir[1]:
    if dir[0]   == 'R': head.pos.x += 1
    elif dir[0] == 'L': head.pos.x -= 1
    elif dir[0] == 'U': head.pos.y += 1
    elif dir[0] == 'D': head.pos.y -= 1

    update(head, tail)
    visited.incl((tail.pos.x, tail.pos.y))
    update(one, two, three, four, five, six, seven, eight, nine)
    visitedAgain.incl((nine.pos.x, nine.pos.y))

echo visited.len
echo visitedAgain.len
