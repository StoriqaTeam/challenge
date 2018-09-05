class AddNumberOfTestsToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :number_of_tests, :integer
  end
end
