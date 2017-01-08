defmodule Trader.Service.SuperVisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil, name: :trade_service_supervisor)
  end

  def init(_) do
    supervise([worker(Trader.Service, [])], strategy: :simple_one_for_one)
  end

  def start_child(stock_symbol) do
    Supervisor.start_child(:trade_service_supervisor, [stock_symbol])
  end
end
