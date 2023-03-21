defmodule Four do
  @moduledoc """
  Documentation for `Four`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Four.hello()
      :world

  """
  def camp_cleanup(filename) do
    filename
    |> File.read!()
    |> String.split()
    |> Stream.map(&String.split(&1, ",", trim: true))
    |> Stream.map(fn [x, y] -> [String.split(x, "-"), String.split(y, "-")] end)
    |> Enum.map(fn [[a, b], [c, d]] -> to_int(a, b, c, d) end)
  end

  def part_one(filename) do
    filename
    |> camp_cleanup()
    |> Enum.reduce(0, fn x, acc -> if contains?(x) do acc + 1 else acc end end)
  end

  def part_two(filename) do
    filename
    |> camp_cleanup()
    |> Enum.reduce(0, fn x, acc -> if contains_p2?(x) do acc + 1 else acc end end)
  end

  defp contains?([[a, b], [c, d]]) do
    if (a in c..d && b in c..d) or (c in a..b && d in a..b) do
      :true
    else
      :false
    end
  end

  defp contains_p2?([[a, b], [c, d]]) do
    if a in c..d || b in c..d || c in a..b || d in a..b do
      :true
    else
      :false
    end
  end

  defp to_int(a, b, c, d) do
    [[String.to_integer(a), String.to_integer(b)], [String.to_integer(c), String.to_integer(d)]]
  end
end
