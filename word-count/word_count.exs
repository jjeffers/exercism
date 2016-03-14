defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do

    Enum.reduce(keys(sentence), %{}, fn(word, acc) ->
      Map.update(acc, word, 1, &(&1 + 1))
    end)
  end

  def keys(sentence) do
    String.split(sentence, [" ", "_"])
    |> Enum.map(fn(word) -> sanitize(word) end)
    |> Enum.reject(fn(word) -> String.length(String.strip(word)) == 0 end)

  end

  def sanitize(word) do
    String.replace(word, ~r/[&!@&%^:$,]/, "")
    |> String.strip
    |> String.downcase
  end
end
