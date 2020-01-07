defmodule Day5.Operations do
  alias Day5.Instruction, as: Instruction
  alias Day5.Operations, as: Operations

  defmacro apply_operation(module, operation, args) do
    quote do: apply(unquote(module), unquote(operation), unquote(args))
  end

  @spec do_operation(Day5.t(), Instruction.t()) :: Day5.t()
  def do_operation(%Day5{sequence: sequence, input: input, output: output, pointer: pointer, length: length}, %Instruction{operation: {module, func}, params: params}) when module == Kernel do
    result = apply_operation(
      module,
      func,
      handle_params(Enum.drop(params, -1), sequence)
    )
    %Day5{sequence: handle_result(result, sequence, List.last(params)), input: input, output: output, pointer: pointer + 4, length: length}
  end

  def do_operation(%Day5{sequence: sequence, input: input, output: output, pointer: pointer, length: length}, %Instruction{operation: {module, func}, params: [{verb, _}]}) when module == Operations do
    case func do
      :store -> %Day5{sequence: List.replace_at(sequence, verb, input), input: input, output: output, pointer: pointer + 2, length: length}
      :output -> %Day5{sequence: sequence, input: input, output: output ++ [Enum.at(sequence, verb)], pointer: pointer + 2, length: length}
    end
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

  @spec handle_param({any, :immediate | :position}, any) :: any
  def handle_param({val, mode}, sequence) do
    case mode do
    :position -> Enum.at(sequence, val)
    :immediate -> val
    end
  end
end
