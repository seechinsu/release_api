# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url = "ecto://postgres:postgres@localhost/release_api_dev"
# System.get_env("DATABASE_URL") ||
#   raise """
#   environment variable DATABASE_URL is missing.
#   For example: ecto://USER:PASS@HOST/DATABASE
#   """

config :release_api, ReleaseApi.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base = "goOaoZF6b4qLU4uq6s8NNRr26KIE3fVRINeYn7Lg0HNvfGfsWdQznYxJZviVVpx4"
# System.get_env("SECRET_KEY_BASE") ||
#   raise """
#   environment variable SECRET_KEY_BASE is missing.
#   You can generate one by calling: mix phx.gen.secret
#   """

config :release_api, ReleaseApiWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#

config :release_api, ReleaseApiWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
