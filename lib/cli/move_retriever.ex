defmodule CLI.MoveRetriever do
  @board Board
  @console_interactor CLI.ConsoleInteractor

  def get_move(board) do
    ask_for_move |> _valid_move(board)
  end

  def get_move(board, message) do
    ask_for_move(message) |> _valid_move(board)
  end

  defp ask_for_move do
    @console_interactor.prompt_user_with_message("Choose a move from the board: ")
  end

  defp ask_for_move(message) do
    @console_interactor.prompt_user_with_message(message)
  end

  def _valid_move(move, board) do
    move |> @console_interactor.convert_to_number |> _validate_move(board)
  end

  defp _validate_move(:error, board) do
    get_move(board, "Please choose a valid move from the board: ")
  end

  defp _validate_move({move, _}, board) do
    move = move - 1
    board
    |> @board.available_moves
    |> Enum.member?(move)
    |> within_available_moves(board, move)
  end

  defp within_available_moves(true, _, move) do
    move
  end

  defp within_available_moves(false, board, _) do
    get_move(board, "Please choose a valid move from the board: ")
  end
end
