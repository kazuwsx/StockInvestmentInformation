class StocksController < ApplicationController
  def index
    @stocks = Stock.includes(:basic_information).order(:securities_code)
  end

  def show
    @stock = Stock.find_by_securities_code(params[:id])
  end

  def types_of_businesses
    @stocks = BasicInformation.pluck(:kind_of_industry).uniq.reject(&:blank?)
  end
  
  def all_stocks_in_this_industry
    @stocks = Stock.where_with_kind_of_industry(params[:kind_of_industry])
                   .order("basic_informations.market_capitalization DESC")
  end

  private
  def search_params
    params.permit(:search)
  end
end
