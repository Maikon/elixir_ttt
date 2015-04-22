defmodule PlayersFactory do
  @game_types %{
    :hvh => [HumanPlayer, HumanPlayer],
    :hvc => [HumanPlayer, ComputerPlayer],
    :cvh => [ComputerPlayer, HumanPlayer],
    :cvc => [ComputerPlayer, ComputerPlayer]
  }

  def get_players_for(choice) do
    @game_types[choice]
  end
end
