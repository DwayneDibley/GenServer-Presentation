defmodule NameServer3Test do
  use ExUnit.Case
  doctest NameServer3

  test "1 - start the server" do
    assert NameServer3.start(:my_server3) == :ok
    assert NameServer3.add(:my_server3, :dwayne, "Red Dwarf") == :ok
    assert NameServer3.find(:my_server3, :dwayne) == "Red Dwarf"
  end
end
