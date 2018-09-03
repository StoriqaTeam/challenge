class AddStartedAtToTaskSolution < ActiveRecord::Migration[5.2]
  def change
    add_column :task_solutions, :started_at, :datetime
    add_column :task_solutions, :time, :integer
  end
end
