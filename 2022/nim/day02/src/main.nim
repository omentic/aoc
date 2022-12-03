# Day Two: Rock Paper Scissors
import std/[os, strutils, sequtils]

let input = paramStr(1).readFile().strip().split("\n").mapIt(it.split(" "))

var score = 0
for line in input:
  if line[1] == "X":
    score += 1
    if line[0] == "A": score += 3
    if line[0] == "B": score += 0
    if line[0] == "C": score += 6
  if line[1] == "Y":
    score += 2
    if line[0] == "A": score += 6
    if line[0] == "B": score += 3
    if line[0] == "C": score += 0
  if line[1] == "Z":
    score += 3
    if line[0] == "A": score += 0
    if line[0] == "B": score += 6
    if line[0] == "C": score += 3
echo score

score = 0
for line in input:
  if line[1] == "X":
    score += 0
    if line[0] == "A": score += 3
    if line[0] == "B": score += 1
    if line[0] == "C": score += 2
  if line[1] == "Y":
    score += 3
    if line[0] == "A": score += 1
    if line[0] == "B": score += 2
    if line[0] == "C": score += 3
  if line[1] == "Z":
    score += 6
    if line[0] == "A": score += 2
    if line[0] == "B": score += 3
    if line[0] == "C": score += 1
echo score
