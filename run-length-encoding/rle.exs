defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t

  def encode("") do
    ""
  end

  def encode(string) do
    string
    |> String.codepoints
    |> _encode(nil, 0, [])
    |> List.to_string
  end

  defp _encode([], current_char, char_count, encoded_blocks) do
    [ encoded_blocks | "#{char_count}#{current_char}"]
  end

  defp _encode([first_char | char_list], nil, _, encoded_blocks) do
    _encode(char_list, first_char, 1, encoded_blocks)
  end

  defp _encode([current_char | char_list], current_char, char_count, encoded_blocks) do
    _encode(char_list, current_char, char_count+1, encoded_blocks)
  end

  defp _encode([first_char | char_list], current_char, char_count, encoded_blocks) do
    _encode(char_list, first_char, 1, [ encoded_blocks | "#{char_count}#{current_char}" ])
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.scan(~r/([0-9]*)([A-Z])/, string, capture: :all_but_first)
    |> Enum.map_join(&_encode_block/1)
  end

  defp _encode_block([num, char]) do
    String.duplicate(char, String.to_integer(num))
  end

end
