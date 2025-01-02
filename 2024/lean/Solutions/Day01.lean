-- Day 1: Historian Hysteria

def solution (input : String) : String :=
  let input := input.stripSuffix "\n" |>.splitOn "\n"
  let l1 := input.map (·.splitOn "   " |>.get! 0 |>.toInt!)
  let l2 := input.map (·.splitOn "   " |>.get! 1 |>.toInt!)
  let p1 :=
    List.foldl (· + ·) 0
    <| List.map Int.natAbs
    <| List.zipWith (· - ·) l1.mergeSort l2.mergeSort
  let p2 :=
    List.foldl (· + ·) 0
    <| List.map (fun a => a * List.count a l2) l1
  s!"{p1}, {p2}"

-- def main (args : List String) : IO Unit := do
--   let input <- IO.FS.readFile s!"../input/{args.get! 0|>.toLower}.txt"
--   IO.println <| solution input
