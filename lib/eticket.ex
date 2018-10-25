defmodule Eticket do
  alias Eticket.Grant.Fetcher.Redis, as: GrantFetcher
  alias Eticket.Grant.Worker, as: GrantWorker

  require Logger

  @redis_addr Application.get_env(:eticket, :redis_addr)

  def prepare(n) do
    {:ok, conn} = Redix.start_link(@redis_addr)

    for x <- 0..n do
      {:ok, _} = Redix.command(conn, ["rpush", "mykey", "foo_#{x}"])
    end
  end

  def start do
    {:ok, fetcher} = GenStage.start_link(GrantFetcher, @redis_addr)
    {:ok, worker} = GenStage.start_link(GrantWorker, :ok)
    GenStage.sync_subscribe(worker, to: fetcher)
  end
end
