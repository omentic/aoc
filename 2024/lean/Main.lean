import Solutions.Day01

def main (args : List String) : IO Unit := do
  let usage := "usage: lake exe aoc Day⟨num⟩"
  match args with
  | ["--help"] | ["help"] =>
    IO.println usage
  | [day] =>
    let input <- IO.FS.readFile s!"../input/{day.toLower}.txt"
    IO.println <| solution input
  | _ =>
    IO.println usage
