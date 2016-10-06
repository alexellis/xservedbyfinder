defmodule WhoServedTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock

  doctest WhoServed

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "Who served " do
    assert WhoServed.served == "Please supply a url"
  end

  test "Who served with invalid url" do
    assert WhoServed.served("url") == "Please supply a url"
  end

  test "Who served with valid url" do
#  just added this cause i was playing around with vcr
    use_cassette "served_with_valid_url" do
      url = "https://www.raspberrypi.org/blog/the-little-computer-that-could/"
      response = %{
        success: true,
        headers: %HTTPotion.Headers{
            hdrs: %{"cache-control" => "max-age=3, must-revalidate",
            "content-length" => "99855",
            "content-type" => "text/html; charset=UTF-8",
            "date" => "Wed, 05 Oct 2016 03:45:23 GMT",
            "last-modified" => "Tue, 04 Oct 2016 21:51:45 GMT",
            "server" => "Apache/2.4.10 (Debian)",
            "vary" => "Accept-Encoding,Cookie",
            "wp-super-cache" => "Served supercache file from PHP",
            "x-clacks-overhead" => "GNU Terry Pratchett",
            "x-served-by" => "Blog VM 1"}},
        status_code: 200,
        x_served_by: "Blog VM 1"}
      assert WhoServed.served(url) == response
    end
  end

  test "get_pi is ok" do
    assert WhoServed.get_pi == ""
  end

  test "get_pi returns built response" do
    use_cassette "served_sets_url" do
      url = "https://www.raspberrypi.org/blog/the-little-computer-that-could/"
      response = WhoServed.get_pi(url)
      assert response.success == true
      assert response.status_code == 200
      assert response.x_served_by == "foo 1"
    end
  end

  test "valid url is passed" do
    url = "https://www.raspberrypi.org/blog/the-little-computer-that-could/"
    assert url |> WhoServed.valid? == true
  end

  test "invalid url is passed" do
    assert "foo" |> WhoServed.valid? == false
  end

end
