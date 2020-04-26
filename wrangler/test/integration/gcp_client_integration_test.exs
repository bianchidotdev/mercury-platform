defmodule Wrangler.GCPClientTest do
  use ExUnit.Case
  alias Wrangler.GCPClient
  @moduletag :integration

  describe "list_buckets/0" do
    test "it responds without an error" do
      assert {:ok, _} = GCPClient.list_buckets
    end

    test "it hits gcs-mock" do
      {:ok, resp} = GCPClient.list_buckets
      assert "https://gcs-mock:4443/storage/v1/b" == resp.url
    end
  end

  describe "list_bucket_objects/1" do
    test "it responds with gcs objects" do
      {:ok, resp} = GCPClient.list_bucket_objects(Application.get_env(:wrangler, :trigger_bucket))
      body = resp.body |> Jason.decode!
      assert body == ""
    end
  end
end
