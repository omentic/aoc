import os, strutils, terminal

let input = paramStr(1)
var unofficial, official: string
var unofficialCount, officialCount: int = 0
var length: int = 20

for line in lines(input):
  var frequency: int = 0
  var unofficialPass, officialPass, unofficialValidity, officialValidity: string
  let
    entry: seq[string] = split(line, {'-', ' ', ':'})
    min: int = parseInt(entry[0])
    max: int = parseInt(entry[1])
    letter: char = entry[2][0]
    pass: string = entry[4]

  if len(pass) > length:
    length = len(pass)

  for char in pass:
    if char == letter:
      inc(frequency)
      if frequency < min:
        unofficialPass.add(ansiForegroundColorCode(fgBlue) & $char)
      elif char == letter and frequency > max:
        unofficialPass.add(ansiForegroundColorCode(fgRed) & $char)
      else:
        unofficialPass.add(ansiForegroundColorCode(fgGreen) & $char)
    else:
      unofficialPass.add(ansiForegroundColorCode(fgDefault) & $char)
  unofficialPass.add(ansiForegroundColorCode(fgDefault))
  if min <= frequency and frequency <= max:
    inc(unofficialCount)
    unofficialValidity = ansiForegroundColorCode(fgGreen) & "VALID (" & $frequency & ")" & ansiForegroundColorCode(fgDefault)
  elif frequency < min:
    unofficialValidity = ansiForegroundColorCode(fgBlue) & "TOO FEW (" & $frequency & " < " & $min & ")" & ansiForegroundColorCode(fgDefault)
  elif frequency > max:
    unofficialValidity = ansiForegroundColorCode(fgRed) & "TOO MANY (" & $frequency & " > " & $max & ")" & ansiForegroundColorCode(fgDefault)

  for i in 0..len(pass)-1:
    if i == min-1:
      if pass[min-1] == letter:
        officialPass.add(ansiForegroundColorCode(fgGreen))
      else:
        officialPass.add(ansiForegroundColorCode(fgRed))
    elif i == max-1:
      if pass[max-1] == letter:
        officialPass.add(ansiForegroundColorCode(fgGreen))
      else:
        officialPass.add(ansiForegroundColorCode(fgRed))
    else:
      officialPass.add(ansiForegroundColorCode(fgDefault))
    officialPass.add(pass[i])
  if pass[min-1] == letter xor pass[max-1] == letter:
    inc(officialCount)
    officialValidity = ansiForegroundColorCode(fgGreen) & "VALID (XOR)" & ansiForegroundColorCode(fgDefault)
  elif pass[min-1] == letter and pass[max-1] == letter:
    officialValidity = ansiForegroundColorCode(fgRed) & "INVALID (AND)" & ansiForegroundColorCode(fgDefault)
  else:
    officialValidity = ansiForegroundColorCode(fgBlue) & "INVALID (NOT)" & ansiForegroundColorCode(fgDefault)

  unofficial.add(alignLeft($min & "-" & $max, 6) & ansiStyleCode(1) & $letter & ansiStyleCode(0) & ": " & unofficialPass & repeat(" ", length+2 - len(pass)) & ansiStyleCode(1) & unofficialValidity & ansiStyleCode(0) & "\n")
  official.add(alignLeft($min & "-" & $max, 6) & ansiStyleCode(1) & $letter & ansiStyleCode(0) & ": " & unofficialPass & repeat(" ", length+2 - len(pass)) & ansiStyleCode(1) & officialValidity & ansiStyleCode(0) & "\n")

unofficial.add("TOTAL VALID PASSWORDS (The Sled Rental Place Down The Street Policy): " & $unofficialCount & "\n")
official.add("TOTAL VALID PASSWORDS (The Official Toboggan Corporate Policy): " & $officialCount)

echo unofficial
echo official
