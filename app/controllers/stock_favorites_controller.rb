class StockFavoritesController < ApplicationController
  def index
    @stocks = Stock.where(favorite: true)
  end

  def create
    stock = Stock.find_by_securities_code(params[:securities_code])
    stock.favorite = true
    stock.save
    redirect_back(fallback_location: stock_path(params[:securities_code]))
  end

  def destroy
    stock = Stock.find_by_securities_code(params[:securities_code])
    stock.favorite = false
    stock.save
    redirect_back(fallback_location: stock_favorites_path)
  end
end
