defmodule BoardTest do
  use ExUnit.Case

  test "marks a position on the board" do
    assert make_move_on_empty_board(0, "x") == ["x", "", "", "", "", "", "", "", ""]
  end

  test "board is unchanged if position is invalid" do
    assert make_move_on_empty_board(10, "x") == empty_board
  end

  test "board is unchanged if position is negative" do
    assert make_move_on_empty_board(-1, "x") == empty_board
  end

  test "board is unchanged if position is taken" do
    board_with_one_move = make_move_on_empty_board(0, "x")
    assert Board.make_move(0, "o", board_with_one_move) == board_with_one_move
  end

  test "returns the available moves" do
    board_with_move = make_move_on_empty_board(5, "x")
    assert Board.available_moves(board_with_move) == [0, 1, 2, 3, 4, 6, 7, 8]
  end

  test "returns the rows for 3x3" do
    assert Board.rows(empty_board) == [["", "", ""],
                                       ["", "", ""],
                                       ["", "", ""]]
  end

  test "returns the rows for 4x4" do
    assert Board.rows(Board.new(4)) == [["", "", "", ""],
                                        ["", "", "", ""],
                                        ["", "", "", ""],
                                        ["", "", "", ""]]
  end
  defp empty_board(), do: Board.new
  defp make_move_on_empty_board(move, mark), do: Board.make_move(move, mark, Board.new)
end
