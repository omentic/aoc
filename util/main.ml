let input =
  CCIO.(with_in filename read_lines_l)
  |> List.map parse_line
  |> Array.of_list
