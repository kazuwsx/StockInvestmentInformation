class BasicIndex < ApplicationRecord
  belongs_to :stock

  def scrape_basic_index(doc, basic_information)
    per = Scraping.fetch_value_by_css(doc, 'div.stock-detail > div > div > div > div > div > table > tr:nth-child(2) > td:nth-child(4)')

    pbr = Scraping.fetch_value_by_css(doc, 'div.stock-detail > div > div > div > div > div > table > tr:nth-child(4) > td:nth-child(4)')

    result = {
      per: per,
      pbr: pbr,
    }
  end

  def save_basic_index(basic_index, hash)
    basic_index.per = hash[:per]
    basic_index.pbr = hash[:pbr]
    basic_index.save
  end
  def show_basic_index(basic_index)
    puts "PER                 #{basic_index.per}" if !basic_index.per.to_i.zero?
    puts "PBR                 #{basic_index.pbr}" if !basic_index.pbr.to_i.zero?
  end
end
