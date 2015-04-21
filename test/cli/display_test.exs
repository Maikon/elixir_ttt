defmodule CLI.DisplayTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

    test "prints the board" do
      board = ["", "", "", "", "", "", "", "", ""]
      assert capture_io(fn ->
        Cli.Display.show_board(board) end) == "1 | 2 | 3\n"   <>
                                              "---------\n"   <>
                                              "4 | 5 | 6\n"   <>
                                              "---------\n"   <>
                                              "7 | 8 | 9\n"
    end

    test "prompts the user for a move" do
      assert capture_io(fn ->
        Cli.Display.ask_for_move
      end) == "Choose a move from the board: "
    end

    test "returns the move from the user" do
      assert simulate_user_move_with("1") == "0"
    end

    test "handles invalid input" do
      assert simulate_user_move_with("invalid\n2") == "1"
    end

    test "handles empty input" do
      assert simulate_user_move_with("\n1") == "0"
    end

    defp simulate_user_move_with(input) do
      capture_io([input: input, capture_prompt: false], fn ->
        IO.write Cli.Display.get_move
      end)
    end
end
