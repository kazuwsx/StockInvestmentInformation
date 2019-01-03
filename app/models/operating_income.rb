class OperatingIncome < ApplicationRecord
  belongs_to :stock

  def scrape_operating_income(doc)
    #来期予想営業利益（みんかぶでは予想ではなく当期がここに入る）
    scrapecd_next_fiscal_operating_income = Scraping.fetch_value_by_css(doc, 'tr.operatingProfit > td:last-child')
    next_fiscal_operating_income = BigDecimal(scrapecd_next_fiscal_operating_income.to_s) * BigDecimal("1_000_000")


    #当期営業利益
    scraped_operating_income_for_this_fiscal_year = Scraping.fetch_value_by_css(doc, 'tr.operatingProfit > td:nth-last-child(2)')
    operating_income_for_this_fiscal_year = BigDecimal(scraped_operating_income_for_this_fiscal_year.to_s) * BigDecimal("1_000_000")

    #前期営業利益
    scraped_privious_year_operating_income = Scraping.fetch_value_by_css(doc, 'tr.operatingProfit > td:nth-last-child(3)')
    privious_year_operating_income = BigDecimal(scraped_privious_year_operating_income.to_s) * BigDecimal("1_000_000")

    #前々期営業利益
    scraped_operating_income_two_fiscal_year_before = Scraping.fetch_value_by_css(doc, 'tr.operatingProfit > td:nth-last-child(4)')
    operating_income_two_fiscal_year_before = BigDecimal(scraped_operating_income_two_fiscal_year_before.to_s) * BigDecimal("1_000_000")

    result = {
      next_fiscal_operating_income: next_fiscal_operating_income,
      operating_income_for_this_fiscal_year: operating_income_for_this_fiscal_year,
      privious_year_operating_income: privious_year_operating_income,
      operating_income_two_fiscal_year_before: operating_income_two_fiscal_year_before,
    }
  end

  def save_operating_income(operating_income, hash)
    next_fiscal_operating_income = hash[:next_fiscal_operating_income]
    operating_income_for_this_fiscal_year = hash[:operating_income_for_this_fiscal_year]
    privious_year_operating_income = hash[:privious_year_operating_income]
    operating_income_two_fiscal_year_before = hash[:operating_income_two_fiscal_year_before]

    operating_income.next_fiscal_operating_income = next_fiscal_operating_income
    operating_income.operating_income_for_this_fiscal_year = operating_income_for_this_fiscal_year
    operating_income.privious_year_operating_income = privious_year_operating_income
    operating_income.operating_income_two_fiscal_year_before = operating_income_two_fiscal_year_before
    operating_income.save
  end

  def show_operating_income(operating_income)
    puts "来季予想営業利益    ￥#{operating_income.next_fiscal_operating_income.to_i.to_s(:delimited)}" if !operating_income.next_fiscal_operating_income.to_i.zero?
    puts "今季営業利益        ￥#{operating_income.operating_income_for_this_fiscal_year.to_i.to_s(:delimited)}" if !operating_income.operating_income_for_this_fiscal_year.to_i.zero?
    puts "前期営業利益        ￥#{operating_income.privious_year_operating_income.to_i.to_s(:delimited)}" if !operating_income.privious_year_operating_income.to_i.zero?
    puts "前々期営業利益      ￥#{operating_income.operating_income_two_fiscal_year_before.to_i.to_s(:delimited)}" if !operating_income.operating_income_two_fiscal_year_before.to_i.zero?
  end
end
