defmodule NameServer6Test do
  use ExUnit.Case
  doctest NameServer6

  test "Test shutdown" do
    assert NameServer6.start(:my_server6) == :ok
    assert NameServer6.add(:my_server6, :dwayne, "Red Dwarf") == :ok
    assert NameServer6.find(:my_server6, :dwayne) == "Red Dwarf"
    assert NameServer6.shutdown(:my_server6) == :ok
  end

  test "Test shutdown1" do
    assert NameServer6.start(:my_server6) == :ok
    assert NameServer6.add(:my_server6, :dwayne, "Red Dwarf") == :ok
    assert NameServer6.find(:my_server6, :dwayne) == "Red Dwarf"
    assert NameServer6.shutdown1(:my_server6) == :ok
  end
end
