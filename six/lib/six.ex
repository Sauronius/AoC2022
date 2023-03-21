defmodule Six do
  @moduledoc """
  Documentation for `Six`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Six.hello()
      :world

  """
  def tuning_trouble(filename) do
    filename
    |> File.read!()
    |> String.replace("\n", "")
    |> find_index2()
  end

  defp find_index(string = <<x::binary-size(4), _rest::binary>>, index \\ 4) do
    <<a, b, c, d>> = x
    if a != b && a != c && a != d && b != c && b != d && c != d do
      index
    else
      find_index(String.slice(string, 1..20000), index + 1)
    end
  end

  defp find_index2(string = <<x::binary-size(14), _rest::binary>>, index \\ 14) do
    <<_drop::binary-size(1), next::binary>> = string

    uniques = x
    |> String.graphemes()
    |> Enum.uniq()
    |> Enum.join()

    if Kernel.byte_size(x) == Kernel.byte_size(uniques) do
      index
    else
      find_index2(next, index + 1)
    end
  end
end
