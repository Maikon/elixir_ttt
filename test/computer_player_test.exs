defmodule ComputerPlayerTest do
  use ExUnit.Case

  test "goes for the win" do
    board  = %{board: ["x", "", "o",
                       "o", "", "",
                       "", "", "x"]}
    assert get_computer_move(board) == 4
  end

  test "blocks a loss" do
    board  = %{board: ["", "", "x",
                       "", "o", "",
                       "", "", "x"]}
    assert get_computer_move(board) == 5
  end

  test "blocks diagonal fork" do
    board  = %{board: ["x", "", "",
                       "", "o", "",
                       "", "", "x"]}
    move = get_computer_move(board)
    assert move_is_within_valid_moves?([1, 3, 5, 7], move) == true
  end

  test "blocks alternative diagonal fork" do
    board  = %{board: ["x", "", "",
                       "", "x", "",
                       "", "", "o"]}
    move = get_computer_move(board)
    assert move_is_within_valid_moves?([2, 6], move) == true
  end

  test "blocks edge fork" do
    board  = %{board: ["", "", "",
                       "", "o", "x",
                       "", "x", ""]}
    move = get_computer_move(board)
    assert move_is_within_valid_moves?([2, 6, 8], move) == true
  end

  defp get_computer_move(board), do: ComputerPlayer.get_move(board)
  defp move_is_within_valid_moves?(moves, move), do: Enum.member?(moves, move)
end
