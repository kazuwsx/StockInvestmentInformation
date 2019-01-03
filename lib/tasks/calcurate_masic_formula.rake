namespace :calculate_masic_formula_rank do
  desc '魔法の公式を求める'
  task :processing_execution=> :environment do
    start_time = Time.now
    MasicFormula.delete_all
    MasicFormula.get_per_rank
    MasicFormula.get_roa_rank
    MasicFormula.calculate_masic_formula_rank
    p "処理概要 #{Time.now - start_time}s"
  end
end
