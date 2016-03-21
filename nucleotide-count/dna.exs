defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    histogram(strand)
    |> Map.get(check_nucleotide(nucleotide), 0)
  end

  defp check_nucleotide(nucleotide) do
    case nucleotide do
      ?A -> nucleotide
      ?G -> nucleotide
      ?T -> nucleotide
      ?C -> nucleotide
      _ -> raise ArgumentError, message: "Invalid nucleotide: #{nucleotide}"
    end
  end

  defp map_nucleotide(nucleotide, histogram) do
    Map.update(histogram, check_nucleotide(nucleotide), 1, &(&1 + 1))
  end

  #def histogram(''), do: []
  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: Map
  def histogram(strand) do
    strand
    |> Enum.reduce(%{ ?A => 0, ?G => 0, ?T => 0, ?C => 0}, &map_nucleotide/2)
  end
end
