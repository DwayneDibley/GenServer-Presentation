defmodule NameServer2Test do
  use ExUnit.Case
  doctest NameServer2

  test "2 - crashing server" do
    assert NameServer2.start(:my_server2) == :ok
    assert NameServer2.rpc(:my_server2, {:add, :dwayne, "Red Dwarf"}) == :ok

    assert NameServer2.rpc(:my_server2, {:crash, :dwayne}) ==
             "%ArithmeticError{message: \"bad argument in arithmetic expression\"}"

    assert NameServer2.rpc(:my_server2, {:find, :dwayne}) == "Red Dwarf"
  end
end
