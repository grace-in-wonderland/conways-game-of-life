defmodule ConwaysGameOfLife.Repo do
  use Ecto.Repo,
    otp_app: :conways_game_of_life,
    adapter: Ecto.Adapters.Postgres
end
