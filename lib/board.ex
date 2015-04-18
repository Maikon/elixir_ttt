defmodule Board do
  @three_by_three 3
  @four_by_four 4

  def new, do: board(@three_by_three)
  def new(@four_by_four), do: board(@four_by_four)

  def make_move(position, mark, board) when position >= 0, do: List.replace_at(board, position, mark)
  def make_move(_, _, board), do: board

  defp board(size) do
    Enum.take(0..(size * size), (size * size))
  end
end
