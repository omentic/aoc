# Day Seventeen: Conway Cubes
import std/os, std/sets, std/enumerate

let input: string = paramStr(1)
type Coord = tuple[x,y,z: int]

# Coordinate system: 0,0 is at the top left
var dimension: HashSet[Coord]
for y, line in enumerate(lines(input)):
  for x, cube in line:
    if cube == '#':
      dimension.incl((x,y,0))
      # stdout.write(x, ",", y, " ")
    # stdout.write(cube)
  # stdout.write('\n')
# echo(dimension)

## Return a tuple describing a dimension's largest axes
func maximum(dim: HashSet[Coord]): tuple[x,y,z: int] =
  result = (0,0,0)
  for cube in dim:
    if abs(cube.x) > result.x: result.x = abs(cube.x)
    if abs(cube.y) > result.y: result.y = abs(cube.y)
    if abs(cube.z) > result.z: result.z = abs(cube.z)

## Return the number of cubes neighboring an arbitary point in space
func neighbors(cube: Coord, dim: HashSet[Coord]): int =
  result = 0
  for x in -1 .. 1:
    for y in -1 .. 1:
      for z in -1 .. 1:
        if ((cube.x+x, cube.y+y, cube.z+z) in dim) and ((x,y,z) != (0,0,0)):
          inc(result)

## Run one cycle of a pocket dimension
func cycle(dim: HashSet[Coord]): HashSet[Coord] =
  let max = maximum(dim)
  for x in -max.x-1 .. max.x+1:
    for y in -max.y-1 .. max.y+1:
      for z in -max.z-1 .. max.z+1:
        let coord = (x,y,z)
        if coord in dim:
          if coord.neighbors(dim) == 2 or coord.neighbors(dim) == 3:
            result.incl(coord)
        if coord notin dim:
          if coord.neighbors(dim) == 3:
            result.incl(coord)

func cycle(dim: HashSet[Coord], reps: int): HashSet[Coord] =
  result = dim
  for i in 1 .. reps:
    result = cycle(result)

## Visualize output
proc echo(dim: HashSet[Coord]) =
  let max = maximum(dim)
  for z in -max.z .. max.z:
    stdout.write("z=", z, '\n')
    for y in -max.y .. max.y:
      for x in -max.x .. max.x:
        if (x,y,z) == (0,0,0):
          stdout.write('0')
        elif (x,y,z) in dim:
          stdout.write('#')
        else:
          stdout.write('.')
      stdout.write('\n')
    stdout.write('\n')

echo len(dimension.cycle(6))
