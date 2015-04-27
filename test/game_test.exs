defmodule GameTest do
  use ExUnit.Case
  @default_message "Nothing was called"
  @game Game
  @display FakeDisplay

  def setup do
    board = ["x", "x", "", "o", "o", "", "", "", ""]
    %{board: board, display: @display}
  end

  test "greets the players" do
    @game.play(setup)
    recorded_message = receive do
      {:greet_players, msg} -> msg
    after
      0 -> @default_message
    end

    assert recorded_message == "Welcoming message was showed"
  end

  test "displays the board" do
    @game.play(setup)
    recorded_message = receive do
      {:show_board, msg} -> msg
    after
      0 -> @default_message
    end

    assert recorded_message == "Showed the board!"
  end

  test "clears the screen" do
    @game.play(setup)
    recorded_message = receive do
      {:clear_screen, msg} -> msg
    after
      0 -> @default_message
    end

    assert recorded_message == "Cleared!"
  end

  test "plays the game until the end" do
    result = {["x", "x", "", "o", "o", "o", "", "", "x"],
              "o won!"}
    assert @game.play(setup) == result
  end

  test "end result can vary" do
    board  = ["x", "o", "x", "x", "o", "x", "o", "", ""]
    setup  = %{board: board, display: @display}
    result = {["x", "o", "x", "x", "o", "x", "o", "x", "o"],
              "It's a draw!"}
    assert @game.play(setup) == result
  end
end
