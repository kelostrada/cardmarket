defmodule Cardmarket do
  @moduledoc """
  API for Cardmarket
  """
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.cardmarket.com/ws/v2.0/output.json")
  plug(Cardmarket.Middleware.Authorization)
  plug(Tesla.Middleware.JSON)

  @doc """
  https://api.cardmarket.com/ws/documentation/API_2.0:Account
  """
  def account() do
    get("/account")
  end

  @doc """
  https://api.cardmarket.com/ws/documentation/API_2.0:Games
  """
  def games() do
    get("/games")
  end

  @doc """
  https://api.cardmarket.com/ws/documentation/API_2.0:Expansions
  """
  def expansions(game_id) do
    get("/games/#{game_id}/expansions")
  end

  @doc """
  https://api.cardmarket.com/ws/documentation/API_2.0:Expansion_Singles
  """
  def expansion_singles(expansion_id) do
    get("/expansions/#{expansion_id}/singles")
  end

  @doc """
  https://api.cardmarket.com/ws/documentation/API_2.0:Productlist
  """
  def productlist() do
    get("/productlist")
  end

  @doc """
  https://api.cardmarket.com/ws/documentation/API_2.0:PriceGuide
  """
  def priceguide(game_id) do
    get("/priceguide", query: [idGame: game_id])
  end
end
