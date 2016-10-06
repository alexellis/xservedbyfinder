defmodule WhoServedServerTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock

  setup do
    {:ok, pid } = WhoServed.Server.start_link
    {:ok, pid: pid}
  end

  test "Who served", %{pid: pid} do
    url = "https://www.raspberrypi.org/blog/the-little-computer-that-could/"
    url_map = %{url => "foo 1"}

    use_cassette "served_sets_url" do
      :ok = WhoServed.Server.served(pid, url)
    end

    assert {:ok, url_map } == WhoServed.Server.served(pid, url)
  end

  test "get all served with multiple requests", %{pid: pid} do
    url = "https://www.raspberrypi.org/blog/the-little-computer-that-could/"

    use_cassette "get_served_with_multiple_requests" do
      WhoServed.Server.served(pid, url)
      WhoServed.Server.served(pid, "https://www.raspberrypi.org/")
    end

    res = WhoServed.Server.all_served(pid)
    assert res == {:ok, ["Blog VM 2", "Blog VM 1"]}
  end
end