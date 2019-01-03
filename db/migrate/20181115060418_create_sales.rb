class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.float :next_fiscal_sales
      t.float :sales_for_this_fiscal_year
      t.float :privious_year_sales
      t.float :sales_two_fiscal_year_before
      t.references :stock, foreign_key: true, index: true
      t.timestamps
    end
  end
end
