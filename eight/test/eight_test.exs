defmodule EightTest do
  use ExUnit.Case
  doctest Eight

  test "part1" do
    assert Eight.part_1("input.txt") == :world
  end
  test "part2" do
    assert Eight.part_2("input.txt") == :world
  end
end
