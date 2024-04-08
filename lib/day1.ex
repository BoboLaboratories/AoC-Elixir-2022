defmodule Day1 do
  @doc """
      iex> Day1.part1(\"""
      ...> 1000
      ...> 2000
      ...> 3000
      ...>
      ...> 4000
      ...>
      ...> 5000
      ...> 6000
      ...>
      ...> 7000
      ...> 8000
      ...> 9000
      ...>
      ...> 10000
      ...> \""")
      24000
  """
  def part1(input) do
    input
    |> parse_input()
    |> Enum.max()
  end

  @doc """
      iex> Day1.part2(\"""
      ...> 1000
      ...> 2000
      ...> 3000
      ...>
      ...> 4000
      ...>
      ...> 5000
      ...> 6000
      ...>
      ...> 7000
      ...> 8000
      ...> 9000
      ...>
      ...> 10000
      ...> \""")
      45000
  """
  def part2(input) do
    input
    |> parse_input()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn entry ->
      entry
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
  end
end
