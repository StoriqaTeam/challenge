class AddSuiteIdToSuiteSolutions < ActiveRecord::Migration[5.2]
  def change
    add_column :suite_solutions, :suite_id, :integer
  end
end
