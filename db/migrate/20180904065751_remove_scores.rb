class RemoveScores < ActiveRecord::Migration[5.2]
  def change
    remove_column :task_solutions, :score
    remove_column :suite_solutions, :score
  end
end
