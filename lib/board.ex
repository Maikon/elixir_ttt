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

  def status(board), do: board |> check_status

  def check_status(board) do
    if winner(board) || draw(board) do
      :over
    else
      :ongoing
    end
  end

  def winner(board) do
    board
    |> all_lines
    |> Enum.any?(fn(line) ->
      Enum.all?(line, fn(position) -> matches_rest_of_the_positions(line, position) end)
    end)
  end

  def rows(board) do
    Enum.chunk(board, board |> length |> :math.sqrt |> round)
  end

  def available_moves(board) do
    Enum.with_index(board)
    |> Enum.filter_map(fn(position) -> position |> position_value |> is_free? end,
                       fn(position) -> position |> position_index end)
  end

  def current_mark(board) do
    turn_is_x?(board) |> get_mark
  end

  def moves_left(board) do
    Enum.count(board) - Enum.count(available_moves(board))
  end

  def last_move_mark(board) do
    board
    |> current_mark
    |> get_opponent
  end

  defp all_lines(board) do
    rows(board) ++ columns(board) ++ diagonals(rows(board))
  end

  defp get_opponent("x"), do: "o"
  defp get_opponent("o"), do: "x"

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
