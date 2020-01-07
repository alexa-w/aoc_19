defmodule Day5 do
  defstruct [:sequence, :input, :pointer, output: []]

  @type t :: %Day5{sequence: [integer], input: integer, output: [integer], pointer: integer}
end
