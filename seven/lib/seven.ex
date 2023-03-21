defmodule Seven do
  @moduledoc """
  Documentation for `Seven`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Seven.hello()
      :world

  """
  def no_space(file) do
    file
    |> File.read!()
    |> String.replace("\n", ",")
    |> String.split("$ ls")
    |> Enum.drop(1)
    |> Enum.map(&String.split(&1, ",", trim: true))
    |> Enum.map(fn x -> {Enum.count(x, fn y -> String.contains?(y, "$ cd ..") == :true end),
         Enum.count(x, fn y -> Regex.match?(~r/dir\s.*/, y) == :true end),
         Enum.reject(x, fn y -> String.contains?(y, "$ cd") == :true or Regex.match?(~r/dir\s.*/, y) == :true end)
          |> Enum.map(fn z -> z |> String.split(" ", trim: true) |> List.first() |> String.to_integer end)
          |> Enum.sum()} end)
    #|> total_size()
    |> find_smallest()
  end

  defp find_smallest(list) do
    total = Enum.reduce(list, 0, fn {_x, _y, z}, acc -> z + acc end)
    smallest(list, total - 40000000, [])
  end

  defp smallest([], _min, list), do: list |> Enum.reject(fn x -> x == :null end) |> Enum.sort(:asc) |> List.first()
  defp smallest([{_return_count, directories_count, size} | t], min, list) do
    cond do
      directories_count == 0 and size >= min -> smallest(t, min, [size | list])
      directories_count == 0 and size < min -> smallest(t, min, list)
      directories_count > 0 -> smallest(t, min, [check_smol(traverse(t, directories_count - 1, size), min) | list])
    end
  end

  defp traverse([{r_c, d_c, s} | next], subfolders_left, size) do
    cond do
      d_c > 0 -> traverse(next, subfolders_left + d_c - 1, size + s)
      subfolders_left == 0 -> size + s
      r_c > 0 -> traverse(next, subfolders_left - 1, size + s)
      :true -> size
    end
  end

  defp check_smol(smol, min) do
    if smol >= min do
      smol
    else
      :null
    end
  end

  #defp total_size(list, acc \\ 0, max \\ 100000)
  #defp total_size([], acc, _max), do: acc
  #defp total_size([{_return_count, directories_count, size} | t], acc, max) do
  #  cond do
  #    directories_count == 0 and size <= 100000 -> total_size(t, acc + size, max)
  #    directories_count > 0 and size <= 100000 -> total_size(t, acc + check(predict_future(t, directories_count - 1, size), max))
  #    size > 100000 -> total_size(t, acc, max)
  #  end
  #end

  defp predict_future(h = [{r_c, d_c, s} | next], subfolders_left, size) do
    cond do
      d_c == 0 && subfolders_left == 0 -> s + size
      r_c == 0 && d_c == 0 -> predict_future(h, 0, size)
      d_c == 0 && subfolders_left != 0 -> predict_future(next, subfolders_left - 1, size + s)
      d_c > 0 && subfolders_left == 0 -> predict_future(next, d_c - 1, size + s)
      d_c > 0 && subfolders_left > 0 -> predict_future(skip(next, d_c), subfolders_left - 1, predict_future(next, d_c - 1, size + s))
    end
  end

  defp skip(list = [{r_c, d_c, _s} | next], subfolders_left) do
    cond do
      subfolders_left == 0 -> list
      r_c > 0 -> skip(next, subfolders_left - r_c)
      d_c > 0 -> skip(next, subfolders_left + d_c)
      r_c == d_c -> list
    end
  end


  defp check(int, max) do
    if int > max do
      0
    else
      int
    end
  end
end
