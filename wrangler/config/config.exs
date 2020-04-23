import Config 

config :wrangler,
  :test, "value"

config :vantagex,
  api_key: System.get_env("ALPHA_VANTAGE_API_KEY")

import_config "#{Mix.env()}.exs"
