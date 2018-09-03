class AddSubmittedToTaskSolutions < ActiveRecord::Migration[5.2]
  def change
    add_column :task_solutions, :submitted, :boolean, default: false
  end
end
