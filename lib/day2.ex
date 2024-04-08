defmodule Day2 do
  @round_points %{win: 6, tie: 3, loss: 0}
  @shape_points %{rock: 1, paper: 2, scissors: 3}
  @shape_mapping %{"A" => :rock, "B" => :paper, "C" => :scissors}
  @winning_combinations [{:rock, :paper}, {:paper, :scissors}, {:scissors, :rock}]

  @doc """
      iex> Day2.part1(\"""
      ...> A Y
      ...> B X
      ...> C Z
      ...> \""")
      15
  """
  def part1(input) do
    y_mapping = %{"X" => :rock, "Y" => :paper, "Z" => :scissors}

    input
    |> parse_input(y_mapping)
    |> Enum.map(&round_points/1)
    |> Enum.sum()
  end

  defp round_points({_, y} = round) do
    status = logic1(round)
    @round_points[status] + @shape_points[y]
  end

  defp logic1(round) when round in @winning_combinations, do: :win
  defp logic1({x, y}) when x == y, do: :tie
  defp logic1(_), do: :loss

  @doc """
      iex> Day2.part2(\"""
      ...> A Y
      ...> B X
      ...> C Z
      ...> \""")
      12
  """
  def part2(input) do
    y_mapping = %{"X" => :loss, "Y" => :tie, "Z" => :win}

    input
    |> parse_input(y_mapping)
    |> Enum.map(fn {_, y} = round ->
      our_shape = logic2(round)
      @round_points[y] + @shape_points[our_shape]
    end)
    |> Enum.sum()
  end

  defp logic2({:rock, :win}), do: :paper
  defp logic2({:paper, :win}), do: :scissors
  defp logic2({:scissors, :win}), do: :rock
  defp logic2({:rock, :loss}), do: :scissors
  defp logic2({:paper, :loss}), do: :rock
  defp logic2({:scissors, :loss}), do: :paper
  defp logic2({x, :tie}), do: x

  defp parse_input(input, y_mapping) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ~r/\s+/u, max: 2))
    |> Enum.map(fn [x, y] -> {@shape_mapping[x], y_mapping[y]} end)
  end
end
