defmodule NameServer3 do
  @moduledoc """
  Very simple name server supporting transactions:
  - In the event of a crash, the caller is sent a message.
  - All other processes using the server will not be affected.
  """
  def start(name) do
    Process.register(spawn(NameServer3, :loop, [name, %{}]), name)
    :ok
  end

  def add(serverName, name, place) do
    rpc(serverName, {:add, name, place})
  end

  def find(serverName, name) do
    rpc(serverName, {:find, name})
  end

  defp rpc(name, request) do
    send(name, {self(), request})

    receive do
      {_name, response} -> response
    end
  end

  def loop(name, state) do
    receive do
      {from, request} ->
        try do
          {response, newState} = handleRequest(request, state)
          send(from, {name, response})
          loop(name, newState)
        rescue
          thrown_value ->
            send(from, {:exception, "#{inspect(thrown_value)}"})
            loop(name, state)
        end
    end
  end

  defp handleRequest({:add, name, place}, state) do
    newState = Map.put(state, name, place)
    {:ok, newState}
  end

  defp handleRequest({:find, name}, state) do
    {state[name], state}
  end
end
