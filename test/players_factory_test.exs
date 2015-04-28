defmodule PlayersFactoryTest do
  use ExUnit.Case

  test "generates players for each game type" do
    assert PlayersFactory.get_players_for(:hvh) == [HumanPlayer, HumanPlayer]
    assert PlayersFactory.get_players_for(:hvc) == [HumanPlayer, ComputerPlayer]
    assert PlayersFactory.get_players_for(:cvh) == [ComputerPlayer, HumanPlayer]
    assert PlayersFactory.get_players_for(:cvc) == [SlowComputerPlayer, SlowComputerPlayer]
  end
end
