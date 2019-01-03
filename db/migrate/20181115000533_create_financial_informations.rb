class CreateFinancialInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_informations do |t|
      t.float :net_income
      t.float :total_assets
      t.float :net_worth
      t.references :stock, foreign_key: true, index: true
      t.timestamps
    end
  end
end
