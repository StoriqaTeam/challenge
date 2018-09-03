class AddInitialTestsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :initial_tests, :text
  end
end
