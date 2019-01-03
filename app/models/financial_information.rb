class FinancialInformation < ApplicationRecord
  belongs_to :stock

  def scrape_financial_information(doc)

    latest_net_income   = Scraping.fetch_value_by_css(doc, 'tr.netIncome > td:last-child')
    previous_net_income = Scraping.fetch_value_by_css(doc, 'tr.netIncome > td:nth-last-child(2)')

    if !latest_net_income.zero?
      tentative_net_income = latest_net_income
      net_income = BigDecimal(tentative_net_income.to_s) * BigDecimal("1_000_000")
    elsif !previous_net_income.zero?
      tentative_net_income = previous_net_income
      net_income = BigDecimal(tentative_net_income.to_s) * BigDecimal("1_000_000")
    end

    latest_total_assets = Scraping.fetch_value_by_css(doc, 'tr.totalAssets > td:last-child')
    previous_total_assets = Scraping.fetch_value_by_css(doc, 'tr.totalAssets > td:nth-last-child(2)')

    if !latest_total_assets.zero?
      tentative_total_assets = latest_total_assets
      total_assets = BigDecimal(tentative_total_assets.to_s) * BigDecimal("1_000_000")
    elsif !previous_total_assets.zero?
      tentative_total_assets = previous_total_assets
      total_assets = BigDecimal(tentative_total_assets.to_s) * BigDecimal("1_000_000")
    else
      total_assets = nil
    end

    latest_net_worth = Scraping.fetch_value_by_css(doc, ' tr.stockholderCap > td:last-child')
    previous_net_worth = Scraping.fetch_value_by_css(doc, ' tr.stockholderCap > td:nth-last-child(2)')

    if !latest_net_worth.zero?
      tentative_net_worth = latest_net_worth
      net_worth = BigDecimal(tentative_net_worth.to_s) * BigDecimal("1_000_000")
    elsif !previous_net_worth.zero?
      tentative_net_worth = previous_net_worth
      net_worth = BigDecimal(tentative_net_worth.to_s) * BigDecimal("1_000_000")
    else
      net_worth = nil
    end

    result = {
      net_income: net_income,
      total_assets: total_assets,
      net_worth: net_worth,
    }
  end

  def save_financial_information(financial_information, hash)
    financial_information.net_income = hash[:net_income]
    financial_information.total_assets = hash[:total_assets]
    financial_information.net_worth = hash[:net_worth]
    financial_information.save
  end

  def show_financial_information(financial_information)
    puts "純利益              ￥#{financial_information.net_income.to_i.to_s(:delimited)}" if !financial_information.net_income.to_i.zero?
    puts "総資産              ￥#{financial_information.total_assets.to_i.to_s(:delimited)}" if !financial_information.total_assets.to_i.zero?
    puts "自己資本            ￥#{financial_information.net_worth.to_i.to_s(:delimited)}" if !financial_information.net_worth.to_i.zero?
  end
end
