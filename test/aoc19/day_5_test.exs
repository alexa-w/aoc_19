defmodule Day5Test do
  use ExUnit.Case, async: true

  test "runs", context do
    assert {:ok}
  end

  describe "output" do
    @describetag :acceptance

  end

  describe "operations" do
    @describetag :unit

    test "add" do
      assert Day5.add([1, 3, 4, 1, 99], [[3, 4], 1], :position_mode) == [1, 100, 4, 1, 99]
    end

    test "multiply" do
      assert Day5.multiply([2, 3, 4, 1, 99], [[3, 4, ], 1], :position_mode) == [2, 99, 4, 1, 99]
    end

  end

end
