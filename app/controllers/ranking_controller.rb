class RankingController < ApplicationController
  def per_ranking
    @stocks = Stock.includes(:basic_index).where("15 > basic_indices.per").where("basic_indices.per > 0").order('basic_indices.per')
  end

  def pbr_ranking
    @stocks = Stock.includes(:basic_index).where("0.8 > basic_indices.pbr").where("basic_indices.pbr > 0").order('basic_indices.pbr')
  end

  def roe_ranking
    @stocks = Stock.includes(:various_index).where("various_indices.roe > 20").order('various_indices.roe DESC')
  end

  def roa_ranking
    @stocks = Stock.includes(:various_index).where("various_indices.roa > 20").order("various_indices.roa DESC")
  end

  def market_capitalization_ranking
    @stocks = Stock.includes(:basic_information).order("basic_informations.market_capitalization DESC").limit(500)
  end

  def masic_formula_ranking
    @stocks = Stock.includes(:masic_formula, :basic_information).where.not(masic_formulas: {masic_formula_rank: :nil}).order("masic_formulas.masic_formula_rank").limit(500)
  end

  def masic_formula_ranking_under_one_hundred_yen
    @stocks = Stock.includes(:masic_formula, :basic_information).where.not(masic_formulas: {masic_formula_rank: :nil}).order("masic_formulas.masic_formula_rank").where("basic_informations.stock_price < 1000").limit(500)
  end

  def the_highest_dividend_yields
    @stocks = Stock.includes(:basic_information).order("basic_informations.dividend_yield DESC").limit(100)
  end

  def cheep_stocks
    @stocks = Stock.includes(:basic_information).where("basic_informations.stock_price > 0").where.not("basic_informations.kind_of_industry IN (?)", ["ETF",  "証券、商品先物取引業"]).order("basic_informations.stock_price").limit(100)
  end
end
