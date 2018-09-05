class AddReferenceSolutionToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :reference_solution, :text
  end
end
