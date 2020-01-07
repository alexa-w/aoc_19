defmodule Day5.Operations do
  alias Day5.Instruction, as: Instruction

  defmacro apply_operation(module, operation, args) do
    quote do: apply(unquote(module), unquote(operation), unquote(args))
  end

  @spec do_operation(list(integer()), Instruction.t()) :: [integer()]
  def do_operation(sequence, %Instruction{operation: {module, func}, params: params}) do
    apply_operation(
      module,
      func,
      handle_params(Enum.drop(params, -1), sequence)
    )
    |> handle_result(sequence, List.last(params))
  end

  def handle_result(result, sequence, {verb, _}) do
    List.replace_at(sequence, verb, result)
  end

  def handle_params([param | []], sequence) do
    [handle_param(param, sequence)]
  end

  def handle_params([param | params], sequence) do
    [handle_param(param, sequence)] ++ handle_params(params, sequence)
  end

  def handle_param({val, mode}, sequence) do
    case mode do
    :position -> Enum.at(sequence, val)
    :immediate -> val
    end
  end


  def store(sequence, [param, input]) do
    {:ok}
  end
end
