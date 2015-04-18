defmodule Board do
  @three_by_three 3
  @four_by_four 4

  def new, do: board(@three_by_three)
  def new(@four_by_four), do: board(@four_by_four)

  def make_move(position, mark, board) do
    cond do
      position_is_valid?(position, board) -> List.replace_at(board, position, mark)
      true -> board
    end
  end

  defp board(size) do
    Enum.take(0..(size * size), (size * size))
  end

  defp position_is_valid?(position, board) do
     position_not_taken(board, position) && position_is_within_bounds(position)
  end

  defp position_not_taken(board, position) do
    Enum.at(board, position) |> is_number
  end

  defp position_is_within_bounds(position) do
    position >= 0
  end
end
