# Day Thirteen: Shuttle Search
import os, strutils, sequtils

let input: string = paramStr(1)
let arrival: int = input.readFile().splitLines()[0].parseInt()
let buses: seq[int] = map(input.readFile().splitLines()[1].split(','),
  func (bus: string): int =
    if bus == "x": 0
    else: parseInt(bus))

var earliest: tuple[id, wait: int] = (999, 999)
for bus in buses:
  if bus > 0:
    if bus - (arrival mod bus) < earliest.wait:
      earliest = (bus, bus - (arrival mod bus))
echo earliest.id * earliest.wait

# blatantly stolen code - what on earth is a chinese remainder theorem?
# (c: lizthegrey)
var timestamp: int = 0
var step: int = 1
for i, bus in buses:
  if bus != 0:
    while (timestamp+i) mod bus != 0:
      timestamp += step
    step *= bus
echo timestamp
