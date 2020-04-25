import Config

config :wrangler,
  test_config: true

config :goth,
  disabled: true

config :tesla,
  adapter: {Tesla.Adapter.Hackney, ssl_options: [verify: :verify_none]}

# json: {:system, "GCP_CREDENTIALS"}
