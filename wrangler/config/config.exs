import Config

config :wrangler,
  gcp_api_host: System.get_env("GCP_API_HOST", "https://www.googleapis.com")

config :vantagex,
  api_key: System.get_env("ALPHA_VANTAGE_API_KEY")

config :goth,
  disabled: true

config :tesla, adapter: Tesla.Adapter.Hackney

import_config "#{Mix.env()}.exs"
