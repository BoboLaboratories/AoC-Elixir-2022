defmodule Day4 do
  @doc """
      iex> Day4.part1(\"""
      ...> 2-4,6-8
      ...> 2-3,4-5
      ...> 5-7,7-9
      ...> 2-8,3-7
      ...> 6-6,4-6
      ...> 2-6,4-8
      ...> \""")
      2
  """
  def part1(input) do
    input
    |> parse_input()
    |> Enum.count(fn {{a, b}, {c, d}} ->
      (a >= c && b <= d) || (c >= a && d <= b)
    end)
  end

  @doc """
      iex> Day4.part2(\"""
      ...> 2-4,6-8
      ...> 2-3,4-5
      ...> 5-7,7-9
      ...> 2-8,3-7
      ...> 6-6,4-6
      ...> 2-6,4-8
      ...> \""")
      4
  """
  def part2(input) do
    input
    |> parse_input()
    |> Enum.count(fn {{a, b}, {c, d}} ->
      (c <= a and a <= d) || (c <= b and b <= d) ||
        (a <= c and c <= b) || (a <= d and d <= b)
    end)
  end

  defp parse_input(input) do
    input
    |> String.split(["\n", ",", "-"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple/1)
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple/1)
  end
end
