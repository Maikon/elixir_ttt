defmodule Board do
  @three_by_three 3
  @empty_position ""

  def new, do: board(@three_by_three)

  def mark_position(position, mark, board) do
    cond do
      position_is_valid?(position, board) -> List.replace_at(board, position, mark)
      true -> board
    end
  end

  def over?(board), do: winner(board) || draw(board)

  def winner(board) do
    all_lines = rows(board) ++ columns(board) ++ diagonals(rows(board))
    all_lines |> Enum.any?(&(Enum.all?(&1, fn(position) -> matches_rest_of_the_positions(&1, position) end)))
  end

  def rows(board) do
    Enum.chunk(board, board |> length |> :math.sqrt |> round)
  end

  def available_moves(board) do
    Enum.with_index(board)
    |> Enum.filter_map(&(is_free?(position_value(&1))),
                       &(position_index(&1)))
  end

  def current_mark(board) do
    turn_is_x?(board) |> get_mark
  end

  def moves_left(board) do
    Enum.count(board) - Enum.count(available_moves(board))
  end

  defp get_mark(true),  do: "x"
  defp get_mark(false), do: "o"

  defp turn_is_x?(board), do: rem(moves_left(board), 2) == 0

  defp draw(board), do: !winner(board) && available_moves(board) == []

  defp board(size) do
    List.duplicate(@empty_position, size * size)
  end

  defp columns(board) do
    rows(board) |> transpose
  end

  defp transpose([[]|_]), do: []
  defp transpose(rows) do
    [Enum.map(rows, &hd/1) | transpose(Enum.map(rows, &tl/1))]
  end

  defp diagonals([[a1, _, a3],
                 [_, b2, _],
                 [c1, _, c3]]), do: [[a1, b2, c3], [a3, b2, c1]]

  defp position_is_valid?(position, board) do
     is_free?(position, board) && position_is_within_bounds(position)
  end

  defp matches_rest_of_the_positions(line, position) do
    !is_free?(position) && position == List.first(line)
  end

  defp position_value({value, _}), do: value
  defp position_index({_, index}), do: index

  defp is_free?(position),        do: position == @empty_position
  defp is_free?(position, board), do: Enum.at(board, position, "invalid-index") |> is_free?

  defp position_is_within_bounds(position), do: position >= 0
end
