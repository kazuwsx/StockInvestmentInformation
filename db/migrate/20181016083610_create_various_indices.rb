class CreateVariousIndices < ActiveRecord::Migration[5.2]
  def change
    create_table :various_indices do |t|
      t.float :roe
      t.float :roa
      t.float :sales_growth_rate
      t.float :operating_income_growth_rate
      t.references :stock, foreign_key: true, index: true
      t.timestamps
    end
  end
end
