defmodule NameServer5Test do
  use ExUnit.Case
  doctest NameServer5

  test "1 - start the server" do
    assert NameServer5.start(:my_server5) == :ok
    assert NameServer5.add(:my_server5, :dwayne, "Red Dwarf") == :ok
    assert NameServer5.find(:my_server5, :dwayne) == "Red Dwarf"
  end
end
