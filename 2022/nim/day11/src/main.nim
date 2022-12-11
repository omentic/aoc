# Day 11: Monkey in the Middle
import std/[os, strutils, sequtils, sugar, algorithm]
import npeg # https://github.com/zevv/npeg

let input = paramStr(1).readFile().strip().split("\n\n")

type Monkey = object
  stuff: seq[int]
  inspect: (int) -> int
  throw: (int) -> int
  count: int

var monkey: Monkey
var monkees: seq[Monkey]

let parser = peg(input):
  input <- +(group * "\n\n")
  group <- monkey * "\n" * starting * "\n" * operation * "\n" * test :
    monkees.add(monkey)
  monkey    <- "Monkey " * >Digit * ":":
    monkey = Monkey()
  starting  <- "  Starting items: " * >+Digit * *(", " * >+Digit):
    monkey.stuff = capture[1 ..< capture.len].mapIt(parseInt(it.s))
  operation <- "  Operation: new = old " * >("+" | "*") * " " * >("old" | +Digit):
    let op =
      if $1 == "+":
        (x, y: int) => x + y
      else:
        (x, y: int) => x * y
    if $2 == "old":
      monkey.inspect = (x: int) => x.op(x)
    else:
      monkey.inspect = (x: int) => x.op(parseInt($2))
  test      <- "  Test: divisible by " * >+Digit * "\n" * success * "\n" * failure:
    monkey.throw = (x: int) => (if x mod parseInt($1) == 0: parseInt($2) else: parseInt($3))
  success   <- "    If true: throw to monkey " * >Digit
  failure   <- "    If false: throw to monkey " * >Digit

assert parser.match(paramStr(1).readFile().strip()).ok == true

let lcm = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29][0 ..< monkees.len].foldl(a*b, 1)

var monkeys = monkees
for _ in 0 ..< 20:
  for i, monkey in monkeys:
    while monkeys[i].stuff.len > 0:
      var worry = monkeys[i].stuff.pop()
      monkeys[i].count += 1
      worry = monkeys[i].inspect(worry)
      worry = worry div 3
      monkeys[monkeys[i].throw(worry)].stuff.add(worry)

echo monkeys.mapIt(it.count).sorted(Descending)[0..1].foldl(a*b, 1)

monkeys = monkees
for _ in 0 ..< 10000:
  for i in 0 ..< monkeys.len:
    while monkeys[i].stuff.len > 0:
      var worry = monkeys[i].stuff.pop()
      monkeys[i].count += 1
      worry = monkeys[i].inspect(worry)
      worry = worry mod lcm
      monkeys[monkeys[i].throw(worry)].stuff.add(worry)

echo monkeys.mapIt(it.count).sorted(Descending)[0..1].foldl(a*b, 1)
