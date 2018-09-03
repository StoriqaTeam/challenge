class AddStartedToSuiteSolutions < ActiveRecord::Migration[5.2]
  def change
    add_column :suite_solutions, :started, :boolean, default: false
  end
end
