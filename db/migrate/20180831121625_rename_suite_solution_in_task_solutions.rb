class RenameSuiteSolutionInTaskSolutions < ActiveRecord::Migration[5.2]
  def change
    rename_column :task_solutions, :suite_solution, :suite_solution_id
  end
end
