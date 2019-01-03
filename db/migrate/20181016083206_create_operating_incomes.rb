class CreateOperatingIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :operating_incomes do |t|
      t.float :next_fiscal_operating_income
      t.float :operating_income_for_this_fiscal_year
      t.float :privious_year_operating_income
      t.float :operating_income_two_fiscal_year_before
      t.references :stock, foreign_key: true, index: true
      t.timestamps
    end
  end
end
