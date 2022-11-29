# Day Sixteen: Ticket Translation
import std/[os, strutils, sequtils, sugar]

let input: string = paramStr(1)

type Rule = tuple[field: string, values: seq[int]]

let data: seq[string] = readFile(input).split("\n\n")
let rules: seq[Rule] =
  data[0].split("\n")
    .map(foo => (foo.split(": ")[0], foo.split(": ")[1].split(" or ")
      .foldl(a & countup(b.split("-")[0].parseInt(),
        b.split("-")[1].parseInt()).toSeq(), @[-1])[1..^1]))
let ticket: seq[int] =
  data[1].split("\n")[1].split(",")
    .map(parseInt)
let nearby: seq[seq[int]] =
  data[2].strip().split(":\n")[1].split("\n")
    .map(foo => foo.strip().split(",").map(parseInt))

var min = rules[0][1].min
var max = rules[0][1].max
for rule in rules:
  min = min(rule[1].min, min)
  max = max(rule[1].max, max)

proc validate(tickets: seq[seq[int]], min: int, max: int): int =
  for ticket in tickets:
    for value in ticket:
      if value < min or value > max:
        result += value

echo nearby.validate(min, max)

proc purge(tickets: seq[seq[int]], min: int, max: int): seq[seq[int]] =
  for ticket in tickets:
    if ticket.allIt(it < max) and ticket.allIt(it > min):
      result.add(ticket)

proc flip(tickets: seq[seq[int]]): seq[seq[int]] =
  for i in 0 ..< tickets[0].len():
    var foo: seq[int]
    for ticket in tickets:
      foo.add(ticket[i])
    result.add(foo)

var possibilities: seq[seq[string]]
for i, field in nearby.purge(min, max).flip():
  var foo: seq[string]
  for rule in rules:
    if field.allIt(it in rule.values):
      foo.add(rule.field)
  possibilities.add(foo)

proc determine(order: seq[string]): seq[string] =
  if order.len() == ticket.len:
    return order
  for value in possibilities[order.len]:
    if value notin order:
      result = determine(order & value)
      if result.len != 1:
        return result
  return @["fail"]

var order: seq[string]

echo zip(determine(order), ticket)
  .filterIt(it[0].contains("departure"))
  .foldl(a * b[1], 1)
