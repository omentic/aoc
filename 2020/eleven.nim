# Day Eleven: Seating System
import os, strutils, sequtils, sugar

let input: string = paramStr(1)
var terminal: seq[seq[char]] = map(split(strip(readFile(input)), '\n'), row => @row)
let height: int = len(terminal)
let width: int = len(terminal[0])

while true:
  var prev, future: seq[char] = @(repeat('.', width)) # dummy floor
  var buffer: seq[seq[char]]  = terminal
  for i, row in buffer:
    if height - i == 1:
      future = @(repeat('.', width))
    else:
      future = buffer[i+1]
    for j, seat in row:
      let threshold: int =
        if j == 0:
          count(prev[j..j+1], '#') + count($row[j+1], "#") + count(future[j..j+1], '#')
        elif j == width - 1:
          count(prev[j-1..j], '#') + count($row[j-1], "#") + count(future[j-1..j], '#')
        else:
          count(prev[j-1..j+1], '#') + count($row[j-1], "#") +
          count($row[j+1], "#") + count(future[j-1..j+1], '#')
      if seat == '#' and threshold >= 4:
        buffer[i][j] = 'L'
      elif seat == 'L' and threshold == 0:
        buffer[i][j] = '#'
    prev = row
  if terminal == buffer: break
  terminal = buffer
echo count($terminal, '#')

terminal = map(split(strip(readFile(input)), '\n'), row => @row)
while true:
  var prev, future: seq[char] = @(repeat('.', width)) # dummy floor
  var buffer: seq[seq[char]] = terminal
  for i, row in buffer:
    if height - i == 1:
      future = @(repeat('.', width))
    else:
      future = buffer[i+1]
    for j, seat in row:
      var threshold: int = 0
      # left
      for k in countdown(j-1, 0):
        if terminal[i][k] == '#': inc(threshold)
        if terminal[i][k] != '.': break
      # right
      for k in j+1 .. width - 1:
        if terminal[i][k] == '#': inc(threshold)
        if terminal[i][k] != '.': break
      # up
      for k in countdown(i-1, 0):
        if terminal[k][j] == '#': inc(threshold)
        if terminal[k][j] != '.': break
      # down
      for k in i+1 .. height - 1:
        if terminal[k][j] == '#': inc(threshold)
        if terminal[k][j] != '.': break
      # down-left
      for k in 1 .. min(i, j):
        if terminal[i-k][j-k] == '#': inc(threshold)
        if terminal[i-k][j-k] != '.': break
      # up-left
      for k in 1 .. min(height-1-i, j):
        if terminal[i+k][j-k] == '#': inc(threshold)
        if terminal[i+k][j-k] != '.': break
      # down-right
      for k in 1 .. min(i, width-1-j):
        if terminal[i-k][j+k] == '#': inc(threshold)
        if terminal[i-k][j+k] != '.': break
      # up-right
      for k in 1 .. min(height-1-i, width-1-j):
        if terminal[i+k][j+k] == '#': inc(threshold)
        if terminal[i+k][j+k] != '.': break
      if seat == '#' and threshold >= 5:
        buffer[i][j] = 'L'
      elif seat == 'L' and threshold == 0:
        buffer[i][j] = '#'
    prev = row
  if terminal == buffer: break
  terminal = buffer
echo count($terminal, '#')
