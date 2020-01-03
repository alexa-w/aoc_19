defmodule Day5 do
  def add(sequence, [[first, second], verb], :position_mode) do
    sum = Enum.fetch!(sequence, first) + Enum.fetch!(sequence, second)
    List.replace_at(sequence, verb, sum)
  end

  def multiply(sequence, [[first, second], verb], :position_mode) do
    product = Enum.fetch!(sequence, first) * Enum.fetch!(sequence, second)
    List.replace_at(sequence, verb, product)
  end
end
