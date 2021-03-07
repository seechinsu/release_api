defmodule ReleaseApi.Repo do
  use Ecto.Repo,
    otp_app: :release_api,
    adapter: Ecto.Adapters.Postgres
end
