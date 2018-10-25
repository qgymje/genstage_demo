defmodule Eticket.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Eticket.Grant.Fetcher.Redis, [Application.get_env(:eticket, :redis_addr)])
    ]

    worker_num = Application.get_env(:eticket, :worker_num)

    workers =
      for id <- 0..worker_num do
        worker(Eticket.Grant.Worker, [], id: id)
      end

    opts = [strategy: :one_for_one, name: Eticket.Supervisor]
    Supervisor.start_link(children ++ workers, opts)
  end
end
