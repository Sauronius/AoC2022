defmodule ThreeTest do
  use ExUnit.Case

  test "greets the world" do
    assert Three.task2("input.txt") == :world
  end
end
