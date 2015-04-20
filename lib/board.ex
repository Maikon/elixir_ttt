defmodule Board do
  @three_by_three 3
  @four_by_four 4
  @empty_position ""

  def new, do: board(@three_by_three)
  def new(@four_by_four), do: board(@four_by_four)

  def mark_position(position, mark, board) do
    cond do
      position_is_valid?(position, board) -> List.replace_at(board, position, mark)
      true -> board
    end
  end

  def over?(board), do: winner(board) || draw(board)

  def winner(board) do
    all_lines = rows(board) ++ columns(board) ++ diagonals(rows(board))
    Enum.any?(all_lines, fn(line) -> Enum.all?(line, fn(position) -> matches_rest_of_the_positions(line, position) end) end)
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
    if moves_left_is_odd_number?(board) do
      "x"
    else
      "o"
    end
  end

  defp moves_left_is_odd_number?(board) do
    rem(moves_left(board), 2) == 0
  end

  defp moves_left(board) do
    Enum.count(board) - Enum.count(available_moves(board))
  end

  defp draw(board), do: !winner(board) && available_moves(board) == []

  defp board(size) do
    List.duplicate(@empty_position, size * size)
  end

  defp columns(board) do
    transpose(rows(board))
  end

  defp transpose([[]|_]), do: []
  defp transpose(rows) do
    [Enum.map(rows, &hd/1) | transpose(Enum.map(rows, &tl/1))]
  end

  defp diagonals([[a1, _, a3],
                 [_, b2, _],
                 [c1, _, c3]]), do: [[a1, b2, c3], [a3, b2, c1]]

  defp diagonals([[a1, _, _, a4],
                 [_, b2, b3, _],
                 [_, c2, c3, _],
                 [d1, _, _, d4]]), do: [[a1, b2, c3, d4], [a4, b3, c2, d1]]

  defp position_is_valid?(position, board) do
     is_free?(board, position) && position_is_within_bounds(position)
  end

  defp matches_rest_of_the_positions(line, position) do
    !is_free?(position) && position == List.first(line)
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
