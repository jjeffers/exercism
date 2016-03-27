defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> parse_number
    |> List.to_string
  end

  defp parse_number(raw) do
    raw
    |> check_digits
    |> check_length
  end

  defp check_digits(raw) do
    cond do
      Regex.match?(~r/[a-z]/, raw) -> invalid_code
      true -> Regex.scan(~r/\d/, raw)
    end
  end

  defp check_length(numbers) do
    cond do
      numbers |> length == 11 -> handle_country_code(numbers)
      numbers |> length == 10 -> numbers
      true -> invalid_code
    end
  end

  defp handle_country_code([["1"]|numbers]) do
    numbers
  end

  defp handle_country_code([_|numbers]), do: invalid_code

  defp invalid_code do
    Enum.map(0..9, fn(x) -> "0" end)
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> parse_number
    |> Enum.take(3)
    |> List.to_string
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    { area_code, rest } = raw |> number |> String.split_at(3)
    { prefix, line_number } = String.split_at(rest, 3)
    "(#{area_code}) #{prefix}-#{line_number}"
  end


end
