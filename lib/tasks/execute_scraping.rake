require 'open_uri_redirections'

namespace :execute_scraping do
  desc 'スクレイピングの実行'
  task :valueGetFromKabutan => :environment do
    for number in 1300..9999 do
      begin
        url = "https://minkabu.jp/stock/#{number}"
        analyzed_document = Scraping.analyzing_page(url)
        if Scraping.inspect_delisting(analyzed_document, number)
          stock = Stock.where(securities_code: number).first_or_create
          hash_of_result = Stock.scrape_stock_information(analyzed_document, number)
          stock.save_stock_information(stock, hash_of_result)
          Stock.show_stock_information(stock)
          stock_id = stock.id

          basic_information = BasicInformation.where(stock_id: stock_id).first_or_create
          hash_of_result = basic_information.scrape_basic_information(analyzed_document)
          hash_of_result[:url] = url
          basic_information.save_basic_information(basic_information, hash_of_result)
          basic_information.show_basic_information(basic_information)

          basic_index = BasicIndex.where(stock_id: stock_id).first_or_create
          hash_of_result = basic_index.scrape_basic_index(analyzed_document, basic_information)
          basic_index.save_basic_index(basic_index, hash_of_result)
          basic_index.show_basic_index(basic_index)

          #決済画面のスクレイピング
          url = "https://minkabu.jp/stock/#{number}/consolidated"
          analyzed_document = Scraping.analyzing_page(url)

          sale = Sale.where(stock_id: stock_id).first_or_create
          hash_of_result = sale.scrape_sales(analyzed_document)
          sale.save_sales(sale, hash_of_result)
          sale.show_sales(sale)

          operating_income = OperatingIncome.where(stock_id: stock_id).first_or_create
          hash_of_result = operating_income.scrape_operating_income(analyzed_document)
          operating_income.save_operating_income(operating_income, hash_of_result)
          operating_income.show_operating_income(operating_income)

          financial_information = FinancialInformation.where(stock_id: stock_id).first_or_create
          hash_of_result = financial_information.scrape_financial_information(analyzed_document)
          financial_information.save_financial_information(financial_information, hash_of_result)
          financial_information.show_financial_information(financial_information)

          various_index = VariousIndex.where(stock_id: stock_id).first_or_create
          hash_of_result = various_index.scrape_various_index(analyzed_document)
          various_index.save_various_index(various_index, hash_of_result)
          various_index.show_various_index(various_index)
        end
        sleep 2
        puts
      rescue OpenURI::HTTPError
        puts number, "\n"
        sleep 1
        next
      end
    end
  end
end
