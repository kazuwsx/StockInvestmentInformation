class AddIndexMasicFormulaMasicFormulaRank < ActiveRecord::Migration[5.2]
  def change
    add_index :masic_formulas, :masic_formula_rank
  end
end
