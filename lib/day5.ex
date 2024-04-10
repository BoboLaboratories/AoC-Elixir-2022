defmodule Day5 do
  @doc """
      iex>Day5.part1(\"""
      ...>    [D]
      ...>[N] [C]
      ...>[Z] [M] [P]
      ...> 1   2   3
      ...>
      ...>move 1 from 2 to 1
      ...>move 3 from 1 to 3
      ...>move 2 from 2 to 1
      ...>move 1 from 1 to 2
      ...>\""")
      "CMZ"
  """
  def part1(input) do
    logic(input, &Function.identity/1)
  end

  @doc """
      iex>Day5.part2(\"""
      ...>    [D]
      ...>[N] [C]
      ...>[Z] [M] [P]
      ...> 1   2   3
      ...>
      ...>move 1 from 2 to 1
      ...>move 3 from 1 to 3
      ...>move 2 from 2 to 1
      ...>move 1 from 1 to 2
      ...>\""")
      "MCD"
  """
  def part2(input) do
    logic(input, &Enum.reverse/1)
  end

  defp logic(input, dest_fun) do
    {cols, instructions} = parse_input(input)

    instructions
    |> Enum.reduce(cols, fn {amount, src, dest}, cols ->
      src_list = Enum.at(cols, src)
      dest_list = Enum.at(cols, dest)

      transfer_list = Enum.take(src_list, amount)
      src_list = Enum.drop(src_list, amount)

      dest_list =
        transfer_list
        |> dest_fun.()
        |> Enum.reduce(dest_list, fn crate, acc -> [crate | acc] end)

      cols
      |> List.replace_at(src, src_list)
      |> List.replace_at(dest, dest_list)
    end)
    |> transpose()
    |> hd()
    |> List.to_string()
  end

  defp parse_input(input) do
    [crates, instructions] = String.split(input, "\n\n")

    crates = parse_crates(crates)
    instructions = parse_instructions(instructions)

    {crates, instructions}
  end

  defp parse_crates(crates) do
    crates = String.split(crates, "\n")

    max_col =
      crates
      |> Enum.at(-1)
      |> String.split(~r/\s+/u, trim: true)
      |> Enum.at(-1)
      |> String.to_integer()

    crates
    |> Enum.drop(-1)
    |> Enum.reverse()
    |> Enum.map(&parse_line(&1, max_col))
    |> transpose()
    |> Enum.map(fn col -> Enum.filter(col, &(&1 != ?\s)) end)
    |> Enum.map(&Enum.reverse/1)
  end

  defp parse_line(line, len), do: parse_line(line, [], len)

  defp parse_line(<<?\s, ?\s, ?\s, ?\s, line::binary>>, acc, len) do
    parse_line(line, [?\s | acc], len - 1)
  end

  defp parse_line(<<?[, crate::utf8, ?], _::utf8, line::binary>>, acc, len) do
    parse_line(line, [crate | acc], len - 1)
  end

  defp parse_line(<<?[, crate::utf8, ?]>>, acc, len) do
    acc = [crate | acc] |> Enum.reverse()
    empty = for x <- 0..(len - 1), x > 0, into: [], do: ?\s
    acc ++ empty
  end

  defp parse_instructions(instructions) do
    instructions
    |> String.split(["\n", "move", "from", "to"], trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3)
    |> Enum.map(fn [amount, src, dest] -> {amount, src - 1, dest - 1} end)
  end

  defp transpose([[] | _]), do: []

  defp transpose(m) do
    [Enum.map(m, &hd/1) | transpose(Enum.map(m, &tl/1))]
  end
end
