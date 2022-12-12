# Day 12: Hill Climbing Algorithm
import std/[os, strutils, sequtils, sets, terminal]

type Cell = tuple[x: int, y: int]

# slow slow slow
let input = paramStr(1).readFile().strip().split("\n")
var grid = input.mapIt(it.toSeq())

proc calc_start(): Cell = # slow
  for i, line in grid:
    for j, elevation in line:
      if elevation == 'S':
        grid[i][j] = '`'
        return (i, j)

proc calc_goal(): Cell = # slow
  for i, line in grid:
    for j, elevation in line:
      if elevation == 'E':
        grid[i][j] = '{' # lol
        return (i, j)

proc valid(fr, to: Cell, visited: HashSet[Cell], desc: bool): (bool, bool) =
  if (to.x >= 0) and (to.y >= 0) and (to.x < grid.len) and (to.y < grid[0].len):
    if to notin visited:
      let sign = if desc: -1 else: 1
      if sign * (grid[to.x][to.y].ord - grid[fr.x][fr.y].ord) < 2:
        if not desc and grid[to.x][to.y] == '{':
          return (true, true)
        if desc and grid[to.x][to.y] == 'a':
          return (true, true)
        return (true, false)
  return (false, false)

proc print(cells: HashSet[Cell]) =
  eraseScreen()
  for i, line in grid:
    for j, ele in line:
      if (i, j) in cells:
        stdout.write("█")
      else:
        stdout.write(ele)
    stdout.write("\n")
  sleep(100)

proc search(start: Cell, desc: bool): int =
  var current = @[start].toHashSet()
  var visited: HashSet[Cell]

  var steps = 0
  while true:
    steps += 1
    var temp: HashSet[Cell]
    for c in current:
      var neighbors: HashSet[Cell]
      let cells: array[4, Cell] = [(c.x+1, c.y), (c.x-1, c.y), (c.x, c.y+1), (c.x, c.y-1)]
      for cell in cells:
        let (valid, success) = valid(c, cell, visited, desc)
        if success:
          return steps
        if valid:
          neighbors.incl(cell)
      visited.incl(c)
      temp.incl(neighbors)
    current = temp
    # print(visited)

let start = calc_start()
let goal = calc_goal()

echo search(start, false)
echo search(goal, true)
