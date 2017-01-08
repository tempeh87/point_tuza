defmodule Trader.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_) do
    processes = [
      #TODO: support database here
      supervisor(Trader.Service.SuperVisor, [])
    ]
    supervise(processes, strategy: :one_for_one)
  end
end
