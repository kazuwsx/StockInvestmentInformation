class BusinessController < ApplicationController
  def index
    @stocks = Stock.where_with_kind_of_industry(params[:kind_of_industry])
                   .order("basic_informations.market_capitalization DESC")
  end

  def show_all_businesses
    @stocks = BasicInformation.pluck(:kind_of_industry).uniq.reject(&:blank?)
  end
end
