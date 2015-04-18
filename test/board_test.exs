defmodule BoardTest do
  use ExUnit.Case

  test "supports 3x3 by default" do
    assert Board.new == [0, 1, 2,
                         3, 4, 5,
                         6, 7, 8]
  end

  test "size can vary" do
    assert Board.new(4) == [0, 1, 2, 3,
                            4, 5, 6, 7,
                            8, 9, 10, 11,
                            12, 13, 14, 15]
  end

  test "marks a position on the board" do
    assert Board.make_move(0, "x", Board.new) == ["x", 1, 2,
                                                   3, 4, 5,
                                                   6, 7, 8]
  end

  test "returns board unchanged if position is invalid" do
    assert Board.make_move(10, "x", Board.new) == [0, 1, 2,
                                                   3, 4, 5,
                                                   6, 7, 8]
  end

  test "returns board unchanged if position is negative" do
    assert Board.make_move(-1, "x", Board.new) == [0, 1, 2,
                                                   3, 4, 5,
                                                   6, 7, 8]
  end

  test "returns board unchanged if position is taken" do
    board_with_move = Board.make_move(0, "x", Board.new)
    assert Board.make_move(0, "o", board_with_move) == ["x", 1, 2,
                                                         3, 4, 5,
                                                         6, 7, 8]
  end
end
