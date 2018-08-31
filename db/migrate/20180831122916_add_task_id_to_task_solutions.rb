class AddTaskIdToTaskSolutions < ActiveRecord::Migration[5.2]
  def change
    add_column :task_solutions, :task_id, :integer
  end
end
