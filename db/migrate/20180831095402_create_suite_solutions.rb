class CreateSuiteSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :suite_solutions do |t|
      t.integer :score, default: 0
      t.boolean :graded, default: false

      t.timestamps
    end
  end
end
