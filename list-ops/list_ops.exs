defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.


  @spec count(list) :: non_neg_integer
  def count(l) do
    reduce(l, 0, fn(_, acc) -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reduce(l, [], fn(head, acc) -> [head | acc] end)
  end

  def map([], _) do
    []
  end

  @spec map(list, (any -> any)) :: list
  def map([head | tail], func) do
    [ func.(head) | map(tail, func) ]
  end

  def filter([], _) do
    []
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([head|tail], f) do
    case f.(head) do
      true -> [ head | filter(tail, f) ]
      _ -> filter(tail, f)
    end
  end

  def reduce([], acc, _) do
    acc
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([head|tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  def append([], b) do
    b
  end

  @spec append(list, list) :: list
  def append([head|tail], b) do
    [head | append(tail, b) ]
  end

  def concat([]) do
    []
  end

  @spec concat([[any]]) :: [any]
  def concat([head|tail]) do
    append( head, concat(tail))
  end
end
