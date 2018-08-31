class SuiteSolution < ApplicationRecord
  has_many :task_solutions, dependent: :destroy
  belongs_to :suite

  after_save :create_task_solutions

  private
    def create_task_solutions
      task_ids = task_solutions.map { |solution| solution.task_id }
      suite_task_ids = suite.tasks.map { |task| task.id }
      to_create_ids = suite_task_ids - task_ids
      ActiveRecord::Base.transaction do
        to_create_ids.each do |task_id|
          TaskSolution.create({ task_id: task_id, suite_solution_id: id })
        end
      end
    end
end
