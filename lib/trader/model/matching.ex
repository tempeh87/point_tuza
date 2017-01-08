defmodule Model.Matching do
  alias Model.Deal, as: Deal
  @moduledoc """
  The struct for trade state of five best match -> http://mis.twse.com.tw/stock/fibest.jsp
  Json Example:
  {
    "match":{ "volume":332, "price":50.9 },
    "time":"10:34:22",
    "open":11.2,
    "low":12.3,
    "high":11.7,
    "selling":[
      {"volume":10,"price":1},
      {"volume":20,"price":2},
      {"volume":30,"price":3},
      {"volume":40,"price":4},
      {"volume":50,"price":5}
    ],
    "buying":[
      {"volume":60,"price":6},
      {"volume":70,"price":7},
      {"volume":80,"price":8},
      {"volume":90,"price":9},
      {"volume":100,"price":10}
    ]
  }
  """

  @derive [Poison.Encoder]
  defstruct [:match,:time,:open,:high,:low,:selling,:buying]

  @doc"""
    Create Matching instance
  """
  @spec new(Deal, String.t, number, number, number, List, List) :: Model.Matching
  def new(match, time, open, high, low, selling, buying) do
    %Model.Matching{
      match:  match,
      time: time,
      open: open,
      high: high,
      low: low,
      selling: selling,
      buying: buying
    }
  end
end
