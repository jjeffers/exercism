defmodule Bob do
  def hey(input) do
    cond do
      is_silence?(input) -> "Fine. Be that way!"
      is_question?(input) -> "Sure."
      is_shouting?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  def is_silence?(input) do
    String.length(String.strip(input)) == 0
  end

  def is_question?(input) do
    String.last(input) == "?"
  end

  def is_shouting?(input) do
    is_all_caps?(input) && Regex.match?(~r/[\p{Lu}]/, input)
  end

  def is_all_caps?(input) do
    input == String.upcase(input)
  end

end
