defmodule Board do
  @three_by_three 3
  @four_by_four 4
  @empty_position ""

  def new, do: board(@three_by_three)
  def new(@four_by_four), do: board(@four_by_four)

  def make_move(position, mark, board) do
    cond do
      position_is_valid?(position, board) -> List.replace_at(board, position, mark)
      true -> board
    end
  end

  def rows(board) do
    Enum.chunk(board, board |> length |> :math.sqrt |> round)
  end


  def available_moves(board) do
    Enum.with_index(board)
    |> Enum.filter_map(&(is_free?(position_value(&1))),
                       &(position_index(&1)))
  end

  defp board(size) do
    List.duplicate(@empty_position, size * size)
  end

  defp position_is_valid?(position, board) do
     is_free?(board, position) && position_is_within_bounds(position)
  end

  defp position_value({value, _}), do: value
  defp position_index({_, index}), do: index

  defp is_free?(position), do: position == @empty_position
  defp is_free?(board, position) do
    Enum.at(board, position, "invalid") |> String.length == 0
  end

  defp position_is_within_bounds(position) do
    position >= 0
  end
end
