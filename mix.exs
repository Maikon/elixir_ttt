defmodule TicTacToe.Mixfile do
  use Mix.Project

  def project do
    [app: :tic_tac_toe,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  defp deps do
    [{:colorful, "0.6.0"}]
  end
end
