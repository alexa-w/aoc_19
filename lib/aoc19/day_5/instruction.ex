defmodule Day5.Instruction do
  defstruct [:operation, :params]

  @modes_map %{
    48 => :position,
    49 => :immediate
  }

  @operations ["01": :+, "02": :*, "03": :store, "04": :output]

  def handle_modes({modes, operation}) do
    {
      Enum.map(String.to_charlist(modes), &(@modes_map[&1])),
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
