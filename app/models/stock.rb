class Stock < ApplicationRecord
  has_one :basic_information, dependent: :destroy
  has_one :operating_income, dependent: :destroy
  has_one :sale, dependent: :destroy
  has_one :various_index, dependent: :destroy
  has_one :basic_index, dependent: :destroy
  has_one :financial_information, dependent: :destroy
  has_one :masic_formula, dependent: :destroy

  scope :find_by_securities_code, ->(securities_code) { find_by(securities_code: securities_code)}

  scope :where_with_kind_of_industry, ->(kind_of_industry) { 
    where("basic_informations.kind_of_industry = ?", kind_of_industry)
    .joins(:basic_information)
   }


  def self.scrape_stock_information(doc, i)
    #証券コード
    securities_code ||= i

    #会社名
    corp_name       ||= doc.xpath('//*[@id="layout"]/div[2]/div[3]/div[2]/div/div[1]/div/div/div[1]/div[1]/h1/a/p').inner_text

    result = {
      securities_code: securities_code,
      corp_name: corp_name,
    }
  end

  def save_stock_information(stock, hash)
    stock.securities_code = hash[:securities_code]
    stock.corp_name = hash[:corp_name]
    stock.save
  end

  def self.show_stock_information(stock)
    puts "証券コード          #{stock.securities_code}" if !stock.securities_code.to_i.zero?
    puts "会社名              #{stock.corp_name}" if stock.corp_name.present?
  end
end
