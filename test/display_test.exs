defmodule DisplayTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

    test "prints the board" do
      board = ["", "", "", "", "", "", "", "", ""]
      assert capture_io(fn ->
        Display.show_board(board) end) == "1 | 2 | 3\n"   <>
                                          "---------\n"   <>
                                          "4 | 5 | 6\n"   <>
                                          "---------\n"   <>
                                          "7 | 8 | 9\n"
    end

    test "prompts the user for a move" do
      assert capture_io(fn ->
        Display.ask_for_move
      end) == "Choose a move from the board: "
    end

    test "returns the move from the user" do
      assert simulate_user_move_with("1") == "0"
    end

    test "handles invalid move" do
      assert simulate_user_move_with("invalid\n2") == "1"
    end

    test "handles empty input" do
      assert simulate_user_move_with("\n1") == "0"
    end

    test "prompts user for a game choice" do
      assert capture_io(fn ->
        Display.ask_for_game_choice
      end) == "Choose a game option from 1-4:\n" <>
              "1) Human vs Human "               <>
              "2) Human vs Computer "            <>
              "3) Computer vs Human "            <>
              "4) Computer vs Computer\n"
    end

    test "returns the game choice from the user" do
      assert simulate_user_game_choice("1") == :hvh
    end

    test "handles invalid choice" do
      assert simulate_user_game_choice("invalid-input\n1") == :hvh
      assert simulate_user_game_choice("\n1") == :hvh
    end

    test "supports all game modes" do
      assert simulate_user_game_choice("1") == :hvh
      assert simulate_user_game_choice("2") == :hvc
      assert simulate_user_game_choice("3") == :cvh
      assert simulate_user_game_choice("4") == :cvc
    end

    defp simulate_user_game_choice(input) do
      capture_io([input: input, capture_prompt: false], fn ->
        IO.write Display.get_game_choice
      end)
      |> String.to_atom
    end

    defp simulate_user_move_with(input) do
      capture_io([input: input, capture_prompt: false], fn ->
        IO.write Display.get_move
      end)
    end
end
