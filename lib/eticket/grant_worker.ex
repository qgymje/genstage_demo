defmodule Eticket.Grant.Worker do
  use GenStage
  require Logger

  @min_demand 1
  @max_demand 5

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  def init(state) do
    GenStage.async_subscribe(
      self(),
      to: Eticket.Grant.Fetcher.Redis,
      min_demand: @min_demand,
      max_demand: @max_demand
    )

    {:consumer, state}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      work(event)
    end

    {:noreply, [], state}
  end

  def work(event) do
    Logger.debug("new event:#{event}")
    :timer.sleep(1000)
    Logger.debug("finish handle event:#{event}")
  end
end
