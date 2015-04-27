defmodule Display do
  @game_choices %{ 1 => :hvh,
                   2 => :hvc,
                   3 => :cvh,
                   4 => :cvc }
  @board Board
  @board_presenter CLI.BoardPresenter
  @move_retriever CLI.MoveRetriever
  @game_choice_retriever CLI.GameChoiceRetriever
  @rematch_choice_retriever CLI.RematchChoiceRetriever
  @colorizer CLI.Colorizer

  def show_welcome_message do
    IO.puts @colorizer.colorize("****************************\n" <>
                                "** Welcome to Tic-Tac-Toe **\n" <>
                                "****************************\n", :yellow)
  end

  def show_board(board) do
    @board_presenter.show(board)
  end

  def show_message(message), do: IO.write @colorizer.colorize("\n#{message}\n", :blue)

  def get_move(board) do
    board |> @move_retriever.get_move
  end

  def get_game_choice do
    @game_choice_retriever.get_game_choice
  end

  def get_rematch_choice do
    @rematch_choice_retriever.get_choice
  end

  def clear_screen do
    IO.ANSI.clear |> IO.write
    IO.ANSI.home  |> IO.write
  end

  defp convert_to_number(string), do: Integer.parse(string)

  defp prompt_user_input_with_message(message), do: IO.gets message <> "\n> "
end
