defmodule Wrangler.GCPClientTest do
  use ExUnit.Case
  @moduletag :integration

  import Tesla.Mock

  alias Wrangler.GCPClient
  defdelegate fixture(string), to: Wrangler.Fixtures

  @storage_base_url Application.get_env(:wrangler, :gcp_api_host) <> "/storage/v1"

  setup do
    if Mix.env == :test do
      mock(fn
        %{method: :get, url: @storage_base_url <> "/b"} ->
          %Tesla.Env{status: 200, body: "hello"}

        %{method: :get, url: @storage_base_url <> "/b/mercury-platform-triggers/o"} ->
          %Tesla.Env{status: 200, body: fixture("list-bucket-objects.json")}
      end)
    end

    :ok
  end


  describe "list_buckets/0" do
    test "it responds without an error" do
      assert {:ok, _} = GCPClient.list_buckets()
    end

    @tag :integration_only
    test "it hits gcr-mock" do
      {:ok, resp} = GCPClient.list_buckets()
      assert "https://gcs-mock:4443/storage/v1/b" == resp.url
    end
  end

  describe "list_bucket_objects/1" do
    test "it responds with gcs objects" do
      {:ok, objects} =
        GCPClient.list_bucket_objects(Application.get_env(:wrangler, :trigger_bucket))

      assert Enum.any?(objects, &(&1.name == "test.csv"))
    end
  end
end
