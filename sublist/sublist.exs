defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """


  def compare(a, a) do
    :equal
  end

  def compare(a, b) do
    cond do
      sublist?(a, b, a, b) -> :sublist
      sublist?(b, a, b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?([], _, _, _), do: true
  defp sublist?(_, [], _, _), do: false

  defp sublist?([head | a_tail], [head | b_tail], initial_a, initial_b) do
    sublist?(a_tail, b_tail, initial_a, initial_b)
  end

  defp sublist?(_, _, initial_a, [_ | initial_b_tail]) do
    sublist?(initial_a, initial_b_tail, initial_a, initial_b_tail)
  end
end
