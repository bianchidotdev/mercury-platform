defmodule Wrangler.GCPClient do
  # alias Goth.Token
  use Tesla

  plug(Tesla.Middleware.BaseUrl, Application.fetch_env!(:wrangler, :gcp_api_host))
  # plug Tesla.Middleware.Headers, [{"authorization", "token xyz"}]
  plug(Tesla.Middleware.JSON)

  def pull_triggers(bucket) do
    list_bucket_objects(bucket)
  end

  def list_bucket_objects(bucket) do
    get(buckets_url() <> "/" <> bucket <> "/o")
  end

  def list_buckets do
    get(buckets_url())
  end

  defp storage_base_url do
    "storage/v1"
  end

  defp buckets_url do
    storage_base_url() <> "/b"
  end

  # def list_buckets(project_id) do
  #   {:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/cloud-platform")
  #   conn = GoogleApi.Storage.V1.Connection.new(token.token)
  #   {:ok, response} = GoogleApi.Storage.V1.Api.Buckets.storage_buckets_list(conn, project_id)
  #   Enum.each(response.items, &IO.puts(&1.id))
  # end

  # def get_token(scope // "storage") do
  #   {:ok, token} = Token.for_scope("https://www.googleapis.com/auth/#{scope}")
  # end
end
