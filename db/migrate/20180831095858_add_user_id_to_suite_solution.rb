class AddUserIdToSuiteSolution < ActiveRecord::Migration[5.2]
  def change
    add_column :suite_solutions, :user_id, :integer
  end
end
