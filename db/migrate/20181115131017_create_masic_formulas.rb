class CreateMasicFormulas < ActiveRecord::Migration[5.2]
  def change
    create_table :masic_formulas do |t|
      t.integer :roa_rank
      t.integer :per_rank
      t.integer :masic_formula_rank
      t.references :stock, foreign_key: true, index: true
      t.timestamps
    end
  end
end
