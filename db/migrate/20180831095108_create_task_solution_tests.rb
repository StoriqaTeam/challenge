class CreateTaskSolutionTests < ActiveRecord::Migration[5.2]
  def change
    create_table :task_solution_tests do |t|
      t.integer :task_solution_id
      t.boolean :result

      t.timestamps
    end
  end
end
