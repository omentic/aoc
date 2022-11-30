# Day Nineteen: Monster Messages
import std/[os, strutils, sequtils, sugar, algorithm]

let input = paramStr(1).readFile().strip().split("\n\n")
let rules: seq[string] = input[0].strip().split("\n")
  .sortedByIt(it.split(": ")[0].parseInt()).mapIt(it.split(": ")[1])

let messages: seq[string] = input[1].strip().split("\n")

func replace(a: string, target: int, with: string): string =
  var replaced = false
  for chunk in a.split(" "):
    if chunk[0] != '"' and chunk.parseInt() == target and not replaced:
      result &= with # probably the bug
      replaced = true
    else:
      result &= chunk
    result &= " "
  result.strip()

var stack: seq[string]
var generated: seq[string]
stack.add(rules[0])
while stack.len > 0: # slow as all hell... but works!
  var current = stack.pop
  if not current.contains({'0'..'9'}):
    generated.add(current)
  else:
    var nextindex = current.split(" ")
      .filterIt(it[0] != '"')[0].parseInt()
    var nextrule = rules[nextindex]
    for chunk in nextrule.split(" | "):
      stack.add(current.replace(nextindex, chunk))

generated.applyIt(it.replace("\"", "").replace(" ", ""))

var sum = 0
for line in messages:
  if line in generated:
    inc sum
echo sum
