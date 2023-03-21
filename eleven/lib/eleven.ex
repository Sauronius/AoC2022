defmodule Eleven do
  @moduledoc """
  Documentation for `Eleven`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Eleven.hello()
      :world

  """
  def mitm(input) do
    input
    |> File.read!()
    |> String.split("\n\n", trim: true)
  end
end
