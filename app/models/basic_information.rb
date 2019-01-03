class BasicInformation < ApplicationRecord
  belongs_to :stock

  def scrape_basic_information(doc)
    #時価総額
    scraped_market_capitalization = Scraping.fetch_value(doc ,'//*[@id="sh_field_body"]/div/div[2]/div/div/div/div[2]/div[1]/div[2]/table/tr[2]/td')

    market_capitalization         = BigDecimal(scraped_market_capitalization.to_s) * BigDecimal("100_000_000")

    #配当利回り
    dividend_yield                = Scraping.fetch_value(doc, '//*[@id="sh_field_body"]/div/div[2]/div/div/div/div[2]/div[1]/div[1]/table/tr[4]/td[1]')

    #株価
    stock_price                   = Scraping.fetch_value(doc, '//*[@id="layout"]/div[2]/div[3]/div[2]/div/div[1]/div/div/div[1]/div[2]/div/div[2]/div')

    #業種
    kind_of_industry              = doc.xpath('//*[@id="sh_field_body"]/div/div[2]/div/div/div/div[1]/ul/li[1]/a').inner_text.to_s

    result = {
      market_capitalization: market_capitalization,
      dividend_yield: dividend_yield,
      stock_price: stock_price,
      kind_of_industry: kind_of_industry,
    }
  end

  def save_basic_information(basic_information, hash)
    basic_information.market_capitalization = hash[:market_capitalization]
    basic_information.dividend_yield = hash[:dividend_yield]
    basic_information.stock_price = hash[:stock_price]
    basic_information.url = hash[:url]
    basic_information.kind_of_industry = hash[:kind_of_industry]
    basic_information.save
  end

  def show_basic_information(basic_information)
    puts "時価総額            ￥#{basic_information.market_capitalization.to_i.to_s(:delimited)}" if !basic_information.market_capitalization.to_i.zero?
    puts "配当利回り          #{basic_information.dividend_yield}" if !basic_information.dividend_yield.to_i.zero?
    puts "株価                ￥#{basic_information.stock_price.to_i.to_s(:delimited)}" if !basic_information.stock_price.to_i.zero?
    puts "概要                #{basic_information.overview}" if basic_information.overview.present?
    puts "URL                 #{basic_information.url}" if basic_information.url.present?
    puts "業種                #{basic_information.kind_of_industry}" if basic_information.kind_of_industry.present?
  end
end
