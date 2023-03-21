defmodule Eight do
  @moduledoc """
  Documentation for `Eight`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Eight.hello()
      :world

  """
  def treetop_tree_house(file) do
    rows = file
    |> File.read!()
    |> String.split("\n")
    |> Stream.map(fn x -> Regex.split(~r{}, x, trim: true) end)
    |> Stream.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.reject(fn x -> x == [] end)
    |> Enum.to_list()

    cols = rows
    |> Enum.map(&List.wrap/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.with_index()

    rows_with_index = rows
    |> Enum.with_index()

    {cols, rows_with_index}
  end

  def part_1(filename) do
    {cols, rows_with_index} = filename
    |> treetop_tree_house()

    outer1 = rows_with_index
    |> List.first()
    |> elem(0)
    |> Enum.count()
    |> Kernel.*(2)

    outer_total = cols
    |> List.first()
    |> elem(0)
    |> Enum.count()
    |> Kernel.*(2)
    |> Kernel.+(outer1)
    |> Kernel.-(4)

    r1 = interior(rows_with_index)
    |> List.flatten()

    c1 = cols
    |> interior()
    |> List.flatten()
    |> Enum.map(fn {x, y} -> {y, x} end)

    r1 ++ c1
    |> Enum.sort()
    |> Enum.dedup()
    |> Enum.count()
    |> Kernel.+(outer_total)
  end

  def part_2(filename) do
    {c_i, r_i} = filename
    |> treetop_tree_house()

    range_row = r_i
    |> interior_2()
    |> Enum.map(fn x -> Enum.chunk_every(x, 2)
      |> Enum.map(fn [{a, b, y}, {_, _, z}] -> {a, b, y, z} end) end)
    |> List.flatten()
    |> Enum.sort() |> IO.inspect()

    range_col = c_i
    |> interior_2()
    |> Enum.map(fn x -> Enum.chunk_every(x, 2)
      |> Enum.map(fn [{a, b, y}, {_, _, z}] -> {b, a, y, z} end) end)
    |> List.flatten()
    |> Enum.sort() |> IO.inspect()

    range_row
    |> Enum.zip_reduce(range_col, [], fn {_, _, a, b}, {_, _, c, d}, acc -> [a * b * c * d | acc] end)
    |> Enum.max()
  end

  defp interior(list) do
    list
    |> List.delete_at(0)
    |> List.delete_at(-1)
    |> Enum.map(fn {x, index} -> {x |> Enum.zip(Stream.iterate(0, &(&1 + 1)) |> Enum.take(Enum.count(x))),index} end)
    |> Enum.map(fn {x, index} -> visible_trees(x, index, elem(List.first(x), 0))
         ++ visible_trees(Enum.reverse(x), index, elem(List.first(Enum.reverse(x)), 0))
        |> Enum.dedup() end)
  end

  defp visible_trees(list, index, highest, visible_list \\ [])
  defp visible_trees([], _, _, visible_list), do: visible_list
  defp visible_trees([{h, i} | t], index, highest, visible_list) do
    if h > highest do
      visible_trees(t, index, h, [{i ,index} | visible_list])
    else
      visible_trees(t, index, highest, visible_list)
    end
  end

  defp interior_2(list) do
    list
    |> Enum.map(fn {x, index} -> {x |> Enum.zip(Stream.iterate(0, &(&1 + 1)) |> Enum.take(Enum.count(x))),index} end)
    |> Enum.map(fn {x, index} -> range_of_sight(x, index) ++ range_of_sight(Enum.reverse(x), index)
        |> Enum.sort() end)
  end

  defp range_of_sight(list, index, visible_list \\ [])
  defp range_of_sight([], _, visible_list), do: visible_list
  defp range_of_sight([{h, i} | t], index, visible_list) do
    if t != [] do
      range_of_sight(t, index, [{i, index, range_helper(t, h, 1)} | visible_list])
    else
      range_of_sight(t, index, [{i, index, 0} | visible_list])
    end
  end

  defp range_helper([{h, _i} | t], height, range) do
    cond do
      t == [] -> range
      h < height -> range_helper(t, height, range + 1)
      :true -> range
    end
  end
end
