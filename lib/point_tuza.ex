defmodule PointTuza do
  use Application

  def start(_type, _args) do
    response = Trader.Supervisor.start_link
    Trader.Service.Facade.init_server
    response
  end
end
