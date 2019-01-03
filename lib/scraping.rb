require 'open_uri_redirections'


class Scraping
  attr_reader :marketCapitalization, :dividendYield, :stockPrice, :overview, :kindOfIndustry

  def self.analyzing_page(url)
    user_agent = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.33 Safari/530.5'
    charset = nil
    html = open(url, "User-Agent" => user_agent, :allow_redirections => :safe) do |f|
      charset = f.charset # 文字種別を取得
      f.read
    end
    result = Nokogiri::HTML.parse(html, nil, charset)
  end

  def self.fetch_value(doc, xpath)
    doc.xpath(xpath).inner_text.gsub(/[一-龠々[,[%[" "]]]]/,"").to_f if doc.xpath(xpath)
  end

  def self.fetch_value_by_css(doc, css_selector)
    doc.search(css_selector).inner_text.gsub(/[一-龠々[,[%[" "]]]]/,"").to_f if doc.search(css_selector)
  end

  def self.inspect_delisting(doc, i)
    if doc.css('em.fsl').inner_text === '上場廃止'
      puts "#{i} \n上場廃止"
      delisted_stock = Stock.find_by(securities_code: i)
      if !delisted_stock.nil?
        Stock.destroy(delisted_stock.id)
      end
      return false
    else
      return true
    end
  end
end
