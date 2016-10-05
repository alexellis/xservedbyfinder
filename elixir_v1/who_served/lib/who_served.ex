defmodule WhoServed do
  @url_error_message "Please supply a url"

  def served do
    @url_error_message
  end

  def served(url) do
    case valid?(url) do
      true ->
        get_pi(url)
      false ->
        @url_error_message
    end
  end

  def valid?(url) do
    uri = URI.parse(url)
    uri.scheme != nil && uri.host =~ "."
  end

  def get_pi do
    ""
  end

  def get_pi(url) do
    HTTPotion.get(url) |> build_response
  end

  defp build_response(response) do
    %{
      success: HTTPotion.Response.success?(response),
      headers: response.headers,
      status_code: response.status_code,
      x_served_by: response.headers[:"x-served-by"]
    }
  end
end
