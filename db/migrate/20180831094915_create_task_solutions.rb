class CreateTaskSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :task_solutions do |t|
      t.integer :suite_solution
      t.text :solution
      t.timestamps
    end
  end
end
