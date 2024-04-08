defmodule Day3 do
  @doc """
      iex> Day3.part1(\"""
      ...> vJrwpWtwJgWrhcsFMMfFFhFp
      ...> jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      ...> PmmdzqPrVvPwwTWBwg
      ...> wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ...> ttgJtRGJQctTZtZT
      ...> CrZsJsPPZsGzwwsLwLmpwMDw
      ...> \""")
      157
  """
  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(&Enum.split(&1, round(length(&1) / 2)))
    |> Enum.map(&Tuple.to_list/1)
    |> intersection_priority()
  end

  @doc """
      iex> Day3.part2(\"""
      ...> vJrwpWtwJgWrhcsFMMfFFhFp
      ...> jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      ...> PmmdzqPrVvPwwTWBwg
      ...> wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ...> ttgJtRGJQctTZtZT
      ...> CrZsJsPPZsGzwwsLwLmpwMDw
      ...> \""")
      70
  """
  def part2(input) do
    input
    |> parse_input()
    |> Enum.chunk_every(3)
    |> intersection_priority()
  end

  defp intersection_priority(list) do
    list
    |> Enum.map(&intersection/1)
    |> Enum.map(&item_priority/1)
    |> Enum.sum()
  end

  defp intersection([head | tail]) do
    intersection(tail, MapSet.new(head))
  end

  defp intersection([head | tail], acc) do
    acc = MapSet.intersection(MapSet.new(head), acc)
    intersection(tail, acc)
  end

  defp intersection([], acc) do
    <<item::utf8, _::binary>> = Enum.at(acc, 0)
    item
  end

  defp item_priority(item) when item >= ?a and item <= ?z, do: item - ?a + 1
  defp item_priority(item) when item >= ?A and item <= ?Z, do: item - ?A + 27

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.codepoints/1)
  end
end
