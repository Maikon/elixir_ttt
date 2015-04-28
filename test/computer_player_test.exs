defmodule ComputerPlayerTest do
  use ExUnit.Case

  test "goes for the win" do
    board  = %{board: ["x", "", "o",
                       "o", "", "",
                       "", "", "x"]}
    assert ComputerPlayer.get_move(board) == 4
  end
end
