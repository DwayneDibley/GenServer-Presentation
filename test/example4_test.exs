defmodule NameServer4Test do
  use ExUnit.Case
  doctest NameServer4

  test "1 - start the server" do
    assert NameServer4.start(:my_server4) == :ok
    assert NameServer4.add(:my_server4, :dwayne, "Red Dwarf") == :ok
    assert NameServer4.find(:my_server4, :dwayne) == "Red Dwarf"
  end
end
