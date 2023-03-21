defmodule TenTest do
  use ExUnit.Case
  doctest Ten

  test "part_one" do
    assert Ten.part_one("input.txt") == :world
  end
  test "part_two" do
    assert Ten.part_two("input.txt") == :world
  end
end
