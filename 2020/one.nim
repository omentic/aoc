# Day One: Report Repair
import os, strutils

let input: string = paramStr(1)
var done: bool = false

for one in lines(input):
  for two in lines(input):
    if parseInt(one) + parseInt(two) == 2020 and not done:
      echo parseInt(one) * parseInt(two)
      done = true
    for three in lines(input):
      if parseInt(one) + parseInt(two) + parseInt(three) == 2020 and done:
        echo parseInt(one) * parseInt(two) * parseInt(three)
        quit()
