defmodule SevenTest do
  use ExUnit.Case
  doctest Seven

  test "greets the world" do
    assert Seven.no_space("files/input.txt") == :world
  end
end
