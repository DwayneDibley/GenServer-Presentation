defmodule NameServer5 do
  @moduledoc """
  Very simple name server supporting transactions, using GenServer:
  """
  use GenServer

  ## Interface -------------------------------------------------------
  def start(name) do
    {:ok, pid} = GenServer.start(__MODULE__, :ok, name: name)
    :ok
  end

  def add(serverName, name, place) do
    GenServer.call(serverName, {:add, name, place})
  end

  def find(serverName, name) do
    GenServer.call(serverName, {:find, name})
  end

  ## Implementation --------------------------------------------------
  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:add, name, place}, _from, state) do
    newState = Map.put(state, name, place)
    {:reply, :ok, newState}
  end

  @impl true
  def handle_call({:find, name}, _from, state) do
    {:reply, state[name], state}
  end
end
