# Day Eighteen: Operation Order
import std/[os, strutils]

let input = paramStr(1).readFile().strip().split("\n")

# cheese: add parenthesis and eval

func evaluate(a, b: int, op: char): int =
  if op == '+':
    return a + b
  elif op == '*':
    return a * b
  else:
    debugEcho "this should never happen."
    return -1

var sum = 0
for line in input:
  var stack: seq[tuple[val: int, op: char]] = @[(0, '+')]
  for c in line:
    let last = stack.len - 1
    if c == ' ':
      discard
    elif c == '+' or c == '*':
      stack[last].op = c
    elif c == '(':
      stack.add((0, '+'))
    elif c == ')':
      stack[last-1] = (evaluate(stack[last-1].val, stack.pop.val, stack[last-1].op), '+')
    else:
      stack[last] = (evaluate(stack[last].val, parseInt($c), stack[last].op), ' ')
  sum += stack[stack.len - 1].val
echo sum

func shunting(expression: string): string =
  var stack: seq[char]
  for t in expression:
    if t == ' ':
      discard
    elif t == '+':
      while stack.len > 0 and stack[stack.len-1] == '+':
        result.add(stack.pop)
      stack.add(t)
    elif t == '*':
      while stack.len > 0 and (stack[stack.len-1] == '+' or stack[stack.len-1] == '*'):
        result.add(stack.pop)
      stack.add(t)
    elif t == '(':
      stack.add(t)
    elif t == ')':
      while stack.len > 0 and stack[stack.len - 1] != '(':
        result.add(stack.pop)
      assert stack.pop == '('
    else:
      result.add(t)
  while stack.len != 0:
    result.add(stack.pop)

func evaluate(expression: string): int =
  var stack: seq[int]
  for s in expression:
    if s == ' ':
      discard
    elif s == '+':
      stack.add(stack.pop + stack.pop)
    elif s == '*':
      stack.add(stack.pop * stack.pop)
    else:
      stack.add(parseInt($s))
  assert stack.len == 1
  return stack[0]

sum = 0
for line in input:
  sum += evaluate(line.shunting())
echo sum
