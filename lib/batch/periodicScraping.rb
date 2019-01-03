require 'net/http'
require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'

 PeriodicScraping
  def self.valueGetFromKabutan
    for i in 7965..7980 do
    #   adress = URI.parse("https://kabutan.jp/stock/?code=#{i}")
    #   url = Net::HTTP.get(adress)
    #
    #   if url.empty?
    #     next
    #   else
    #
    #     #基本情報画面のスクレイピング
    #     url = "https://kabutan.jp/stock/?code=#{i}"
    #
    #     scrapeBasicInformation = Scraping.new(url)
    #     scrapeBasicInformation.prepareScraping
    #     # puts 'scrapeBasicInformation.'
    #     scrapeBasicInformation.getStockInformation
    #     scrapeBasicInformation.getBasicInformation
    #
    #     adress = URI.parse("https://kabutan.jp/stock/finance?code=#{i}&mode=k")
    #     url = Net::HTTP.get(adress)
    #
    #     if url.empty?
    #       next
    #     else
    #       #決済画面のスクレイピング
    #       url = "https://kabutan.jp/stock/finance?code=#{i}&mode=k"
    #       scrapePaymentInformation = Scraping.new(url)
    #       scrapePaymentInformation.prepareScraping
    #       scrapePaymentInformation.getSettlementInformation
    #     end
    #   end
    #   sleep(1)
    end
  end
end
