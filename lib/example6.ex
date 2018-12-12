defmodule NameServer6 do
  @moduledoc """
  Two ways to stop the server
  """
  use GenServer

  def start(name) do
    {:ok, _pid} = GenServer.start(__MODULE__, :ok, name: name)
    :ok
  end

  def add(serverName, name, place) do
    GenServer.cast(serverName, {:add, name, place})
  end

  def find(serverName, name) do
    GenServer.call(serverName, {:find, name})
  end

  def shutdown(serverName) do
    GenServer.cast(serverName, :shutdown)
  end

  def shutdown1(serverName) do
    GenServer.stop(serverName, :normal)
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def terminate(_reason, _state) do
    # Cleanup code
  end

  @impl true
  def handle_cast({:add, name, place}, state) do
    newState = Map.put(state, name, place)
    {:noreply, newState}
  end

  def handle_cast(:shutdown, state) do
    # do something
    {:stop, :normal, state}
  end

  @impl true
  def handle_call({:find, name}, _from, state) do
    {:reply, state[name], state}
  end

  @impl true
  def info(info, state) do
    Logger.info("Info: #{inspect(info)}, #{inspect(state)}")
    {:noreply, state}
  end
end
