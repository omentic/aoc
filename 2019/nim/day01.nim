# Day One: The Tyranny of the Rocket Equation
import os, strutils

let input: string = paramStr(1)
var sum, fuelsum: int = 0

for mass in lines(input):
  var fuel = parseInt(mass) div 3 - 2
  sum += fuel
  fuelsum += fuel
  while fuel > 0:
    fuel = fuel div 3 - 2
    fuelsum += max(0, fuel)

echo sum
echo fuelsum
