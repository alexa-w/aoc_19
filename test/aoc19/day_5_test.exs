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

    assert Day5.marshal("1002,7,5,3,3,4,101,-5,2,1,4,1,4,4,99,103,2,4,9", 0) == [0, 0]
  end

  describe "instruction" do
    @describetag :unit

    test "output" do
      assert Instruction.handle_instruction([1102, 1, 3, 2]) == %Instruction{
        operation: {Kernel, :*},
        params: [
          {1, :immediate},
          {3, :immediate},
          {2, :position}
        ]
      }

      assert Instruction.handle_instruction([3, 5]) == %Instruction{
        operation: {Operations, :store},
        params: [
          {5, :position}
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
      assert Operations.do_operation(%Day5{sequence: [1, 3, 4, 1, 99], input: 0, pointer: 4}, %Instruction{
        operation: {Kernel, :+},
        params: [
          {3, :position},
          {4, :position},
          {1, :position}
        ]
      }) == %Day5{sequence: [1, 100, 4, 1, 99], input: 0, pointer: 8}
    end

    test "multiply" do
      assert Operations.do_operation(%Day5{sequence: [102, 3, 4, 1, 99], input: 0, pointer: 0}, %Instruction{
        operation: {Kernel, :*},
        params: [
          {3, :immediate},
          {4, :position},
          {1, :position}
        ]
      }) == %Day5{sequence: [102, 297, 4, 1, 99], input: 0, pointer: 4}
    end

    test "store" do
      assert Operations.do_operation(%Day5{sequence: [3, 2, 99], input: 2, pointer: 2}, %Instruction{
        operation: {Operations, :store},
        params: [
          {2, :position}
        ]
      }) == %Day5{sequence: [3, 2, 2], input: 2, pointer: 4}
    end

    test "output" do
      assert Operations.do_operation(%Day5{sequence: [4, 2, 0, 99], input: 0, pointer: 0}, %Instruction{
        operation: {Operations, :output},
        params: [
          {2, :position}
        ]
      }) == %Day5{sequence: [4, 2, 0, 99], input: 0, output: [0], pointer: 2}

      assert Operations.do_operation(%Day5{sequence: [4, 2, 0, 99], input: 0, output: [0], pointer: 0}, %Instruction{
        operation: {Operations, :output},
        params: [
          {2, :position}
        ]
      }) == %Day5{sequence: [4, 2, 0, 99], input: 0, output: [0, 0], pointer: 2}
    end

    test "jump_if_true" do
      assert Operations.do_operation(%Day5{sequence: [5, 2, 0], input: 0, pointer: 0}, %Instruction{
        operation: {Operations, :jump_if_true},
        params: [
        {2, :position},
        {0, :position}
        ]
      }) == %Day5{sequence: [5, 2, 0], input: 0, output: [], pointer: 3}

      assert Operations.do_operation(%Day5{sequence: [1105, 2, 57], input: 0, pointer: 0}, %Instruction{
        operation: {Operations, :jump_if_true},
        params: [
          {2, :immediate},
          {57, :immediate}
        ]
      }) == %Day5{sequence: [1105, 2, 57], input: 0, output: [], pointer: 57}
    end
  end
end
