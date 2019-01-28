class StocksController < ApplicationController
  def index
    @stocks = Stock.includes(:basic_information).order(:securities_code)
  end

  def show
    @stock = Stock.find_by_securities_code(params[:id])
  end
end
