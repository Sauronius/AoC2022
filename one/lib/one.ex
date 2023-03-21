defmodule One do
  @moduledoc """
  Documentation for `One`.
  """

  @doc """
  Find the amount of calories carried by each elf.

  ## Examples

      iex> One.calories_sum("input.txt")

  """
  @spec calories_sum(String.t()) :: list()
  def calories_sum(filename) do
    filename
    |> Path.expand()
    |> File.read!()
    |> String.splitter("\n\n")
    |> Stream.map(fn n -> String.split(n)
        |> Stream.map(&String.to_integer/1) end)
    |> Enum.map(&Enum.sum/1)
  end

  @doc """
  Find the highest amount of calories carried amongst the elves.

  ## Examples

      iex> One.most_calories("input.txt")

  """
  @spec most_calories(String.t()) :: integer()
  def most_calories(filename) do
    filename
    |> calories_sum()
    |> Enum.max()
  end

  @doc """
  Find the total calories carried by three elves with the highest individual count.

  ## Examples

      iex> One.top_three_calories("input.txt")

  """
  @spec top_three_calories(String.t()) :: integer()
  def top_three_calories(filename) do
    filename
    |> calories_sum()
    |> Enum.sort(:desc)
    |> Enum.slice(0..2)
    |> Enum.sum()
  end
end
