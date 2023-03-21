defmodule NineTest do
  use ExUnit.Case
  doctest Nine

  test "part 1" do
    assert Nine.part_one("input.txt") == :world
  end
  test "part 2" do
    assert Nine.part_two("input.txt") == :world
  end
end
