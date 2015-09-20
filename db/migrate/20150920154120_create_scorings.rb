class CreateScorings < ActiveRecord::Migration
  def change
    create_table :scorings do |t|
      t.integer :score
      t.integer :candidate_id
      t.integer :category_id
      t.timestamps null: false
    end
  end
end
