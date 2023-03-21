defmodule Two do
  @moduledoc """
  Documentation for `Two`.
  """
  @points [1, 2, 3]
  @doc """
  Calculates RPS score according to given strategy

  ## Examples

      iex> Two.rps("input.txt")

  """
  def cheat_list(filename) do
    filename
    |> Path.expand()
    |> File.read!()
    |> String.split("\n")
    |> Stream.map(&String.split/1)
    |> Enum.reject(fn x -> x == [] || Enum.count(x) == 1 end)
  end

  def rps(filename) do
    filename
    |> cheat_list()
    |> Enum.reduce(0, fn x, acc -> acc + compare(x) end)
  end

  def rps2(filename) do
    filename
    |> cheat_list()
    |> Enum.reduce(0, fn x, acc -> acc + compare2(x) end)
  end

  defp compare([<<x>>, <<y>>]) do
    diff = ?X - ?A
    sign_points = y - diff - ?A + 1
    z = x - y + diff
    cond do
      z == 2 -> sign_points + 6
      z == -2 -> sign_points
      z == 1 -> sign_points
      z == 0 -> sign_points + 3
      z == -1 -> sign_points + 6
    end
  end

  defp compare2([<<x>>, y]) do
    index_lose = x - ?A - 1
    index_draw = x - ?A
    index_win = x - ?A - 2
    cond do
      y == "X" -> Enum.at(@points, index_lose)
      y == "Y" -> Enum.at(@points, index_draw) + 3
      y == "Z" -> Enum.at(@points, index_win) + 6 |> IO.inspect()
    end
  end
end
