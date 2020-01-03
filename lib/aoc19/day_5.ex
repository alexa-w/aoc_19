defmodule Day5 do
  @doc """

  """
  def add(sequence, [[first, second], verb], :position_mode) do
    sum = Enum.fetch!(sequence, first) + Enum.fetch!(sequence, second)
    List.replace_at(sequence, verb, sum)
  end
end
