defmodule Ten do
  @moduledoc """
  Documentation for `Ten`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Ten.hello()
      :world

  """
  def cathode_ray_tube(input) do
    input
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def part_one(input) do
    list = input
    |> cathode_ray_tube()
    |> reg_and_cycle(1, 0)

    for i <- [20, 60, 100, 140, 180, 220] do
      Enum.find(list, nil, fn {_, a} -> a == i end) |> elem(0) |> Kernel.*(i)
    end
    |> Enum.sum()
  end

  @spec part_two(any) :: any()
  def part_two(input) do
    list = input
    |> cathode_ray_tube()
    |> reg_and_cycle(1, 0)
    |> Enum.chunk_every(40)
    |> Enum.with_index(fn element, index -> {element, index * 40} end)
    |> Enum.map(&draw_sign(&1, []))
    |> IO.inspect()

    for x <- list, into: "" do
      x
      |> Enum.join()
      |> Kernel.<>("\n")
    end
    |> IO.puts()
  end

  defp reg_and_cycle(instr, register, cycle, list \\ [])
  defp reg_and_cycle([], _, _, list), do: list |> List.flatten |> Enum.map(fn {_x, y, z} -> {y, z} end) |> Enum.reverse
  defp reg_and_cycle([instr | tail], register, cycle, list) do
    l = [{nreg, _preg, ncyc} | _t] = instruction(instr, register, cycle)
    reg_and_cycle(tail, nreg, ncyc, [l | list])
  end

  defp instruction("noop", register, cycle) do
    [{register, register, cycle + 1}]
  end

  defp instruction(b, register, cycle) do
    [_, value] = b
    |> String.split(" ", trim: true)

    int_value = value
    |> String.to_integer()

    [{register + int_value, register, cycle + 2}, {register, register, cycle + 1}]
  end

  defp draw_sign(list, output)
  defp draw_sign({[], _}, output), do: output |> Enum.reverse()
  defp draw_sign({[{reg, cycle} | t], offset}, output) do
    if abs(cycle - offset - reg - 1) <= 1 do
      draw_sign({t, offset}, ["#" | output])
    else
      draw_sign({t, offset}, ["." | output])
    end
  end
end
