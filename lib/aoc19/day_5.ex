defmodule Day5 do
  defstruct [:sequence, :input, :length, pointer: 0, output: []]

  @type t :: %Day5{sequence: [integer], input: integer, output: [integer], pointer: integer, length: integer}

  def marshal(sequence, input) do
    sequence
    |> Day5.Parse.parse
    |> to_struct(input)
    |> solve
  end

  def to_struct(sequence, input) do
    %Day5{sequence: sequence, input: input, length: Enum.count(sequence)}
  end

  def slice_instruction(%Day5{sequence: sequence, pointer: pointer}) do
    instruction = sequence
    |> Enum.at(pointer)
    |> Integer.mod(10)
    Enum.slice(sequence, pointer, get_length(instruction))
  end

  def get_length(instruction) do
    if instruction < 3, do: 4, else: 2
  end

  @spec solve(Day5.t()) :: [integer]
  def solve(%Day5{output: output, pointer: pointer, length: length}) when pointer == length do
    output
  end

  def solve(input_struct) do
    if Enum.at(Map.get(input_struct, :sequence), Map.get(input_struct, :pointer)) == 99 do
      Map.get(input_struct, :output)
    else
      solve(Day5.Operations.do_operation(input_struct, Day5.Instruction.handle_instruction(slice_instruction(input_struct))))
    end
  end

  def day_5_solution do
    File.read!('bin/day_5')
    |> marshal(1)
  end
end
