defmodule Day5Test do
  use ExUnit.Case, async: true
  alias Day5.Operations, as: Operations
  alias Day5.Parse, as: Parse
  alias Day5.Instruction, as: Instruction

  test "runs" do
    assert {:ok}
  end

  describe "output" do
    @describetag :acceptance

  end

  describe "instruction" do
    @describetag :unit

    test "output" do
      assert Instruction.handle_instruction([1002, 1, 3, 2]) == %Instruction{
        operation: {Kernel, :*},
        params: [
          {1, :position},
          {3, :immediate},
          {2, :position}
        ]
      }

      assert Instruction.handle_instruction([103, 5]) == %Instruction{
        operation: {Operations, :store},
        params: [
          {5, :immediate}
        ]
      }
    end
  end

  describe "parsing" do
    @describetag :unit

    test "parse" do
      assert Parse.parse("1,2,3,4,5") == [1, 2, 3, 4, 5]
    end
  end

  describe "operations" do
    @describetag :unit

    test "add" do
      assert Operations.arithmetic([1, 3, 4, 1, 99], :+, [[3, 4], 1], :position_mode) == [1, 100, 4, 1, 99]
    end

    test "multiply" do
      assert Operations.arithmetic([2, 3, 4, 1, 99], :*, [[3, 4, ], 1], :position_mode) == [2, 99, 4, 1, 99]
    end
  end

end
