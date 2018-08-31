class CreateSuiteTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :suite_tasks do |t|
      t.integer :task_id
      t.integer :suite_id

      t.timestamps
    end
  end
end
