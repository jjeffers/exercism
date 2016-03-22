defmodule DNA do



  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """

  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    cond do
      Enum.count(strand1) == Enum.count(strand2) -> _hamming_distance(strand1, strand2)
      true -> nil
    end
  end

  defp _hamming_distance([], _) do
    0
  end

  defp _hamming_distance([head1 | tail1], [head1 | tail2]) do
    hamming_distance(tail1, tail2)
  end


  defp _hamming_distance([head1 | tail1], [head2 | tail2]) do
    1 + hamming_distance(tail1, tail2)
  end

end
