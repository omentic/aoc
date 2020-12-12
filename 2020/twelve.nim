# Day Twelve: Rain Risk
import os, strutils, sequtils, math, sugar

let input: string = paramStr(1)
let instructions: seq[tuple[action: char, value: int]] =
  map(split(strip(readFile(input)), '\n'),
    instruction => (instruction[0], parseInt(instruction[1..^1])))

var ferry, actual: tuple[latitude, longitude, bearing: int] = (0, 0, 0)
var waypoint: tuple[latitude, longitude: int] = (1, 10)
for instruction in instructions:
  let value: int = instruction.value
  let current: tuple[latitude, longitude: int] = waypoint
  case instruction.action
  of 'N':
    inc(ferry.latitude, value)
    inc(waypoint.latitude, value)
  of 'S':
    dec(ferry.latitude, value)
    dec(waypoint.latitude, value)
  of 'E':
    inc(ferry.longitude, value)
    inc(waypoint.longitude, value)
  of 'W':
    dec(ferry.longitude, value)
    dec(waypoint.longitude, value)
  of 'L':
    inc(ferry.bearing, value)
    let bearing: float = degToRad(toFloat(value))
    case value
    of 0, 180:
      waypoint.latitude = sgn(cos(bearing)) * current.latitude
      waypoint.longitude = sgn(cos(bearing)) * current.longitude
    of 90, 270:
      waypoint.latitude = sgn(sin(bearing)) * current.longitude
      waypoint.longitude = -sgn(sin(bearing)) * current.latitude
    else:
      discard
  of 'R':
    dec(ferry.bearing, value)
    let bearing: float = degToRad(toFloat(value))
    case value
    of 0, 180:
      waypoint.latitude = sgn(cos(bearing)) * current.latitude
      waypoint.longitude = sgn(cos(bearing)) * current.longitude
    of 90, 270:
      waypoint.latitude = -sgn(sin(bearing)) * current.longitude
      waypoint.longitude = sgn(sin(bearing)) * current.latitude
    else:
      discard
  of 'F':
    let bearing: float = degToRad(toFloat(ferry.bearing))
    if abs(cos(bearing)) == 1.0:
      inc(ferry.longitude, sgn(cos(bearing)) * value)
    elif abs(sin(bearing)) == 1.0:
      inc(ferry.latitude, sgn(sin(bearing)) * value)
    inc(actual.longitude, value * waypoint.longitude)
    inc(actual.latitude, value * waypoint.latitude)
  else:
    discard
echo abs(ferry.longitude) + abs(ferry.latitude)
echo abs(actual.longitude) + abs(actual.latitude)
