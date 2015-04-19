defmodule BoardTest do
  use ExUnit.Case

  test "supports 3x3 by default" do
    assert Board.new == ["", "", "",
                         "", "", "",
                         "", "", ""]
  end

  test "size can vary" do
    assert Board.new(4) == ["", "", "", "",
                            "", "", "", "",
                            "", "", "", "",
                            "", "", "", ""]
  end

  test "marks a position on the board" do
    assert Board.make_move(0, "x", Board.new) == ["x", "", "",
                                                   "", "", "",
                                                   "", "", ""]
  end

  test "returns board unchanged if position is invalid" do
    assert Board.make_move(10, "x", Board.new) == ["", "", "",
                                                   "", "", "",
                                                   "", "", ""]
  end

  test "returns board unchanged if position is negative" do
    assert Board.make_move(-1, "x", Board.new) == ["", "", "",
                                                   "", "", "",
                                                   "", "", ""]
  end

  test "returns board unchanged if position is taken" do
    board_with_move = Board.make_move(0, "x", Board.new)
    assert Board.make_move(0, "o", board_with_move) == ["x", "", "",
                                                         "", "", "",
                                                         "", "", ""]
  end

  test "returns the available moves" do
    board_with_move = Board.make_move(5, "x", Board.new)
    assert Board.available_moves(board_with_move) == [0, 1, 2, 3, 4, 6, 7, 8]
  end

  test "returns the rows for 3x3" do
    assert Board.rows(Board.new) == [["", "", ""],
                                     ["", "", ""],
                                     ["", "", ""]]
  end

  test "returns the rows for 4x4" do
    assert Board.rows(Board.new(4)) == [["", "", "", ""],
                                        ["", "", "", ""],
                                        ["", "", "", ""],
                                        ["", "", "", ""]]
  end
end
