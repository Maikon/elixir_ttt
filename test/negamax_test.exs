defmodule NegamaxTest do
  use ExUnit.Case

  test "goes for the win" do
    board = ["x", "", "o",
             "o", "", "",
             "", "", "x"]
    assert negamax_best_move(board) == 4
  end

  test "blocks a loss" do
    board = ["", "", "x",
             "", "o", "",
             "", "", "x"]
    assert negamax_best_move(board) == 5
  end

  test "blocks diagonal fork" do
    board = ["x", "", "",
             "", "o", "",
             "", "", "x"]
    move = negamax_best_move(board)
    assert move_is_within_valid_moves?([1, 3, 5, 7], move) == true
  end

  test "blocks alternative diagonal fork" do
    board = ["x", "", "",
             "", "x", "",
             "", "", "o"]
    move = negamax_best_move(board)
    assert move_is_within_valid_moves?([2, 6], move) == true
  end

  test "blocks edge fork" do
    board = ["", "", "",
             "", "o", "x",
             "", "x", ""]
    move = negamax_best_move(board)
    assert move_is_within_valid_moves?([2, 6, 8], move) == true
  end

  defp negamax_best_move(board), do: Negamax.best_move(board)
  defp move_is_within_valid_moves?(moves, move), do: Enum.member?(moves, move)
end
