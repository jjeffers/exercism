defmodule DNA do
  @dna_to_rna_map %{ ?A => ?U, ?G => ?C, ?T => ?A, ?C => ?G }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, fn(nucleotide) -> @dna_to_rna_map[nucleotide] end)
  end
end
