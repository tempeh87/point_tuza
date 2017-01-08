defmodule Model.Deal do
  @moduledoc """

  """
  @derive [Poison.Encoder]
  defstruct [:price, :volume]
  @type t :: %__MODULE__{price: float, volume: float}

  @doc """
    ## Parameters
      - price
      - volume
  """
  @spec new(float, float) :: Model.Deal
  def new(price, volume) do
    %Model.Deal{price: price, volume: volume}
  end
end
