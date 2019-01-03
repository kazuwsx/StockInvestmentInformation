class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :securities_code, unique: true
      t.string  :corp_name     , unique: true
      t.timestamps
    end
  end
end
