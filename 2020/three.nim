import os, strutils, std/enumerate

let input: string = paramStr(1)

proc descend(x: int, y: int): int =
  var longitude: int = 0
  for i, latitude in enumerate(lines(input)):
    if i mod y == 0:
      if latitude[longitude mod len(latitude)] == '#':
        inc(result)
      longitude += x

echo descend(3, 1)
echo descend(1, 1) * descend(3, 1) * descend(5, 1) * descend(7, 1) * descend(1, 2)
