class SearchController < ApplicationController
  def index
    if  [:search] && Stock.find_by(securities_code: search_params[:search])
      redirect_to stock_path(search_params[:search])
    elsif [:search] &&Stock.find_by(corp_name: search_params[:search])
      stock = Stock.find_by(corp_name: search_params[:search])
      redirect_to stock_path(stock.securities_code)
    else
      render template: "search/not_exist.html.erb"
    end
  end

  private
  def search_params
    params.permit(:search)
  end
end
