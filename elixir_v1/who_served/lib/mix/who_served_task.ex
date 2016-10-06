defmodule Mix.Tasks.WhoServed do
  use Mix.Task

  @shortdoc "Finds out which pi served the page"
  def run(urls) do
    HTTPotion.start
    results = Enum.map(urls, fn(x) -> WhoServed.served(x) end)
    Enum.map(results, fn(x) -> IO.puts x.x_served_by end)
  end
end