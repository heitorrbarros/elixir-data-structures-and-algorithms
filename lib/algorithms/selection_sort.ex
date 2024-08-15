defmodule Algorithms.SelectionSort do
  @moduledoc """
  The `SelectionSort` module provides an implementation of the classic Selection Sort algorithm in Elixir.

  ## Overview

  Selection Sort is a simple comparison-based sorting algorithm. It works by dividing the list into two parts: the sorted part at the beginning and the unsorted part at the end. Initially, the sorted part is empty, and the unsorted part is the entire list.

  ## How It Works

  1. Start with the first element of the list.
  2. Find the smallest element in the unsorted portion of the list.
  3. Swap this smallest element with the first unsorted element.
  4. Move the boundary between the sorted and unsorted parts one element to the right.
  5. Repeat the process until the entire list is sorted.

  ## Performance

  - **Time Complexity**: O(n^2) in the worst, average, and best cases, where n is the number of items being sorted. This is because, for each element, it scans the remaining unsorted elements to find the smallest one.
  - **Space Complexity**: O(1), as Selection Sort is an in-place sorting algorithm, meaning it requires only a constant amount of additional memory space.

  ## Comparison with Bubble Sort

  While both Selection Sort and Bubble Sort have the same time complexity of O(n^2), Selection Sort generally performs fewer swaps. In Bubble Sort, elements are swapped every time they are out of order, which can result in many swaps. In contrast, Selection Sort only swaps once per pass through the list, which can make it more efficient in practice for certain datasets.

  ## Examples

      iex> Algorithms.SelectionSort.sort([10, 3, 1, 6, 7, 11, 29])
      [1, 3, 6, 7, 10, 11, 29]

      iex> Algorithms.SelectionSort.sort([])
      nil

      iex> Algorithms.SelectionSort.sort([5])
      [5]

      iex> Algorithms.BubbleSort.sort(1)
      nil

      iex> Algorithms.BubbleSort.sort("a")
      nil
  """

  require Logger

  @spec sort(list()) :: list() | nil
  def sort(list) when is_list(list) and list != [] do
    {time, sorted_list} =
      :timer.tc(fn ->
        sort(list, 0, length(list))
      end)

    Logger.debug("Execution time: #{time} microseconds")
    sorted_list
  end

  def sort(_) do
    Logger.debug("Invalid input")
    nil
  end

  defp sort(list, i, n) when i < n - 1 do
    {list, lowest_number_index} = find_lowest_number_index(list, i, i + 1, i)
    Logger.debug("Lowest number index: #{lowest_number_index}")

    list =
      if lowest_number_index != i do
        swap(list, i, lowest_number_index)
      else
        list
      end

    sort(list, i + 1, n)
  end

  defp sort(list, i, _n) do
    Logger.info("Total iterations: #{i}")
    list
  end

  defp find_lowest_number_index(list, i, n, lowest_number_index) when n < length(list) do
    if Enum.at(list, n) < Enum.at(list, lowest_number_index) do
      find_lowest_number_index(list, i, n + 1, n)
    else
      find_lowest_number_index(list, i, n + 1, lowest_number_index)
    end
  end

  defp find_lowest_number_index(list, _i, _n, lowest_number_index),
    do: {list, lowest_number_index}

  defp swap(list, i, n) do
    item1 = Enum.at(list, i)
    item2 = Enum.at(list, n)

    Logger.debug("Swapping #{item1} with #{item2}")

    list
    |> List.replace_at(i, Enum.at(list, n))
    |> List.replace_at(n, Enum.at(list, i))
  end
end
