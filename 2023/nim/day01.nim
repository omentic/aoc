# Day One: Trebuchet?!
import std/[os, strutils, sequtils, sugar]

let input = paramStr(1).readFile().strip().split("\n")

var values: seq[int]
for line in input:
  var buf = ""
  for c in line:
    if c in '0'..'9':
      buf.add(c)
  buf = if buf.len == 1: buf & buf else: buf[0] & buf[^1]
  values.add(buf.parseInt())
echo values.foldl(a + b, 0)

var parsed = input
for _ in 0 ..< 100: # :-(
  parsed = parsed.map(x => x.multiReplace([
    ("one", "o1e"), # one1one does NOT work
    ("two", "t2o"),
    ("three", "t3e"),
    ("four", "f4fr"),
    ("five", "f5e"),
    ("six", "s6x"),
    ("seven", "s7n"),
    ("eight", "e8t"),
    ("nine", "n9e"),
  ]))

values = @[]
for line in parsed:
  var buf = ""
  for c in line:
    if c in '0'..'9':
      buf.add(c)
  buf = if buf.len == 1: buf & buf else: buf[0] & buf[^1]
  values.add(buf.parseInt())
echo values.foldl(a + b, 0)
