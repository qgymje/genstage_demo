defmodule Eticket.Grant.Fetcher.Redis do
  use GenStage
  require Logger

  def start_link(redis_addr) do
    GenStage.start_link(__MODULE__, redis_addr, name: __MODULE__)
  end

  def init(redis_addr) do
    {:ok, conn} = Redix.start_link(redis_addr)

    Logger.debug("============ add more items")

    for x <- 0..50 do
      {:ok, _} = Redix.command(conn, ["rpush", "mykey", "foo_#{x}"])
    end

    {:producer, conn}
  end

  def handle_demand(demand, conn) when demand > 0 do
    Logger.debug("demand is: #{demand}")

    events =
      for _ <- 0..demand do
        {:ok, event} = Redix.command(conn, ["lpop", "mykey"])
        if event == nil do
          Logger.debug "sleeping 1s"
          Process.sleep(1000)
        end
        event
      end

    {:noreply, events |> Enum.filter(&(&1 != nil)), conn}
  end
end
