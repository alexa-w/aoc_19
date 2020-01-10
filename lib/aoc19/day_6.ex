defmodule OrbitMap do

  defstruct [:input, count: 0]
  @type t :: %OrbitMap{input: [String.t()], count: integer}

  def marshal(input) do
    String.split(input, "\n")
  end

  def checksum(input) do
    Enum.reduce(input, 0, fn(orbit, count) -> count + OrbitMap.accumulate(orbit, input) end)
  end

  def accumulate(orbit, input) do
    1
  end
end
