defmodule Newzjunky.Repo do
  use Ecto.Repo,
    otp_app: :newzjunky,
    adapter: Ecto.Adapters.Postgres
end
