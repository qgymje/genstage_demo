defmodule EticketTest do
  use ExUnit.Case
  doctest Eticket

  test "greets the world" do
    assert Eticket.hello() == :world
  end
end
