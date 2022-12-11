# Day 8: Treetop Tree House
import std/[os, strutils, sugar]

let input = paramStr(1).readFile().strip().split("\n")

type Tree = object
  height: int
  visible: bool
  scenic: int

var forest = collect:
  for line in input:
    collect:
      for c in line:
        Tree(height: parseInt($c), visible: false, scenic: 1)

var sum = 0
var max = 0

template gaze(s: seq[seq[Tree]], a, b: iterable[int], min: int): int =
  var result = 0
  block loop:
    for k in a:
      for l in b:
        inc result
        if s[k][l].height >= min:
          break loop
  result

for i in 0 ..< forest.len:
  var min = (-1, -1, -1, -1)
  for j in 0 ..< forest.len:
    let k = forest[0].len - 1 - j

    if forest[i][j].height > min[0]:
      min[0] = forest[i][j].height
      if not forest[i][j].visible: inc sum
      forest[i][j].visible = true

    if forest[i][k].height > min[1]:
      min[1] = forest[i][k].height
      if not forest[i][k].visible: inc sum
      forest[i][k].visible = true

    if forest[j][i].height > min[2]:
      min[2] = forest[j][i].height
      if not forest[j][i].visible: inc sum
      forest[j][i].visible = true

    if forest[k][i].height > min[3]:
      min[3] = forest[k][i].height
      if not forest[k][i].visible: inc sum
      forest[k][i].visible = true

    let min = forest[i][j].height

    forest[i][j].scenic *= forest.gaze(countdown(i-1, 0), j..j, min)
    forest[i][j].scenic *= forest.gaze(i..i, countdown(j-1, 0), min)
    forest[i][j].scenic *= forest.gaze(i+1 ..< forest.len, j..j, min)
    forest[i][j].scenic *= forest.gaze(i..i, j+1 ..< forest.len, min)

    if forest[i][j].scenic > max:
      max = forest[i][j].scenic

echo sum
echo max
