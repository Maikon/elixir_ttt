ExUnit.start()

defmodule FakeDisplay do
  def show_welcome_message do
    send self(), {:greet_players, "Welcoming message was showed"}
  end

  def show_board(_) do
    send self(), {:show_board, "Showed the board!"}
  end

  def show_message(_) do
    send self(), {:show_message, "Thanked the user for playing!"}
  end

  def clear_screen do
    send self(), {:clear_screen, "Cleared!"}
  end

  def get_game_choice,       do: :hvc
  def get_move,              do: 8
  def get_input_for_rematch, do: :no
end
