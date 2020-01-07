defmodule Day5.Parse do
  def parse(input) do
    input
    |> String.split(",")
    |> Enum.map(&(String.to_integer(&1)))
  end
end
