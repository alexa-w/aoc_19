defmodule Day5Test do
  use ExUnit.Case

  setup_all do
    {:ok, input: File.read!("bin/day_5")}
  end

  test "runs", context do
    assert context.input
  end
end
