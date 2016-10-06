defmodule WhoServed.Server do
  use GenServer

  def start_link(opts \\[]) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  def init(state) do
    {:ok, state}
  end

  def served(pid, url) do
    GenServer.call(pid, {:served, url})
  end

  def all_served(pid) do
    GenServer.call(pid, {:all_served})
  end

  def handle_call({:served, url}, _from, state) do
    response = WhoServed.served(url)
    case Map.fetch(state, url) do
      :error ->
        {:reply, :ok, Map.put(state, url, response.x_served_by)}
      {:ok, _ } ->
        {:reply, {:ok, Map.put(state, url, response.x_served_by)}, state}
    end
  end

  def handle_call({:all_served}, _from, state) do
    case Enum.empty?(state) do
      :true ->
        {:reply, :ok, "no one served"}
      :false ->
        {:reply, {:ok, Map.values(state)}, state}
    end
  end
end