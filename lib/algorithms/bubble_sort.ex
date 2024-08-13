defmodule Algorithms.BubbleSort do
  @moduledoc """
  The `BubbleSort` module provides an implementation of the classic Bubble Sort algorithm in Elixir.

  ## Overview

  Bubble Sort is a simple sorting algorithm that repeatedly steps through the list to be sorted,
  compares each pair of adjacent items, and swaps them if they are in the wrong order. The pass
  through the list is repeated until the list is sorted. The algorithm gets its name because smaller
  elements "bubble" to the top of the list.

  ## How It Works

  1. Start at the beginning of the list.
  2. Compare the first two elements. If the first is greater than the second, swap them.
  3. Move to the next pair of elements and repeat the comparison and swap if necessary.
  4. Continue this process until the end of the list is reached. This completes one pass.
  5. Repeat the entire process for the remaining unsorted portion of the list.
  6. The algorithm stops when a pass is completed without any swaps, indicating that the list is sorted.

  ## Performance

  - **Time Complexity**: O(n^2) in the worst and average cases, where n is the number of items being sorted.
  - **Space Complexity**: O(1), as Bubble Sort is an in-place sorting algorithm.

  ## Examples

      iex> Algorithms.BubbleSort.sort([10, 3, 1, 6, 7, 11, 29])
      [1, 3, 6, 7, 10, 11, 29]

      ### Testing the edges ;)
      iex> Algorithms.BubbleSort.sort(nil)
      nil

      iex> Algorithms.BubbleSort.sort(1)
      nil

      iex> Algorithms.BubbleSort.sort("a")
      nil

  ## Usage

  To use the Bubble Sort algorithm, simply call the `sort/1` function with a list of elements:

      iex> Algorithms.BubbleSort.sort([5, 2, 9, 1, 5, 6])
      [1, 2, 5, 5, 6, 9]

  The function will return the sorted list. If the input is not a list or is an empty list, the function will return `nil`.

  Happy sorting!
  """

  require Logger

  @doc """

  BubbleSort

  ## Examples

      iex> Algorithms.BubbleSort.sort([10, 3, 1, 6, 7, 11, 29])
      [1, 3, 6, 7, 10, 11, 29]

      ### Testing the edges ;)
      iex> Algorithms.BubbleSort.sort(nil)
      nil

      iex> Algorithms.BubbleSort.sort(1)
      nil

      iex> Algorithms.BubbleSort.sort("a")
      nil

  """
  def sort(list) when is_list(list) and list != [] do
    {time, sorted_list} =
      :timer.tc(fn ->
        unsorted_until_index = length(list) - 1
        sort(list, unsorted_until_index, false)
      end)

    Logger.debug("Execution time: #{time} microseconds")
    sorted_list
  end

  def sort(_) do
    Logger.debug("Invalid input")
    nil
  end

  defp sort(list, _unsorted_until_index, true), do: list

  defp sort(list, unsorted_until_index, false) do
    {new_list, sorted} =
      Enum.reduce(0..(unsorted_until_index - 1), {list, true}, fn i, {acc, sorted} ->
        if Enum.at(acc, i) > Enum.at(acc, i + 1) do
          item1 = Enum.at(acc, i)
          item2 = Enum.at(acc, i + 1)
          Logger.debug("Swapping #{item1} with #{item2}")

          acc =
            acc
            |> List.replace_at(i, item2)
            |> List.replace_at(i + 1, item1)

          {acc, false}
        else
          {acc, sorted}
        end
      end)

    sort(new_list, unsorted_until_index - 1, sorted)
  end
end
