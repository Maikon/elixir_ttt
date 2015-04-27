defmodule CLI.DisplayTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  @display CLI.Display

    test "prints welcoming message" do
      message = capture_io(fn ->
        @display.show_welcome_message
      end)
      assert message_contains_string(message, "Welcome to Tic-Tac-Toe")
    end

    test "prints the board" do
      board = ["", "", "", "", "", "", "", "", ""]
      assert capture_io(fn ->
        @display.show_board(board) end) == "1 | 2 | 3\n"   <>
                                           "---------\n"   <>
                                           "4 | 5 | 6\n"   <>
                                           "---------\n"   <>
                                           "7 | 8 | 9\n"
    end

    test "prompts the user for a move" do
      message = capture_io([input: "1"], fn ->
        IO.write @display.get_move(Board.new)
      end)
      assert message_contains_string(message, "Choose a move from the board:")
    end

    test "prompts the user for invalid move" do
      message = capture_io([input: "invalid\n1"], fn ->
        IO.write @display.get_move(Board.new)
      end)
      assert message_contains_string(message, "Please choose a valid move from the board")
    end

    test "returns the move from the user" do
      assert simulate_user_move_with("1") == "0"
    end

    test "handles invalid move" do
      assert simulate_user_move_with("invalid\n22\n2\n") == "1"
    end

    test "handles empty input" do
      assert simulate_user_move_with("\n1") == "0"
    end

    test "prompts user for a game choice" do
      message = capture_io([input: "1"], fn ->
        IO.write @display.get_game_choice
      end)
      assert message_contains_string(message,"Choose a game option from 1-4:\n" <>
                                             "1) Human vs Human "               <>
                                             "2) Human vs Computer "            <>
                                             "3) Computer vs Human "            <>
                                             "4) Computer vs Computer")
    end

    test "returns the game choice from the user" do
      assert simulate_user_game_choice("1") == :hvh
    end

    test "handles invalid choice" do
      assert simulate_user_game_choice("invalid-input\n1") == :hvh
      assert simulate_user_game_choice("21\n1") == :hvh
    end

    test "supports all game modes" do
      assert simulate_user_game_choice("1") == :hvh
      assert simulate_user_game_choice("2") == :hvc
      assert simulate_user_game_choice("3") == :cvh
      assert simulate_user_game_choice("4") == :cvc
    end

    test "can display a message" do
      message = capture_io(fn ->
        @display.show_message("x won!")
      end)
      assert message_contains_string(message, "x won!")
    end

    test "asks the user for a rematch" do
      message = capture_io([input: "n\n"], fn ->
        IO.write @display.get_rematch_choice
      end)
      assert message_contains_string(message, "Would you like to play again? (y)es (n)o:")
    end

    test "when the user wants a rematch" do
      assert simulate_rematch_input("y\n") == :yes
      assert simulate_rematch_input("yes\n") == :yes
    end

    test "when the user does not want a rematch" do
      assert simulate_rematch_input("n\n")  == :no
      assert simulate_rematch_input("no\n") == :no
    end

    test "handles invalid input for rematch prompt" do
      assert simulate_rematch_input("invalid\nno\n") == :no
      assert simulate_rematch_input(" \nyes\n")      == :yes
    end

    test "clears the screen" do
      message = capture_io(fn ->
        @display.clear_screen
      end)
      assert message == "\e[2J\e[H"
    end

    defp simulate_user_game_choice(input) do
      capture_io([input: input, capture_prompt: false], fn ->
        IO.write @display.get_game_choice
      end)
      |> String.to_atom
    end

    defp simulate_user_move_with(input) do
      capture_io([input: input, capture_prompt: false], fn ->
        IO.write @display.get_move(Board.new)
      end)
    end

    defp simulate_rematch_input(input) do
      capture_io([input: input, capture_prompt: false], fn ->
        IO.write @display.get_rematch_choice
      end) |> String.to_atom
    end

    defp message_contains_string(message, string) do
      String.contains?(message, string)
    end
end
