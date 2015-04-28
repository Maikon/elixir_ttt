defmodule SlowComputerPlayerTest do
  use ExUnit.Case

  test "blocks a loss" do
    board = %{board: ["", "", "x",
                      "", "o", "",
                      "", "", "x"]}
    assert SlowComputerPlayer.get_move(board) == 5
  end
end
