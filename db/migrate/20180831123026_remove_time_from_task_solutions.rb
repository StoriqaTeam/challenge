class RemoveTimeFromTaskSolutions < ActiveRecord::Migration[5.2]
  def change
    remove_column :task_solutions, :time
  end
end
