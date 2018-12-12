defmodule GenServerSlidesTest do
  use ExUnit.Case
  doctest NameServer1

  test "1 - start the server" do
    assert NameServer1.start(:my_server) == :ok
    assert NameServer1.rpc(:my_server, {:add, :dwayne, "Red Dwarf"}) == :ok
    assert NameServer1.rpc(:my_server, {:find, :dwayne}) == "Red Dwarf"
  end
end
