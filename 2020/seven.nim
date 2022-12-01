# Day Seven: Handy Haversacks
import os, strutils, sequtils, sugar

let input: string = paramStr(1)
let rules: seq[tuple[outer: string, inner: seq[string]]] =
  input.readFile().strip().split('\n')
    .map(rule => (rule.split(" contain ")[0].replace(" bags"),
      rule.split(" contain ")[1].replace(" bags").replace(" bag").replace(".").split(", ")))

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

echo outside("shiny gold").deduplicate().len
echo inside("shiny gold")
