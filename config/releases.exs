import Config

db_host =
  System.get_env("DATABASE_HOST") ||
    raise """
    environment variable DATABASE_HOST is missing.
    """

db_database = System.get_env("DATABASE_DB")
db_username = System.get_env("DATABASE_USER")
db_password = System.get_env("DATABASE_PASSWORD")
db_url = "ecto://#{db_username}:#{db_password}@#{db_host}/#{db_database}"

config :release_api, ReleaseApi.Repo,
  url: db_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :release_api, ReleaseApiWeb.Endpoint,
  http: [:inet6, port: 4000],
  secret_key_base: secret_key_base
