defmodule CLI.RunnerTest do
  use ExUnit.Case
  @zero_timeout 0
  @runner CLI.Runner

  def setup do
    %{game: FakeGame, display: FakeDisplay}
  end

  test "it starts the game" do
    @runner.start(setup)
    assert recorded_message == {:play, "Game has begun!"}
  end

  test "it restarts the game when user wants another round" do
    @runner.another_round(:yes, setup)
    assert recorded_message == {:play, "Game has begun!"}
  end

  test "it shows farewell message otherwise" do
    @runner.another_round(:no, setup)
    assert recorded_message == {:show_message, "Thanked the user for playing!"}
  end

  def recorded_message do
    receive do
      {message, content} -> {message, content}
    after
      @zero_timeout -> "Nothing was called"
    end
  end
end


defmodule FakeGame do
  def play(_) do
    send self(), {:play, "Game has begun!"}
  end
end
