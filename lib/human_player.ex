defmodule HumanPlayer do

  def get_move(%{display: display, board: board}) do
    display.get_move(board)
  end
end
