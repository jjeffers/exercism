defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  defp a_match?(charset, charset), do: true
  defp a_match?(_, _), do: false

  defp charset_map(word) do
    word
    |> String.codepoints
    |> Enum.reduce(%{}, fn(char, acc) ->
      Map.update(acc, char, 1, &(&1 + 1))
    end)
  end

  defp anagram?(word, word), do: false

  defp anagram?(original_word, candidate) do
    a_match?(charset_map(original_word), charset_map(candidate))
  end

  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter(fn(candidate) -> anagram?(String.downcase(base), String.downcase(candidate)) end)
  end
end
