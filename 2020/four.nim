# Day Four: Passport Processing
import os, strutils

let input: string = paramStr(1)
var fieldedPassports, validPassports: int = 0

for passport in split(readFile(input), "\n\n"):
  var fields, valid: int = 0
  for pairs in split(strip(replace(passport, "\n", " ")), " "):
    let
      key: string = split(pairs, ":")[0]
      value: string = split(pairs, ":")[1]
    case key
    of "byr":
      if parseInt(value) >= 1920 and parseInt(value) <= 2002:
        inc(valid)
      inc(fields)
    of "iyr":
      if parseInt(value) >= 2010 and parseInt(value) <= 2020:
        inc(valid)
      inc(fields)
    of "eyr":
      if parseInt(value) >= 2020 and parseInt(value) <= 2030:
        inc(valid)
      inc(fields)
    of "hgt":
      let
        units: string = value[len(value)-2..len(value)-1]
        height: string = value[0..len(value)-3]
      if units == "cm" and parseInt(height) >= 150 and parseInt(height) <= 193:
        inc(valid)
      elif units == "in" and parseInt(height) >= 59 and parseInt(height) <= 76:
        inc(valid)
      inc(fields)
    of "hcl":
      block hex:
        if value[0] == '#':
          for char in value[1..len(value)-1]:
            if char notin {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'}:
              break hex
          inc(valid)
      inc(fields)
    of "ecl":
      if value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
        inc(valid)
      inc(fields)
    of "pid":
      if len(value) == 9:
        inc(valid)
      inc(fields)
  if fields >= 7:
    inc(fieldedPassports)
  if valid >= 7:
    inc(validPassports)

echo fieldedPassports
echo validPassports
