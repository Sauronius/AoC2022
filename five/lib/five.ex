defmodule Five do
  @moduledoc """
  Documentation for `Five`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Five.hello()
      :world

  """
  def supply_stacks(filename) do
    [crate_stack, instructions] = filename
    |> File.read!()
    |> String.split("\n\n")
    |> Stream.with_index()
    |> Enum.map(fn {x, y} -> if y == 0 do crates(x) |> Enum.with_index(1) else move_list(x) end end)

    #remake(crate_stack, instructions)
    #|> Enum.map(fn {x, _y} -> List.first(x) end)

    remake2(crate_stack, instructions)
    |> Enum.map(fn {x, _y} -> List.first(x) end)
  end

  defp crates(string) do
    string
    |> String.split("\n")
    |> Enum.map(&parse/1)
    |> Enum.zip()
    |> Enum.map(fn x -> x
        |> Tuple.to_list()
        |> Enum.reject(fn x -> x == "   " end)
        |> List.delete_at(-1) end)
  end

  defp move_list(moves) do
    moves
    |> regex_magic(~r/(?:move )(\d*)(?: from )(\d)(?: to )(\d)/)
    |> Enum.map(fn [_h | t] -> t
        |> Enum.map(fn x -> String.to_integer(x) end) end)
  end

  defp regex_magic(string, regex) do
    Regex.scan(regex, string)
  end

  @spec parse(String.t(), list()) :: list()
  defp parse(string, acc \\ [])
  defp parse("", acc), do: Enum.reverse(acc)
  defp parse(string, acc) do
    take = String.slice(string, 0..2)
    parse(String.slice(string, 4..100), [take | acc])
  end

  defp remake(crates, []), do: crates
  defp remake(crates, [h | t]) do
    [amount, start, finish] = h
    {take, leave} = crates
    |> Enum.find(fn x -> elem(x, 1) == start end)
    |> elem(0)
    |> Enum.split(amount)

    crates
    |> List.update_at(start - 1, fn {_a, b} -> {leave, b} end)
    |> List.update_at(finish - 1, fn {a, b} -> {List.flatten([Enum.reverse(take) | a]), b} end)
    |> remake(t)
  end

  defp remake2(crates, []), do: crates
  defp remake2(crates, [h | t]) do
    [amount, start, finish] = h
    {take, leave} = crates
    |> Enum.find(fn x -> elem(x, 1) == start end)
    |> elem(0)
    |> Enum.split(amount)

    crates
    |> List.update_at(start - 1, fn {_a, b} -> {leave, b} end)
    |> List.update_at(finish - 1, fn {a, b} -> {List.flatten([take | a]), b} end)
    |> remake2(t)
  end
end
