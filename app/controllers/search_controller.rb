class SearchController < ApplicationController
  def index
    if  [:search] && Stock.find_by(securities_code: params[:search])
      redirect_to stock_path(params[:search])
    elsif [:search] &&Stock.find_by(corp_name: params[:search])
      stock = Stock.find_by(corp_name: params[:search])
      redirect_to stock_path(stock.securities_code)
    else
      render template: "search/not_exist.html.erb"
    end
  end
end
