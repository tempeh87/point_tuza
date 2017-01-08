defmodule Trader.Service do
  use GenServer
  def start_link(stock_symbol) do
    IO.puts "Initializing Trade server for #{stock_symbol}"
    GenServer.start_link(__MODULE__, stock_symbol, name: from_process_registry(stock_symbol))
  end

  def add_matching(trade_service, matching) do
    GenServer.cast(trade_service, {:add_matching, matching})
  end

  def get_latest(trade_service) do
    GenServer.call(trade_service, :get_latest)
  end

  defp from_process_registry(stock_symbol) do
    {:via, :gproc, {:n, :l, {:trade_service, stock_symbol}}}
  end

  def get_process_by_symbol(stock_symbol) do
   :gproc.whereis_name({:n, :l, {:trade_service, stock_symbol}})
  end

  def init(stock_symbol) do
    {:ok, Model.History.new(stock_symbol)}
  end

  def handle_cast({:add_matching, matching}, history) do
    {:noreply, history |> Model.History.add_matching(matching)}
  end

  def handle_call(:get_latest, _, history) do
    {:reply, history |> Model.History.get_latest, history}
  end
end
