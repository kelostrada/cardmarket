defmodule Cardmarket do
  @moduledoc """
  API for Cardmarket
  """
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.cardmarket.com/ws/v2.0/output.json")
  plug(Cardmarket.Middleware.Authorization)
  plug(Tesla.Middleware.JSON)

  def account() do
    get("/account")
  end

  def games() do
    get("/games")
  end

  def expansions(game_id) do
    get("/games/#{game_id}/expansions")
  end

  def expansion_singles(expansion_id) do
    get("/expansions/#{expansion_id}/singles")
  end

  def productlist() do
    get("/productlist")
  end

  def priceguide(game_id) do
    get("/priceguide", query: [idGame: game_id])
  end
end
