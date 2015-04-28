defmodule SlowComputerPlayer do
  @time_in_seconds "1"

  def get_move(%{board: board}) do
    System.cmd("sleep", [@time_in_seconds])
    Negamax.best_move(board)
  end
end
