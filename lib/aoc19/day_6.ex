defmodule OrbitMap do
  def marshal(input) do
    String.split(input, "\n")
  end

  def checksum(input) do
    0
  end
end
