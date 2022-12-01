# Day Fifteen: Rambunctious Recitation
import std/[os, strutils, sequtils]

let input: string = paramStr(1)

proc recite(nth: int): int =
  var numbers: seq[int] = input.readFile().strip().split(",").map(parseInt)
  var history: seq[int] = newSeqWith[int](nth, -1)
  for i in 0 .. nth - 2:
    let previous: int = numbers[i]
    if i == len(numbers) - 1:
      if history[previous] != -1:
        numbers.add(i - history[previous])
      else:
        numbers.add(0)
    history[previous] = i
  return numbers[^1]

echo recite(2020)
echo recite(30000000)
