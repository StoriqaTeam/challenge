class CreateTasksuites < ActiveRecord::Migration[5.2]
  def change
    create_table :tasksuites do |t|
      t.integer :task_id, foreign_key: { on_delete: :cascade }
      t.integer :suite_id, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
