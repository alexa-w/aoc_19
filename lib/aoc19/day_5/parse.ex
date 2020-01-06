defmodule Day5.Parse do

  @modes_map %{
    48 => :position,
    49 => :immediate
  }

  @one_param_instructions ["03", "04"]

  def modes(instruction) do
    Integer.to_string(instruction)
    |> pad_leading
    |> slice
    |> String.to_charlist
    |> to_modes
  end

  def one_param_instruction?(instruction) do
    Enum.any? @one_param_instructions, &(&1 == instruction)
  end

  def pad_leading(instruction) do
    String.pad_leading(instruction, 5, "0")
  end

  def slice(instruction) do
    String.split_at(instruction, 3)
    |> take_modes
  end

  def take_modes({modes, instruction}) do
    one_param_instruction?(instruction)
    |> case do
      true -> String.last(modes)
      false -> modes
    end
  end

  def to_modes([param | []]) do
    [@modes_map[param]]
  end

  def to_modes([param | params]) do
    [@modes_map[param]] ++ to_modes(params)
  end
end
