defmodule Day5Test do
  use ExUnit.Case, async: true

  test "runs" do
    assert {:ok}
  end

  describe "output" do
    @describetag :acceptance

  end

  describe "instruction" do
    @describetag :unit

    test "output" do
      assert Day5.Instruction.handle_instruction([1002, 1, 3, 2]) == %Day5.Instruction{
        operation: :*,
        params: [
          {1, :position},
          {3, :immediate},
          {2, :position}
        ]
      }

      assert Day5.Instruction.handle_instruction([103, 5]) == %Day5.Instruction{
        operation: :store,
        params: [
          {5, :immediate}
        ]
      }
    end
  end

  describe "parsing" do
    @describetag :unit

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
