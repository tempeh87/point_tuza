defmodule Model.History do
  @moduledoc """

  """
  alias Model.History, as: History
  @max 15
  defstruct [:symbol, :records]

  def add_matching(history, matching) do
    if history |> History.exists?(matching) do
      history
    else
      %History{symbol: _, records: records} = history
      new_records = [matching | records] |> Enum.take(@max)
      %{history | records: new_records}
    end
  end

  def new(symbol) do
    %Model.History{
      symbol: symbol,
      records: []
    }
  end

  def get_latest(%History{symbol: _, records: records} = _) do
    case records do
      [head | _] ->
        {:ok, head}
      [] ->
        {:empty, nil}
    end
  end

  def exists?(%History{symbol: _, records: records}, matching) do
    case records do
      [head| _] -> head.time == matching.time
      _ -> false
    end
  end
end
