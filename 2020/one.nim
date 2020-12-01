import os, strutils

let input = paramStr(1)

for one in lines(input):
  for two in lines(input):
    if parseInt(one) + parseInt(two) == 2020:
      echo parseInt(one) * parseInt(two)
    for three in lines(input):
      if parseInt(one) + parseInt(two) + parseInt(three) == 2020:
        echo parseInt(one) * parseInt(two) * parseInt(three)
