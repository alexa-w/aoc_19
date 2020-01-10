defmodule Day5.Operations do
  alias Day5.Instruction, as: Instruction
  alias Day5.Operations, as: Operations

  defmacro apply_operation(module, operation, args) do
    quote do: apply(unquote(module), unquote(operation), unquote(args))
  end

  @spec do_operation(Day5.t(), Instruction.t()) :: Day5.t()
  def do_operation(%Day5{sequence: sequence, input: input, output: output, pointer: pointer, length: length}, %Instruction{operation: {module, func}, params: params}) when module == Kernel do
    IO.inspect(sequence)
    IO.inspect(func)
    IO.inspect(handle_params(params, sequence))
    IO.inspect(pointer)
    result = apply_operation(
      module,
      func,
      handle_params(Enum.drop(params, -1), sequence)
    )
    %Day5{sequence: handle_result(result, sequence, List.last(params)), input: input, output: output, pointer: pointer + 4, length: length}
  end

  def do_operation(%Day5{sequence: sequence, input: input, output: output, pointer: pointer, length: length}, %Instruction{operation: {module, func}, params: params}) when module == Operations do
    {verb, _} = List.first(params)
    IO.inspect(sequence)
    IO.inspect(func)
    IO.inspect(handle_params(params, sequence))
    IO.inspect(pointer)
    IO.puts("<____________________>")
    case func do
      :store -> %Day5{sequence: List.replace_at(sequence, verb, input), input: input, output: output, pointer: pointer + 2, length: length}
      :output -> %Day5{sequence: sequence, input: input, output: output ++ [handle_param(List.first(params), sequence)], pointer: pointer + 2, length: length}
      :jump_if_true -> %Day5{sequence: sequence, input: input, output: output, pointer: jump_if_true(sequence, pointer, params), length: length}
      :jump_if_false -> %Day5{sequence: sequence, input: input, output: output, pointer: jump_if_false(sequence, pointer, params), length: length}
      :less_than -> %Day5{sequence: less_than(sequence, params), input: input, output: output, pointer: pointer + 4, length: length}
      :equals -> %Day5{sequence: equals(sequence, params), input: input, output: output, pointer: pointer + 4, length: length}
    end
  end

  def jump_if_true(sequence, pointer, [condition, direction]) do
    case handle_param(condition, sequence) do
      0 -> pointer + 3
      _ -> handle_param(direction, sequence)
    end
  end

  def jump_if_false(sequence, pointer, [condition, direction]) do
    case handle_param(condition, sequence) do
      0 -> handle_param(direction, sequence)
      _ -> pointer + 3
    end
  end

  def less_than(sequence, [first, second, {direction, _}]) do
    if handle_param(first, sequence) < handle_param(second, sequence) do
      List.replace_at(sequence, direction, 1)
    else
      List.replace_at(sequence, direction, 0)
    end
  end

  def equals(sequence, [first, second, {direction, _}]) do
    if handle_param(first, sequence) == handle_param(second, sequence) do
      List.replace_at(sequence, direction, 1)
    else
      List.replace_at(sequence, direction, 0)
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
