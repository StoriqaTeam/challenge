class CreateTaskSolutionResults < ActiveRecord::Migration[5.2]
  def change
    create_table :task_solution_results do |t|
      t.string :name
      t.boolean :passed

      t.timestamps
    end
  end
end
