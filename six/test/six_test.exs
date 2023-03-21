defmodule SixTest do
  use ExUnit.Case
  doctest Six

  test "greets the world" do
    assert Six.tuning_trouble("input.txt") == :world
  end
end
