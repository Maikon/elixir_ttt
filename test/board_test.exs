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
    assert Board.mark_position(0, "o", board_with_one_move) == board_with_one_move
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

  test "finds winner in a row" do
    top_row    = ["x", "x", "x", "", "", "", "", "", ""]
    middle_row = ["", "", "", "x", "x", "x", "", "", ""]
    bottom_row = ["", "", "", "", "", "", "x", "x", "x"]

    assert winner_in?(top_row)    == true
    assert winner_in?(middle_row) == true
    assert winner_in?(bottom_row) == true
  end

  test "finds winner in a column" do
    first_column  = ["x", "", "", "x", "", "", "x", "", ""]
    second_column = ["", "x", "", "", "x", "", "", "x", ""]
    third_column  = ["", "", "x", "", "", "x", "", "", "x"]

    assert winner_in?(first_column)  == true
    assert winner_in?(second_column) == true
    assert winner_in?(third_column)  == true
  end

  test "finds winner in diagonals" do
    left_diagonal = ["x", "", "",
                     "", "x", "",
                     "", "", "x"]
    right_diagonal = ["", "", "x",
                      "", "x", "",
                      "x", "", ""]

    assert winner_in?(left_diagonal) == true
    assert winner_in?(right_diagonal) == true
  end

  test "returns false if there's no winner" do
    assert winner_in?(empty_board) == false
  end

  test "when the game is ongoing" do
    assert Board.status(empty_board) == :ongoing
  end

  test "when the game has a winner" do
    board_with_win  = ["x", "", "", "x", "", "", "x", "", ""]

    assert Board.status(board_with_win) == :over
  end

  test "when the game is a draw" do
    board_with_draw  = ["x", "o", "x", "x", "o", "x", "o", "x", "o"]

    assert Board.status(board_with_draw) == :over
  end

  test "knows the mark that goes next" do
    board_with_one_move = make_move_on_empty_board(0, "x")

    assert Board.current_mark(empty_board) == "x"
    assert Board.current_mark(board_with_one_move) == "o"
  end

  test "returns the mark of the last move made" do
    board  = ["x", "", "o", "", "", "", "", "", ""]
    assert Board.last_move_mark(board) == "o"
  end

  defp empty_board(), do: Board.new
  defp make_move_on_empty_board(position, mark), do: Board.mark_position(position, mark, Board.new)
  defp winner_in?(line), do: Board.winner(line)
end
