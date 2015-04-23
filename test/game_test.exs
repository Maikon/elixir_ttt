defmodule GameTest do
  use ExUnit.Case
  @default_message "Nothing was called"

  def setup do
    board = ["x", "x", "", "o", "o", "", "", "", ""]
    %{board: board, display: FakeDisplay}
  end

  test "greets the players" do
    Game.play(setup)
    recorded_message = receive do
      {:greet_players, msg} -> msg
    after
      0 -> @default_message
    end

    assert recorded_message == "Welcoming message was showed"
  end

  test "displays the board" do
    Game.play(setup)
    recorded_message = receive do
      {:show_board, msg} -> msg
    after
      0 -> @default_message
    end

    assert recorded_message == "Showed the board!"
  end

  test "plays the game until the end" do
    result = %{board: ["x", "x", "", "o", "o", "o", "", "", "x"],
               status: "o won!"}
    assert Game.play(setup) == result
  end

  test "end result can vary" do
    board  = ["x", "o", "x", "x", "o", "x", "o", "", ""]
    setup  = %{board: board, display: FakeDisplay}
    result = %{board: ["x", "o", "x", "x", "o", "x", "o", "x", "o"],
               status: "It's a draw!"}
    assert Game.play(setup) == result
  end
end

defmodule FakeDisplay do
  def show_welcome_message do
    send self(), {:greet_players, "Welcoming message was showed"}
  end

  def show_board(_) do
    send self(), {:show_board, "Showed the board!"}
  end

  def get_game_choice,       do: :hvc
  def get_move,              do: 8
end
