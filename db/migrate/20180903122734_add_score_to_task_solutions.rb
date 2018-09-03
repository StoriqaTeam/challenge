class AddScoreToTaskSolutions < ActiveRecord::Migration[5.2]
  def change
    add_column :task_solutions, :score, :integer
  end
end
