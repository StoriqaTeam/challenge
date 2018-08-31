class AddRuntimeInitialToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :runtime, :text
    add_column :tasks, :initial, :text
  end
end
