defmodule Pointcard.Repo do
  use Ecto.Repo,
    otp_app: :pointcard,
    adapter: Ecto.Adapters.Postgres
end
