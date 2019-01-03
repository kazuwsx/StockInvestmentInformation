class CreateBasicInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_informations do |t|
      t.float :market_capitalization
      t.float :dividend_yield
      t.float :stock_price
      t.string :overview
      t.string :url
      t.string :kind_of_industry
      t.references :stock, foreign_key: true, index: true
      t.timestamps
    end
  end
end
