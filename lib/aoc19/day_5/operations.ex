defmodule Day5.Operations do
  defmacro do_math(module, operation, args) do
    quote do: apply(unquote(module), unquote(operation), unquote(args))
  end

  def arithmetic(sequence, operation, [[first, second], verb], :position_mode) do
    result = do_math(
      Kernel,
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
