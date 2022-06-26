defmodule Pointcard.Repo do
  use Ecto.Repo,
    otp_app: :pointcard,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
