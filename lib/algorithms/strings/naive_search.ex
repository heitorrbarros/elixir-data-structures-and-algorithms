defmodule Algorithms.Strings.NaiveSearch do
  @moduledoc """
  Provides a naive search algorithm for finding the first occurrence of a pattern in a text.

  This module implements a simple and straightforward approach to string searching. The algorithm
  checks for the presence of the pattern in the text by comparing each substring of the text with
  the pattern.

  ## Time Complexity
  The time complexity of the naive search algorithm is O(n * m), where `n` is the length of the text
  and `m` is the length of the pattern. In the worst case, the algorithm needs to check each position
  in the text and compare up to `m` characters for each position.

  ## Space Complexity
  The space complexity of the naive search algorithm is O(1), as it only requires a constant amount
  of extra space for variables and does not use any additional data structures that grow with the
  input size.

  ## Examples

      iex> Algorithms.Strings.NaiveSearch.search("sad", "sadbutsad")
      0

      iex> Algorithms.Strings.NaiveSearch.search("sad", "asbdcs")
      -1

      iex> Algorithms.Strings.NaiveSearch.search("de", "abcabcdef")
      6

      iex> Algorithms.Strings.NaiveSearch.search("de", "")
      -1

      iex> Algorithms.Strings.NaiveSearch.search("", "")
      -1

      iex> Algorithms.Strings.NaiveSearch.search("", "test")
      -1
  """
  @spec search(pattern :: String.t(), text :: String.t()) :: integer()
  def search(pattern, text) do
    pattern_size = String.length(pattern)
    text_size = String.length(text)

    cond do
      pattern_size == 0 -> -1
      text_size == 0 -> -1
      pattern_size > text_size -> -1
      true -> search(pattern, text, 0, pattern_size, text_size)
    end
  end

  defp search(_pattern, _text, i, pattern_size, text_size) when i > text_size - pattern_size do
    -1
  end

  defp search(pattern, text, i, pattern_size, text_size) do
    if match?(pattern, text, i, pattern_size) do
      i
    else
      search(pattern, text, i + 1, pattern_size, text_size)
    end
  end

  defp match?(pattern, text, left, pattern_size) do
    right = left + pattern_size - 1

    Enum.all?(left..right, fn i ->
      String.at(pattern, i - left) == String.at(text, i)
    end)
  end
end
