class AddTestsToTaskSolutions < ActiveRecord::Migration[5.2]
  def change
    add_column :task_solutions, :tests, :text
  end
end
