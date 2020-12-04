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
      if parseInt(value) in 1920 .. 2002:
        inc(valid)
    of "iyr":
      if parseInt(value) in 2010 .. 2020:
        inc(valid)
    of "eyr":
      if parseInt(value) in 2020 .. 2030:
        inc(valid)
    of "hgt":
      let
        units: string = value[^2..^1]
        height: string = value[0..^3]
      if units == "cm" and parseInt(height) in 150 .. 193:
        inc(valid)
      elif units == "in" and parseInt(height) in 59 .. 76:
        inc(valid)
    of "hcl":
      block hex:
        for char in value[1..^1]:
          if char notin {'0'..'9', 'a'..'f'}:
            break hex
        if value[0] == '#':
          inc(valid)
    of "ecl":
      if value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
        inc(valid)
    of "pid":
      if len(value) == 9:
        inc(valid)
    else:
      dec(fields)
    inc(fields)
  if fields >= 7:
    inc(fieldedPassports)
  if valid >= 7:
    inc(validPassports)

echo fieldedPassports
echo validPassports
