defmodule ComputerPlayer do

  def get_move(%{board: board}) do
    Negamax.best_move(board)
  end
end
