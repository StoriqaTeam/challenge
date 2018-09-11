class AddPrioToSuiteTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :suite_tasks, :priority, :integer, null: false, default: 0
  end
end
