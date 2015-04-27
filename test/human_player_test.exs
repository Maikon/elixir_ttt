defmodule HumanPlayerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "returns a move" do
    game = %{board: Board.new, display: CLI.Display}

    assert capture_io([input: "1", capture_prompt: false], fn ->
      IO.write HumanPlayer.get_move(game)
    end) == "0"
  end
end
