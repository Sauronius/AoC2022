defmodule FourTest do
  use ExUnit.Case
  doctest Four

  test "integer pairs" do
    assert Four.camp_cleanup("input.txt") == :world
  end

  test "part one" do
    assert Four.part_one("input.txt") == 5
  end

  test "part two" do
    assert Four.part_two("input.txt") == 5
  end
end
