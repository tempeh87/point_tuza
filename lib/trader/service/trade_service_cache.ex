defmodule Trader.Service.Cache do
  defp create_trade_service(stock_symbol) do
    case Trader.Service.SuperVisor.start_child(stock_symbol) do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
  end

  def get_trade_server_process(stock_symbol) do
    case Trader.Service.get_process_by_symbol(stock_symbol) do
      #not found => create a new one
      :undefined -> create_trade_service(stock_symbol)
      #exist
      pid -> pid
    end
  end
end
