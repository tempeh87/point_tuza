defmodule Model.Test do
  use ExUnit.Case
  test "Model.Deal" do
    deal = Model.Deal.new(1.0, 50)
    assert(deal.price == 1.0)
    assert(deal.volume == 50)
  end

  test "Model.Matching" do
    match_deal = Model.Deal.new(50.9, 332)
    selling = 1..5 |> Enum.map(fn(index) -> Model.Deal.new(index, index * 10) end)
    buying = 6..10 |> Enum.map(fn(index) -> Model.Deal.new(index, index * 10) end)
    matching = Model.Matching.new(match_deal, "10:34:22", 11.2, 11.7, 12.3, selling, buying)
    IO.puts(Poison.encode!(matching))
    assert(matching.match.price == 50.9)
  end
end
