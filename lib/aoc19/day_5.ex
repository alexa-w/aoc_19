defmodule Day5 do

  defmacro do_math(operation, args) do
    quote do: apply(Kernel, unquote(operation), unquote(args))
  end

  def arithmetic(sequence, operation, [[first, second], verb], :position_mode) do
    result = do_math(
      operation,
      [Enum.fetch!(sequence, first),
      Enum.fetch!(sequence, second)]
    )
    List.replace_at(sequence, verb, result)
  end

  def store(sequence, [param, input]) do
    {:ok}
  end
end
