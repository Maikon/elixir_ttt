defmodule Board do
  @three_by_three 3
  @four_by_four 4

  def new, do: board(@three_by_three)
  def new(@four_by_four), do: board(@four_by_four)
  def new(custom_board), do: custom_board

  defp board(size) do
    Enum.take(0..(size * size), (size * size))
  end
end
