defmodule Day5Test do
  use ExUnit.Case, async: true

  test "runs" do
    assert {:ok}
  end

  describe "output" do
    @describetag :acceptance

  end

  describe "parsing" do
    @describetag :unit

    test "modes" do
      assert Day5.Parse.modes(101) == [:position, :position, :immediate]
      assert Day5.Parse.modes(3) == [:position]
      assert Day5.Parse.modes(103) == [:immediate]
      assert Day5.Parse.modes(1002) == [:position, :immediate, :position]
    end
  end

  describe "operations" do
    @describetag :unit

    test "add" do
      assert Day5.arithmetic([1, 3, 4, 1, 99], :+, [[3, 4], 1], :position_mode) == [1, 100, 4, 1, 99]
    end

    test "multiply" do
      assert Day5.arithmetic([2, 3, 4, 1, 99], :*, [[3, 4, ], 1], :position_mode) == [2, 99, 4, 1, 99]
    end
  end

end
