defmodule Three do
  @moduledoc """
  Documentation for `Three`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Three.hello()
      :world

  """
  def task(filename) do
    filename
    |> File.read!()
    |> String.split()
    |> Enum.map(fn x -> String.split_at(x, div(String.length(x), 2)) end)
    |> Enum.map(fn {x, y} -> [String.graphemes(x), String.graphemes(y)] end)
    |> Enum.map(fn [x, y] -> for a <- x,
      Enum.any?(y, fn b -> b == a end) == :true do
      a
    end end)
    |> Enum.map(&Enum.dedup/1)
    |> List.flatten()
    |> Enum.reduce(0, fn x, acc -> sign_code(x) + acc end)
  end

  def task2(filename) do
    filename
    |> File.read!()
    |> String.split()
    |> Enum.chunk_every(3)
    |> Enum.map(fn [x, y, z] -> [String.graphemes(x), String.graphemes(y), String.graphemes(z)] end)
    |> Enum.map(fn [x, y, z] -> for a <- x,
      Enum.any?(y, fn b -> b == a end) == :true,
      Enum.any?(z, fn c -> c == a end) == :true do
      a
    end end)
    |> IO.inspect()
    |> Enum.map(&Enum.dedup/1)
    |> List.flatten()
    |> Enum.reduce(0, fn x, acc -> sign_code(x) + acc end)
  end

  defp sign_code(<<sign>>) do
    if sign in ?a..?z do
      sign - ?a + 1
    else
      sign - ?A + 27
    end
  end
end
