class AddDetailsToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :favorite, :boolean, default: false, null: false
    add_index  :stocks, :favorite
  end
end
