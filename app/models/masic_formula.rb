class MasicFormula < ApplicationRecord
  belongs_to :stock

  def self.get_per_rank
    basic_indexies = BasicIndex.includes(:stock).where.not(per: [nil, 0]).where("per > 0").order(:per)
    rank = 1
    before_value = basic_indexies.first.per
    basic_indexies.each do |basic_index|
      rank += 1 if basic_index.per > before_value
      masic_formula = MasicFormula.where(stock_id: basic_index.stock_id).first_or_create
      masic_formula.per_rank = rank
      masic_formula.save
      before_value = basic_index.per
      print "・" if rank % 100 === 0
    end
    puts "PERのランク付けを終えました"
  end

  def self.get_roa_rank
    various_indexies = VariousIndex.where.not(roa: [nil, 0]).order(roa: :desc)
    rank = 1
    before_value = various_indexies.first.roa
    various_indexies.each do |various_index|
      rank += 1 if various_index.roa < before_value
      masic_formula = MasicFormula.where(stock_id: various_index.stock_id).first_or_create
      masic_formula.roa_rank = rank
      masic_formula.save
      before_value = various_index.roa
      print "・" if rank % 100 === 0
    end
    puts "ROAのランク付けを終えました"
  end

  def self.calculate_masic_formula_rank
    stocks = Stock.includes(:basic_information).where.not(basic_informations: {:kind_of_industry => ["不動産業", "銀行業"]})
    stocks.each do |stock|
      masic_formula = MasicFormula.find_by(stock_id: stock.id)
      if !masic_formula&.per_rank.nil? && !masic_formula&.roa_rank.nil?
        per_rank = masic_formula.per_rank
        roa_rank = masic_formula.roa_rank
        masic_formula.masic_formula_rank = per_rank + roa_rank
        masic_formula.save
      end
    end
  end
end
