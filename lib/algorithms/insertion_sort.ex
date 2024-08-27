defmodule Algorithms.InsertionSort do
  require Logger

  @moduledoc """
  Provides an implementation of the insertion sort algorithm.

  Insertion sort is a simple sorting algorithm that builds the final sorted array one item at a time.
  It is much less efficient on large lists than more advanced algorithms such as quicksort, heapsort, or merge sort.

  ## Time Complexity
  - Worst-case: O(n^2)
  - Best-case: O(n) when the list is already sorted
  - Average-case: O(n^2)

  ## Space Complexity
  - O(1) additional space

  ## Examples

      iex> Algorithms.InsertionSort.sort([10, 3, 1, 6, 7, 11, 29])
      [1, 3, 6, 7, 10, 11, 29]

      iex> Algorithms.InsertionSort.sort([4, 3, 2, 1])
      [1, 2, 3, 4]

      iex> Algorithms.InsertionSort.sort([1, 2, 3, 4])
      [1, 2, 3, 4]

      iex> Algorithms.InsertionSort.sort([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5])
      [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

      iex> Algorithms.InsertionSort.sort([])
      []

      iex> Algorithms.InsertionSort.sort(nil)
      nil
  """
  @spec sort(list :: list(integer) | nil) :: list(integer)
  def sort(list) when is_list(list) do
    {time, sorted_list} =
      :timer.tc(fn ->
        list
        |> Enum.reduce([], fn value, acc ->
          insert_sorted(acc, value)
        end)
      end)

    Logger.debug("Execution time: #{time} microseconds")
    sorted_list
  end

  def sort(_) do
    nil
  end

  defp insert_sorted([], value), do: [value]

  defp insert_sorted([head | _tail] = sorted_list, value) when value <= head do
    [value | sorted_list]
  end

  defp insert_sorted([head | tail], value) do
    [head | insert_sorted(tail, value)]
  end
end
