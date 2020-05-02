import Config

config :wrangler,
  test_config: true

config :logger,
  level: :error

config :tesla,
  adapter: Tesla.Mock
