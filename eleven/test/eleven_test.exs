defmodule ElevenTest do
  use ExUnit.Case
  doctest Eleven

  test "greets the world" do
    assert Eleven.mitm("input.txt") == :world
  end
end
