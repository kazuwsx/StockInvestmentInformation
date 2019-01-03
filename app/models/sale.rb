class Sale < ApplicationRecord
  belongs_to :stock

  def scrape_sales(doc)
    #来期予想売上高
    scraped_next_fiscal_sales = Scraping.fetch_value_by_css(doc, 'tr.sales > td:last-child')
    next_fiscal_sales = BigDecimal(scraped_next_fiscal_sales.to_s) * BigDecimal("1_000_000")

    #当期売上高
    scraped_sales_for_this_fiscal_year = Scraping.fetch_value_by_css(doc, 'tr.sales > td:nth-last-child(2)')
    sales_for_this_fiscal_year = BigDecimal(scraped_sales_for_this_fiscal_year.to_s) * BigDecimal("1_000_000")


    #前期売上高
    scraped_privious_year_sales = Scraping.fetch_value_by_css(doc, 'tr.sales > td:nth-last-child(3)')
    privious_year_sales = BigDecimal(scraped_privious_year_sales.to_s) * BigDecimal("1_000_000")

    #前々期売上高
    scraped_sales_two_fiscal_year_before = Scraping.fetch_value_by_css(doc, 'tr.sales > td:nth-last-child(4)')
    sales_two_fiscal_year_before = BigDecimal(scraped_sales_two_fiscal_year_before.to_s) * BigDecimal("1_000_000")

    result = {
      next_fiscal_sales: next_fiscal_sales,
      sales_for_this_fiscal_year: sales_for_this_fiscal_year,
      privious_year_sales: privious_year_sales,
      sales_two_fiscal_year_before: sales_two_fiscal_year_before,
    }
  end

  def save_sales(sale, hash)
    next_fiscal_sales = hash[:next_fiscal_sales]
    sales_for_this_fiscal_year = hash[:sales_for_this_fiscal_year]
    privious_year_sales = hash[:privious_year_sales]
    sales_two_fiscal_year_before = hash[:sales_two_fiscal_year_before]

    sale.next_fiscal_sales = next_fiscal_sales
    sale.sales_for_this_fiscal_year = sales_for_this_fiscal_year
    sale.privious_year_sales = privious_year_sales
    sale.sales_two_fiscal_year_before = sales_two_fiscal_year_before
    sale.save
  end

  def show_sales(sale)
    puts "来季予想売上高      ￥#{sale.next_fiscal_sales.to_i.to_s(:delimited)}" if !sale.next_fiscal_sales.to_i.zero?
    puts "今季売上高          ￥#{sale.sales_for_this_fiscal_year.to_i.to_s(:delimited)}" if !sale.sales_for_this_fiscal_year.to_i.zero?
    puts "前期売上高          ￥#{sale.privious_year_sales.to_i.to_s(:delimited)}" if !sale.privious_year_sales.to_i.zero?
    puts "前々期売上高        ￥#{sale.sales_two_fiscal_year_before.to_i.to_s(:delimited)}" if !sale.sales_two_fiscal_year_before.to_i.zero?
  end
end
