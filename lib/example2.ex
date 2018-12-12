defmodule NameServer2 do
  @moduledoc """
  Very simple name server supporting two methods:
  add: Add a name and a place.
  find: Given a name, return the place or nil
  """

  def start(name) do
    Process.register(spawn(NameServer2, :loop, [name, %{}]), name)
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

  defp handleRequest({:crash, name}, state) do
    1 / 0
    {state[name], state}
  end
end
