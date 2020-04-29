defmodule Wrangler.GCPClient do
  # alias Goth.Token
  require OK
  require Logger
  use OK.Pipe
  use Tesla

  plug(Tesla.Middleware.BaseUrl, Application.fetch_env!(:wrangler, :gcp_api_host))
  # plug Tesla.Middleware.Headers, [{"authorization", "token xyz"}]
  plug(Tesla.Middleware.JSON)

  def pull_triggers(bucket) do
    {:ok, _resp} = list_bucket_objects(bucket)
  end

  def list_buckets do
    get(storage_base_url() <> "/b")
  end
  
  def list_bucket_objects(bucket) do
    Logger.info "hi"
    call(method: :get, url: storage_base_url() <> "/b/" <> bucket <> "/o")
    ~>> Map.fetch(:items)
  end

  # opts includes [:query, :body, :headers, :opts]
  def call(options) do
    case request(options) do
      {:ok, %{status: 200, body: body}} -> parse_body(body)
      {:ok, resp} -> handle_resp(resp)
      {:error, error} -> {:error, error}
    end
  end

  defp parse_body(body) do
    {:ok, body}
    ~>> Jason.decode(keys: :atoms)
  end

  defp handle_resp(resp) do
    case resp do
      %{status: 200} -> {:ok, resp}
      _ -> {:error, resp}
    end
  end

  defp storage_base_url do
    "storage/v1"
  end

  # def get_token(scope // "storage") do
  #   {:ok, token} = Token.for_scope("https://www.googleapis.com/auth/#{scope}")
  # end
end
