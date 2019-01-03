class StocksController < ApplicationController
  def index
    @stocks = Stock.includes(:basic_information).order(:securities_code)
  end

  def show
    @stock = Stock.find_by_securities_code(params[:id])
  end

  def search_stock
    if  [:search] && Stock.find_by(securities_code: search_params[:search]).present?
      redirect_to stock_path(params[:search])
    elsif [:search] && Stock.find_by(corp_name: params[:search]).present?
      stock = Stock.find_by(corp_name: params[:search])
      redirect_to stock_path(stock.securities_code)
    else
      render template: "/stocks/not_exist.html.erb"
    end
  end

  def favorite
    stock = Stock.find_by_securities_code(params[:securities_code])
    stock.favorite = 1
    stock.save 
    redirect_back(fallback_location: stock_path(params[:securities_code]))
  end

  def favorite_list
    @stocks = Stock.where(favorite: 1)
  end

  def remove_from_favorite
    stock = Stock.find_by_securities_code(params[:securities_code])
    stock.favorite = nil
    stock.save
    redirect_back(fallback_location: favorite_list_path)
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
