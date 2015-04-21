defmodule CLI.DisplayTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

    test "prints the board" do
      board = ["", "", "", "", "", "", "", "", ""]
      assert capture_io(fn ->
        Cli.Display.show_board(board) end) == "1 | 2 | 3\n"   <>
                                              "---------\n" <>
                                              "4 | 5 | 6\n"   <>
                                              "---------\n" <>
                                              "7 | 8 | 9\n"
    end
end
