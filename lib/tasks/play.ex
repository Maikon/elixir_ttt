defmodule Mix.Tasks.Play do
  use Mix.Task

  def run(_) do
    Runner.start(%{game: Game, display: Display})
  end
end
