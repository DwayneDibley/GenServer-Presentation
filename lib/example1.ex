defmodule NameServer1 do
  @moduledoc """
  Very simple name server supporting two methods:
  add: Add a name and a place.
  find: Given a name, return the place or nil
  """

  def start(name) do
    Process.register(spawn(NameServer1, :loop, [name, %{}]), name)
    :ok
  end

  def rpc(name, request) do
    send(name, {self(), request})

    receive do
      {_name, response} -> response
    end
  end

  def loop(name, state) do
    receive do
      {from, request} ->
        {response, newState} = handleRequest(request, state)
        send(from, {name, response})
        loop(name, newState)
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
