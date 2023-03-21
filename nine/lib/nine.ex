defmodule Nine do
  @moduledoc """
  Documentation for `Nine`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Nine.hello()
      :world

  """
  def rope_bridge(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [a, b] -> [a, String.to_integer(b)] end)
  end

  def part_one(file) do
    file
    |> rope_bridge()
    |> positions({2500, 2500}, {2500, 2500}, [{2500, 2500}])
  end

  def part_two(file) do
    file
    |> rope_bridge()
    |> positions_2(Enum.map(0..9, fn _x -> {1000, 1000} end), [])
  end

  defp positions([], _, _ , list), do: list |> List.flatten |> Enum.sort() |> Enum.dedup() |> Enum.count()
  defp positions([[direction, moves] | t], h_p, t_p, list) do
    {nhp, ntp, l} = move(h_p, t_p, direction, moves, [])
    positions(t, nhp, ntp, [l | list])
  end

  defp positions_2([], _ , list), do: list |> List.flatten |> Enum.sort |> Enum.dedup() |> IO.inspect() |> Enum.count()
  defp positions_2([[direction, moves] | t], knots, list) do
    {n_k, l} = mov_snek(knots, direction, moves)
    positions_2(t, n_k, [l | list])
  end

  defp move(h = {a, b}, t, direction, left, list) do
    if left == 0 do
      {h, t, list}
    else
      case direction do
        "U" -> nh = {a, b + 1}
          if touching?(nh, t) == true do
            move(nh, t, direction, left - 1, [t | list])
          else
            move(nh, h, direction, left - 1, [h | list])
          end
        "D" -> nh = {a, b - 1}
          if touching?(nh, t) == true do
            move(nh, t, direction, left - 1, [t | list])
          else
            move(nh, h, direction, left - 1, [h | list])
          end
        "L" -> nh = {a - 1, b}
          if touching?(nh, t) == true do
            move(nh, t, direction, left - 1, [t | list])
          else
            move(nh, h, direction, left - 1, [h | list])
          end
        "R" -> nh = {a + 1, b}
          if touching?(nh, t) == true do
            move(nh, t, direction, left - 1, [t | list])
          else
            move(nh, h, direction, left - 1, [h | list])
          end
      end
    end
  end

  defp step(list, first_elem, prevh, direction, prev_moved \\ :false, st \\ 1, output \\ [])
  defp step([], _, _, _, _, _, list) do
    list |> List.flatten() |> Enum.reverse()
  end
  defp step([h | tail], element, prevh, direction, prev_moved, s, output) do
    {uh, ut, _list} = move(element, h, direction, s, [])
    cond do
      prev_moved == :false -> p_m = :true
        step(tail, ut, h, direction, p_m, 1, [[ut, uh] | output])
      touching?(element, h) -> step(tail, h, h, direction, prev_moved, 1, [h | output])
      :true -> step(tail, clamp_adjust(element, h), h, direction, prev_moved, 1, [clamp_adjust(element, h) | output])
    end
  end

  defp mov_snek(_knots = [h | t], direction, moves, list \\ []) when moves > 0 do
    mov_snek(step(t, h, h, direction), direction, moves - 1,[List.last(step(t, h, h, direction)) | list])
  end

  defp mov_snek(knots, _direction, _moves, list) do
    {knots, list}
  end

  def clamp_adjust({hx, hy}, {tx, ty}), do: {clamp_adjust(hx, tx), clamp_adjust(hy, ty)}
  def clamp_adjust(h, t), do: t + min(max(h - t, -1), 1)

  defp touching?({a, b}, {c, d}) do
    if abs(a) - abs(c) <= 1 and abs(a) - abs(c) >= -1 and abs(b) - abs(d) <= 1 and abs(b) - abs(d) >= -1 do
      :true
    else
      :false
    end
  end
end
