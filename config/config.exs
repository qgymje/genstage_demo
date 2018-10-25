use Mix.Config

config :eticket,
  redis_addr: "redis://localhost:6379/0",
  worker_num: 10
