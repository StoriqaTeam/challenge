class DropTaskSolutionTests < ActiveRecord::Migration[5.2]
  def change
    drop_table :task_solution_tests
  end
end
