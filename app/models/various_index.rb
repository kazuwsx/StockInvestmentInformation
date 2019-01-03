class VariousIndex < ApplicationRecord
  belongs_to :stock

  def scrape_various_index(doc)
    latest_roe = Scraping.fetch_value_by_css(doc, 'tr.roe > td:last-child')
    previous_roe = Scraping.fetch_value_by_css(doc, 'tr.roe > td:nth-last-child(2)')

    if !latest_roe.zero?
      roe = latest_roe
    elsif !previous_roe.zero?
      roe = previous_roe
    else
      roe = nil
    end

    latest_roa = Scraping.fetch_value_by_css(doc, 'tr.roa > td:last-child')
    previous_roa = Scraping.fetch_value_by_css(doc, 'tr.roa>td:nth-last-child(2)')

    if !latest_roa.zero?
      roa = latest_roa
    elsif !previous_roe.zero?
      roa = previous_roa
    else
      roa = nil
    end

    result = {
      roe: roe,
      roa: roa,
    }
  end

  def save_various_index(various_index, hash)
    various_index.roe = hash[:roe]
    various_index.roa = hash[:roa]
    various_index.save
  end

  def show_various_index(various_index)
    puts "ROE                 #{various_index.roe}" if !various_index.roe.to_i.zero?
    puts "ROA                 #{various_index.roa}" if !various_index.roa.to_i.zero?
  end
end
