defmodule Day5.Instruction do
  defstruct [:operation, :params]

  alias Day5.Operations, as: Operations

  @modes_map %{
    48 => :position,
    49 => :immediate
  }

  @operations [
    "01": {Kernel, :+},
    "02": {Kernel, :*},
    "03": {Operations, :store},
    "04": {Operations, :output},
    "05": {Operations, :jump_if_true},
    "06": {Operations, :jump_if_false},
    "07": {Operations, :less_than},
    "08": {Operations, :equals}
  ]

  defp handle_modes({modes, operation}) do
    {
      modes
      |> String.reverse
      |> String.to_charlist
      |> Enum.map(&(@modes_map[&1])),
      operation
    }
  end

  @spec handle_instruction(nonempty_list(integer())) :: Day5.Instruction.t()
  def handle_instruction([instruction | params]) do
    {modes, operation} = Integer.to_string(instruction)
    |> String.pad_leading(Enum.count(params) + 2, "0")
    |> String.split_at(-2)
    |> handle_modes
    %Day5.Instruction{
      operation: @operations[String.to_atom(operation)],
      params: Enum.with_index(params)
      |> Enum.map(fn {param, i} -> {param, Enum.at(modes, i)} end)
    }
  end
end
