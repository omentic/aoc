# Day Seven: Handy Haversacks
import os, strutils, sequtils, sugar

let input: string = paramStr(1)
let rules: seq[tuple[outer: string, inner: seq[string]]] =
  map(split(strip(readFile(input)), '\n'),
    rule => (replace(split(rule, " contain ")[0], " bags"),
      split(replace(replace(replace(split(rule, " contain ")[1], " bags"), " bag"), "."), ", ")))

proc outside(color: string): seq[string] =
  for rule in rules:
    if contains(join(rule.inner), color):
      result.add(rule.outer)
      result.add(outside(rule.outer))

proc inside(color: string): int =
  for rule in rules:
    if rule.outer == color:
      for bag in rule.inner:
        if bag == "no other":
          result = 0
        else:
          result += parseInt($bag[0]) * (inside(bag[2..^1]) + 1)

echo len(deduplicate(outside("shiny gold")))
echo inside("shiny gold")
