class AddDetailsToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :favorite, :integer
    add_index  :stocks, :favorite
  end
end
