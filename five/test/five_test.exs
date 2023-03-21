defmodule FiveTest do
  use ExUnit.Case
  doctest Five

  test "greets the world" do
    assert Five.supply_stacks("input.txt") == :world
  end
end
