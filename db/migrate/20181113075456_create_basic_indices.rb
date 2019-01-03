class CreateBasicIndices < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_indices do |t|
      t.float :per
      t.float :pbr
      t.references :stock, foreign_key: true, index: true
      t.timestamps
    end
  end
end
