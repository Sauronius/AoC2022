defmodule OneTest do
  use ExUnit.Case

  setup context do
    if context[:files] do
      File.write!("test1.txt", """
      12
      453
      77
      23

      44
      5

      9999999
      1111111

      3
      """)

      File.write!("test2.txt", """
      1111
      1111
      1111

      2222
      2222

      33333

      444444

      9999999
      """)

      on_exit(fn ->
        File.rm!("test1.txt")
        File.rm!("test2.txt")
      end)
    end
  end

  @moduletag :files

  describe "show proper max sum" do
    test "t1" do
      assert One.most_calories("test1.txt") == 11111110
    end

    test "t2" do
      assert One.most_calories("test2.txt") == 9999999
    end
  end

  describe "show proper top3 sum" do
    test "test1" do
      assert One.top_three_calories("test1.txt") == 11111724
    end

    test "test2" do
      assert One.top_three_calories("test2.txt") == 10477776
    end
  end
end
