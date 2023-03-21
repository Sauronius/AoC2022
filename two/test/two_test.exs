defmodule TwoTest do
  use ExUnit.Case

  setup context do
    if context[:files] do
      File.write!("test1.txt", """
      A X
      B Y
      C Z
      A Z
      C X
      A Y
      A Z
      B X
      B Y
      B Z
      C X
      C Y
      C Z
      """)

      File.write!("test2.txt", """
      B Z
      A Z
      C Z
      """)

      on_exit(fn ->
        File.rm!("test1.txt")
        File.rm!("test2.txt")
      end)
    end
  end

  @moduletag :files

  describe "show proper score" do
    test "t1" do
      assert Two.rps("test1.txt") == 66
    end

    test "t2" do
      assert Two.rps("test2.txt") == 24
    end
  end

  describe "show proper points corrected" do
    test "test1" do
      assert Two.rps2("test1.txt") == 67
    end

    test "test2" do
      assert Two.rps2("test2.txt") == 24
    end
  end
end
