defmodule OrbitMap do

  defstruct [:input, cache: %{}]
  @type t :: %OrbitMap{input: [String.t()], cache: Map.t()}

  def marshal(input) do
    String.split(input, "\n")
    |> Enum.reduce(%{}, &to_cache/2)
  end

  def to_cache(orbit, storage) do
    [v, k] = orbit
    |> split
    Map.put(storage, String.to_atom(k), %{orbited: v})
  end

  def to_struct(cache, input) do
    %OrbitMap{input: input, cache: cache}
  end

  def checksum(cache) do
    cache
    |> Enum.reduce({0, cache}, &handle_reduce/2)
  end

  def handle_reduce(orbit, {count, storage}) do
    {new_count, new_storage} = accumulate(orbit, storage)
    {count + new_count, new_storage}
  end

  @spec accumulate({String.t(), %{orbited: String.t(), distance: integer}}, Map.t()) :: {integer, Map.t()}
  def accumulate({"COM", _}, cache) do
    {1, cache}
  end

  def accumulate({_, %{distance: d}}, cache) when not is_nil(d) do
    {d, cache}
  end

  def accumulate({orbiter, %{orbited: o}}, cache) do
    {distance, cache} = accumulate(Map.get(cache, String.to_atom(o)), cache)
    {distance + 1, put_in(cache, [orbiter, :distance], distance)}
  end

  def split(orbit) do
    String.split(orbit, ")")
  end

  def match(link, chain) do
    Enum.find(chain, &(matches?(link, split(&1))))
  end

  def matches?(link, [_, orbiter]) do
    link == orbiter
  end

  def solve_checksum(input) do
    input
    |> marshal
    |> checksum
  end
end
