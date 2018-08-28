class AddFieldsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :title, :string
    add_column :tasks, :description, :string
    add_column :tasks, :tests, :string
    add_column :tasks, :language, :string
  end
end
