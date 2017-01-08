defmodule Trader.Service.Facade do
  use Plug.Router

  plug :match
  plug :dispatch
  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  def init_server do
    case Application.get_env(:point_tuza, :web_server_port) do
      nil -> raise("Can't find web_server_port under ./config/config.exs")
      port ->
        Plug.Adapters.Cowboy.http(__MODULE__, nil, port: port)
    end
  end

  get "/test" do
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "hello_world")
  end

  post "/add_matching" do
    conn
    |> parse
    |> extract_matching!
    |> response
  end

  defp extract_matching!(conn) do
    matching = Poison.decode!(conn.params["matching"], as: %Model.Matching{})
    stock_symbol = conn.params["stock_symbol"]
    IO.inspect({stock_symbol, matching})
    {stock_symbol, matching} |> add_matching
    Plug.Conn.assign(conn, :response, "OK")
  end

  defp add_matching({stock_symbol, matching}) do

  end

  defp response(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, conn.assigns[:response])
  end

  defp parse(conn, opts \\ []) do
    opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
  end

  match _ do
    Plug.Conn.send_resp(conn, 404, "Not found")
  end
end
