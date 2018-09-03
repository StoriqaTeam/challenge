class AddTaskSolutionIdToTaskSolutionResults < ActiveRecord::Migration[5.2]
  def change
    add_column :task_solution_results, :task_solution_id, :integer
  end
end
